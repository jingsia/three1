/*************************************************************************
	> File Name: Item.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 21 Mar 2016 06:49:57 PM CST
 ************************************************************************/

#include "Config.h"
#include "Item.h"
#include "Server/WorldServer.h"

namespace GObject
{

void ItemEquip::DoEquipBind(bool checkType)
{
	if(!m_BindStatus && (!checkType || _itemBaseType->bindType > 0))
	{
		m_BindStatus = true;
		DB4.PushUpDateData("UPDATE `item` SET `bindType` = 1 WHERE `id` = %" I64_FMT "u", _id);
	}
}

}
