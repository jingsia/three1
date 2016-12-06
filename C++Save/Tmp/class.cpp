#include<iostream>
using namespace std;

class A
{
public:
	A(int id):a(id){}
	void GetA();
protected:
	int a;
};

void A::GetA()
{
	std::cout << a << std::endl;
}

class B : public A
{
	B(int id):A(id),b(id){}
public:
	int b;
};

int main()
{
	B s(1);
	
	s.GetA();

	return 0;
}
