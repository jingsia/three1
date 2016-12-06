/*************************************************************************
	> File Name: test.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 24 Oct 2016 01:50:52 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;

class A
{
	public:
		A(int a, int b): _a(a), _b(b) {}

		A& operator +=(int rate)
		{
			_a *= rate;
			_b *= rate;
		}

		int GetA() { return _a;}

		A* operator ->() { return this;}
		operator A*() { return this;}
	private:
		int _a;
		int _b;
};

int main()
{
	A a(1, 2);
	a+=10;
	std::cout << a.GetA() << std::endl;
	std::cout << a->GetA() << std::endl;
	(*(*a))+=10;
	std::cout << a.GetA() << std::endl;
	return 0;
}
