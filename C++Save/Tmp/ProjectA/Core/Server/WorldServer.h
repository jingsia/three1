#ifndef	SERVER_INC
#define SERVER_INC

#include "Common/Singleton.h"
#include "Network/TcpServerWrapper.h"
#include "ServerTypes.h"
#include "GObject/World.h"
#include "DB/DBWorker.h"
#include "Login/LoginWorker.h"
#include "WorkerThread.h"
#include "GObject/LoadWorker.h"

#include <curl/curl.h>

extern const char* s_HelpInfo;

namespace GObject
{
	class Country;
#ifndef _WIN32
    class DCWorker;
    class OpenAPIWorker;
#endif
    class LoadWorker;
}

class BaseThread;
class WorldServer : public Singleton<WorldServer>
{
public:
	void Run();
	bool ParseCommandInfor(Int32 argc, char * argv[]);

protected:
	WorldServer();
	virtual ~WorldServer();
	friend class Singleton<WorldServer>;

public:
	bool Init(const char * = NULL, const char * = NULL, int num = 0);
	void Shutdown();
	void UnInit();
	void SetActive(bool active);
	bool IsActive() const;

public:
	GObject::Country& GetCountry(UInt8 worker);
	GObject::World& GetWorld();
#ifndef _WIN32
	GObject::DCWorker& GetDC();
    GObject::OpenAPIWorker& GetOpenAPI();
#endif
	DB::DBWorker& GetDB();
	DB::DBWorker& GetDB1();
	DB::DBWorker& GetDB2();
	DB::DBWorker& GetDB3();
	DB::DBWorker& GetDB4();
	DB::DBWorker& GetDB5();
	DB::DBWorker& GetDB6();
	DB::DBWorker& GetDB7();
	DB::DBWorker& GetDB8();
	DB::DBWorker& GetDBLog();
	DB::DBWorker& GetDBLog1();
	Login::LoginWorker& GetLogin();
    GObject::LoadWorker& GetLoad();

	inline Network::TcpServerWrapper* GetTcpService() {return m_TcpService;}

protected:
	template <typename WorkerType>
	inline WorkerType& Worker(UInt8 worker)
	{
		return (dynamic_cast<WorkerThread<WorkerType>*>(m_AllWorker[worker]))->Worker();
	}

private:
	bool	m_IsActive;
	ServerInfor m_ServerInfor;

	//////////////////////////////////////////////////////////////////////////
public:
	BaseThread*	m_AllWorker[MAX_THREAD_NUM];
	Network::TcpServerWrapper* m_TcpService;

public:
    void Up();
    void Down();
    void State(const char* action, int serverNum);

    void do_curl_request( const char* url );
    bool do_http_request(const char* url, int timeout);

    void updateState(const char* action);
    bool do_http_request_for_login(UInt32 accid, std::string token, int timeout = 3);

private:
    CURL* curl;
};

#define SERVER()		WorldServer::Instance()
#define NETWORK()		SERVER().GetTcpService()
#define WORLD()			SERVER().GetWorld()
#ifndef _FB
#ifndef _VT
#ifndef _WIN32
#define DC()			SERVER().GetDC()
#ifdef  OPEN_API_ON
#define OPENAPI()       SERVER().GetOpenAPI()
#endif
#endif
#endif
#endif
#define DB()			SERVER().GetDB()
#define DB1()			SERVER().GetDB1()
#define DB2()			SERVER().GetDB2()
#define DB3()			SERVER().GetDB3()
#define DB4()			SERVER().GetDB4()
#define DB5()			SERVER().GetDB5()
#define DB6()			SERVER().GetDB6()
#define DB7()			SERVER().GetDB7()
#define DB8()			SERVER().GetDB8()
#define DBLOG()			SERVER().GetDBLog()
#define DBLOG1()		SERVER().GetDBLog1()
#define LOGIN()			SERVE().GetLogin()
#define LOAD()          SERVER().GetLoad()

#define CURRENT_THREAD_ID() WorkerThread<WorkerRunner<> >::LocalWorker().GetThreadID()
inline  bool  IsMainThread()
{
    return Thread::current() == 0;
}
#endif

