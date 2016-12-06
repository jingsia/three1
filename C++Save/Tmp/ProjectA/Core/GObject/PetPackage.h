/*************************************************************************
	> File Name: PetPackage.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 21 Mar 2016 09:57:55 AM CST
 ************************************************************************/

#ifndef _PETPACKAGE_H_
#define _PETPACKAGE_H_

namespace GObject
{
	class PetPackage : public Package
	{
	public:
		PetPackage(Player * player);
		~PetPackage();
		void UnInit();

	private:
		UInt16 m_ItemSize;
		UInt16 m_EquipSize;
		ItemCont m_PetItems;
		ItemCont m_PetEquips;
		static const UInt16 INIT_PETGEM_PACK_SIZE = 100;	//初始化仙宠宝石背包大小
		static const UInt16 INIT_PETARM_PACK_SIZE = 200;    //初始化仙宠装备背包大小
	
	public:
		inline UInt16 GetPetGemPgRestSize() const
		{
			return INIT_PETGEM_PACK_SIZE > m_ItemSize ? (INIT_PETGEM_PACK_SIZE - m_ItemSize) : 0;
		}
		inline UInt16 GetPetEqPgRestSize() const
		{
			return INIT_PETARM_PACK_SIZE > m_EquipSize ? (INIT_PETARM_PACK_SIZE - m_EquipSize) : 0;
		}
		inline ItemBase *  FindPetItem(UInt32 id, bool bind = true)
		{
			item_elem_iter iter = m_PetItems.find(ItemKey(id, bind));
			if(iter == m_PetItems.end())
				return NULL;
			return iter->second;
		}
		inline ItemBase * FindPetEquip(UInt32 id, bool bind = true)
		{
			item_elem_iter iter = m_PetEquips.find(ItemKey(id, bind));
			if(iter == m_PetEquips.end())
				return NULL;

			return static_cast<ItemPetEq *>(iter->second);
		}

		ItemBase * AddItemFromDB(UInt32 id, UInt32 num, bool bind);
		ItemBase * AddExitEquip(ItemPetEq * equip, bool fromDB =false);
		ItemPetEq * FindPetEquip(FairyPet *& pet, UInt16 petId, UInt8& pos, UInt64 id);
		ItemBase * AddPetEquip(ItemPetEq *, bool notify = false, UIn16 FromWhere = 0);
		ItemBase * AddPetEquipN(UInt32 typeId, UInt32 num, bool bind = false, bool silence = false, UInt16 FromWhere = 0 );
		bool TryAddPetItem(ItemBase * item, UInt16 num);
		ItemBase* AddPetItem(UInt32 typeId, UInt32 num, bool bind = false, bool notify = false, UInt16 FromWhere = 0);
		bool TryDelPetItem(ItemBase * item, UInt16 num);
		bool DelPetItem(UInt64 id, UInt16 num, bool bind, UInt16 toWhere = 0);
		bool DelPetEquip(UInt64 id, UInt16 toWhere = 0);
		UInt8 MergePetGem(UInt16 gemId1, UInt16 gemId2, UInt16& ogid);
		UInt8 AttachPetGem(UInt32 petId, UInt64 equipId, UInt16 gemId);
		UInt8 DetachPetGem(UInt32 petId, UInt64 equipId, UInt8 gemPos);
		UInt8 UpPetEquip(UInt16 petId, UInt64 equipId);
		void GetHFValue();
		bool EquipTo(UInt64 id, FairyPet * pet, UInt8& pos);
		UInt8 equipUpgrade(UInt32 petId, UInt64 equipId, std::string& idStr);
		UInt64 equipUpgrade(ItemPetEq *, ItemPetEq *);

		void SendPackageItemInfor();
		void AppendEquipData(Stream& st, ItemPetEq * equip);
		void SendSingleEquipData(ItemPetEq * equip, UInt8 type);
		void SendItemData(ItemBase * item);

		ItemBase* AddRandomPetEq(UInt32 score, UInt32 typeId = 0, int cloorIdx = -1, UInt16 FromWhere = 0, bool notify = true);
		ItemBase* AddRandomPetGem(UInt32 score, int lvIdx = -1);
	};
}
#endif
