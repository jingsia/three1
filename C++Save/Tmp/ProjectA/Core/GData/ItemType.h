/*************************************************************************
	> File Name: ItemType.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Mar 2016 10:20:19 AM CST
 ************************************************************************/

#ifndef _ITEM_TYPE_H_
#define _ITEM_TYPE_H_

#include "AttrExtra.h"
#include "WeponDef.h"


#define L_LINGZHU_ID 21607
#define R_LINGZHU_ID 21721

enum ItemQuality
{
	Item_Green	= 1,
	Item_Blue	= 2,
	Item_Purple	= 3,
	Item_Yellow = 4,
	Item_Red	= 5,

	Item_Quality_Max
};

enum ItemClass
{
	Item_None	= 0,
	Item_Armor1 = 1,
	Item_Armor2,

	Item_Wepon = 200,

	/*and so on*/
	Item_Class_Max
}


inline bool IsEquipId(UInt64 id)
{
	return id > 25000;
}

inline bool IsEquipTypeId(UInt32 id)
{
	return (id >= LARM_ID && ID <= RARM_ID) || (id >= LBMIN_ID && id <= LBMAX_ID);
}

inline bool IsLingbaoTypeId(UInt32 id)
{
	return id >= LBMIN_ID && id <= LBMAX_ID;
}

inline bool IsPetEquipTypeId(UInt3 id)
{
	return id >= LPETARM_ID && id <= RPETARM_ID;
}

inline bool IsPetItem(UInt32 id)
{
	return id >= LPETGEM_ID && id <= RPETGEM_ID;
}

inline bool IsGemId(UInt32 id)
{
	return id >= LGEM_ID && id <= RGEM_ID;
}

/***********************************************/

inline bool IsEquip(UInt8 subClass)
{
	return (subClass >= static_cast<UInt8>(Item_Weapon) && subClass <= static_cast<UInt8>(Item_InnateTrump) || (subClass >= static_cast<UInt8>(Item_Evolution) && subClass <= static_cast<UInt8>(Item_Evolution3)));
}

inline bool IsLingzhu(UInt8 subClass)
{
	return (subClass >= static_cast<UInt8>(Item_Jin) && subClass <= static_cast<UInt8>(Item_tu));
}


namespace GData
{
	struct ItemBaseType: public ObjectBaseT<UInt64>
	{
		ItemClass	subClass;
		UInt32      price;
		UInt16      reqLev;
		UInt16      vLev;
		UInt8		quality;
		UInt16      maxQuantity;
		UInt8       bindType;
		UInt16      energy;
		UInt32      trumpExp;
		UInt16      data;
		UInt8       career;
		float       salePriceUp;

		ItemBaseType(UInt64 id, std::string& n = "") : ObjectBaseT<UInt64>(id, n) {}
		virtual ~ItemBaseType() {}
		bool operator <(const ItemBaseType& other) const  {return getId() < other.getId();}
		bool operator ==(const ItemBaseType& other) const {return getId() == other.getId();}
		inline UInt16 Size(UInt16 num) const
		{
			if(subClass == Item_Task)
				return 0;
			if(IsEquip(subClass))
				return num;
			return (num + maxQuantity - 1) / maxQuantity;
		}
	};

	struct ItemNormalType : public ItemBaseType
	{
		ItemNormalType(UInt32 id = 0, const std::string n = "") : ItemBaseType(id, n) {}
		virtual ~ItemNormalType() {}
	};

	struct ItemGemType : public ItemBaseType
	{
		const AttrExtra* attrExtra;
		ItemGemType(UInt32 id, std::string n = "", UInt32 attrId = 0) : ItemBaseType(id, n)
		{
			const AttrExtraItem * attr = attrExtraManager[attrId];
			if(attr)
				attrExtra = *attr;
			else
				attrExtra = NULL;
		}

		virtual ~ItemGemType() {}
	};

	struct ItemEquipType : public ItemBaseType
	{
		const AttrExtra* attrExtra;
		bool fix;

		ItemEquipType(UInt32 id, std::string n = "", UInt32 attrId = 0) : ItemBaseType(id, n), fix(false)
		{
			const AttrExtraItem * attr = attrExtraManager[attrId];	
			if(attr)
				attrExtra = *attr;
			else
				attrExtra = NULL;
		}

		void setAttr(const AttrExtra* attr, bool fix = false)
		{
			if(this->fix)
				delete attrExtra;
			attrExtra = attr;
			this->fix = fix;
		}

		virtual ~ItemEquipType()
		{
			if(fix && attrExtra)
				delete attrExtra;
		}
	};

	struct ItemWeaponType : public ItemEquipType
	{
		ItemWeaponType(UInt32 id = 0, std::string n = "", UInt32 attrId = 0) : ItemWeaponType(id, name, attrId) {}
	};

	struct ItemEquipSetType:
		public ObjectBaseT<>
	{
		const AttrExtra* attrExtra[4];

		ItemEquipSetType(UInt32 id = 0, std::string n = "") : ObjectBaseT<>(id, n) {}
	};

	typedef ObjectListT<ItemBaseType> ItemBaseTypeManager;
	typedef ObjectMapT<ItemBaseType, std::string> ItemBaseTypeNameManager;
	extern ItemBaseTypeManager itemBaseTypeManager;
	extern ItemBaseTypeNameManager itemBaseTypeNameManager;
	extern std::vector<ItemGemType *> gemTypes;
	extern std::vector<ItemGemType *> lingzhuTypes;
	typedef ObjectListT<ItemEquipSetType> ItemEquipSetTypeManager;
	extern ItemEquipSetTypeManager evolutionTypes;

#define ITEM_BIND_CHECK(bindType, bind) \
	if(!bind && bindType == 1) bind = true;

}
#endif
