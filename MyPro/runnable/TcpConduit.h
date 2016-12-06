#ifndef _TCPCONDUIT_H_
#define _TCPCONDUIT_H_

#include "Network.h"

struct evbuffer;
struct bfferevent;

namespace Network
{
	class TcpSlaveServer;
	class TcpConduit
	{
		friend class TcpSlaveServer;
	public:
		TcpConduit(int, TcpSlaveServer *, int);
		virtual ~TcpConduit();
		void send(const void *, int);
		void getAddr(struct sockaddr_in *);
		void closeConn();
		void forceClose();
		inline int fd() {return _socket;}
		void pendClose();
		inline int id() {return _uid;}

		virtual bool active() {return true;}
		virtual void OnTick(UInt32 now) {}
		virtual void initConnection() {};

	protected:
		virtual int parsePacket(struct evbuffer * buf, int &off, int &len) { return 0;}

		virtual void onRecv(int cmd, int len, void *buf) {}
		virtual void onDisconnected() {}

	private:
		static void _readcb(struct bufferevent *, void * arg);
		static void _writecb(struct bufferevent *, void * arg);

		void on_read();
		void on_write();
		void on_event(short);

	protected:
		int _socket;
		TcpSlaveServer * _host;
		struct bufferevent * _bev;
		bool _pendclose;

		int _uid;
	};
}
#endif
