/*************************************************************************
	> File Name: Cfg.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 11 Mar 2016 06:57:57 AM CST
 ************************************************************************/

#include "Cfg.h"
#include "common/StringTokenizer.h"

Cfg cfg;

Cfg::Cfg(): tcpPort(8888), serverIp(0), serverLogId(0), dbDataPort(3306), dbObjectPort(3306),fbVersion(false), vtVersion(false), debug(false), openYear(2011), openMonth(9), openDay(23), enableWallow(false), limitLuckDraw(0),
	merged(false), supportCmpress(true), GMCheck(true), channelNum(0),serverNum(0), serverNo(0), testPlatform(false), arenaPort(0), serverWarPort(0),enableLoginLimit(false),loginLimit(10000),onlineLimit(0),udplog(true),dclog(true), secdclog(false),secdclogTest(false),unionPlatfo    rm(false),autoForbid(false),autoKick(false),rpServer(e_rp_none), _filename("conf/config.lua")
{
}

