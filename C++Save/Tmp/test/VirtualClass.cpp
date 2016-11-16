/*************************************************************************
	> File Name: VirtualClass.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Sun 13 Mar 2016 12:47:37 AM CST
 ************************************************************************/

#include<iostream>
using namespace std;

/**************************************************
	> example 1
 **************************************************/

#if 0
class ClxBase{
public:
	ClxBase() { cout << "1" << endl;};
	~ClxBase() { std::cout << "FROM NO VIRTUAL 1 CLXBASE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXBASE" << std::endl; }

};

class ClxDerived : public ClxBase{
public:
	ClxDerived() {cout << "2" << endl;};
	~ClxDerived() { std::cout << "FROM NO VIRTUAL 1 CLXDE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXDE" << std::endl; }

};

int main()
{
	ClxDerived *p = new ClxDerived;
	p->DoSomething();
	delete p;

	return 0;
}

#endif

#if 0
/**************************************************
	> example 2
 **************************************************/

class ClxBase{
public:
	ClxBase() {};
	~ClxBase() { std::cout << "FROM NO VIRTUAL 1 CLXBASE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXBASE" << std::endl; }

};

class ClxDerived : public ClxBase{
public:
	ClxDerived() {};
	~ClxDerived() { std::cout << "FROM NO VIRTUAL 1 CLXDE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXDE" << std::endl; }

};

int main()
{
	ClxBase *p = new ClxDerived;
	p->DoSomething();
	delete p;

	return 0;
}
#endif

#if 1
/**************************************************
	> example 3
 **************************************************/

class ClxBase{
public:
	ClxBase() {};
	virtual ~ClxBase() { std::cout << "FROM NO VIRTUAL 1 CLXBASE" << std::endl;}

	virtual void DoSomething() { std::cout << "Do something class CLXBASE" << std::endl; }

};

class ClxDerived : public ClxBase{
public:
	ClxDerived() {};
	~ClxDerived() { std::cout << "FROM NO VIRTUAL 1 CLXDE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXDE" << std::endl; }

};

int main()
{
	ClxBase *p = new ClxDerived;
	p->DoSomething();
	delete p;

	return 0;
}
#endif

#if 0
/**************************************************
	> example 4
 **************************************************/

class ClxBase{
public:
	ClxBase() {};
	virtual ~ClxBase() { std::cout << "FROM NO VIRTUAL 1 CLXBASE" << std::endl;}

	virtual void DoSomething() { std::cout << "Do something class CLXBASE" << std::endl; }

};

class ClxDerived : public ClxBase{
public:
	ClxDerived() {};
	~ClxDerived() { std::cout << "FROM NO VIRTUAL 1 CLXDE" << std::endl;}

	void DoSomething() { std::cout << "Do something class CLXDE" << std::endl; }

};

int main()
{
	ClxDerived *p = new ClxDerived;
	p->DoSomething();
	delete p;

	return 0;
}

#endif

/*******************************************
	> no virtual
		> base duixiang
		> no base duixiang

	> virtual
 *******************************************/
















