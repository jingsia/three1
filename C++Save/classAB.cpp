/*************************************************************************
	> File Name: test.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Sat 12 Nov 2016 03:23:25 AM CST
 ************************************************************************/


//测试AB程序析构释放delete先后顺序
#include<iostream>
using namespace std;

class A
{
	public:
		A() { a = new int();}
		~A() { std::cout << a << std::endl; delete a; std::cout << "free a" << std::endl;}

	private:
		int* a;
};

class B
{
	public:
		B() { a = new A();}
~B() { delete a; std::cout << "free b" << std::endl;}
	private:
	A* a;
};

int main()
{
	B b;
	return 0;
}

