/*************************************************************************
	> File Name: Cfg.h
	> Author: yangjx
	> Mail: yangjx@163.com 
	> Created Time: Thu 10 Mar 2016 07:19:17 PM CST
 ************************************************************************/

#ifndef _CFG_H_
#define _CFG_H_

enum RPServerType
{
	e_rp_none = 0,
	e_rp_xinyun = 1,
	e_rp_lianmen = 2,
};

class Cfg
{
public:
	Cfg();
	void load(const char * = NULL);
	inline void setFilename(const char * fn) { filename = fn;}

	UInt16		tcpPort;
	UInt32		serverIp;
	std::string ifName;
	std::string scriptPath;
	std::string reportPath0;
	std::string reportPath1;
	UInt32		serverLogId;
	std::string announceFile;

	std::string dbDataHost;
	UInt16		dbDataPort;
	std::string dbDataUser;
	std::string dbDataPassword;
	std::string dbDataSource;

	std::string dbObjectHost;
	UInt16		dbObjectPort;
	std::string dbObjectUser;
	std::string dbObjectPassword;
	std::string dbObjectSource;

	std::string dbLockHost;
	UInt16		dbLockPort;
	std::string dbLockUser;
	std::string dbLockPassword;
	std::string dbLockSource;

	std::string dbLogHost;
	UInt16		dbLogPort;
	std::string dbLogUser;
	std::string dbLogPassword;
	std::string dbLogSource;

	std::string cryptKey1, cryptKey2;

public:
	inline void setTcpPort(UInt16 p) {tcpPort = p};
	void setIfName(const char * iname);
	inline void setScrptPath(const char * p){scriptPath = p;}
	inline void setReportPath0(const char * p){reportPath0 = p;}
	inline void setReportPath1(const char * p){reportPath1 = p;}
	inline void setServerLogId(const UInt32 id){serverLogId = id;}
	inline void setAnnounceFile(const char * p){announceFile = p;}
	inline void setDataDataBase(const char *h, UInt16 p, const char * u, const char * pw, const char * s)
	{dbDataHost = h; dbDataPort = p; dbDataUser = u; dbDataPassword = pw; dbDataSource = s;}
	inline void setObjectDatabase(const char * h, UInt16 p, const cha    r * u, const char * pw, const char * s )
	{dbObjectHost = h; dbObjectPort = p; dbObjectUser = u; dbObjectPa    ssword = pw; dbObjectSource = s;}
	inline void setLogDatabase(const char * h, UInt16 p, const char *     u, const char * pw, const char * s )
	{dbLogHost = h; dbLogPort = p; dbLogUser = u; dbLogPassword = pw;     dbLogSource = s;}
	inline void setLockDatabase(const char * h, UInt16 p, const char     * u, const char * pw, const char * s )
	{dbLockHost = h; dbLockPort = p; dbLockUser = u; dbLockPassword =     pw; dbLockSource = s;}


};

extern Cfg cfg;

#endif

