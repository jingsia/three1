#ifndef _SYSMSG_H_
#define _SYSMSG_H_

#include "Common/Stream.h"

namespace GObject
{
	class Player;
}

class SysMsgItem
{
public:
	SysMsgItem(UInt8, const std::string&);
	void send(GObject::Player *);
	void sendva(GObject::Player *, ...);
	void sendva2(UInt16 serverNo, ...);

	void get(char *);
	void getva(char *, ...);
	void geta(std::string& str, ...);
	void getvap(Stream *, ...);

private:
	UInt8 _type;
	std::string _msgBody;
	Stream _stream;
};

class SysMsg
{
public:
	~SysMsg();
	void load();
	void add(UInt32, UInt8, const char *);
	inline SysMsgItem * operator[] (UInt32 idx) { if(idx < _msg.size()) return _msg[idx]; return NULL;}
private:
	std::vector<SysMsgItem *> _msg;
};

extern SysMsg globalSysMsg;

#endif
