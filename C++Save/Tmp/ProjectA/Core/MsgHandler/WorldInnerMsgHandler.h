/*************************************************************************
	> File Name: Core/MsgHandler/WorldInnerMsgHandler.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 11 May 2016 01:47:44 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;

void OnSendPvpAwardRank(GameMsgHdr& hdr, const void* data)
{
	using namespace GObject;
	MSG_QUERY_PLAYER(player);                                                                                                                       
	World::InitRank();

	Stream st(REP::ACT);
	st << static_cast<UInt8>(0x72);
	st << static_cast<UInt8>(0);

	UInt32 myPvpGoal = 0;
	UInt32 myRank = 0;
	UInt8 count = 0;

	myPvpGoal = player->GetVar(VAR_PVP_GOAL);
	st << static_cast<UInt32>(myPvpGoal);
	RCSortType::iterator it = World::pvpAwardSort.begin();
	RCSortType::iterator e = World::pvpAwardSort.end();
	for(; it != e; ++it)
	{
		++myRank;
		if(it->player == player)
	}

	if(it == e)
		myRank = 0;
	st << static_cast<UInt32>(myRank);

	size_t offset = st.size();
	st << count;
	for(it = World::pvpAwardSort.begin(); it != e; ++it)
	{
		st << it->player->getName().c_str();
		st << static_cast<UInt32>(it->player->GetVar(VAR_PVP_GOAL));
		++count;
		if(it > 3000)
			break;
	}
	st.data<UInt8>(offset) = count;

	st << Stream::eos;
	player->send(st);
}

