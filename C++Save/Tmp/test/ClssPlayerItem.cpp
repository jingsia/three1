/*************************************************************************
	> File Name: ClssPlayerItem.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 18 Mar 2016 10:42:46 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;

class Player
{
public:
	Player()
	{
		std::cout << "this is Player " << std::endl;
	}

	const void getP() const
	{
		std::cout << "this is getP" << std::endl;
	}
};

class Package
{
public:
	Package(Player * pl) : m_Owner(pl) {}

	const void  GetPl() const
	{
		m_Owner->getP();
	}

private:
	Player* m_Owner;
};

int main()
{
	Player pl;

	Package pkg(&pl);
	pkg.GetPl();

	return 0;
}
