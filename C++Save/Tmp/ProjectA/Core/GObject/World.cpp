#include "Config.h"
#include "World.h"
#include "Common/TimeUtil.h"
#include "Script/WorldScript.h"
#include "Script/BattleFormula.h"
#include "GObject/GVar.h"
#include "Battle/BattleManager.h"
#include "Player.h"
#include "ChatHold.h"
#include "Clan.h"
#include <time.h>
#include "Battle/ClanBattleDistribute.h"
#include "Battle/ClanBattleRoom.h"
#include "MsgHandler/GMHandler.h"
#include "Battle/ClanBattleCityStatus.h"
#include "Battle/BattleAnalyze.h"
#include "Battle/BattleReport.h"
#include "Battle/BattleReportAnalyse.h"
#include "GObject/Exploit.h"
#include "GData/Map.h"
#include "GData/Robot.h"
#include "Battle/Report2Id.h"
#include "Common/LoadingCounter.h"
#include "Mail.h"

#define W_CHAT_MAX 20

namespace GObject
{
    MapIndexPlayer World::arenaSort;
    
    UInt8 time = 0;
    bool World::Init()
    {
        chatHold = new ChatHold(0,W_CHAT_MAX);

        std::string path = cfg.scriptPath + "World/main.lua";
        TimeUtil::TimeAdd(GVAR.GetVar(GVAR_TIMEADD));
        {
            _worldScript = new Script::WorldScript(path.c_str()); 
        }

        path = cfg.scriptPath + "formula/main.lua";
        _battleFormula = new Script::BattleFormula(path.c_str());

        UInt32 now = TimeUtil::Now(), sday = TimeUtil::SharpDay(1) - 10; 

        if(sday < now) sday += 86400;
        AddTimer(86400 * 1000, World_Midnight_Check, this, (sday - now) * 1000);
        AddTimer(86400 * 1000, World_Test, this, 10* 1000);

        UInt32 ArenaAwardTime = TimeUtil::SharpDay(0) + 21 * 3600;
        if(ArenaAwardTime < now) ArenaAwardTime += 86400;
        AddTimer(86400 * 1000, World_Send_Arena_Award, this, (ArenaAwardTime - now) * 1000);
        
        //UInt32 storeAFreshTime = TimeUtil::SharpDay(0) + 21 * 3600;
        UInt32 storeAFreshTime = TimeUtil::SharpDay(0) + 15 * 3600+3120;
        World_Store_Fresh(this);
        if( storeAFreshTime < now ) storeAFreshTime += 86400;
        AddTimer(86400 * 1000, World_Store_Fresh, this, (storeAFreshTime - now) * 1000);

        time_t n = now;
        tm* tt=localtime(&n);
        UInt8 min = tt->tm_min;
        UInt8 sec = tt->tm_sec;

        UInt16 second = 0;
        //UInt16 s = 0;
        if( min%TIME_ONCE == 0 && sec == 0 )
        {
            second = 0;
            //s = 0 ;
        }
        else
        {
            second = ((min%TIME_ONCE)*60+sec)%TIME_TAB;
            //s = TIME_ONCE*60-((min%TIME_ONCE)*60+sec);
        }
        //sharpMinute

        UInt32 s =TimeUtil::SharpHour(1,now);
        if(s < now ) s += 3600;
        AddTimer(10*60*1000, World_Govern_SendInfo,this,(s+1)*1000);
        AddTimer(15*1000, World_Govern_SendAward, this,(TIME_TAB-second+3)*1000);


        AddTimer(1*1000,World_clanBattle_stageCheck,this,5*1000);

        AddTimer(1* 1000, world_clanBattle_putFighters, this, 10*1000);

        AddTimer(1*1000,World_clanBattle_OneRound,this,30*1000);

        GVAR.SetVar(GVAR_BATTLE_STATUS,3);

        //GVAR.SetVar(GVAR_CLAN_CREATE, TimeUtil::Now() + 60);
        //LoadingCounter lc("GM attack");
        //lc.reset(1000);
        //GMHandler::Battle(1003,1006);
        //GMHandler::Battle(1009,1009);
        //lc.finalize();
        //LoadingCounter lc("GM attack");
        //lc.reset(1000);
        //GMHandler::Battle(1,2);

		UInt32 pvpAwardPoint = TimeUtil::SharpDayT(0, now) + 22 * 3600;
		AddTimer(86400 * 1000, World_pvp_award, static_cast<void*>(NULL), (pvpAwardPoint >= now ?  pvpAwardPoint - now : 86400 + pvpAwardPoint - now) * 1000);
        InitRank();
        return true; 
    }


