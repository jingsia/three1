#ifndef _MSGTYPES_H_
#define _MSGTYPES_H_

#include "Common/Queue.h"
#include "Common/Paltform.h"
#define DITYPE UInt64

namespace GObject
{
	class Player;
}

struct MsgHdr
{
	MsgHdr(): desWorkerID(0), cmdID(0), bodyLen(0) {}
	MsgHdr(UInt32 id, UInt8 did, UInt32 blen): desWorkerID(id), cmdID(did), bodyLen(blen) {}
	UInt8	desWorkerID;
	UInt32  cmdID;
	UInt32  bodyLen;
};

struct GameMsgHdr
{
	GameMsgHdr():
		player(NULL) {}
	GameMsgHdr(UInt32 id, UInt8 did, GObject::Player * pl, UInt32 bLen):
		MsgHdr(id, did, bLen), Player(pl) {}

	MsgHdr msgHdr;
	GObject::Player *player;
};

struct LoginMsgHdr
{
	LoginMsgHdr():
		playerID(0), sessionID(0) {}
	LoginMsgHdr(UInt32 id, UInt8 did, IDTYPE pid, int sess, UInt32 blen):
		msgHdr(id, did, blen), playerID(PID), sessionID(sess) {}

	MsgHdr msgHdr;
	IDTYPE playerID;
	int sessionID;
};

typedef Queue<MsgHdr*> MsgQueue;

#endif
