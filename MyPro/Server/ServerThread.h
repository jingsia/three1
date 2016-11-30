/*************************************************************************
	> File Name: ServerThread.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 10 Nov 2016 03:04:36 PM CST
 ************************************************************************/
#ifndef SERVERTHREAD_H_
#define SERVERTHREAD_H_

#include "Common/BaseThread.h"
#include "WorkerRunner.h"

template <typename WorkerType>
class WorkerThread:
	public BaseThread
{
public:
	WorkerThread(WorkerType* worker) : m_Worker(worker)
	{
	};
	virtual ~WorkerThread()
	{
		delete m_Worker;
	}

public:
	virtual void Start();
	virtual void Stop();
	virtual void Run();
	virtual void Shutdown();
	virtual void Wait();

public:
	inline WorkerType& Worker() { return *m_Worker; }

	inline static WorkerType& LocalWorker() {return static_cast<WorkerThread<WorkerType> *>(current())->Worker();}

private:
	static void WorkerProcess(void *);
private:
	WorkerType* m_Worker;
};

template <typename WorkerType>
inline void WorkerThread<WorkerType>::WorkerProcess(void * param)
{
	WorkerType * pWorker = reinterpret_cast<WorkerType*>(param);

	pWorker->RunnerProc();
}

template <typename WorkerType>
inline void WorkerThread<WorkerType>::Start()
{
}

template <typename WorkerType>
inline void WorkerThread<WorkerType>::Run()
{
	assert(m_Worker != NULL);
	start(WorkerProcess, m_Worker);
}

template <typename WorkerType>
inline void WorkerThread<WorkerType>::Stop()
{
}

template <typename WorkerType>
inline void WorkerThread<WorkerType>::Shutdown()
{
	assert(m_Worker != NULL);
	m_Worker->Shutdown();
}

template <typename WorkerType>
inline void WorkerThread<WorkerType>::Wait()
{
	join();
}

#endif
