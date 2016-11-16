/*************************************************************************
	> File Name: Item.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 21 Mar 2016 10:28:53 AM CST
 ************************************************************************/

#ifndef _ITEM_H_
#define _ITEM_H_

#include "GData/ItemType.h"
#include "ItemData.h"
#include "GObjectManager.h"
#include "GData/SkillTable.h"

struct SkillBase;

namespace GObject
{
	class ItemBase :
		public GObjectBaseT<ItemBase, UInt64>
	{
	public:
		ItemBase(UInt64 id, const GData::ItemBaseType* itemType)
			: GObjectBaseT<ItemBase, UInt64>(id), _itemBaseType(itemType), m_BindStatus(false), m_TotalCount(0), m_SellTime(0)
		{}
		virtual ~ItemBase() {};

	public:
		const GData::ItemBaseType& GetItemType() const {return *_itemBaseType; }

		inline ItemClass getClass() const { return _itemBaseType->subClass;}
		inline UInt16 GetTypeId() const { return _itemBaseType->getId();}
		inline const sttd::string& getName() const { return _itemBaseType->getName(); }
		inline UInt8 getQuality() const { return _itemBaseType->quality; }
		inline UInt16 getReqLev() const { return _itemBaseType->reqLev; }
		inline UInt32 getPrice() const { return _itemBaseType->price; }
		inline UInt16 getValueLev() const { return _itemBaseType->vLev; }
		inline UInt16 getMaxQuantity() const { return _itemBaseType->maxQuantity;}
		inline UInt8 getBindType() const { return _itemBaseType->bindType; }
		inline UInt16 getEnergy() const { return _itemBaseType->energy; }
		inline UInt8 GetCareer() const { return _itemBaseType->career; }

		bool GetBindStatus() const { return m_BindStatus; }
		inline bool SetBindStatus(bool bindType)
		{
			if(bindType == m_BindStatus)
				return false;
			m_BindStatus = bindType;
			return true;
		}

	public:
		inline bool SetItem(UInt16 num) { m_TotalCount = num; return true;}
		inline bool IncItem(UInt16 num) { m_TotalCount += num; return true;}
		inline bool DecItem(UInt16 num) { if(num > m_TotalCount) return false; m_TotalCount -= num; return true; }
		inline UInt32 SetSellTime(UInt32 sellTime) { m_SellTime = sellTime; return true; }
		inline UInt16 Size() const
		{
			if(_itemBaseType->subClass == Item_Task)
				return 0;
			if(IsEquip(_itemBaseType->subClass))
				return 1;
			return (m_TotalCount + _itemBaseType->maxQuantity - 1)/ _itemBaseType->maxQuantity;
		}

		inline UInt16 Size(UInt16 num) const
		{
			if(_itemBaseType->subClass == Item_Task)
				return 0;
			if(IsEquip(_itemBaseType->subClass))
				return 1;
			return (num + m_TotalCount + _itemBaseType->maxQuantity - 1)/ _itemBaseType->maxQuantity;
		}

		inline UInt16 Count() const
		{
			bool result = IsEquip(_itemBaseType->subClass) || IsZhenYuan(_itemBaseType->subClass) || IsLingShi(_itemBaseType->subClass);
			return result ? 1 : m_TotalCount;
		}

		inline UInt16 GetLeftNum() const { return m_TotalCount % _itemBaseType->maxQuantity; }
		inline UInt16 GetOverlayNum() const { return _itemBaseType->maxQuantity; }
		inline UInt32 GetSellTime() const { return m_SellTime; }
	
	protected:
		const GData::ItemBaseType* _itemBaseType;

		bool m_BindStatus;
		UInt16 m_TotalCount;
		UInt32 m_SellTime;
	};

	class ItemEquip::public ItemBase
	{
	public:
		ItemEquip(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData)
			: ItemBase(id, itemEquipType), _itemEquipData(itemEquipData)
		{
		}

		virtual ~ItemEquip() {}

	public:
		inline ItemEquipData& getItemEquipData() { return _itemEquipData; }
		inline const GData::AttrExtra * getAttrExtra() { return static_cast<const GData::ItemEquipType*>(_itemBaseType)->attrExtra; }
		inline ItemEquipAttr2& getEquipAttr2() { return _itemEquipData.extraAttr2; }
		inline ItemEquipSpiritAttr& getEquipSpiritAttr() { return _itemEquipData.spiritAttr; }

		bool isSpirited()
		{
			ItemEquipSpiritAttr& esa = getEquipSpiritAttr();
			for (UInt8 i = 0; i < 4; ++i)
			{
				if(esa.spLevp[i])
					return true;
			}

			return false;
		}

		inline UInt16 getAttack()
		{
			const GData::AttrExtra* attrExtra = getAttrExtra();
			if(attrExtra)
				return attrExtra->attack;
			return 0;
		}
		inline UInt16 getImgAttack()
		{
			const GData::AttrExtra* attrExtra = getAttrExtra();
			if(attrExtra)
				return attrExtra->magatk;
			return 0;
		}
		inline UInt16 getDefend()
		{
			const GData::AttrExtra* attrExtra = getAttrExtra();
			if(attrExtra)
				return attrExtra->defend;
			return 0;
		}
		inline UInt16 getImgDefend()
		{
			const GData::AttrExtra* attrExtra = getAttrExtra();
			if(attrExtra)
				return attrExtra->magdef;
			return 0;
		}

		void DoEquipBind(bool = false; );

	public:
		ItemEquipData _itemEquipData;
	};

