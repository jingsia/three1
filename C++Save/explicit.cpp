/*************************************************************************
	> File Name: explicit.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Nov 2016 03:29:34 AM CST
 ************************************************************************/

#include<iostream>
#include<memory.h>
using namespace std;

class A
{
public:
	char *_ptr;
	int _size;
	A(int a)
	{
		_ptr = malloc(size + 1);
		_size = a;
		memset(_ptr, 0, size + 1);
	}

	A(const char *a)
	{
		int size = strlen(a);
		_ptr = malloc(size + 1);
		strcpy(_ptr, a);
		_size = strlen(_ptr);
	}
};
