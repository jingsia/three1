#include "Environment_UNIX.h"
#include "Exception.h"
#include "Buffer.h"
#include <cstring>
#include <unistd.h>
#include <stdlib.h>
#include <sys/utsname.h>
#include <sys/param.h>
#include <cstring>
#if defined(_OS_FAMILY_BSD)
#include <sys/sysctl.h>
#elif _OS == _OS_HPUX
#include <pthread.h>
#endif


EnvironmentImpl::StringMap EnvironmentImpl::_map;
FastMutex EnvironmentImpl::_mutex;


std::string EnvironmentImpl::getImpl(const std::string& name)
{
	FastMutex::ScopedLock lock(_mutex);

	const char* val = getenv(name.c_str());
	if (val)
		return std::string(val);
	else
		throw NotFoundException(name);
}


bool EnvironmentImpl::hasImpl(const std::string& name)
{
	FastMutex::ScopedLock lock(_mutex);

	return getenv(name.c_str()) != 0;
}


void EnvironmentImpl::setImpl(const std::string& name, const std::string& value)
{
	FastMutex::ScopedLock lock(_mutex);

	std::string var = name;
	var.append("=");
	var.append(value);
	_map[name] = var;
	if (putenv((char*) _map[name].c_str()))
	{
		std::string msg = "cannot set environment variable: ";
		msg.append(name);
		throw SystemException(msg);
	}
}


std::string EnvironmentImpl::osNameImpl()
{
	struct utsname uts;
	uname(&uts);
	return uts.sysname;
}


std::string EnvironmentImpl::osVersionImpl()
{
	struct utsname uts;
	uname(&uts);
	return uts.release;
}


std::string EnvironmentImpl::osArchitectureImpl()
{
	struct utsname uts;
	uname(&uts);
	return uts.machine;
}


std::string EnvironmentImpl::nodeNameImpl()
{
	struct utsname uts;
	uname(&uts);
	return uts.nodename;
}


unsigned EnvironmentImpl::processorCountImpl()
{
#if defined(_OS_FAMILY_BSD)
	unsigned count;
	std::size_t size = sizeof(count);
	if (sysctlbyname("hw.ncpu", &count, &size, 0, 0))
		return 1;
	else
		return count;
#elif _OS == _OS_HPUX
	return pthread_num_processors_np();
#elif defined(_SC_NPROCESSORS_ONLN)
	int count = sysconf(_SC_NPROCESSORS_ONLN);
	if (count <= 0) count = 1;
	return static_cast<int>(count);
#else
	return 1;
#endif
}



//
// nodeIdImpl
//
#if defined(_OS_FAMILY_BSD) || _OS == _OS_QNX
//
// BSD variants
//
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if_dl.h>



void EnvironmentImpl::nodeIdImpl(NodeId& id)
{
	std::memset(&id, 0, sizeof(id));
	struct ifaddrs* ifaphead;
	int rc = getifaddrs(&ifaphead);
	if (rc) return;

	for (struct ifaddrs* ifap = ifaphead; ifap; ifap = ifap->ifa_next)
	{
		if (ifap->ifa_addr && ifap->ifa_addr->sa_family == AF_LINK)
		{
			struct sockaddr_dl* sdl = reinterpret_cast<struct sockaddr_dl*>(ifap->ifa_addr);
			caddr_t ap = (caddr_t) (sdl->sdl_data + sdl->sdl_nlen);
			int alen = sdl->sdl_alen;
			if (ap && alen > 0)
			{
				std::memcpy(&id, ap, sizeof(id));
				break;
			}
		}
	}
	freeifaddrs(ifaphead);
}



#elif defined(__CYGWIN__) || _OS == _OS_LINUX
//
// Linux, Cygwin
//
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <net/if.h>
#ifndef __CYGWIN__
#include <net/if_arp.h>
#else // workaround for Cygwin, which does not have if_arp.h
#define ARPHRD_ETHER 1 /* Ethernet 10Mbps */
#endif
#include <arpa/inet.h>
#include <unistd.h>



void EnvironmentImpl::nodeIdImpl(NodeId& id)
{
	std::memset(&id, 0, sizeof(id));
	int sock = socket(PF_INET, SOCK_DGRAM, 0);
	if (sock == -1) return;

	// the following code is loosely based
	// on W. Richard Stevens, UNIX Network Programming, pp 434ff.
	int lastlen = 0;
	int len = 100*sizeof(struct ifreq);
	struct ifconf ifc;
	char* buf = 0;
	for (;;)
	{
		buf = new char[len];
		ifc.ifc_len = len;
		ifc.ifc_buf = buf;
		if (::ioctl(sock, SIOCGIFCONF, &ifc) < 0)
		{
			if (errno != EINVAL || lastlen != 0)
			{
				close(sock);
				delete [] buf;
				return;
			}
		}
		else
		{
			if (ifc.ifc_len == lastlen)
				break;
			lastlen = ifc.ifc_len;
		}
		len += 10*sizeof(struct ifreq);
		delete [] buf;
	}
	for (const char* ptr = buf; ptr < buf + ifc.ifc_len;)
	{
		const struct ifreq* ifr = reinterpret_cast<const struct ifreq*>(ptr);
		int rc = ioctl(sock, SIOCGIFHWADDR, ifr);
		if (rc != -1)
		{
			const struct sockaddr* sa = reinterpret_cast<const struct sockaddr*>(&ifr->ifr_hwaddr);
			if (sa->sa_family == ARPHRD_ETHER)
			{
				std::memcpy(&id, sa->sa_data, sizeof(id));
				break;
			}
		}
		ptr += sizeof(struct ifreq);
	}
	close(sock);
	delete [] buf;
}



#elif defined(_OS_FAMILY_UNIX)
//
// General Unix
//
#include <sys/ioctl.h>
#if defined(sun) || defined(__sun)
#include <sys/sockio.h>
#endif
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <unistd.h>



void EnvironmentImpl::nodeIdImpl(NodeId& id)
{
	std::memset(&id, 0, sizeof(id));
	char name[MAXHOSTNAMELEN];
	if (gethostname(name, sizeof(name)))
		return;

	struct hostent* pHost = gethostbyname(name);
	if (!pHost) return;

	int s = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (s == -1) return;

	struct arpreq ar;
	std::memset(&ar, 0, sizeof(ar));
	struct sockaddr_in* pAddr = reinterpret_cast<struct sockaddr_in*>(&ar.arp_pa);
	pAddr->sin_family = AF_INET;
	std::memcpy(&pAddr->sin_addr, *pHost->h_addr_list, sizeof(struct in_addr));
	int rc = ioctl(s, SIOCGARP, &ar);
	close(s);
	if (rc < 0) return;
	std::memcpy(&id, ar.arp_ha.sa_data, sizeof(id));
}



#endif
