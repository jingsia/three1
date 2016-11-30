#include "Config.h"
#include "MsgHandler.h"
#include "Server/WorldServer.h"
#include "GObject/Player.h"
#include "MsgID.h"
#include "GMHandler.h"

void MsgHandler::DeregisterAllMsg()
{
	for(int i = 0; i < MAX_MSG_NUM; ++i)
	{
		if(m_HandlerList[i])
		{
			TRACE_LOG("m_HandlerList[%u] delete", i);
		}
		delete (m_HandlerList[i]);
		m_HandlerList[i] = NULL;
	}
}

bool MsgHandler::ProcessMsg()
{
	if(isRunnerShutdown() && (m_Worker < WORKER_THREAD_DB || m_Worker == WORKER_THREAD_LOAD))
	{
		fprintf(stderr, "%s:", m_Worker);
		return false;
	}

	Handler* handler = NULL;
	MsgQueue tmp;
	MsgQueue msgQueue;
	if(!GLOBAL().GetMsgQueue(m_Worker, msgQueue))
		return false;
	MsgHdr * hdr = NULL;
	do
	{
		hdr = msgQueue.Pop();
		assert(hdr->cmdID < MAX_MSG_NUM);
		handler = m_HandlerList[hdr->cmdID];
		if(handler != NULL)
		{
			if( !handler->m_Wrapper(handler->m_Func, hdr))
			{}
		}
		else
		{
		}
		GLOBAL().FreeMsgBlock((char *)hdr);
	}
	while ( !msgQueue.Empty());
	return true;
}
