/*************************************************************************
	> File Name: GlobalData.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 10 Nov 2016 09:59:15 AM CST
 ************************************************************************/

#ifndef GLOBALDATA_INC
#define GLOBALDATA_INC

#include "Common/Singleton.h"
#include "Common/Queue.h"
#include "MsgHandler/MsgTypes.h"
#include "Server/ServerTypes.h"
#include "Common/Mutex.h"
#include "Common/MemBlockPool.h"

class GlobalObject: public Singleton<GlobalObject>
{
	const static size_t MIN_MEMBLOCK_SIZE = 128;
	const static size_t MEMPOOL_NUM = 10;

protected:
	GlobalObject():m_MaxPoolSize(0)
	{
		memset(m_Pools, 0, sizeof(m_Pools));
	}
	virtual ~GlobalObject() {}
	friend class Singleton<GlobalObject>;

public:
	bool Init();

	void UnInit();

public:
	template <typename MsgHdrType>
	void PushMsg(const MsgHdrType& hdr, void * msgBody);

	inline bool GetMsgQueue(UInt8 workerId, MsgQueue& popMsgQueue)
	{
		assert(workerId>=0 && workerId<MAX_THREAD_NUM)
		{
			FastMutex::ScopedLock lock(m_MsgQueueCs[workerId]);
			if(m_MsgQueue[workerId].Empty())
				return false;
			popMsgQueue = m_MsgQueue[workerId];
			m_MsgQueue[workerId].clear();
		}
		return true;
	}
public:
	void * AllocMsgBlock(size_t size);
	void FreeMsgBlock(void* ptr);

private:
	MsgQueue		m_MsgQueue[MAX_THREAD_NUM];
	FastMutex		m_MsgQueuecs[MAX_THREAD_NUM];

	MemBlockPool*	m_Pools[MEMPOOL_NUM];

	size_t			m_MaxPoolSize;
};

template <typename MsgHdrType>
inline void GlobalObject::PushMsg(const MsgHdrType& hdr, void* msgBody)
{
	UInt8 workerId = hdr.msgHdr.desWorkerID;
	if(workerId >= (UInt8)MAX_THREAD_NUM)
		return;
	char * buffer = (char*)AllocMsgBlock(sizeof(MsgHdrType) + hdr.msgHdr.bodyLen);
	if(buffer == NULL)
		return;
	memcpy(buffer, &hdr, sizeof(MsgHdrType));
	if(msgBody != NULL && hdr.msgHdr.bodyLen > 0)
		memcpy(buffer+sizeof(MsgHdrType), msgBody, hdr.msgHdr.bodyLen);

	FastMutex::ScopedLock lock(m_MsgQueueCs[workerId]);
	m_MsgQueue[workerId]. push((MsgHdr*)buffer);
}
#endif
