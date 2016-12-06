#include "Config.h"
#include "GlobalObject.h"

bool GlobalObject::Init()
{
	size_t size = MIN_MEMBLOCK_SIZE;
	for(UInt32 i = 0; i < MEMPOLL_NUM; ++i)
	{
		m_MaxPoolSize = size;
		m_Pools[i] = new MemBlockPool(size);
		size *= 2;
	}
	return true;
}

void GlobalObject::UnInit()
{
	for (int i = 0; i < MAX_THREAD_NUM; ++i)
	{
		FastMutex::ScopedLock lock(m_MsgQueueCs[i]);
		while (!m_MsgQueue[i].Empty())
		{
			FreeMsgBlock(m_MsgQueue[i].Pop());
		}
		m_MsgQueue[i].Clear();
	}

	for(UInt32 i = 0; i < MEMPOOL_NUM; ++i)
	{
		delete m_Pools[i];
		m_Pools[i] = NULL;
	}
}

void * GlobalObject::AllocMsgBlock(size_t size)
{
	char *ptr = NULL;

	size += sizeof(size_t);
	if(size > m_MaxPoolSize)
	{
		ptr = (char*)malloc(size);
	}
	else
	{
		size_t index = 0;
		size_t poolSize = MIN_MEMBLOCK_SIZE;
		while(size > poolSize)
		{
			++index;
			poolSize *=2;
		}
		ptr = (char*)m_Pools[index]->Alloc();
	}
	if(ptr == NULL) return NULL;
	*(size_t *)ptr = size;
	return ptr + sizeof(size_t);
}

void GlobalObject::FreeMsgBlock(void * ptr)
{
	if(ptr == NULL) return;

	char* mem = (char*)ptr - sizeof(size_t);
	size_t size = *(size_t*)mem;
	if(size > m_MaxPoolSize)
	{
		free(mem);
	}
	else
	{
		size_t index = 0;
		size_t poolSize = MIN_MENBLOCK_SIZE;
		while(size > poolSize)
		{
			++index;
			poolSize *= 2;
		}
		m_Pools[index]->Free(mem);
	}
}
