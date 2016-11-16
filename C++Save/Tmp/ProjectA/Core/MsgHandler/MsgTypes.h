/*************************************************************************
	> File Name: MsgTypes.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 18 Mar 2016 02:04:28 PM CST
 ************************************************************************/
#ifndef _MSGTYPES_H_
#define _MSGTYPES_H_

#include "Common/Queue.h"

namespace GObject
{
	class Player;
}

struct MsgHdr
{
	MsgHdr() : desWorkerID(0), cmdID(0), bodyLen(0) {}
	MsgHdr(UInt32 id, UInt8 did, UInt32 blen) : desWorkerID(did), cmdID(id), bodyLen(blen) {}
	UInt8 desWorkerID;
	UInt32 cmdID;
	UInt32 bodyLen;
};

struct GameMsgHdr
{
	GameMsgHdr() : player(NULL) {}
	GameMsgHdr(UInt32 id, UInt8 did, GObject::Player * pl, UInt32 blen) :
		msgHdr(id, did, blen), player(pl) {}

	MsgHdr msgHdr;
	GObject::Player * player;
};

struct LoginMsgHdr
{
	LoginMsgHdr() :
		playerID(0), sessionID(0) {}

	LoginMsgHdr(UInt32 id, UInt8 did, UInt64 pid, int sess, UInt32 blen):
		msgHdr(id, did, blen), playerID(pid), sessionID(sess) {}
	MsgHdr msgHdr;
	UInt64 playerID;
	int sessionID;
};

typedef Queue<MsgHdr *> MsgQueue;
#endif
