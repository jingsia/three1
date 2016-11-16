/*************************************************************************
	> File Name: test.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 30 Jun 2016 03:57:21 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;
#include<string.h>

extern "C"  
{  
	    #include "lua.h"  
	    #include "lauxlib.h"  
	    #include "lualib.h"  
}

int main()
{
	lua_State *L = luaL_newstate();
	if(L == NULL)
		return 0;

	int bRet = luaL_loadfile(L, "hello.lua");
	if(bRet)
		return 0;

	bRet = lua_pcall(L, 0, 0, 0);

	lua_getglobal(L, "str");
	string str = lua_tostring(L, -1);
	std::cout << str.c_str() << endl;

	lua_getglobal(L, "add");
	lua_pushnumber(L, 10);
	lua_pushnumber(L, 20);
	int iRet = lua_pcall(L, 2, 1, 0);
	if(iRet)
	{
		const char *pErrorMsg = lua_tostring(L, -1);
		cout << pErrorMsg << endl;
		lua_close(L);
		return 0;
	}

	if(lua_isnumber(L, -1))
	{
		double fValue = lua_tonumber(L, -1);
		cout << fValue << endl;
	}
	lua_close(L);
	return 0;
}