    void World::UnInit() 
    {

    }


    std::string World::GetLogName()
    {
        return "log/World/"; 
    }

    void World::World_Midnight_Check( World * world )
    {
        UInt32 curtime = TimeUtil::Now();

        //记录此刻活动状态
        world->_worldScript->onActivityCheck(curtime+300);  //延迟300秒计算是否活动时间已过
            
    }

    void World::World_Test( World * world )
    { 
#if 0
        struct NewUserStruct  
        {
            UInt64 phoneId;
            UInt16 len1;
            char accounts[10];
            //std::string accounts;
            UInt16 len2;
            char password[10];
            //std::string password;
            UInt16 len3;
            char _name[10];
            //std::string _name;
            UInt8 _class;
            //UInt8 _rp; //1:回流免费用户 2:回流vip1-vip4用户 3:回流vip5+用户
            std::string _para;
        };
        NewUserStruct ns ;
        ns.len1 = 10;
        ns.len2 = 10;
        ns.len3 = 10;
        ns.phoneId = 1;
        ns.accounts = {'l','b'};
        ns.password = {'1'};
        ns._name = {'Q'};
        ns._class = 5;
        ns._para = "192.168.88.250";
        LoginMsgHdr hdr1(0xE1, WORKER_THREAD_LOGIN, 8500, 1212121 , sizeof(ns)); 
        GLOBAL().PushMsg(hdr1, &ns);
#endif
        //UInt32 BattleId = Battle::battleManager.CreateBattleGround();
        /*
        for(UInt8 i = 1; i < 10 ;++i)
        {
            UInt64 pid = (static_cast<UInt64>(1)<<48)|i;
            Player *pl = globalPlayers[pid];
            if(!pl)
                continue;
            Battle::battleManager.EnterBattleGround(BattleId,pl,i);
        }
        */
        /*
        UInt8 flag = 1;
        UInt8 i = 1;
        for(auto it = globalPlayerVec.begin(); it != globalPlayerVec.end(); ++it)
        {
            if( i > 11 )
                break;
            Player* pl = *it;
            Battle::battleManager.EnterBattleGround(BattleId,pl,i, flag);
            i++;
            flag = !flag;
        }
        Battle::battleManager.StartGround(BattleId);
        */
    }

    void World::World_Govern_SendInfo(World* world)
    {
        for(auto it = GObject::globalOnlinePlayerSet.begin() ; it != GObject::globalOnlinePlayerSet.end() ; ++it)
        {
            UInt8 type = 0;
            GameMsgHdr hdr(0x156,WORKER_THREAD_COUNTRY_1,(*it),sizeof(type));
            GLOBAL().PushMsg(hdr,&type);
        }
    }

    void World::World_Govern_SendAward(World* world)
    {
        for(auto it = GObject::globalOnlinePlayerSet.begin() ; it != GObject::globalOnlinePlayerSet.end() ; ++it)
        {
            //在线
            time_t now = TimeUtil::Now();
            tm* tt=localtime(&now);
            UInt8 min = tt->tm_min;
            UInt8 sec = tt->tm_sec;
            UInt16 restSec = (min%TIME_ONCE==0 && sec == 0) ? 0: (min%TIME_ONCE*60+sec);
            UInt16 time = 0;
            if( restSec == 0 )
            {
                time = 0;
            }
            else
            {
                time = ( restSec%TIME_TAB == 0 ? restSec/TIME_TAB : restSec/TIME_TAB+1);
            }
            GameMsgHdr hdr(0x155,WORKER_THREAD_COUNTRY_1,(*it),sizeof(time));
            GLOBAL().PushMsg(hdr,&time);
        }
    }


