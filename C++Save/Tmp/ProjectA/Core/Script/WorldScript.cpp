/*************************************************************************
	> File Name: WorldScript.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 30 Mar 2016 09:19:16 AM CST
 ************************************************************************/

#include "Config.h"
#include "WorldScript.h"
#include "GData/Store.h"
#include "GData/Title.h"
#include "GObject/Dungeon.h"
#include "GObject/Player.h"
#include "GObject/Copy.h"
#include "GObject/FrontMap.h"
#include "GObject/Fighter.h"
#include "GObject/World.h"
#include "Server/OidGenerator.h"
#include "GObject/SpecialAward.h"
#include "GameActionLua.h"
#include "Server/Cfg.h"
#include "GObject/HeroIsland.h"
#include "GObject/TeamCopy.h"
#include "GObject/ClanCopy.h"

namespace Script
{
WorldScript::WorldScript( const char * fn)
{
	doFile(fn);
}

void WorldScript::onActivityCheck(UInt32 tm)
{
	call<void>("onActivityCheck", tm);
}

void WorldScript::init()
{
	def("getQixiCard", GObject::World::getQixiCard);
	def("setQixiCard", GObject::World::setQixiCard);
}

void WorldScript::postInit()
{
	call<void>("initSeed", IDGenerator::gSeedOidGenerator.ID());
}

GData::Store * WorldScript::GetStore()
{
	return &GData::store;
}

GData::TitleList * WorldScript::GetTitleList()
{
	return &GData::titleList;
}

void WorldScript::forceCommitArena()
{
	call<void>("forceCommitArena");
}

}

