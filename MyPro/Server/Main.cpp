#include "Config.h"
#include "WorldServer.h"
#include <sys/resource.h>

extern "C" __attribute__((constructor)) void __serverInit()
{
	struct rlimit rlsrc = {RLIM_INFINITY, RLIM_INFINITY};
	struct rlimit rlsrc2 = {131072, 262144};
	setrlimit(RLIMIT_CORE, &rlsrc);
	setrlimit(RLIMIT_NOFILE, &rlsrc2);
	int f = open("/proc/sys/kernel/core_uses_pid", O_WRONLY);
	if(f < 0)
		return;
	write(f, "1", 1);
	close(f);
}

extern "C" void sigbreak(int sig)
{
	SERVER().Shutdown();
}

int main(int argc, char* argv[])
{
	if(!SERVER().ParseCommandInfor(argc, argv))
	{
		fprintf(stdout, "%s\n", s_HelpInfo);
		exit(-1);
	}
#ifndef SIGBREAK
#define SIGBREAK 21
#endif
	signal(SIGABRT, &sigbreak);
	signal(SIGINT, &sigbreak);
	signal(SIGTERM, &sigbreak);
	signal(SIGBREAK, &sigbreak);

	GLOBAL().Init();
}
