/*************************************************************************
	> File Name: rlimitAndAttribute.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 27 Jun 2016 09:44:45 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;

#include <sys/resource.h>
#include <fcntl.h>

extern "c" __attribute__((constructor)) void __serverInit()
{
	struct rlimit rlsrc = {RLIM_INFINITY, RLIM_INFINITY};
	struct rlimit rlsrc2 = {131072, 262144};
	setlimit(RLIMIT_CORE, &rlsrc);
	setlimit(RLIMIT_CORE, &rlsrc2);

	int f = open("/proc/sys/kernel/core_uses_pid", O_WRONLY);
	if(f < 0)
		return;
	write(f, "1", 1);
	close(f);
}
