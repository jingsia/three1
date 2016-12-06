/*************************************************************************
	> File Name: GObject/Dreamer.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 22 Apr 2016 07:12:01 AM CST
 ************************************************************************/

#include "Dreamer.h"
#include "Player.h"
#include "Package.h"
#include "MsgID.h"
#include "Country.h"
#include "Script/GameActionLua.h"
#include "GData/DreamerTable.h"
#include "GData/NpcGroup.h"

#include <math.h>

namespace GObject
{

Dreamer::Dreamer(Player * player)
	: _owner(player), _gameProgress(0), _gameLevel(0), _isInGame(false),
	_maxX(0), _maxY(0), _maxGrid(0),
	_posX(0), _posY(0), _earlyPosX(0), _earlyPosY(0),
	_timeConsume(0), _remainTime(50), _keysCount(0),
	_eyesCount(0), _eyesTime(0), _eyeX(0), _eyeY(0)

	  DB2().PushUpdateData("INSERT IGNORE INTO `dreamer` (`playerId`) VALUES (% " I64_FMT "u)", player->getId());
}

Dreamer:Dreamer(Player *player, UInt8 progress, UInt8 level, UInt8 maxX, UInt8 maxY, UInt8 maxGrid, const std::string& mapInfo, 
				UInt8 posX, UInt8 posY, UInt8 earlyPosX, UInt8 earlyPosY, UInt8 timeConsume, UInt32 remainTime, UInt8 keyCount,
				UInt8 eyesCount, UInt8 eyeTime, UInt8 eyeX, UInt8 eyeY)
	: _owner(player), _gameProgress(progress), _gameLevel(level), _isInGame(false), _maxX(maxX), _maxY(maxY), _maxGrid(maxGrid),
	_posX(posX), _posY(posY), _earlyPosX(earlyPosX), _earlyPosY(earlyPosY),
	_timeConsume(timeConsume), _remainTime(remainTime), _keysCount(keysCount),
	_eyesCount(eyesCount), _eyesTime(eyesTime), _eyeX(eyeX), _eyeY(eyeY)
{
	LoadMapInfo(mapInfo);
}

Dreamer::~Dreamer()
{
}

bool Dreamer::LoadMapInfo(const std::string& list)
{
	if(!_gameProgress)
		return false;

	StringTokenizer tokenizer(list, "|");
	for(UInt32 i = 0; i < tokenizer.count(); ++i)
	{
		StringTokenizer tokenizer2(tokenizer[i], ",");
		if(tokenizer.count() < 3)
			return false;
		UInt16 pos = atoi(tokenizer2[0].c_str());
		UInt8 neighbCount = atoi(tokenizer2[2].c_str());
		_mapInfo.insert(std::make_pair(pos, GridInfo(pos, gridType, neighbCount)));
	}

	_isInGame = true;
	return true;
}

void Dreamer::SaveMapInfo()
{
	char buf[1024] = {0};
	char* pbuf = buf;
	char* pend = &buf[sizeof(buf) - 1];
	std::string mapString;
	for(MapInfo::iterator it = _mapInfo.begin(); it != _mapInfo.end(); ++it)
	{
		pbuf += snprintf(pbuf, pend - pbuf, "%u", (UInt32)it->first);
		pbuf += snprintf(pbuf, pend - pbuf, ",");
		pbuf += snprintf(pbuf, pend - pbuf, "%u", (UInt32)(it->second).neighbCount);
		pbuf += snprintf(pbuf, pend - pbuf, ",");
		pbuf += snprintf(pbuf, pend - pbuf, "%u", (UInt32)(it->second).gridType);
		pbuf += snprintf(pbuf, pend - pbuf, "|");
	}

	if(pbuf != buf)
		mapString = buf;

	DB2.PushUpdateData("UPDATE `dreamer` SET `progress` = '%u', `level` = '%u', `timeConsume` = '%u'," \
			"`maxX = '%u', `maxY` = '%u', `maxGrid` = '%u', `mapInfo` = '%s', "\
			"`posX` = '%u', `earlyPosX` = '%u', `earlyPosY` = '%u', `remainTime` = '%u', `keys` = '%u', "\
			"`eyes` = '%u', `eyeTime` = '%u', `eyeX` = '%u', `eyeY` = '%u' WHERE `playerId` = % "I64_FMT "u",
			gameProgress, _gameLevel, _timeConsume,
			_maxX, _maxY, _maxGrid, mapStrng.c_str(),
			_posX, _posY, _earlyPosX, _earlyPosY, _remainTime, _keysCount,
			_eyesCount, _eyesTime, eyeX, _eyeY, _owner->getId());
}

