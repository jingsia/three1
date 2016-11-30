/*************************************************************************
	> File Name: Thread.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 10 Nov 2016 02:04:52 PM CST
 ************************************************************************/
#ifndef Foundation_Thread_INCLUDED
#define Foundation_Thread_INCLUDED

#include "Plateform.h"
#include "Mutex.h"

#if defined(_OS_FAMILY_WINDOWS)
#include "Thread_WIN32.h"
#else
#include "Thread_POSIX.h"
#endif

class Runnable;
class ThreadLocalStorage;

class Thread: private ThreadImpl
{
public:
	typedef ThreadImpl::TIDImpl TID;

	using ThreadImpl::Callable;

	enum Priority
	{
		PRIO_LOWEST  = PRIO_LOWEST_IMPL, /// The lowest thread priority.
		PRIO_LOW     = PRIO_LOW_IMPL,    /// A lower than normal thread priority.
		PRIO_NORMAL  = PRIO_NORMAL_IMPL, /// The normal thread priority.
		PRIO_HIGH    = PRIO_HIGH_IMPL,   /// A higher than normal thread priority.
		PRIO_HIGHEST = PRIO_HIGHEST_IMPL /// The highest thread priority.
	};

	Thread();

	Thread(const std::string& name);

	~Thread();

	int id() const;

	TID tid() const;

	std::string name() const;

	std::string getName() const;

	void setName(const std::string& name);

	void setPriority(Priority prio);

	Priority getPriority() const;

	void setOSPriority(int prio);

	int getOSPriority() const;

	static int getMinOSPriority();

	static int getMaxOSPriority();

	void setStackSize(int size);

	int getStackSize() const;

	void start(Runnable& target);

	void start(Callable target, void * pData = 0);

	void join();

	void join(long milliseconds);

	bool tryJoin(long milliseconds);

	bool isRunning() const;

	static void sleep(long milliseconds);

	static void yield();

	static Thread* current();

	static TID currentTid();

protected:
	ThreadLocalStorage& tls();

	void clearTLS();

	std::string makeName();

	static int uniqueId();

private:
	Thread(const Thread&);
	Thread& operator = (const Thread&);

	int				_id;
	std::string		_name;
	ThreadLocalStorage* _pTLS;
	mutable FastMutex	_mutex;

	friend class ThreadLocalStorage;
	friend class PooledThread;
};

inline Thread::TID Thread::tid() const
{
	return tidImpl();
}

inline int Thread::id() const
{
	return _id;
}

inline std::string Thread::name() const
{
	FastMutex::ScopedLock lock(_mutex);

	return _name;
}

inline std::string Thread::getName() const
{
	FastMutex::ScopedLock lock(_mutex);
	return _name;
}

inline bool Thread::isRunning() const
{
	return isRunningImpl();
}

inline void Thread::sleep(long milliseconds)
{
	sleepImpl(milliseconds);
}

inline void Thread::yiedld()
{
	yieldImpl();
}

inline Thread* Thread::current()
{
	return static_cast<Thread*>(currentImpl());
}

inline void Thread::setOSPriority(int prio)
{
	setOSPriorityImpl(prio);
}

inline int Thread::getOSPriority() const
{
	return getOSPriorityImpl();
}

inline int Thread::getMinOSPriority()
{
	return ThreadImpl::getMinOSPriorityImpl();
}

inline int Thread::getMaxOSPriority()
{
	return ThreadImpl::getMaxOSPriorityImpl();
}

inline void Thread::setStackSize(int size)
{
	setStackSizeImpl(size);
}

inline int Thread::getStackSize() const
{
	return getStackSizeImpl();
}

inline Thread::TID Thread::currentTid()
{
	return currentTidImpl();
}

#endif
