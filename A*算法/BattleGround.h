#ifndef BATTLEGROUND_H_
#define BATTLEGROUND_H_

#include "Config.h"
#include <map>
#include <vector>
#include "Common/Stream.h"
#include "Server/OidGenerator.h"
#include "MsgID.h"

#define GROUND_LENGTH 20

namespace GObject
{
    class Fighter;
    class Player;
    class AStar;
}

namespace Battle
{
#define PLAYERMAX 5

    struct BattleInfo
    {
        UInt16 _round;
        UInt8 _x;				// 战斗地点  X
        UInt8 _y;				// 战斗地点	 Y
        UInt8 _attackSide;		// 进攻方
        UInt16 _attackFighter;  // 进攻散仙
        UInt8 _defendSide;		// 防守方
        UInt16 _defendFighter;	// 防守散仙
        UInt64 _brtId;			// 战报ID
        UInt8 _res;				// 战斗结果 返回胜利方的side 0表示胜负未分

        BattleInfo(UInt16 round ,UInt8 x,UInt8 y, UInt8 attackSide ,UInt16 attackFighter ,UInt8 defendSide ,UInt16 defendFighter,UInt64 brtId, UInt8 res):_round(round),_x(x),_y(y),_attackSide(attackSide),_attackFighter(attackFighter),_defendSide(defendSide),_defendFighter(defendFighter),_brtId(brtId),_res(res){}
        BattleInfo(){}
    };

    class BattleObject;
    class BattleFighter;

    typedef std::vector<UInt8> vecInfo;   

    struct Ascoord
    {
        UInt8 x;
        UInt8 y;

		Ascoord() : x(0), y(0) {}
        Ascoord(const UInt8 vx,const UInt8 vy):x(vx),y(vy) {}

        inline bool operator == ( const Ascoord p)
        {
            return (this->x == p.x && this->y == p.y );
        }
        inline bool operator != ( const Ascoord p)
        {
            return (this->x != p.x || this->y != p.y );
        }
        inline void operator += ( const Ascoord p)
        {
            this->x += p.x;
            this->y += p.y;
        }
    };

    //A*的基本节点
    struct Node
    {
        Ascoord node; 
        Ascoord parent;
        UInt8 g;
        UInt8 h;

		Node() : g(0), h(0) {}
        Node(Ascoord p) : node(p) {}
        Node(Ascoord n,Ascoord p,UInt8 lh,UInt8 rh):node(n),parent(p),g(lh),h(rh) {} 
    };

    struct AttackInfo
    {
        Ascoord attack;
        Ascoord target;
        AttackInfo(Ascoord a,Ascoord t) : attack(a) , target(t) {}
    };
    
	//仿函数
    template<class T=BattleFighter*>
    struct LessActId
    {
        bool operator() (T bf1,T bf2)
        {
            if( bf1->GetBattleIndex() < bf2->GetBattleIndex() )
            {
                return true;
            }
            return false;
        }
    };

    struct TargetInfo
    {
        BattleFighter * bo;
        Ascoord attack;	//攻击点
        UInt8 cost;		//行动力消耗
        UInt8 pri;		//攻击优先级

		TargetInfo() : bo(NULL), cost(0), pri(0) {}
        TargetInfo(BattleFighter* b, Ascoord a,UInt8 c,UInt8 p): bo(b),attack(a),cost(c),pri(p) {}
    };

    struct FighterInfo
    {
        GObject::Player* owner;
        UInt16 fighterId;
        UInt8  posx;
        UInt8  posy;
		UInt8  num;

		FighterInfo() : owner(NULL), fighterId(0), posx(0), posy(0), num(0) {}
        FighterInfo(GObject::Player* player,UInt16 id,UInt8 x,UInt8 y, UInt8 n) : owner(player),fighterId(id),posx(x),posy(y), num(n) {}
    };

    //替补信息
    class BenchInfo
    {
	public:
		BenchInfo() : x(0), y(0) {}
		BenchInfo(UInt8 lx , UInt8 ly ) : x(lx) , y(ly) {}

		void InsertFighter(BattleFighter* bf) { listFighter.push_back(bf);}
		std::list<BattleFighter*> GetListFighter() const { return listFighter;}

		BattleFighter* GetFrontFighter() const 
		{ 
			if ( listFighter.empty()) 
				return NULL;
			return listFighter.front();
		}

