﻿#include "Config.h"

#include "WorldServer.h"
#include "GData/GDataManager.h"
#include "GObject/GObjectManager.h"
#include "GObject/World.h"
#include "GObject/Country.h"
#include "GObject/Var.h"
#include "GObject/GVar.h"
#include "Battle/BattleReport.h"
//#include "GObject/ClanManager.h"
#include "DB/DBWorker.h"
#include "WorkerThread.h"
#include "DB/DBConnectionMgr.h"
#include "Login/LoginWorker.h"
#include "Cfg.h"
#include "SysMsg.h"
#include "Common/TimeUtil.h"
#ifndef _FB
#ifndef _VT
#ifndef _WIN32
#include "GObject/DCWorker.h"
//#include "GObject/DCLogger.h"
#include "kingnet_analyzer.h"
//#include "GObject/OpenAPIWorker.h"
#endif
#endif
#endif
//#include "GObject/SortWorker.h"
#include "Common/StringTokenizer.h"
//#include "GObject/Tianjie.h"
const char* s_HelpInfo = "";
//////////////////////////////////////////////////////////////////////////
WorldServer::WorldServer() : m_IsActive(false), curl(NULL)
{
	memset(m_AllWorker, 0x00, sizeof(m_AllWorker));
	m_TcpService = NULL;
    curl = curl_easy_init();
}

WorldServer::~WorldServer()
{
	for (int i = 0; i < MAX_THREAD_NUM; i++)
	{
		delete m_AllWorker[i];
	}
	//delete m_TcpService;
    if (curl) curl_easy_cleanup(curl);
}

bool WorldServer::ParseCommandInfor(Int32 argc, char * argv[])
{
	int status = 0;
	for(int i = 1; i < argc; ++ i)
	{
		switch(status)
		{
		case 1:
			cfg.setFilename(argv[i]);
			break;
		default:
			if(strcmp(argv[i], "--config") == 0)
			{
				status = 1;
			}
			break;
		}
	}
	return true;
}

