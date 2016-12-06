/*************************************************************************
	> File Name: StructTValue.c
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 30 Jun 2016 03:23:54 AM CST
 ************************************************************************/

#include<stdio.h>
struct TValue
{
	Value value;
	int	  tt;
};

union Value
{
	GCObject *gc;
	void *p;
	lua_Number n;
	int b;
};

union GCObject
{
	GCheader gch;
	union TString ts;
	union Udata u;
	union Closure cl;
	struct Table h;
	struct Proto p;
	struct UpVal uv;
	struct lua_State th;
};
