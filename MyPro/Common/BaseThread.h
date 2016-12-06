#ifndef BASETHREAD_INC
#define BASETHREAD_INC

#include "Thread.h"
#include "URandom.h"

class BaseThread:
	public Thread
{
public:
	BaseThread(): Thread() {};
	virtual ~BaseThread() {};

public:
	virtual void Start()	= 0;
	virtual void Run()		= 0;
	virtual void Stop()		= 0;
	virtual void Shutdown() = 0;
	virtual void Wait()		= 0;

public:
	URandom uRandom;
};
#endif