    void World::world_clanBattle_putFighters(World* world)
    {
        map<UInt32,std::vector<Battle::MapDistributeInfo*>> room2Distribute = Battle::battleDistribute.GetData();
        for( auto it = room2Distribute.begin(); it != room2Distribute.end(); ++it )
        {
            UInt32 roomId = it->first;
            if( roomId == 0 )
                continue;
            Battle::RoomAllCityStatus* status = Battle::roomAllCityStatusManager.GetRoomAllCityStatus(roomId);
            if( status->GetStage() != 1 )
                continue;
            Battle::RoomBattle* roomBattle = Battle::battleManager.GetRoomBattle(roomId);
            if( roomBattle == NULL )
            {
                //COUT<<"put fighters"<<std::endl;
                roomBattle = new Battle::RoomBattle(roomId);
                for( auto iter = (it->second).begin(); iter != (it->second).end(); ++iter)
                {
                    UInt8 mapId = (*iter)->GetMapId();
                    Battle::SingleBattle* singleBattle = new Battle::SingleBattle(roomId,mapId,4);
                    singleBattle->SetNextStartTime(0);

                    /*玩家的战将入场*/
                    std::vector<Battle::DistributeInfo*> vecInfo = (*iter)->GetDistributeInfo();
                    for( auto iterator = vecInfo.begin(); iterator != vecInfo.end(); ++iterator )
                    {
                        //放将进入战场
                        UInt64 playerId = (*iterator)->GetPlayerId();
                        UInt16 fighterId = (*iterator)->GetFighterId();
                        UInt8  posx = (*iterator)->GetPosX();
                        UInt8  posy = (*iterator)->GetPosY();
                        GObject::Player* player = GObject::globalPlayers[playerId];
                        if( player == NULL )
                        {

                            singleBattle->NpcEnterBattleGround(0,fighterId,posx,posy);
                        }
                        else
                        {
                            singleBattle->EnterBattleGround(player,fighterId,posx,posy);
                        }
                    }
                    /*策划所谓的野怪入场 从配置中读取该地图上的野怪信息*/
                    /* 如果该处有玩家布置的战将  则不放入野怪*/
                    if( status->GetCityOwnForce(mapId) == 0 )
                    {
                        std::cout<<" roomId "<<static_cast<UInt32>(roomId)<<std::endl;
                        std::cout<<"cityId is   "<<static_cast<UInt32>(mapId)<<" 这个城还没有被占领,  放野怪进行干扰  "<<std::endl;
                        GData::MapInfo* mapInfo = GData::mapTable.GetMapInfo(mapId);
                        std::vector<GData::NpcInfo> vecNpcInfo = mapInfo->GetNpcInfo();
                        for( auto iterator = vecNpcInfo.begin(); iterator != vecNpcInfo.end(); ++iterator)
                        {
                            UInt16 fighterId = (*iterator).fighterId;
                            UInt8  x = (*iterator).x;
                            UInt8  y = (*iterator).y;
                            bool flag = true;
                            for( auto p = vecInfo.begin(); p != vecInfo.end(); ++p )
                            {
                                if( (*p)->GetPosX() == x && (*p)->GetPosY() == y )
                                {
                                    flag = false;
                                    break;
                                }
                            }
                            if( flag )
                            {
                                singleBattle->NpcEnterBattleGround(0,fighterId,x,y);
                            }
                        }
                    }
                    roomBattle->InsertSingleBattle(singleBattle);
                }
                Battle::battleManager.InsertRoomBattle(roomBattle);
            }
        }
    }

    
    //军团战战术一回合
    void World::World_clanBattle_OneRound(World* world)
    {
        //
        std::vector<Battle::RoomBattle*>  roomBattleList = Battle::battleManager.GetRoomBattleList();
        if( roomBattleList.empty())
            return;
        for( auto it = roomBattleList.begin(); it != roomBattleList.end(); ++it)
        {
            if( roomBattleList.empty() )
                break;
            UInt8 stage = (*it)->GetStage();
            if( stage != 1 )
                continue;
            std::vector<Battle::SingleBattle*> vecSingleBatte = (*it)->GetSingleBattles();
            if( vecSingleBatte.empty() )
                continue;
            for( auto iter = vecSingleBatte.begin(); iter != vecSingleBatte.end(); ++iter)
            {
                if( (*iter) != NULL)
                {
                    UInt32 nextActTime = (*iter)->GetNextStartTime(); 
                    if( nextActTime == 0 )
                    {
                        (*iter)->StartOneRound();
                        UInt16 timeCost = (*iter)->GetOneRoundTimeCost();
                        UInt32 now = TimeUtil::Now();
                        (*iter)->SetNextStartTime(timeCost+now);
                    }
                    else
                    {
                        UInt32 now = TimeUtil::Now();
                        if( fabs( now - (*iter)->GetNextStartTime() ) <= 1  )
                        {

                            (*iter)->StartOneRound();
                            UInt16 timeCost = (*iter)->GetOneRoundTimeCost();
                            (*iter)->SetNextStartTime(timeCost+now);
                        }
                    }
                }
            }
        }
    }


