/*************************************************************************
	> File Name: Class.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 14 Mar 2016 05:34:32 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;


class B
{
public:
	B () {}
	~B() {}

	void GetB() { std::cout << "this is b" << std::endl;}
};

class A
{
public:
	A(int a, B *);
	~A();

	void SetA(const int a);
	const int GetA() const;

private:
	int _a;
	B * _b;
};

A::A(int a, B * b): _b(b), _a(a)
{

}

A::~A() {}

void A::SetA(const int a)
{
	_a = a;
}

const int A::GetA() const
{
	_b->GetB();
	return _a;
}


int main(int argc, char * argv[])
{
	B b;
	A a(10, &b);
	std::cout << a.GetA() << std::endl;

	return 0;
}
