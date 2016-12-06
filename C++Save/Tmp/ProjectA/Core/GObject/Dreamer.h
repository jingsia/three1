/*************************************************************************
	> File Name: GObject/Dreamer.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 20 Apr 2016 09:41:30 AM CST
 ************************************************************************/

#include "Config.h"
#include "Common/Singleton.h"
#include "Common/Stream.h"
#include "Common/URandom.h"

namespace GObject
{

class Player;

#ifndef POS_TO_INDEX
#define POS_TO_INDEX(x,y) (UInt16)((x) + ((UInt16)(y) << 8))
#endif

#ifndef INDEX_TO_POS
#define INDEX_TO_POS(index, x, y) \
	x = (index) & 0xFF; \
	y = ((index) >> 8) & 0xFF;
#endif

static const UInt8 MAX_PROGRESS = 12;
static const UInt8 MAX_LEVEL = 5;

static const UInt16 DREAMER_ITEM[MAX_PROGRESS + 1] =
{
	0,
	9290,
	9295,
	9300,
	9305,
	9460,
	9465,
	9470,
	9886,
	329,
	335,
	357,
	363
};

class Dreamer
{

#ifndef UNKNOWN_FLAG
#define UNKNOWN_FLAG 0x80
#endif

#define LEFT_UP		0x00
#define UP			0x10
#define RIGHT_UP	0x20
#define RIGHT		0x30
#define RIGHT_DOWN	0x40
#define DOWN		0x50
#define LEFT_DOWN	0x60
#define LEFT		0x70

	enum GridType
	{
		GRID_WAVE		= 0x1,
		GRID_KEY		= 0x2,
		GRID_TREASURE	= 0x3,
		GRID_EYE		= 0x4,
		GRID_ITEM		= 0x5,
		GRID_WHIRLWIND	= 0x6,
		GIRD_TIME		= 0x7,
		GRID_ARROW		= 0x8,
		GRID_NORMAL_MAX,
	};

	enum Progress
	{
		PROGRESS_NONE	= 0,
		PROGRESS_70		= 1,
		PROGRESS_80		= 2,
		PROGRESS_90		= 3,
		PROGRESS_100	= 4,
		PROGRESS_110	= 5,
		PROGRESS_120	= 6,
		PROGRESS_130	= 7,
		PROGRESS_140	= 8,
		PROGRESS_150	= 9,
		PROGRESS_160	= 10,
		PROGRESS_170	= 11,
		PROGRESS_180	= 12,
		PROGRESS_MAX,
	};

	enum Level
	{
		LEVEL_NONE	= 0,
		LEVEL_1,
		LEVEL_2,
		LEVEL_3,
		LEVEL_4,
		LEVEL_5,
		LEVEL_6,
		LEVEL_7,
		LEVEL_8,
		LEVEL_9,
		LEVEL_10,
		LEVEL_11,
		LEVEL_12,
	};

	struct GridInfo
	{
		UInt8 neighbCount;
		UInt8 posX;
		UInt8 posY;
		UInt16 gridType;

		GridInfo(UInt16 index, UInt16 type, UInt8 neighbourCount)
			: neighbCount(neighbourCount)
		{
			INDEX_TO_POS(index, posX, posY);
			gridType = type;
		}
	};

	friend class DreamerWalker;

	public:
	Dreamer(Player *player);
	Dreamer(Player *player, UInt8 progress, UInt8 level, UInt8 maxX, UInt8 maxY, UInt8 maxGrid, const std::string& mapInfo,
			UInt8 posX, UInt8 posY, UInt8 earlyPosX, UInt8 earlyPosY, UInt8 timeConsume, UInt32 remainTime, UInt8 keysCount,
			UInt8 eyesCount, UInt8 eyeTime, UInt8 eyeX, UInt8 eyeY);
	~Dreamer();

	void OnCommond(UInt8 command, UInt8 va1, UInt8 val2);

	void SendGameInfo();
	void SendGridInfo(UInt8 posX, UInt8 posY);
	void SendMapInfo(bool isNext = false);
	void SendEyeInfo(UInt8 type);
	void SendTimeOver();
	void SendExploreOver();

	void SetTime(UInt8 count);
	void SetEye(UInt8 count);
	void SetKey(UInt8 count);

private:
	bool InitMap(UInt8 level);
	bool InitArrow();
	bool InitItem();
	bool InitEye();
	bool SelectBornGrid();
	bool LoadMapInfo(const std::string& list);
	void SaveMapInfo();

	void OnRequestStart(UInt8 progress);
	bool OnMove(UInt8 x, UInt8 y);
	bool OnStepIntoWave();
	bool OnGetTreasure();
	bool OnGetKey();
	bool OnGetItem();
	bool OnSufferWhirlwind();
	bool OnGetTime();
	bool OnGetEye();
	bool OnUseEye(UInt8 type);
	bool OnBuyEye(UInt8 count = 1);
	void OnAbort();

	UInt8 CheckGridType(UInt8 type);
	bool CheckEnd();
	UInt8 CalcArrowType(UInt16 srcPos, UInt16 dstPos);

private:
	typedef std::map<UInt16, GridInfo> MapInfo;
	player * _owner;

	MapInfo _mapInfo;

	UInt8 _gameProgress;
	UInt8 _gameLevel;
	bool _isInGame;

	UInt8 _maxX;
	UInt8 _maxY;
	UInt8 _maxGrid;

	UInt8 _posX;
	UInt8 _posY;
	UInt8 _earlyPosX;
	UInt8 _earlyPosY;

	UInt8 _timeConsume;
	UInt8 _remainTime;
	UInt8 _keyCount;

	UInt8 _eyesCount;
	UInt8 _eyesTime;
	UInt8 _eyeX;
	UInt8 _eyeY;

	URandom _rnd;

private:
	void DumpMapData();
};

}