    //判断军团战属于哪一个阶段
    void World::World_clanBattle_stageCheck(World* world)
    {
        std::vector<Battle::RoomAllCityStatus*> vecData = Battle::roomAllCityStatusManager.GetData();
        for( auto it = vecData.begin(); it != vecData.end(); ++it )
        {
            //UInt8 stage = (*it)->GetStage();
            //if( stage == 2 )
            //  continue;
            UInt32 now = TimeUtil::Now();
            (*it)->SetStage(now);

            //如果处于准备阶段  把非空的战场删除
            UInt32 roomId = (*it)->GetRoomId();
            Battle::RoomBattle* roomBattle = Battle::battleManager.GetRoomBattle(roomId);
            if( (*it)->GetStage() == 0 && roomBattle != NULL )
            {
                std::cout<<"处于准备阶段  删掉战场"<<std::endl;
                Battle::battleManager.removeRoomBattle(roomId);
                //每天给予免费的军粮
                Battle::clanBattleRoomManager.GiveFreeCampaignFood(roomId);
            }
            if( (*it)->GetStage() == 2 && roomBattle != NULL)  //结算阶段
            {
                //COUT<<"处于结算阶段  开始发奖励啦"<<std::endl;
                roomBattle->Settlement();
                Battle::battleManager.removeRoomBattle(roomId);
                Battle::clanBattleRoomManager.RemoveClanBattleRoom(roomId);
                Battle::battleDistribute.RemoveRoomDistribute(roomId);
                Battle::report2IdTable.RemoveReports(roomId);
            }
        }
    }

    static bool init = false;
    inline bool player_enum_rc(GObject::Player *pl,int)
    { 
        UInt32 pos = pl->GetVar(VAR_ARENA_POS) ;
        if(pos && pos <= 3000)
        { 
            Player * p = World::arenaSort[pos].pl;
            if(!p)
                World::arenaSort[pos] = ArenaMember(pl);
        }

		UInt32 goal = pl->GetVar(VAR_PVP_GOAL);
		if(goal)
		{
			RCSort s;
			s.player = pl;
			s.total = goal;
			World::pvpAwardSort.insert(s);
		}
        return true;
    }

    void World::InitRank()
    { 
        if(init)
            return ;

        GObject::globalPlayers.enumerate(player_enum_rc, 0);
        init = true;
    } 