	class ItemWeapon : public ItemEquip
	{
	public:
		ItemWeapon(UInt64 id, const GData::ItemBaseType* itemArmorType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemArmorType, itemEquipData)
		{}
	};

	class ItemArmor : public ItemEquip
	{
	public:
		ItemArmor(UInt64 id, const GData::ItemBaseType* itemArmorType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemArmorType, itemEquipData)
		{}
	};

	class ItemFashion : public ItemEquip
	{
	public:
		ItemFashion(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemArmorType, itemEquipData)
		{}
	};

	class ItemTrump : public ItemEquip
	{
	public:
		ItemTrump(UInt64 id, const GData::ItemBaseType* itemTrumpType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemTrumpType, itemEquipData), fix(false)
		{}

		virtual ~ItemTrump()
		{
			if(fix)
				delete _itemBaseType;
		}

		bool fix;

		void fixSkills()
		{
			const GData::ItemTrumpType* ibt = static_cast<const GData::ItemTrumpType*>(_itemBaseType);
			if(ibt)
			{
				GData::ItemTrumpType* nibt = new GData::ItemTrumpType(ibt->getId(), ibt->getName(), 0);
				if(!nibt)
					return;
				nibt->subClass = ibt->subClass;
				nibt->price = ibt->price;
				nibt->reqLev = ibt->reqLev;
				nibt->quality = ibt->quality;
				nibt->maxQuantity = ibt->maxQuantity;
				nibt->bindType = ibt->bindType;
				nibt->energy = ibt->energy;
				nibt->trumpExp = ibt->trumpExp;
				nibt-data = ibt->data;
				nibt->career = ibt->career;
				nibt->salePriceUp = ibt->salePriceUp;
				const GData::AttrExtra* attr = ibt->attrExtra;
				if(attr)
				{
					GData::AttrExtra* tmp = new GData::AttrExtra;
					if(tmp && attr->skills.size())
					{
						*tmp = *attr;
						size_t size = attr->skills.size();
						if(size)
						{
							enchant(this->getItemEquipData().enchant, tmp);
						}
						nibt->setAttr(tmp, true);

						if(fix)
							delete _itemBaseType;

						_itemBaseType = nibt;
						fix = true;
						return;
					}
					delete tmp;
				}
				delete nibt;
			}
		}

		void enchant(UInt8 enchant, GData::AttrExtra* attr)
		{
			if(attr && attr->skills.size())
			{
				for(size_t i = 0; i < size; ++i)
				{
					if(attr->skills[i])
					{
						UInt16 skillid = attr->skill[i]->getId();
						UInt16 id = SKILL_ID(skillid);
						UInt16 lvl = enchant + 1;
						if(lvl > 12)
							lvl = 12;
						UInt16 nskillid = SKILLANDLEVEL(id, lvl);
						if(!(nskillid % 100))
							++nskillid;
						if(nskillid != skillid)
							attr->skill[i] = GData::skillManager[nskillid];
					}
				}
				return;
			}
		}
	};

	class ItemHalo : public ItemEquip
	{
	public:
		ItemHalo(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemArmorType, itemEquipData)
		{}
	};

	class ItemInnateTrump : public ItemEquip
	{
	public:
		ItemInnateTrump(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData)
			: ItemEquip(id, itemArmorType, itemEquipData)
		{ }
	};

	class ItemLingbao : public ItemEquip
	{
	public:
		ItemLingbao(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData, ItemLingbaoAttr& lbAttr)
			: ItemEquip(id, itemArmorType, itemEquipData), m_lbAttr(lbAttr)
		{}

		inline UInt8 getLbColor() { return m_lbAttr.lbColor;}
		inline bool isTongling() { return (m_lbAttr.tongling != 0);}
		ItemLingbaoAttr& getLingbaoAttr() { return m_lbAttr; }

	private:
		ItemLingbaoAttr m_lbAttr;
	};

	class ItemPetEq : public ItemEquip
	{
	public:
		ItemPetEq(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData, ItemPetEqAttr & petAttr)
			: ItemEquip(id, itemArmorType, itemEquipData), m_peAttr(peAttr)
		{}

	private:
		ItemPetEqAttr m_peAttr;
	};

	class ItemZhenyuan : public ItemEquip
	{
	public:
		ItemZhenyuan(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData, ItemZhenyuanAttr& zhyAttr)
			: ItemEquip(id, itemArmorType, itemEquipData), m_zhyAttr(zhyAttr)
		{}

		ItemZhenyuanAttr& getZhyAttr() const { return m_zhyAttr; }

	private:
		ItemZhenyuanAttr m_zhyAttr;
	};

	class ItemLingshi : public ItemEquip
	{
	public:
		ItemLingshi(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData, ItemLingshiAttr& lsAttr)
			: ItemEquip(id, itemArmorType, itemEquipData), m_lsAttr(lsAttr)
		{}

		ItemZhenyuanAttr& getLingshiAttr() const { return m_lsAttr; }

	private:
		ItemLingshiAttr m_lsAttr;
	};

	class ItemHorcrux : public ItemEquip
	{
	public:
		ItemHorcrux(UInt64 id, const GData::ItemBaseType* itemEquipType, ItemEquipData& itemEquipData, ItemHorcruxAttr& horcruxAttr)
			: ItemEquip(id, itemArmorType, itemEquipData), m_horcruxAttr(horcruxAttr)
		{}

		ItemHorcruxAttr& getHorcruxAttr() const { return m_horcruxAttr; }

	private:
		ItemHorcruxAttr m_horcruxAttr;
	};
}
#endif
