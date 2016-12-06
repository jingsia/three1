/*************************************************************************
	> File Name: as.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 31 Oct 2016 05:41:28 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;

class A
{
	public:
 static bool GetA() { return _a;}
 static void SetA(bool a) { _a = a;}

	private:
	static bool _a;

};

bool A::_a = true;

int main()
{
	A a;
	a.SetA(false);

	std::cout << a.GetA() << std::endl;

	return 0;
}
