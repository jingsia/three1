/*************************************************************************
	> File Name: ServerTypes.h
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 10 Nov 2016 11:42:01 AM CST
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
	WORKER_BATTLE,
	WORKER_THREAD_NUMTRAL,
	WORKER_THREAD_WORLD,
	WORKER_THREAD_LOGIN,
	WORKER_THREAD_DC,
	WORKER_THREAD_OPEN_API,
	WORKER_THREAD_DB,
	WORKER_THREAD_DB1,
	WORKER_THREAD_DB2,
	WORKER_THREAD_DB3,
	WORKER_THREAD_DB4,
	WORKER_THREAD_DB5,
	WORKER_THREAD_DB6,
	WORKER_THREAD_DB_LOG,
	WORKER_THREAD_LOAD,

	MAX_THREAD_NUM
};
