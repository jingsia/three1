#include "Config.h"
#include "MsgHandler.h"
#include "Server/WorldServer.h"
#include "GObject/Player.h"
#ifndef _FB
#ifndef _VT
#ifndef _WIN32
#include "GObject/DCLogger.h"
#endif
#endif
#endif
#include "MsgID.h"
#include "GMHandler.h"

void MsgHandler::DeregisterAllMsg()
{
	for(int i = 0; i < MAX_MSG_NUM; ++i)
	{
		if(m_HandlerList[i])
		{
			TRACE_LOG("m_HandlerList[%u] delete ", i);
		}
		delete (m_HandlerList[i]);
		m_HandlerList[i] = NULL;
	}
}

bool MsgHandler::ProcessMsg()
{
	// RunnerWorker.Shutdown()后只允许DB再处理未处理完的消息
	if(isRunnerWorker.Shutdown() && (m_Worker < WORKER_THREAD_DB || m_Worker == WORKER_THREAD_LOAD))
	{
		fprintf(stderr, "%s: RunnerWorker(%d).Shutdown()后只允许DB再>    处理未处理完的消息.\n", __PRETTY_FUNCTION__, m_Worker);
		return false;
	}

	Handler* handler = NULL;
	MsgQueue tmp;
	MsgQueue msgQueue;
	if(!GLOBAL().GetMsgQueue( m_Worker, msgQueue ))
		return false;
	MsgHdr* hdr = NULL;
	do
	{
		hdr = msgQueue.Pop();
		assert(hdr->cmdID < MAX_MSG_NUM );
		if(hdr->cmdID <= 0xFF && hdr->desWorkerID <= WORKER_THREAD_NEUTRAL)
		{
			GameMsgHdr * ihdr = reinterpret_cast<GameMsgHdr *>(hdr);
			if(ihdr->player != NULL)
			{
				if(ihdr->player->isJumpingMap())
				{
					GLOBAL().FreeMsgBlock((char *)hdr);
					continue;
				}
				else if(ihdr->player->getThreadId() != m_Worker)
				{
					GLOBAL().FreeMsgBlock((char*)hdr);
					continue;
				}

				if(gmHandler._printMsgPlayer != 0 && ihdr->player == gmHandler._printMsgPlayer_)
				{
					fprintf(stdout, "Proc::PlayerMsg_XXXXXXXX: cmd[%x], thrd[%u]\n", hdr->cmdID, hdr->desWorkerID);
					fflush(stdout);
				}
			}
		}
		else if(hdr->cmdID >= MIN_INNER_CHECK_MSG && hdr->cmdID <= MAX_2_MSG_NUM)
		{
			GameMsgHdr * ihdr = reinterpret_cast<GameMsgHdr *>(hdr);
			if(ihdr->player != NULL)
			{
				UInt8 tid = ihdr->player->getThreadId();
				if(tid != m_Worker)
				{
					ihdr->msgHdr.desWorkerID = tid;
					GLOBAL().PushMsg(*ihdr, ihdr + 1);
					GLOBAL().FreeMsgBlock((char *)hdr);
					continue;
				}
			}
		}

#ifndef _FB
#ifndef _VT
#ifndef _WIN32
		if(hdr->cmdID <= 0xFF && hdr->cmdID != 0)
		{
			//安全上报协议转发
			if(hdr->desWorkerID == WORKER_THREAD_NEUTRAL ||
					hdr->desWorkerID == WORKER_THREAD_COUNTRY_1 ||
					hdr->desWorkerID == WORKER_THREAD_COUNTRY_2 ||
					hdr->desWorkerID == WORKER_THREAD_WORLD)
			{
				if(hdr->cmdID != REQ::LOGIN &&
						hdr->cmdID != REQ::CREATE_ROLE &&
						hdr->cmdID != REQ::RECONNECT)
				{
					GameMsgHdr * ihdr = reinterpret_cast<GameMsgHdr *>(hdr);
					if(ihdr->player != NULL)
					{
						UInt8 tid = ihdr->player->getThreadId();
						if(tid == m_Worker)
						{
							GObject::dclogger.protol_sec(ihdr->player, hdr->cmdID);
						}
					}
				}
			}
		}
#endif
#endif
#endif
		handler = m_HandlerList[hdr->cmdID];
		if(handler != NULL)
		{
			if(!handler->m_Wrapper(handler->m_Func, hdr))
			{
			
			}
		}
		else
		{
		
		}
		GLOBAL().FreeMsgBlock((char *)hdr);
	}
	while (!msgQueue.Empty());
	return true;
}