		void PopFrontFighter() { 
			if( listFighter.empty() )
				return;
			listFighter.pop_front();
		}

		UInt8 GetX() const { return x;}
		UInt8 GetY() const { return y;}

		UInt16 GetFighterNum() const { return listFighter.size();}

	private:
		UInt8 x ;  //替补点x坐标
		UInt8 y ;  //替补点y坐标
		std::list<BattleFighter*> listFighter;
    };
    

    class BattleGround
    {
        public:
            BattleGround(UInt32 id , UInt8 mapId):_roomId(id), _x(0), _y(0),  _mapGround(NULL), _mapCamp(NULL), _mapFighters(NULL), _currentBf(NULL), _maxID(0), _battleNum(IDGenerator::gBattleOidGenerator0.ID()),_roundId(0),_isFirstRound(true),_oneRoundCostTime(0),_isSetCapture(false), _isNpc(false), _actCount(0), _mapMaxFgtNum(0)
            {
                InitMapFight(mapId);
            }
            ~BattleGround()
            {
                //delete [] _mapFighters;
                /*
                for(UInt8 j = 0; j < _y ; ++j)
                {
                    for(UInt8 i = 0 ; i < _x ; ++i )
                    {
                        if( _mapFighters[i+j*_x] != NULL )
                        {
                            delete _mapFighters[i+j*_x];
                        }
                    }

                }
                */
                _mapFighters = NULL;

                delete [] _mapGround;
                _mapGround = NULL;

                delete []_mapCamp;
                _mapGround = NULL;

                for( auto it = _map2preInfo.begin(); it != _map2preInfo.end(); ++it )
                {
                    for( auto iter = (it->second).begin(); iter != (it->second).end(); ++iter)
                    {
                        delete (*iter);
                    }
                }

                _map2preInfo.clear();
                _aroundAscoord.clear();
                battleIds.clear();
                num2pos.clear();
                camp2fighters.clear();
                _closeList.clear();
                _openList.clear();
            }

            void InitMapFight(UInt8 mapId);
            void PushBattleInfo(const BattleInfo& bi);
            void PushFighter(GObject::Player*, UInt16 ,UInt8,UInt8);   //放入战将
            void PushNpc(UInt8 forceId,UInt16 fighterId,UInt8 x,UInt8 y); //放入npc
            void SetCampActId();              //设置阵营行动id
            void GetCampAttackOrder(UInt8 campId,UInt8 dir);
            void SearchFromDownToUp(UInt8 campId);
            void SearchFromUpToDown(UInt8 campId);
            void SearchFromRightToLeft(UInt8 campId);
            void SearchFromLeftToRight(UInt8 campId);
            void SetBattleIndex();        //设置战场战将的出手id
            UInt8 GetSpecialDirection(); 
            void  FightOneRound();        //战术一回合
            void  SetEachPosNumber();
            UInt8 GetBattleIndex(UInt8 x,UInt8 y );  //获得某一位置的行动id
            BattleFighter* GetMinBattleIndexFighter(std::vector<BattleFighter*> listFighter);
            bool SomeCampIsAllDie(UInt8 campId);
            bool CheckIsStop();         //判断是不是已经打完了
            void MakePreStartInfo();	//开战前信息
            UInt16 GetOneRoundTimeCost() const { return _oneRoundCostTime;}   //获得战术一回合的消耗时间
            void SyncHp(BattleFighter* bft,UInt8 x, UInt8 y);
            void SortByActId();
            void Move();               //军团战对象移动
            void ArenaMove();          //竞技场移动

            //产生战报信息
            void Fight(BattleFighter *bf , BattleFighter * bo,UInt8& result,UInt32& BattleReport,UInt16& fightTimeCost);
            UInt8 GetRideSub(const UInt8& posx ,const UInt8& posy);  //获得移动消耗的体力值

            BattleFighter * newFighter( UInt8 x , UInt8 y, GObject::Fighter *, bool flag = 0 );
            void setObject(UInt8 x , UInt8 y ,BattleFighter * bf,UInt8 flag = 0);
            void preStart();   //战将进入战场  开打前 
            void start();      //竞技场开战

            void TestCoutBattleS(BattleFighter* bf = NULL);
            void InsertFighterInfo(UInt8 flag = 0);
            void GetAllBattleFighter(std::list<BattleFighter*>& listFighters);
            UInt8 GetFactAttackDis();     //获得时间的攻击距离
            UInt8 GetCampInfo(UInt8 index) { return _mapCamp[index];}


