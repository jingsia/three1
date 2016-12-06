#ifndef _NETWORK_H_
#define _NETWORK_H_

#define make_linger(s) \
{ \
	struct linger so_linger; \
	    so_linger.l_onoff = 1; \
	    so_linger.l_linger = 0; \
	    setsockopt(s, SOL_SOCKET, SO_LINGER, (const char *)&so_linger, sizeof(so_linger)); \
}

#define make_no_linger(s) \
{ \
	struct linger so_linger; \
	    so_linger.l_onoff = 0; \
	    so_linger.l_linger = 0; \
	    setsockopt(s, SOL_SOCKET, SO_LINGER, (const char *)&so_linger, sizeof(so_linger)); \
}

namespace Network
{
#ifdef _WIN32
	inline int close(int s) {return closesocket(s);}
	inline int read(int fd, char *buf, int len) {return recv(fd, buf, len, 0);}
	inline int write(int fd, char *buf, int len) { return send(fd, buf, len, 0);}
#endif
	void Initialize();
	void Uninitialize();
	UInt32 ResolveAddress(const char * domain);
}

#endif