bool WorldServer::Init(const char * scriptStr, const char * serverName, int num)
{
	if(serverName != NULL)
	{
		const char * p = strstr(serverName, "_s");
		if(p != NULL)
		{
			cfg.channelName = std::string(serverName, p);
			cfg.serverNum = atoi(p + 2);
			cfg.slugName = cfg.channelName;
		}
	}
    Network::Initialize();
	//读取配置文件
	TimeUtil::Init();
    GObject::VarSystem::Init();
    GObject::GVarSystem::Init();
	cfg.load(scriptStr);
	globalSysMsg.load();
    //	Battle::battleReport.init();

#ifndef _WIN32
#ifdef _FB
    _analyzer.Init("./conf/udplogfb.xml");
#else
    _analyzer.Init();
#endif
#ifdef _FB
#else
    //GObject::dclogger.init();
#endif
#endif

    if (!num)
    {
        srand(time(NULL));
        cfg.serverNum = cfg.tcpPort+rand()%1000;
    }
    else
        cfg.serverNum = num;

    cfg.serverLogId = cfg.serverNum;

#ifdef _FB
    cfg.fbVersion = true;
#endif
#ifdef _VT
    cfg.vtVersion = true;
#endif

#ifdef _DEBUG
    cfg.debug = true;
#endif

	//数据库连接操作， 连接池创建
	DB::gDataDBConnectionMgr = new DB::DBConnectionMgr();
	DB::gDataDBConnectionMgr->Init( cfg.dbDataHost.c_str(), cfg.dbDataUser.c_str(), cfg.dbDataPassword.c_str(), cfg.dbDataSource.c_str(), 1, 32, cfg.dbDataPort );

	DB::gObjectDBConnectionMgr = new DB::DBConnectionMgr();
	DB::gObjectDBConnectionMgr->Init( cfg.dbObjectHost.c_str(), cfg.dbObjectUser.c_str(), cfg.dbObjectPassword.c_str(), cfg.dbObjectSource.c_str(), 4, 32, cfg.dbObjectPort );

	DB::gLogDBConnectionMgr = new DB::DBConnectionMgr();
	DB::gLogDBConnectionMgr->Init( cfg.dbLogHost.c_str(), cfg.dbLogUser.c_str(), cfg.dbLogPassword.c_str(), cfg.dbLogSource.c_str(), 4, 32, cfg.dbLogPort );

    DB::gLockDBConnectionMgr = new DB::DBConnectionMgr();
	DB::gLockDBConnectionMgr->Init( cfg.dbLockHost.c_str(), cfg.dbLockUser.c_str(), cfg.dbLockPassword.c_str(), cfg.dbLockSource.c_str(), 1, 4, cfg.dbLockPort );

	int worker;

	worker = WORKER_THREAD_WORLD;
	m_AllWorker[worker] = new WorkerThread<GObject::World>(new GObject::World());

	for (worker = WORKER_THREAD_COUNTRY_1; worker <= WORKER_THREAD_NEUTRAL; worker++)
	{
		m_AllWorker[worker] = new WorkerThread<GObject::Country>(new GObject::Country(worker));
	}

	worker = WORKER_THREAD_LOGIN;
	m_AllWorker[worker] = new WorkerThread<Login::LoginWorker>(new Login::LoginWorker());

	//worker = WORKER_THREAD_SORT;
	//m_AllWorker[worker] = new WorkerThread<GObject::SortWorker>(new GObject::SortWorker(0, WORKER_THREAD_SORT));
#ifndef _FB
#ifndef _VT
#ifndef _WIN32
	worker = WORKER_THREAD_DC;
	m_AllWorker[worker] = new WorkerThread<GObject::DCWorker>(new GObject::DCWorker(0, WORKER_THREAD_DC));
#ifdef  OPEN_API_ON
	worker = WORKER_THREAD_OPEN_API;
	m_AllWorker[worker] = new WorkerThread<GObject::OpenAPIWorker>(new GObject::OpenAPIWorker(0, WORKER_THREAD_OPEN_API));
#endif
#endif
#endif
#endif
	worker = WORKER_THREAD_LOAD;
	m_AllWorker[worker] = new WorkerThread<GObject::LoadWorker>(new GObject::LoadWorker(0, WORKER_THREAD_LOAD));
	worker = WORKER_THREAD_DB;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB));
	worker = WORKER_THREAD_DB1;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB1));
	worker = WORKER_THREAD_DB2;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB2));
	worker = WORKER_THREAD_DB3;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB3));
	worker = WORKER_THREAD_DB4;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB4));
	worker = WORKER_THREAD_DB5;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB5));
	worker = WORKER_THREAD_DB6;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB6));
	worker = WORKER_THREAD_DB7;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB7));
	worker = WORKER_THREAD_DB8;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(0, WORKER_THREAD_DB8));

	worker = WORKER_THREAD_DB_LOG;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(1, WORKER_THREAD_DB_LOG));
	worker = WORKER_THREAD_DB_LOG1;
	m_AllWorker[worker] = new WorkerThread<DB::DBWorker>(new DB::DBWorker(1, WORKER_THREAD_DB_LOG1));

#ifndef _FB
#ifndef _VT
#ifndef _WIN32
	worker = WORKER_THREAD_DC;
	m_AllWorker[worker]->Run();
#endif
#endif
#endif

	//启动数据库线程处理
	worker = WORKER_THREAD_DB;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB1;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB2;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB3;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB4;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB5;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB6;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB7;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB8;
	m_AllWorker[worker]->Run();

	worker = WORKER_THREAD_DB_LOG;
	m_AllWorker[worker]->Run();
	worker = WORKER_THREAD_DB_LOG1;
	m_AllWorker[worker]->Run();

	GData::GDataManager::LoadAllData();
	//GObject::GObjectManager::InitGlobalObject();
	GObject::GObjectManager::InitIDGen();	    //将各表的最大ID值存入缓存
	GObject::GObjectManager::loadAllData();

	Battle::battleReport0.init();
	Battle::battleReport1.init();
#ifndef _FB
#ifndef _VT
#ifndef _WIN32
#ifdef  OPEN_API_ON
	worker = WORKER_THREAD_OPEN_API;
	m_AllWorker[worker]->Run();
#endif
#endif
#endif
#endif
    worker = WORKER_THREAD_LOAD;
    m_AllWorker[worker]->Run();
	return true;
}

void WorldServer::UnInit()
{
    Down();

	DB::gObjectDBConnectionMgr->UnInit();
	delete DB::gObjectDBConnectionMgr;
	DB::gObjectDBConnectionMgr = NULL;

	DB::gDataDBConnectionMgr->UnInit();
	delete DB::gDataDBConnectionMgr;
	DB::gDataDBConnectionMgr = NULL;

	DB::gLogDBConnectionMgr->UnInit();
	delete DB::gLogDBConnectionMgr;
	DB::gLogDBConnectionMgr = NULL;

	Network::Uninitialize();
}

