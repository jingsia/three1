/*************************************************************************
	> File Name: testsss.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 08 Nov 2016 11:33:34 AM CST
 ************************************************************************/

/*
 * va_list vl; //定义一个指向参数列表的变量(一个...指针)
 * va_start(vl,first_param); //把指向参数列表的变量初始化
 * va_arg(vl,mode); //获取下一个参数,参数类型由第二个参数指定,第二个参数用于在va_arg内部进行尺寸计算,以便找到下一个参数
 * va_end(vl); //结束
 * */

#include<iostream>
#include <cstdarg>
#include <stdio.h>
using namespace std;

void variable(int i,...)
{
	int j=0;
	va_list arg_ptr; //定义一个指向参数列表的变量
	va_start(arg_ptr,i); //把指向参数列表的变量初始化

	while(j!=-1) //自定义的一个参数结束标志
	{
		j=va_arg(arg_ptr,int); //获取下一个参数
		printf("%d ",j);
	}
	va_end(arg_ptr); //结束
}

int main()
{
	variable(1,2,3,4,5);
	return 0;
}
