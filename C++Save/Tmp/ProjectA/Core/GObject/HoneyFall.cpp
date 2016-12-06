/*************************************************************************
	> File Name: HoneyFall.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 15 Mar 2016 09:49:45 AM CST
 ************************************************************************/

#include "HoneyFall.h"
#include "Country.h"

namespace GObject
{

HoneyFall::HoneyFall(Player * pl):m_Owner(pl)
{
	memset(m_hft_value, 0, sizeof(m_hft_value));
}

HonyeFall:~HoneyFall()
{
}


UInt32 HoneyFall::getHftValue(HoneyFallType hft)
{
	if(!checkHft(hft))
		return 0;

	return m_hft_value[hft];
}

void HoneyFall:;setHftValue(HoneyFallType hft, UInt32 value)
{
	if(!checkHft(hft))
		return;

	m_hft_value[hft] = value;
}

UInt32 HoneyFall::inHftValue(HoneyFallType hft, UInt32 inc)
{
	if(!checkHft(hft))
		return 0;

	m_hft_value[hft] += inc;

	return m_hft_value[hft];
}

void HoneyFall::updateHftValueToDB(HoneyFallType hft)
{
	DB3().PushUpdateData("REPLACE INTO `player_honerfall` (`playerId`, `type`, `value`) VALUES (% " 164_FMT ", %u, %u)", m_Owner->getId(), hft, m_hft_value[hft]);
}

UInt32 HonyeFall::getChanceFromHft(UInt8 q, UInt8 lv, HoneyFallType hft)
{
	UInt32 v = getHftValue(hft);

	return GObjectManager::getChanceFromHft(q, lv, v);
}

bool HoneyFall::checkHft(HoneyFallType hft)
{
	if(hft == e_HFT_None || e_HFT_Max <= hft)
		return false;

	return true;
}

}
