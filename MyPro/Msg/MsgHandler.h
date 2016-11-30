#ifndef MSGHANDLER_H_
#define MSGHANDLER_H_

#define MAX_MSG_NUM			0x500
#define MIN_INNER_CHECK_MSG 0x200

namespace GObject
{
	class Player;
}

class MsgHandler
{
public:
	MsgHandler(UInt8 worker = 0xFF): m_Worker(worker), m_RunnerShutdown(false)
	{
		for(int i = 0; i < MAX_MSG_NUM; ++i)
		{
			m_HandlerList[i] = NULL;
		}
	}

	virtual ~MsgHandler()
	{
	}

public:
	void DeregisterAllMsg();

	bool ProcessMsg();

	template<typename HdrType, typename MsgType>
	inline void RegisterMsgHandler(void (*handlerfunc)(HdrType&, MsgType&))
	{
		Handler *handler = new Handler();
		assert(handler != NULL);
		handler->m_Func = (char*)handlerfunc;
		handler->m_Wrapper = &HandlerWrapper<HdrType, MsgType>;
		UInt32 msgId = MsgType::s_MsgId;
		assert(msgId < MAX_MSG_NUM);
		assert(!m_HandlerList[msgId]);
		m_HandlerList[msgId] = handler;
	}

	template <typename HdrType, int MsgId, typename StructType>
	inline void RegisterMsgHandler(void (*handlerfunc)(HdrType&, StructType *))
	{
		Handler *hadler = new Handler();
		assert(handler != NULL);
		handler->m_Func = (char *)handlerfunc;
		handler->m_Wrapper = &HandlerWrapper2<HdrType, StructType>;
		UInt32 msgId = MsgId;
		assert(msgId < MAX_MSG_NUM );
		assert(!m_HandlerList[msgId]);
		if(m_HandlerList[msgId])
			printf("%d\n", msgId);
		m_HandlerList[msgId] = handler;
	}

	inline void setRunnerShutdown(bool v) { m_RunnerShutdown = v;}
	inline bool isRunerShutdown() const { return m_RunnerShutdown;}

protected:
	template <typename HdrType, typename MsgType>
	static bool HandlerWrapper(char * func, const MsgHdr * hdr)
	{
		MsgType msg1;
		char* msgBody = (char*)((HdrType*)hdr + 1);

		if(msg1.Unserialize( msgBody, ((HdrType*)hdr)->msgHdr.bodyLen ) != static_cast<UInt32>(-1))
			((void (*)(HdrType&, MsgType&))func)(*(HdrType*)hdr, msg1);
		return true;
	}

	template<typename HdrType, typename StructType>
	static bool HandlerWrapper2(char* func, const MsgHdr* hdr)
	{
		StructType* msgBody = (StructType *)((HdrType*)hdr + 1);

		((void (*)(HdrType&, StructType *))func)(*(HdrType*)hdr, msgBody);
		return true;
	}

private:
	struct Handler
	{
		bool (*m_Wrapper)(char*, const MsgHdr*);
		char *m_Func;
	};

	Handler* m_HandlerList[MAX_MSG_NUM];
	UInt8 m_Worker;
	bool m_RunnerShutdown;
};

#endif
