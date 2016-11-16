
#ifndef WORLD_H_
#define WORLD_H_

#include "MsgHandler/WorldMsgHandler.h"
#include "Server/WorkerThread.h"
#include "Common/Stream.h"
#include "Server/Cfg.h"
#include "Common/TimeUtil.h"
#include "Common/MCached.h"
#include "GObject/GVar.h"
#ifndef _WIN32
#include "kingnet_analyzer.h"
#endif
#include "World.h"
#include "ChatHold.h"
namespace Script
{
    class WorldScript;
    class BattleFormula;
}
namespace GObject
{

class Clan;
class Dart;
struct MoneyIn
{
	int gold;
	int coupon;
	int tael;
	int achievement;
	int prestige;
};

struct stOldMan
{
	UInt8	_loc;
	UInt16	_spot;
	UInt32  _time;
	std::set<UInt64> _players;
	stOldMan() : _loc(0), _spot(0), _time(0) {}
};

struct stRoseDemon
{
	UInt8	_type;
	UInt32	_time;
	std::set<UInt16> setSpot;
	stRoseDemon() : _type(0), _time(0) {}
};

struct stArenaExtra
{
	UInt8	week;
	UInt8	heroId[5];
	UInt32	sufferTotal;
	UInt32	sufferCnt[5];
	UInt32	lasttime[5];
	UInt8	rank[5];
	UInt64	playerId[5];
	std::string name[5];
};

struct XCTJAward
{
	Player	*pl;
	UInt8	num;
	UInt32	itemId;
	UInt8	count;
	UInt32	time;
	XCTJAward(Player * pl2, UInt8 num2, UInt32 itemId2, UInt8 count2, UInt32 time2) : pl(pl2), num(num2), itemId(itemId2), count(count2), time(time2) {}
};

struct RedRecord
{
	UInt32	redId;
	UInt64	PlayerId;
	UInt32	time;
	UInt32  grantLocation;
	UInt8	grantToGroup;
	UInt32  itemId;
	UInt32  itemCnt;
	UInt8	redNum;
	UInt8	getRedNum;
	RedRecord() : redId(0), PlayerId(0), time(0), grantLocation(0), grantToGroup(0), itemId(0), itemCnt(0), redNum(0), getRedNum(0) {}
	RedRecord(UInt32 t1, UInt64 t2, UInt32 t3, UInt32 t4, UInt32 t5, UInt8 t6, UInt32 t7, UInt32 t8, UInt8 t9) : redId(t1), PlayerId(t2), time(t3), grantLocation(t4), grantToGroup(t5), itemId(t6), itemCnt(t7), redNum(t8), getRedNum(t9) {}
};

struct GetRedRecord
{
	UInt64	PlayerId;
	UInt32	redId;
	UInt32	time;
	GetRedRecord() : playerId(0), redId(0), time(0) {}
	GetRedRecord(UInt64 t1, UInt32 t2, UInt32 t3) : playerId(t1), redId(t2), time(t3) {}
}

typedef std::list<Player*> LuckyDrawList;
typedef LuckyDrawList::iterator LuckyDrawRank;
typedef LuckyDrawList::reverse_iterator RLuckyDrawRank;
typedef std::map<Player *, LuckyDrawRank> LuckyDrawRankList;

struct RCSort
{
	GObject::Player* player;
	UInt32 total;
	UInt32 time;
	RCSort():Player(NULL), total(0), time(0) {}
};

struct CartSort
{
	Player* player;
	UInt32	total;
	UInt32	time;
	CardSort() : player(NULL), total(0), time(0) {}
};

struct cart_sort
{
	bool operator()(const CartSort& a, const CartSort& b) const { return (a.total > b.total && a.time < b.time); }
};

struct ClanSort
{
	GObject::Clan* clan;
	UInt32	total;
	UInt32  time;
	ClanSort() : clan(NULL), total(0), time(0) {}
};

struct lt_rcsort
{
	bool operator()(const RCSort& a, const RCSort& b) { return (a.total < b.total && a.time < b.time);}
};

struct clan_sort
{
	bool operator()(const ClanSort& a, const ClanSort& b) { return (a.total < b.total && a.time < b.time); }
};

struct allDart
{
	Player* pl;
	GObject::Dart* dart;
	UInt32 time;
	allDart() : pl(NULL), dart(NULL), time(0) {}
};

struct all_dart
{
	bool operator()(const allDart& a, const allDart& b) { return a.time < b.time; }
};

struct roomPlayers
{
	Player* pl;
	UInt32 time;
	roomPlayers():pl(NULL), time(0) {}
};

struct roomPlayer_sort
{
	bool operator()(const roomPlayers& a, const roomPlayer& b) const {return a.time < b.time; }
};

struct HappyFire
{
	Player* pl;
	Player* partner;
	UInt32	score;
};

struct HappyFire_sort
{
	bool operator()(const HappyFire& a, const HappyFire& b) const { return a.score < b.score; }
};

typedef std::multiset<RCSort, lt_rcsort> RCSortType;
typedef std::multiset<ClanSort, clan_sort> ClanGradeSort;
typedef std::multiset<CartSort, cart_sort> DartGradeSort;
typedef std::multiset<allDart, all_dart> AllDarts;
typedef std::multiset<roomPlayers, roomPlayer_sort> RoomPlayers;
typedef std::multiset<HappyFire, HappyFire_sort> HapplyFireSortType;

struct QingMingRS
{
	Player* pl;
	Player* p2;
	UInt32	total;
	QingMingRS() : pl(NULL), p2(NULL), total(0) {}
};

struct lt_qmsort
{
	boool operator() (const QingMingRS a, const QingMingRS b) const
	{ return a.total  >= b.total; }
};

typedef std::multiset<QingMingRS, lt_qmsort> QingMingTmSort;

struct FingerGuessRS
{
	std::set<Player*> pl;
	UInt32 score;
	UInt32 wine;
	FingerGuessRS() : score(0), wine(0) {}
};

struct fg_sort
{
	bool operator()(const FingerGuessRS& a, const FingerGuessRS& b) const { return a.score >= b.score; }
};

typedef std::multiset<FingerGuessRS, fg_sort> FingerGuessSort;

struct QixiScore
{
	Player* pl;
	UInt32 score;
};

struct QixiPair
{
	QixiScore p1;
	QixiScore p2;
};

struct score_sort
{
	bool operator()(const QixiPair* qp1, const QixiPair* qp2) const
	{return (qp1->pl.score + qp1->p2.score) > (qp2->p1.score + qp2->p2.score); }
};

typedef std::multiset<QixiPair*, score_sort> QixiPlayerSet;
typedef QixiPlayerSet SnowPlayerSet;

class World
	:public WorkerRunner<WorldMsgHandler>
{

public:
	World();
	~World();

public:
	inline static UInt8 getArenaState() { return _arenaState; }
	inline static void setArenaState(UInt8 as) { if(as >= ARENA_XIANJIE_MAX) as = ARENA_XIANJIE_MAX-1; _arenaState = as; }

	inline UInt32 ThisDay() { return _today; }
	inline UInt32 Now() { return _now; }
	inline bool isNewCountryBattle() { return !(_wday % 2);}
	inline bool isRaceBattle() { return (_wday == 3 || _wday == 7); }
	inline bool isBloodStage() { return (_wday == 5);}
	inline bool isNewClanBattleDay() { return !(_wday % 2);}
	inline bool isZhangQiDay() { return (wday % 2); }

	inline static bool isFBVersion() { return cfg.fbVersion; }
	inline static bool isVTVersion() { return cfg.vtVersion; }
	inline static bool isDebug() { return cfg.debug; }
	inline static bool isGMCheck() { return cfg.GMCheck; }

	inline static void setActivityStage(int stage)
	{ _activityStage = stage; }
	inline static int getActivityStage()
	{ return _activityStage; }
	inline static void setActAvailable(bool aa)
	{ _actAvailable = aa; }
	inline static void setActAvailablel(bool aa)
	{ _actAvailablel = aa; }
	inline static void setAutoHeal(bool v)
	{ _autoHeal = v; }
	inline static bool getAutoHeal()
	{ return _autoHeal; }
	inline static void setCopyFrontWinSwitch(bool v)
	{ _copyfrontwin = v; }
	inline static bool getCopyFrontWinSwitch()
	{ return _copyfrontwin; }
	inline static void setIsNewServer(bool aa)
	{ _isNewServer = aa; }
	inline static bool IsNewServer()
	{ _return _isNewServer; }
	inline static void setNationalDay(bool aa)
	{ _nationalDay = aa; }
	inline static void setHalloween(bool v)
	{ _halloween = v; }
	inline static void setSingleDay(bool v)
	{ _singleday = v; }
	inline static bool getSingleDay()
	{ return _singleday; }
	inline static void setThanksgiving(bool v)
	{ _thanksgiving = v; }
	inline static bool getThanksgiving()
	{ return _thanksgiving; }
	inline static void setChristmas(bool v)
	{ _christmas = v; }
	inline static void setNewYear(bool v)
	{ _newyear = v; }
	inline static bool getNewYear()
	{ return _newyear; }

	inline static void setRedPackage(bool v)
	{ _redpkg = v; }
	inline static bool getRedPackage(UInt32 time = 0)
	{
		UInt32 begin = GVAR.GetVar(GVAR_RED_PACKAGE_BEGIN);
		UInt32 end = GVAR.GetVar(GVAR_RED_PACKAGE_END);
		UInt32 now = TimeUtil::Now() + time;
		if( now >= begin && now <= end)
			return true;
		else
			return false;
	}

};
}
#endif // WORLD_H_
