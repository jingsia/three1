

bool WorldServer::Init(const char* scriptStr, const char * serverName, int num)
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
	Network::Initialize();	//开启多线程evthread_use_pthreads()
	//读取配置文件
	TimeUtil::Init();
	GObject::VarSystem::Init();
	GObject::GVarSystem::Init();
	cfg.load(scriptStr);
	globalSysMsg.load();
}
