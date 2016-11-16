/*************************************************************************
	> File Name: max.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 17 May 2016 01:56:41 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;

template<typename T>
inline T Max(const T& a, const T& b)
{
	return a > b ? a : b;
}

int main()
{
	int a = 10, b = 3;
	cout << Max(a, b) << endl;
	return 0;
}
