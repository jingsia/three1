/*************************************************************************
	> File Name: Core/GObject/Fighter.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 08 Apr 2016 06:11:24 PM CST
 ************************************************************************/

#ifndef _FIGHTER_H_
#define _FIGHTER_H_

#include "GObjectManager.h"

#define ARMORS_MAX 7

#include "Item.h"
#include "GData/AttrExtra.h"
#include "Common/TimeUtil.h"
#include "Server/ServerTypes.h"
#include "GData/SkillTable.h"
#include "GData/CittaTable.h"
#include "GObject/WBossMgr.h"
#include "GObject/Mail.h"
#include "SecondSoul.h"
#include "ShuoShuo.h"

namespace GObject
{

#define GREAT_FIGHTER_MAX	800
#define NPC_FIGHTER_MAX		16384

#define FIGHTER_BUFF_ATTR1		0x01
#define FIGHTER_BUFF_ATTR2		0x02
#define FIGHTER_BUFF_ATTR3		0x03
#define FIGHTER_BUFF_XTHTYT		0x04
#define FIGHTER_BUFF_CRMASGIRL  0x05
#define FIGHTER_BUFF_DRESS		0x07
#define FIGHTER_BUFF_WEDDING	0x08

#define FIGHTER_BUFF_RMAN		0x09
#define FIGHTER_BUFF_RWMAN		0x0A
#define FIGHTER_BUFF_SMAN		0x0B
#define	FIGHTER_BUFF_SWMAN		0x0C
#define FIGHTER_BUFF_DMAN		0x0D
#define FIGHTER_BUFF_DWMAN		0x0E

#define FIGHTER_BUFF_RDIAMOND	0x0F
#define FIGHTER_BUFF_BLUE		0x10
#define FIGHTER_BUFF_QQVIP		0x11
#define FIGHTER_BUFF_SANTA		0x12
}

#endif

