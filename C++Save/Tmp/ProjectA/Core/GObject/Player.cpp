/*************************************************************************
	> File Name: Player.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 15 Mar 2016 10:17:00 AM CST
 ************************************************************************/

namespace GObject {
Player::Player()
{

	m_hf = new HoneyFall(this);
}

Player::~Player()
{
	delete m_hf;
	m_hf = NULL;
}

HoneyFall * Player::getHoneyFall()
{
	return m_hf;
}

void Player::UpdatePvpRank(UInt32 goal)
{    
	AddVar(VAR_PVP_GOAL, goal);
	for(RCSortType::iterator it = World::pvpAwardSort.begin(), e = World::pvpAwardSort.end(); it != e; ++it)
	{    
		if(it->player == this)
		{    
			World::pvpAwardSort.erase(it);
			break;
		}    
	}    

	RCSort s;
	s.player = this;
	s.total = this->GetVar(VAR_PVP_GOAL);
	World::pvpAwardSort.insert(s);

	GameMsgHdr hdr(0x101, WORKER_THREAD_WORLD, this, 0);
	GLOBAL().pushMsg(hdr, NULL);                                                                                                                
}

}
