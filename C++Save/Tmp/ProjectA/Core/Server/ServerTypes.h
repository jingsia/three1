/*************************************************************************
	> File Name: ServerTypes.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 18 Mar 2016 02:25:24 PM CST
 ************************************************************************/

#ifndef _SERVERTYPES_H_
#define _SERVERTYPES_H_

struct ServerInfor
{
	std::string m_Ip;
	UInt16		m_Port;
	std::string m_DBIp;
	UInt16		m_DBPort;
};

enum
{
	WORKER_THREAD_COUNTRY_1 = 0,
	WORKER_THREAD_COUNTRY_2,
	WORKER_THREAD_NEUTRAL,
	WORKER_THREAD_WORLD,
	WORKER_THREAD_LOGIN,
	WORKER_THREAD_SORT,

	WORKER_THREAD_DB,
	WORKER_THREAD_DB1,
	WORKER_THREAD_DB2,
	WORKER_THREAD_DB3,
	WORKER_THREAD_DB4,
	WORKER_THREAD_DB5,
	WORKER_THREAD_DB6,
	WORKER_THREAD_DB7,
	WORKER_THREAD_DB8,
	WORKER_THREAD_DB_LOG,
	WORKER_THREAD_DB_LOG1,
	WORKER_THREAD_LOAD,

	MAX_THREAD_NUM
};

#define COUNTRY_EMEI WORKER_THREAD_COUNTRY_1
#define COUNTRY_KUNLUN WORKER_THREAD_COUNTRY_2
#define COUNTRY_NEUTRAL WORKER_THREAD_NEUTRAL
#define COUNTRY_MAX (WORKER_THREAD_NEUTRAL + 1)

#define LEVEL_MAX (200)
#define CLAN_LEVEL_MAX (10)
#define NEWGUILDSTEP_MAX (34)

#endif
