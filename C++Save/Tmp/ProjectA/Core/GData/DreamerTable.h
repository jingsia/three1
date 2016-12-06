/*************************************************************************
	> File Name: DreamerTable.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 20 Apr 2016 05:24:49 AM CST
 ************************************************************************/

#ifndef _DREAMER_H_
#define _DREAMER_H_

#include "Config.h"
#include "Common/StringTokenizer.h"

namespace GData
{

typedef std::map<UInt16, UInt8> GridTypeCount;

struct DreamerLevelData
{
	UInt8 maxX;
	UInt8 maxY;
	UInt8 maxGrid;
	UInt8 timeConsume;
	GridTypeCount gridTypeCount;	//每层地图种类的最大数量
	DreamerLevelData()
		: maxX(0), maxY(0), maxGrid(0), timeConsume(0)
	{
	}
	DreamerLevelData(UInt8 x, UInt8 y, UInt8 count, UInt8 time, const std::string& typeCount)
		: maxX(x), maxY(y), maxGrid(count), timeConsume(time)
	{
		StringTokenizer tokenizer(typeCount, "|");
		for(size_t i = 0; i < tokenizer.count(); ++i)
		{
			StringTokenizer tk(tokenizer[i], ",")
			if(tk.count() >= 2)
			{
				UInt16 type = atoi(tk[0].c_str());
				UInt8 count = atoi(tk[1].c_str());
				gridTypeCount.insert(std::make_pair(type, count));
			}
		}
	}
};

typedef std::vector<DreamerLevelData> DreamerData;
typedef std::vector<DreamerData> DreamerDataTable;

extern DreamerDataTable dreamerDataTable;

}

#endif
