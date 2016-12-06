/*************************************************************************
	> File Name: WorldScript.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 30 Mar 2016 09:04:02 AM CST
 ************************************************************************/

#ifndef _WORLDSCRIPT_H_
#define _WORLDSCRIPT_H_

#include "Script.h"

namespace GData
{
	class Store;
	class TitleList;
}

namespace Script
{

class WorldScript:
	public Script
{
public:
	WorldScript(const char *);
	void init();
	void postInit();
	void onActivityCheck(UInt32);
	UInt32 onAthleticsNewBox(UInt8, UInt32);
	void forceCommitArena();

	static GData::Store * GetStore();
	static GData::TitleList * GetTitleList();
};

}

#endif
