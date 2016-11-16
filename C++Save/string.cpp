/*************************************************************************
	> File Name: sss.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 27 Oct 2016 06:53:55 PM CST
 ************************************************************************/

#include<iostream>
 #include <string.h>
using namespace std;

int main()
{
	char * a = "1234";
	string s(a);
	std::cout << strlen(a) << std::endl;
	std::cout << s << std::endl;

	string news, news1;
	news.assign(s, 0,2);
	news1.assign(s, 2,2);
	std::cout << news << "xxx " << s  << "  sssss"  << news1 << std::endl;
	return 0;
}
