/*************************************************************************
	> File Name: ItemData.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 21 Mar 2016 01:25:32 PM CST
 ************************************************************************/

#ifndef _ITEMDATA_H_
#define _ITEMDATA_H_

#include "Common/Stream.h"

#define ENCHANT_LEVEL_MAX 10
#define TRUMP_ENCHANT_LEVEL_MAX 10
#define SOCKETS_MAX 6

namespace GObject
{
	struct ItemData
	{
		UInt64 id;
		UInt64 ownerId;
		UInt16 itemNum;
		UInt8 bindType;

		bool operator < (const ItemData& item) const
		{
			return ownerId < item.ownerId;
		}
	};

	struct TempItemData
	{
		UInt64 id;
		UInt64 ownerId;
		UInt16 itemNum;
		UInt8 bind;
		UInt32 sellTime;

		bool operator < (const TempItemData& item) const
		{
			return ownerId < item.ownerId;
		}
	};

	struct ItemEquipAttr2
	{
		ItemEquipAttr2() : type1(0), type2(0), type3(0), value1(0), value2(0), value3(0) {}

		UInt8 type1;
		UInt8 type2;
		UInt8 type3;
		UInt16 value1;
		UInt16 value2;
		UInt16 value3;

		inline UInt8 getCount()
		{
			if(type1 != 0)
			{
				if(type2 != 0)
				{
					if(type3 != 0)
						return 3;
					return 2;
				}
				return 1;
			}
			return 0;
		}

		inline void appendAttrToStream(Stream& st)
		{
			if(type1 != 0)
			{
				if(type2 != 0)
				{
					if(type3 != 0)
						st << static_cast<UInt8>(3) << type1 << value1 << type2 << value2 << type3 << value3;
					else
						st << static_cast<UInt8>(2) << type1 << value1 << type2 << value2;
				}
				else
					st << static_cast<UInt8>(1) << type1 << value1;
			}
			else
				st << static_cast<UInt8>(0);
		}
	};

	struct ItemEquipSpiritAttr
	{
		UInt16 spLev[4];
		UInt8 spForm[3];

		ItemEquipSpiritAttr() { memset(spLev, 0, sizeof(spLev)); memset(spForm, 0, sizeof(spForm));}

		inline void appendAttrToStream(Stream& st)
		{
			st << spLev[0] << spLev[1] << spLev[2] << spLev[3];
			st << spForm[0] << spForm[1] << spForm[2];
		}
	};

	struct ItemEquipData
	{
		UInt8 sockets;
		UInt8 enchant;
		UInt8 tRank;
		UInt8 maxTRank;
		UInt8 trumpExp;
		UInt16 gems[SOCKETS_MAX];
		ItemEquipAttr2 extraAttr2;
		ItemEquipSpiritAttr spiritAttr;

		ItemEquipData () : sockets(0), enchant(0), tRank(0), maxTRank(0), trumpExp(0) { memset(gems, 0, sizeof(gems));}
	};

	struct ItemLingbaoAttr
	{
		UInt8 tongling;
		UInt8 lbColor;
		UInt8 type[4];
		UInt16 value[4];
		UInt16 skill[2];
		UInt16 factor[2];
		UInt32 battlePoint;

		ItemLingbaoAttr() : tongling(0), lbColor(0), battlePoint(0)
		{
			memset(type, 0, sizeof(type));
			memset(value, 0, sizeof(value));
			memset(skill, 0, sizeof(skill));
			memset(factor, 0, sizeof(factor));
		}

		inline void appendAttrToStream(Stream& st)
		{
			if(tongling == 0)
			{
				UInt8 zero8 = 0;
				UInt16 zero16 = 0;
				st << zero8 << lbColor << zero8;
				st << zero16 << zero16 << zero16 << zero16;
			}
			else
			{
				st << tongling << lbColor;
				UInt8 cnt = 0;
				size_t offset = st.size();
				st << cnt;
				for(int i = 0; i < 4 ; ++i)
				{
					if(type[i] != 0)
					{
						st << type[i] << value[i];
						++cnt;
					}
				}

				st.data<UInt8>(offset) = cnt;
				if(skill[0])
					st << skill[0] << factor[0] << skill[1] << skill[2];
				else
					st << skill[1] << factor[1] << skill[0] << factor[0];
			}
		}

		UInt16 getType(UInt8 i)
		{
			if(i > 0 && i < 4)
				return type[i];

			return 0;
		}

		UInt16 getValue(UInt8 i)
		{
			if(i >= 0 && i < 4)
				return value[i];
			return 0;
		}
	};

	struct ItemPetAttr
	{
		UInt8 lv;
		UInt32 exp;
		UInt32 skill;
		UInt16 gems[4];
		ItemPetAttr() : lv(0), exp(0), skill(0) { memset(gems, 0, sizeof(gems));}

		inline void appendAttrToStream(Stream& st)
		{
			st << skill << lv << exp;
			UInt8 count = 0;
			size_t pos = st.size();
			st << count;
			for(UInt8 z = 0; z < sizeof(gems)/ sizeof(gems[0]) ; ++ z)
			{
				if(gems[z] > 0)
				{
					count |= (1<<z);
					st << gems[z];
				}
			}

			st.data<UInt8>(pos) = count;
		}
	};

	struct ItemZhenyuanAttr
	{
		UInt8 color;
		UInt8 type[4];
		UInt16 value[4];
		UInt16 typeExtra[2];
		UInt16 valueExtra[2];

		ItemZhenyuanAttr() : color(0)
		{
			memset(type, 0, sizeof(type));
			memset(value, 0, sizeof(value));
			memset(typeExtra, 0, sizeof(typeExtra));
			memset(valueExtra, 0, sizeof(valueExtra));
		}

		inline void appendAttrToStream(Stream& st)
		{
			UInt8 cnt = 0, cnt1 = 0, cnt2 = 0;
			size_t offset = st.size();
			st << cnt;
			for(int i = 0; i < 4; ++i)
			{
				if(type[i] != 0)
				{
					st << type[i] << value[i];
					++ cnt1;
				}
			}

			for(int i = 0; i < 2; ++i)
			{
				if(typeExtra[i] != 0)
				{
					st << typeExtra[i] << valueExtra[i];
					++cnt2;
				}
			}
			cnt = (cnt2 << 4) | cnt1;
			st.data<UInt8>(offset) = cnt;
		}

		UInt8 getAttrNum()
		{
			UInt8 count = 0;
			for(int i = 0; i < 2; ++i)
			{
				if(typeExtra[i] > 0)
					++count;
			}
			return count;
		}
	};

	struct ItemLingshiAttr
	{
		UInt8 lv;
		UInt32 exp;

		IemLingshiAttr(): lv(1), exp(0) {}
	};

	struct ItemHorcruxAttr
	{
		UInt32 attr[4];

		ItemHorcruxAttr()
		{
			memset(attr, 0, sizeof(attr));
		}

		void setAttr(UInt32 value0, UInt32 value1, UInt32 value2, UInt32 value3)
		{
			attr[0] = value0;
			attr[1] = value1;
			attr[2] = value2;
			attr[3] = value3;
		}
		UInt32 getAttr(UInt8 index) {if(index > 3) return 0; return attr[index];}

		const ItemHorcruxAttr& operator=(ItemHorcruxAttr& other) const
		{
			for(size_t i = 0 ; i < sizeof(attr)/sizeof(attr[0]); ++i)
			{
				attr[i] = other.attr[i];
			}
		}
	};

}

#endif