void WorldServer::SetActive(bool active)
{
	m_IsActive = active;
}

bool WorldServer::IsActive() const
{
	return m_IsActive;
}

void WorldServer::Run()
{
	int worker;

	//worker = WORKER_THREAD_SORT;
	//m_AllWorker[worker]->Run();

	worker = WORKER_THREAD_WORLD;
	m_AllWorker[worker]->Run();

	//启动工作线程
	for (worker = WORKER_THREAD_COUNTRY_1; worker <= WORKER_THREAD_NEUTRAL; worker++)
	{
		m_AllWorker[worker]->Run();
	}

	//启动登录线程
	worker = WORKER_THREAD_LOGIN;
	m_AllWorker[worker]->Run();

	m_TcpService = new Network::TcpServerWrapper(cfg.tcpPort);
	m_TcpService->Start();

    Up();

	//主线程等待所有子线程结束
	for (worker = 0; worker < MAX_THREAD_NUM; worker++)
	{
        while(!m_AllWorker[worker]->tryJoin(300000))
        {
            updateState("open");
        }
		//m_AllWorker[worker]->Wait();
	}

	m_TcpService->Join();

	delete m_TcpService;
}

void WorldServer::Shutdown()
{
	int worker;

    Down();

	//关闭网络线程
	m_TcpService->UnInit();

	Thread::sleep(2000);

	//关闭所有工作线程
	for (worker = 0; worker < MAX_THREAD_NUM; worker++)
	{
#ifdef OPEN_API_ON
		if(worker < WORKER_THREAD_DB && worker != WORKER_THREAD_OPEN_API)
#else
		if(worker < WORKER_THREAD_DB)
#endif
			m_AllWorker[worker]->Shutdown();
	}

    // XXX: erase all event
	Thread::sleep(2000);
    //GObject::eventWrapper.clear();   //LIBODELETE 
	Thread::sleep(2000);
	m_AllWorker[WORKER_THREAD_DB]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB1]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB2]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB3]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB4]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB5]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB6]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB7]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB8]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB_LOG]->Shutdown();
	m_AllWorker[WORKER_THREAD_DB_LOG1]->Shutdown();
#ifdef OPEN_API_ON
    m_AllWorker[WORKER_THREAD_OPEN_API]->Shutdown();
#endif

    m_AllWorker[WORKER_THREAD_LOAD]->Shutdown();
}

#define MAX_RET_LEN 1024

static int recvret(char* data, size_t size, size_t nmemb, char* buf)
{
    size_t nsize = size * nmemb;
    if (nsize > MAX_RET_LEN) {
        //bcopy(data, buf, MAX_RET_LEN);
		memcpy(buf, data, MAX_RET_LEN);
        return MAX_RET_LEN;
    }

	memcpy(buf, data, nsize);
    //bcopy(data, buf, nsize);
    return nsize;
}

void WorldServer::do_curl_request( const char* url )
{
    char buffer[MAX_RET_LEN] = {0};
    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, recvret);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &buffer);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 10);
    curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);

    //fprintf(stderr, "URL: %s\n", url);

    CURLcode res = curl_easy_perform(curl);
    if (CURLE_OK == res)
    {
        // TODO:
        //fprintf(stderr, "URL: %s [OK]\n", url);
    }
    else
    {
        //fprintf(stderr, "URL: %s [ERROR]\n", url);
    }
}

bool WorldServer::do_http_request(const char* url, int timeout)
{
    char buffer[MAX_RET_LEN] = {0};
    curl_easy_setopt(curl, CURLOPT_URL, url);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, recvret);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &buffer);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, timeout);
    curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);

    //fprintf(stderr, "URL: %s\n", url);

    CURLcode res = curl_easy_perform(curl);
    if (CURLE_OK == res)
    {
        //fprintf(stderr, "URL: %s [OK]\n", url);
        const char* msg = strcasestr(buffer, "msg");
        if (!msg)
            return false;
        if (strcasestr(msg, "ok"))
            return true;
        return false;
    }
    else
    {
        //fprintf(stderr, "URL: %s [ERROR]\n", url);
        return false;
    }

    return false;
}

