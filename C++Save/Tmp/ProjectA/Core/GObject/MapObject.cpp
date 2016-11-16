/*************************************************************************
	> File Name: MapObject.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Sat 02 Apr 2016 07:33:56 AM CST
 ************************************************************************/

#include "Config.h"
#include "MapObject.h"
#include "Server/WorldServer.h"
#include "Player.h"
#include "MOAction.h"

namespace GObject
{

	MapObject::MapObject(const MOData& moData) : m_MOData(moData)
	{
	}

	MapObject::~MapObject()
	{
	}

	void MapObject::Action(Player* player)
	{
		MOAction::Action(player, GetID(), GetActionType());
	}
}
