/*************************************************************************
	> File Name: HoneyFall.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 15 Mar 2016 09:26:57 AM CST
 ************************************************************************/

#ifndef _HONEYFALL_H_
#define _HONEYFALL_H_

#include "Config.h"

namespace GObject
{

	class Player;

	enum HoneyFallType
	{
		e_HFT_None			= 0,
		e_HFT_Equip_Enchant = 1,
		e_HFT_Trump_Enchant = 2,
		e_HFT_Trump_SJ		= 3,
		e_HFT_Trump_JF		= 4,
		e_HFT_MAX,
	};

	class HoneyFall
	{
		public:
			HoneyFall(Player * pl);
			~HoneyFall();

			void updateHftValueToDB(HoneyFallType hft);
			UInt32 getHftValue(HoneyFallType hft);
			void setHftValue(UInt8 hft, UInt32 value);
			UINt32 incHftValue(HonyeFallType hft, UInt32 inc = 1);
			bool checkHft(UInt8 hft);
			UInt32 getChanceFromHft(UINt8 q, UInt8 lv, HoneyFallType hft);

		private:
			UInt32 m_hft_value[e_HFT_MAX];
			Player * m_owner;
	};
}

#endif