bool WorldServer::do_http_request_for_login(UInt32 accid, std::string token, int timeout)
{
    char buffer[MAX_RET_LEN] = {0};
    Stream st;
    st << "uid=" << accid << "&appid=" << cfg.appid << "&token=" << token ;
    std::string url = cfg.remoteUrl;
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, recvret);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &buffer);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, timeout);
    curl_easy_setopt(curl, CURLOPT_NOSIGNAL, 1L);

    //fprintf(stderr, "URL: %s\n", url.c_str());

    CURLcode res = curl_easy_perform(curl);
    if (CURLE_OK == res)
    {
        //fprintf(stderr, "URL: %s [OK]\n", url.c_str());
        const char* msg = strcasestr(buffer, "msg");
        if (!msg)
            return false;
        if (strcasestr(msg, "ok"))
            return true;
        return false;
    }
    else
    {
        //fprintf(stderr, "URL: %s [ERROR]\n", url.c_str());
        return false;
    }

    return false;
}

void WorldServer::State(const char* action, int serverNum)
{
    if (!curl || !action || !serverNum)
        return;
    char url[4096] = {0};
    snprintf(url, sizeof(url), "%s&state=%s&server=s%d", cfg.stateUrl.c_str(), action, serverNum);

    do_curl_request(url);

    updateState(action);
}


void WorldServer::updateState(const char* action)
{
#ifdef _DEBUG
    if (!curl || !action)
        return;
    char url[4096] = {0};

    char serverIp[20];
    in_addr iaddr;
    iaddr.s_addr = cfg.serverIp;
    strcpy(serverIp, inet_ntoa(iaddr));
    //snprintf(url, sizeof(url), "http://192.168.88.250/serverstate.php?ip=%s&port=%d&state=%s", serverIp, cfg.tcpPort, action);
    do_curl_request(url);
#endif
}

void WorldServer::Up()
{
    State("open", cfg.serverNum);
    if (!cfg.mergeList.empty())
    {
        StringTokenizer st(cfg.mergeList, " ");
        if (st.count())
        {
            for (UInt32 i = 0; i < st.count(); ++i)
                State("open", atoi(st[i].c_str()));
        }
    }
    //GObject::Tianjie::instance().setNetOk();   //LIBODELETE
}

void WorldServer::Down()
{
    State("close", cfg.serverNum);
}

GObject::Country& WorldServer::GetCountry(UInt8 worker)
{
	assert(worker==WORKER_THREAD_NEUTRAL || worker==WORKER_THREAD_COUNTRY_1 || worker==WORKER_BATTLE);
	return Worker<GObject::Country>(worker);
}

GObject::World& WorldServer::GetWorld()
{
	return Worker<GObject::World>(WORKER_THREAD_WORLD);
}

#ifndef _FB
#ifndef _VT
#ifndef _WIN32
GObject::DCWorker& WorldServer::GetDC()
{
	return Worker<GObject::DCWorker>(WORKER_THREAD_DC);
}

#ifdef  OPEN_API_ON
GObject::OpenAPIWorker& WorldServer::GetOpenAPI()
{
    return Worker<GObject::OpenAPIWorker>(WORKER_THREAD_OPEN_API);
}
#endif
#endif
#endif
#endif

GObject::LoadWorker& WorldServer::GetLoad()
{
	return Worker<GObject::LoadWorker>(WORKER_THREAD_LOAD);
}

DB::DBWorker& WorldServer::GetDB()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB);
}

DB::DBWorker& WorldServer::GetDB1()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB1);
}

DB::DBWorker& WorldServer::GetDB2()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB2);
}

DB::DBWorker& WorldServer::GetDB3()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB3);
}

DB::DBWorker& WorldServer::GetDB4()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB4);
}

DB::DBWorker& WorldServer::GetDB5()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB5);
}

DB::DBWorker& WorldServer::GetDB6()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB6);
}

DB::DBWorker& WorldServer::GetDB7()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB7);
}

DB::DBWorker& WorldServer::GetDB8()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB8);
}

DB::DBWorker& WorldServer::GetDBLog()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB_LOG);
}

DB::DBWorker& WorldServer::GetDBLog1()
{
	return Worker<DB::DBWorker>(WORKER_THREAD_DB_LOG1);
}

Login::LoginWorker& WorldServer::GetLogin()
{
	return Worker<Login::LoginWorker>(WORKER_THREAD_LOGIN);
}