            /*全是跟寻找最优敌人或者最优前进坐标的一些方法*/
            void GetNearEnemy(UInt8 x,UInt8 y,std::vector<Ascoord>& vecEnemy); 
            void Analyse(std::list<Ascoord>path,Ascoord& target);
            bool IsInAttackZone(Ascoord stand, Ascoord target);  //判断是不是在攻击范围内
            void GetTarget(UInt8 x,UInt8 y ,UInt8 ride);   //获得攻击目标
            void GetNeighbourEnemy(UInt8 x,UInt8 y,std::vector<Ascoord>& vecAscoord);//相邻的敌人
            void BowAnalyse(std::list<Ascoord> path,Ascoord target);  //弓箭行走路径分析
            void GetBackPosition(std::vector<Ascoord>& vecNearEnemy, std::vector<AttackInfo>& vecFinal);  //弓箭兵后退攻击时 获得后退的坐标
            void GetRideZone(std::vector<Ascoord>& vecAscoord);   //一个行动力所能到获得到的攻击范围
            bool EnemyCanAttack(Ascoord stand, Ascoord target);   //敌人是不是可以攻击到我
            //UInt8 GetDirection(UInt8 x,UInt8 y , UInt8 cx, UInt8 cy);    //获得方向
            void MoveAnalyse(std::list<Ascoord> path, Ascoord target, Ascoord& move);   //如果没有路径  需要前进到哪一个点
            void GetMoveTargetByDir(UInt8 d, Ascoord& move);   //由方向获得目标
            bool InMyAttackHasEnemy(const Ascoord& p );    //我的攻击范围内是不是有敌人
            Ascoord ConvertConverstion(const Ascoord& p);  //坐标转换  主要是为了使用六边形的的规律
            void GetMovePos(std::list<Ascoord>path, Ascoord& last);  //获得要移动的坐标
            UInt8 GetShootActionType(UInt8 x ,UInt8 y, std::vector<Ascoord>& vecEnemy);  //获得弓箭兵的攻击的方式  ( 原地  前进   后退 ) 
            void  ShootGetTarget(UInt8 actionType);    //获得弓箭兵攻击目标
            void  MoveGetEnemy(std::vector<Ascoord>& vecAscoord);
            void  GetMovePosition(Ascoord& move);
            UInt8 GetDistance(Ascoord & lp , Ascoord& rp );  //获得两点之间的距离  如果挨着距离为0
            bool  IsNearbyHaveEnemy(Ascoord& p);

            void AttackInStyle(UInt8 x,UInt8 y, Ascoord& target);   
            UInt8 AddPriority(Ascoord& target);   //增加优先级  按照进攻方式  如果是猛攻方式   有限打直线目标
            void ShootCurrentAttack(Ascoord& target);
            void ShootFrontAttack(Ascoord& target);
            void GetBackPosition(Ascoord& target,std::vector<AttackInfo>& vecFinal);
            void BowGetTarget(UInt8 x,UInt8 y, std::vector<Ascoord>& vecEnemy);
            void ShootBackAttack(Ascoord& target);
            ////////一下这些家伙全是A*相关东西

            UInt8 GetGValue(const Ascoord& p);
            UInt8 GetHValue(const Ascoord &p);  //获得H值
            void  SetStart(const Ascoord &p);   //设置终止点
            void  SetEnd(const Ascoord &p);  //设置起始点
            
            bool  IsObstract(const Ascoord &p); //是不是障碍物
            bool  IsInList(std::list<Node>&list, const Ascoord &p );
            bool  JudgeSurround(const Ascoord& cur,const Ascoord& parent, UInt8 g);
            Node* FindFromList(std::list<Node>& list,const Ascoord& p);
            void  CheckUp(std::vector<Ascoord>&vecAScoord);
            bool  ComputeRoute();
            bool  PopBestStep(Node* node);
            bool  GetRoute(std::list<Ascoord>& list);
            void  GetAround(const Ascoord& p,std::vector<Ascoord>&vecAscoord);
            bool  IsInAround(const Ascoord& p , const Ascoord& t);