void Dreamer::OnCommand(UInt8 command, UInt8 val, UInt8 val12)
{
	switch(command)
	{
		case 0:
			{
				SendMapInfo();
			}
			break;
		case 1:
			{
				if(OnMove(val, val2) && !_remainTime)
				{
					SendGridInfo(val, val2);
					SendTimeOver();
					OnAbort();
					return;
				}
			}
			break;
		case 2:
			{
				MapInfo::iterator it = _mapInfo.find(POS_TO_INDEX(_posX, _posY));
				if(it == _mapInfo.end())
					return;
				if((it->second).gridType & CLEAR_FLAG)
				{
					SendGridInfo(_posX, _posY);
					return;
				}
				bool res = false;
				switch ((it->second).gridType & 0x0F)
				{
					case GRID_WAVE:
						res = OnStepIntoWave();
						if(res)
						{
							_eyesTime = 0;
							InitMap(++_gameLevel);
							SendMapInfo(true);
							if(!_remainTime)
							{
								SendTimeOver();
								OnAbort();
							}
							else
							{
								_owner->dreamerUdpLog(10000, 3 + _gameLevel);
							}
							return;
						}
						break;
					case GRID_KEY:
						res = OnGetKey();
						break;
					case GRID_TREASURE:
						res = OnGetTreasure();
						if(!res)
							return;
						break;
					case GRID_EYE:
						res = OnGetEye();
						break;
					case GRID_ITEM:
						res = OnGetItem();
						break;
					case GRID_TIME:
						res = OnGetTime();
						break;
					case GRID_ARROW:
						res = true;
						break;
					default:
						break;
				}

				if(!_remainTime)
				{
					SendTimeOver();
					OnAbort();
					return;
				}

				if(res)
					(it->second).gridType |= CLEAR_FLAG;
				INDEX_TO_POS(it->first, val, val2);
			}
			break;
		case 3:
			switch (val)
			{
				case 1:
					OnUseEye(val2);
					break;
				case 2:
					OnBuyEye(val2);
					break;
			}
			SendEyeInfo(val);
			val = _posX;
			val2 = _posY;
			return;
			break;
		case 4:
			switch(val)
			{
				case 0:
					SendGameInfo();
					return;
				case 0xFF:
					OnAbort();
					return;
				default:
					OnRequestStart(val);
					return;
			}
		default:
			break;
	}

	SaveMapInfo();
	SendGridInfo(val, val2);
	DumpMapData();
	if(CheckEnd())
	{
		SendExploreOver();
		OnAbort();
		return;
	}
}

bool Dreamer::InitMap(UInt8 level)
{
	if(level > MAX_LEVEL || level == 0)
	{
		return false;
	}

	_mapInfo.clear();

	const GData::DreamerLevelData& dreamerLevelData = GData::dreamerDataTable[_gameProgress][level];
	_maxX = dreamerLevelData.maxX;
	_maxY = dreamerLevelData.maxY;
	_maxGrid = dreamerLevelData.maxGrid;
	std::map<UInt16, UInt8> typeMap = dreamerLevelData.gridTypeCount;
	_timeConsume = dreamerLevelData.timeConsume;

	std::vector<UInt16> validGrid;
	std::set<UInt16> invalidGrid;
	std::map<UInt16, UInt8> neighbourCount;
	for(UInt8 x = 0; x< _maxX; ++x)
	{
		for(UInt8 y = 0; y < _maxY; ++y)
		{
			invalidGrid.insert(POS_TO_INDEX(x,y));
		}
	}

	UInt16 curPos = POS_TO_INDEX(_rnd(_maxX), _rnd(_maxY));
}

