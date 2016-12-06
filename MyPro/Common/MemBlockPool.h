#ifndef _MEMBLOCK_POOL_H_
#define _MEMBLOCK_POOL_H_

#include <memory.h>
#include "Mutex.h"

class MemBlockPool
{
	struct MemBlock
	{
		MemBlock * next;
		char	data[1];
	};

public:
	explicit MemBlockPool(size_t size);
	~MemBlockPool();

	void* Alloc();
	void Free(void* ptr);

private:
	const size_t m_Size;
	MemBlock* m_pBlockList;
	FastMutex m_Mutex;
};
#endif