    void World::World_Send_Arena_Award( World * world )
    { 
        InitRank();
        static std::string Award[] = {
            "20003,200",
            "20003,180",
            "20003,160",
            "20003,140",
            "20003,120",
            "20003,100",
            "20003, 80",
            "20003, 60",
            "20003, 40",
            "20003, 20",
            "20003, 10"
        };

        for(auto it = arenaSort.begin(); it != arenaSort.end(); ++it)
        { 
            UInt16 pos = it->first;
            GObject::Player* pl = it->second.pl;
            if(!pl)
                continue;
            UInt8 index = 0;

            if(!pos)
                continue;
            if(pos == 1)
                index = 0;
            else if(pos == 2)
                index = 1;
            else if(pos == 3)
                index = 2;
            else if(pos < 11)
                index = 3;
            else if(pos < 21)
                index = 4;
            else if(pos < 51)
                index = 5;
            else if(pos < 101)
                index = 6;
            else if(pos < 201)
                index = 7;
            else if(pos < 301)
                index = 8;
            else if(pos < 1001)
                index = 9;
            else 
                index = 10;

            Mail* mail = new Mail(IDGenerator::gMailOidGenerator.ID(),pl,1,Award[index],0,static_cast<UInt32>(-1));
            if(mail)
            {    
                GObject::globalMails.add(mail->GetId(), mail);
                pl->AddMail(mail->GetId());
            }       
        } 
    } 
    
    //定时刷新( 应该是所有玩家 )
    void World::World_Store_Fresh(World* world)
    {

        for( auto it = GObject::globalPlayerVec.begin(); it != GObject::globalPlayerVec.end(); ++it )
        {
            //(*it)->GetStoreA()->FreshItems();
            GameMsgHdr hdr(0x157 ,WORKER_THREAD_COUNTRY_1,(*it),0);
            GLOBAL().PushMsg(hdr,NULL);
        }
    }
    void World::UpdateArena(UInt16 oldIndex ,UInt16 index)
    { 
        ArenaMember am = arenaSort[index];
        if(am.pl)
            return ;

        if(oldIndex)
            DB1().PushUpdateData("DELETE from `arenaRobot` where `index` = %u",oldIndex); 

        if(index && index < 3001)
            DB1().PushUpdateData("REPLACE INTO `arenaRobot` values(%u, %u, %u)",index,am.firstIndex, am.robotId); 
    } 
    ArenaMember World::GetArenaMember(UInt16 index)
    { 
        if(!arenaSort[index].NotEmpty())
        { 
           UInt32 robotId = uRand(GData::robotInfo.GetRobotSize())+1;
           if(robotId && robotId < GData::robotInfo.GetRobotSize())
               arenaSort[index] = ArenaMember(index,robotId);
           UpdateArena(0,index);
        } 
        return arenaSort[index];
    }

	void World::World_pvp_award(void *)
	{
		World::InitRank();
		static MailPackage::MailItem s_item[][1] = {
			{{20003, 300}},
			{{20003, 250}},
			{{20003, 200}},
			{{20003, 150}},
			{{20003, 110}},
			{{20003,  80}},
			{{20003,  50}},
			{{20003,  40}},
			{{20003,  30}},
			{{20003,  20}},
			{{20003,  10}},
		}

		UInt8 pos = 0;
		for(RCSortType::iterator it = World::pvpAwardSort.begin(), e = World::pvpAwardSort.end(); it != e; ++it)
		{
			Player* player = it->player;
			if(!player)
				continue;

			player->SetVar(VAR_PVP_GOAL, 0);

			++pos;
			UInt8 awardLvl = 0;
			if(pos == 1)
				awardLvl = 1;
			else if(pos == 2)
				awardLvl = 2;
			else if(pos == 3)
				awardLvl = 3;
			else if(pos <=10)
				awardLvl = 4;
			else if(pos <=20)
				awardLvl = 5;
			else if(pos <= 50)
				awardLvl = 6;
			else if(pos <= 100)
				awardLvl = 7;
			else if(pos <= 200)
				awardLvl = 8;
			else if(pos <= 300)
				awardLvl = 9;
			else if(pos <= 1000)
				awardLvl = 10;
			else if(pos <= 3000)
				awardLvl = 11;
			else
				continue;

			SYSMSGV(title, 5267);
			SYSMSGV(content, 5268, awardLvl);
			MailItemsInfo itemsInfo(s_item[award - 1], PvpAward, 1);
			Mail * mail = player->GetMailBox()->newMail(NULL, 0x21, title, content, 0xFFFE0000, true, &itemsInfo);
			if(mail)
			{
				mailPackageManager.push(mail->id, s_item[awardLvl - 1], 1, true);
			}
		}

		World::pvpAwardSort.clear();
	}

}
