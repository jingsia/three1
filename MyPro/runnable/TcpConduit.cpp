#include "Config.h"
#include "TcpConduit.h"
#include "TcpServer.h"
#include "Common/TInf.h"
#include "Common/Unzipper.h"

#include <event2/event.h>
#include <event2/buffer.h>
#include <event2/bufferevent.h>

namespace Network
{
	TcpConduit::TcpConduit(int fd, TcpSlaveServer *h, int uid):_socket(fd), _host(h), _bev(NULL), _pendclose(false), _uid(uid)
	{
		//bufferevent_socket_new 参数一需要添加的事件集 参数二 相关的文件描述符 参数三标志
		_bev = bufferevent_socket_new(_host->getEvBase(), _socket, BEV_OPT_THREADSAFE | BEV_OPT_DEFER_CALLBACKS);
		if(!_bev)
			throw std::bad_alloc();
		bufferevent_setcb(_bev, _readcb, _writecb, _eventcb, this);
		bufferevent_enable(_bev, EV_READ);
	}

	TcpConduit::~TcpConduit()
	{
		if(_Bev != NULL)
		{
			bufferevent_free(_bev);
			_bev = NULL;
		}
		if(_socket != 0)
		{
			close(_socket);
			_socket = 0;
		}
	}

	void TcpConduit::send(const void *buf, int size)
	{
		if(_bev == NULL)
			return;
		bufferevent_write(_bev, buf, size);
	}

	void TcpConduit::_readcb(struct bufferevent *, void * arg)
	{
		static_cast<TcpConduit *>(arg)->on_read();
	}

	void TcpConduit::_writecb(struct bufferevent *, void * arg)
	{
		static_cast<TcpConduit *>(arg)->on_write();
	}

	void TcpConduit::_eventcb(struct bufferevent *, short wht, void * arg)
	{
		static_cast<TcpConduit *>(arg)->on_event(wht);
	}

	void TcpConduit::on_read()
	{
		struct evbuffer * buffer = bufferevent_get_input(_bev);
		while(1)
		{
			int off, len;
			int cmd = parsePacket(buffer, off, len);
			if(cmd < 0)
			{
				forceClose();
				return;
			}
			if(len <= 0)
				return;

			char * data = new(std::nothrow) char[len];
			if(data == NULL)
				evbuffer_drain(buffer, len);
			else
			{
				evbuffer_remove(buffer, data, len);
				if(cmd & 0x1000000)
				{
					unsigned int decomp_size = static_cast<unsigned long>(*(UInt16*)(data + off));
					buf::Unzipper unzip(data + off + 2, len - off -2);
					if(unzip.size() && decomp_size == unzi.size())
					{
						onRecv(cmd & 0xFFFFFF, decomp_size, (char*)&unzip);
					}
					else
					{
						forceClose();
					}
				}
				else
					onRecv(cmd, len - off, data + off);
				delete[] data;
			}
		}
	}

	void TcpConduit::on_write()
	{
		if(_pendclose)
		{
			struct evbuffer * buffer = bufferevent_get_output(_bev);
			if(buffer != NULL && evbuffer_get_Length(buffer) > 0)
				return;

			_pendclose = false;

			closeConn();
		}
	}

	void TcpConduit::on_event(short wht)
	{
		if((wht & ((BEV_EVENT_EOF | BEV_EVENT_ERROR | BEV_EVENT_TIMEOUT))) > 0)
		{
			forceClose();
		}
	}

	void TcpConduit::getAddr(struct sockaddr_in * addr)
	{
		socklen_t l = sizeof(struct sockaddr_in);
		getpeername(_socket, (struct sockaddr *)addr, &l);
	}

	void TcpConduit::closeConn()
	{
		bufferevent_disable(_bev, EV_WRITE);
		shutdown(_socket, 2);
	}

	void TcpConduit::forceClose()
	{
		bufferevent_disable(_bev, EV_WRITE);
		onDisconnected();
		_host->remove(id());
	}

	void TcpConduit::pendClose()
	{
		struct evbuffer * buffer = bufferevent_get_output(_bev);
		if(buffer == NULL || evbuffer_get_length(buffer) == 0)
		{
			_pendclose = false;
			closeConn();
			return;
		}
		make_no_linger(_socket);
		_pendclose = true;
	}
}
