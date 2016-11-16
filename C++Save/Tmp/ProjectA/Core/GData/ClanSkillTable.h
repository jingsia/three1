/*************************************************************************
	> File Name: ClanSkillTable.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 18 Apr 2016 07:31:27 PM CST
 ************************************************************************/

#ifndef _CLANSKILLTABLE_H_
#define _CLANSKILLTABLE_H_

#include <string>

namespace GData
{
struct ClanSkillTableData
{
	ClanSkillTableData(UInt16 id = 0, const std::string& name = std::string(), UInt8 level = 0, UInt32 needs = 0, UInt32 value = 0) :
		id(id), name(name), level(level), needs(needs), value(value) {}

	ClanSkillTableData(const ClanSkillTableData& cstd)
	{
		id = cstd.id;
		name = cstd.name;
		level = cstd.level;
		needs = cstd.needs;
		value = cstd.value;
	}

	ClanSkillTableData operator=(const ClanSkillTableData& cstd)
	{
		id = cstd.id;
		name = cstd.name;
		level = cstd.level;
		needs = cstd.needs;
		value = cstd.value;
		return *this;
	}

	UInt16 id;
	std::string name;
	UInt8 level;
	UInt32 needs;
	float value;
};

typedef std::vector<ClanSkillTableData> SingClanSkillTable;
typedef std::vector<SingleClanSkillTable> ClanSkillTable;

extern ClanSkillTable clanSkillTable;

}
#endif
