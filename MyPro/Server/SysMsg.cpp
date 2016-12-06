#include "Config.h"
#include "SysMsg.h"
#include "GObject/Player.h"
#include "WorldServer.h"
#include "MsgID.h"
#include "Cfg.h"
#include <cstdarg>

#include "Script/Script.h"

class SysMsgScript:
	public Script::Script
{
public:
	SysMsgScript(SysMsg * sysMsg)
	{
		class_add<SysMsg>("SysMsg");
		class_def<SysMsg>("set", &SysMsg::add);
		set("sysMsg", sysMsg);
	}
};

SysMsg globalSysMsg;

SysMsgItem::SysMsgItem(UInt8 type, const std::string& msg): _type(type), _msgBody(msg), _stream(REP::SYSTEM_INFO)
{
	_stream << static_cast<UInt8>(type) << msg << Stream::eos;
}

void SysMsgItem::send(GObject::Player * player)
{
	if(player != NULL)
	{
		player->send(_stream);
	}
	else
		NETWORK()->Broadcast(_stream);
}

void SysMsgItem::sendva(GObject::Player * player, ...)
{
	int size = 256;

	char *p = new(std::nothrow) char[size];
	if(p == NULL)
		return;

	while (1)
	{
		va_list ap;
		va_start(ap, player);
		int n = vsnprintf(p, size, _msgBody.c_str(), ap);
		va_end(ap);

		if(n > -1 && n < size)
			break;

		if(n > -1)
			size = n+1;
		else
			size *= 2;
		delete[] p;
		if((p = new(std::nothrow) char[size]) == NULL)
		{
			return;
		}
	}

	Stream s(REP::SYSTEM_INFO);
	st << _type << p << Stream::eos;
	delete [] p;

	if(player != NULL)
		player->send(st);
	else
		NETWORK()->Broadcast(st);
}

bool enum_send_same_server_no(GObject::Player* player, void * ptr)
{
	struct _data
	{
		UInt16 _serverNo;
		Stream _st;
	};
	_data* curData = reinterpret_cast<_data *>(ptr);
	if(player != NULL && player->GetServerNo() == curData->_serverNo)
		player->send(curData->_st);
	return true;
}

SysMsg::~SysMsg()
{
	for(std::vector<SysMsgItem *>::iterator it = _msg.begin(); it != _msg.end(); ++it)
	{
		if(*it != NULL)
			delete *it;
	}
	_msg.clear();
}

void SysMsg::load()
{
	SysMsgScript script(this);
	std::string path = cfg.scriptPath + "SysMsg.lua";
	script.doFile(path.c_str());
}