            //下面这些是跟战役结算相关的
            void  GiveBattleAward();	 //战斗奖励
            void  SetCaptureForce();     //设置占领的势力id   0代表谁都没占(或者说由野怪占领)
            UInt8 GetCaptureId();        //得到占领的势力id
            void  GetAliveForce(std::vector<UInt8> &vecForce); //获得结束后依然还存活的势力
            void  SendBattleEachInfo();  //发送每一次的战术经过
            std::vector<UInt8> GetPreStartForces(); //获得开打之前有哪些势力
            void  SendBattleResultInfo();  //发送战役结果
            void AutoEnterFighters(UInt8 index, GObject::Player *pl, UInt16 pos = 0);  //竞技场战将进场

            void ClearArenaPos();  //清除竞技场位置信息
            
            void SetIsNPC(bool v){ _isNpc = v;}
            bool GetIsNPC(){ return _isNpc;}
            UInt32 GetBattleNUmber(){ return _battleNum;} 
            bool IsRelivePoint(UInt8 x,UInt8 y);              //判断坐标点是不是复活点
            BenchInfo* GetBenchInfo(UInt8 x , UInt8 y );      //获得替补点的信息
			void GetForceData(UInt8, UInt8, Stream&);

            std::list<BattleFighter*> MixExtraFighterByForceId(); //替补队列按照势力id一次编号(例如 势力1~势力2~势力3~势力1.......)
            std::list<BattleFighter*> GetBenchFighterByForceId(UInt8 forceId);
            void SetExtraFighterActId();    //设置替补战将的行动id
            void GetMinNumRelive(UInt8 forceId, Ascoord& ascoord); //获得最小的人数的替补点
            void GetAllRelivePoint(UInt8 forceId,std::vector<Ascoord>& Relive);
            void Relive(BattleFighter*& bft);  //复活 其实就把满足条件的死亡的战将放替补队列  然后从替补队列取第一个

			void SetBaseHeroInfo(GObject::Fighter* fgt, UInt8 campId, UInt8 x, UInt8 y, bool isMine, UInt8 num);

        private:
            UInt32 _roomId;   //房间id  没有的话 就默认就是0
            UInt8 _x;         //地图的长
            UInt8 _y;         //地图的宽
            UInt8 _mapId;     //地图的id(即城市id)
            //std::map<UInt8 ,std::list<GObject::Player *> >  map_player;
            
            std::map<UInt8, std::vector<FighterInfo*>> _map2preInfo;	//放将初始时，用来存储相关信息的
            std::map<UInt8, std::list<Ascoord>> _camp2pos;				//阵营对应的布阵位置  直接按照行动顺序进行布局

            UInt8 * _mapGround;				 //地图信息  可以设置战场的环境
            //UInt8 * _mapFlag;    
            UInt8 * _mapCamp;				 //地图阵营信息
            BattleObject ** _mapFighters;    //注意和fighters的坐标同步
            std::map<UInt8,Ascoord> num2pos; //地图位置对应编号

            std::map<UInt8,std::list<BattleFighter*>> camp2fighters; //阵营对应的战将们
            //std::list<BattleFighter *> fighters[PLAYERMAX];        //阵营中的战将
            std::vector<BattleInfo> battleIds;

            std::vector<TargetInfo> _vecTarget;  //当前出手战将所能攻击到的敌人们
            BattleFighter * _currentBf;   //当前出手战将

            Stream _pack;               //战术组包

            UInt16 _maxID;
            UInt32 _battleNum;         //战术战报id
            
            UInt16 _roundId;           //战术回合id
            bool   _isFirstRound;
            UInt16 _oneRoundCostTime;  //一回合消耗的时间
            bool   _isSetCapture;      //是不是被占领
            std::set<GObject::Player*> setPlayer;

            //一下全是跟A*算法  有关的东西
            Ascoord _start;
            Ascoord _end;
            std::list<Node>  _closeList;
            std::list<Node>  _openList;
            std::vector<Ascoord> _aroundAscoord;

            //特殊功能 
            bool _isNpc;
            std::list<BenchInfo*> listBench;          //替补战将列表信息
            std::list<BattleFighter*> listFighters;   //所有战将
            UInt16 _actCount;                         //行动数量

			UInt8 _mapMaxFgtNum;					  //战术中从0开始（标记地图上武将ID）
    };
}
#endif // BATTLEGROUND_H_

/* vim: set ai si nu sm smd hls is ts=4 sm=4 bs=indent,eol,start */

