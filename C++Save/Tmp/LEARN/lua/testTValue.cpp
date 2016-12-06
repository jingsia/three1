/*************************************************************************
	> File Name: testTValue.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 30 Jun 2016 03:31:49 AM CST
 ************************************************************************/

#include<iostream>
#include<string.h>
using namespace std;

extern "C"
{
	#include "lua.h"
	#include "lauxlib.h"
	#include "lualib.h"
}

int main()
{
	lua_State *L = luaL_newstate();
	lua_pushstring(L, "am so cool~~");
	lua_pushnumber(L, 20);

	if(lua_isstring(L, 1))
	{
		std::cout << lua_tostring(L, 1) << std::endl;
	}

	if(lua_isnumber(L, 2))
	{
		std::cout << lua_tonumber(L, 2) << std::endl;
	}

	lua_close(L);
	return 0;
}
