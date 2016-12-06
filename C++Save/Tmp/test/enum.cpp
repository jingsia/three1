/*************************************************************************
	> File Name: enum.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 17 Mar 2016 11:12:54 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;

enum A
{
	Item_Green	= 1,
	Item_Yellow	= 2,
};

int getA(A a)
{
	int s = 0;

	std::cout << Item_Yellow << std::endl;
	switch (a)
	{
	case Item_Green:
		s = 1;
		break;
	case Item_Yellow:
		s = 2;
		break;
	}

	return s;
}

int main()
{
	std::cout << getA(Item_Green) << std::endl;
	return 0;
}
