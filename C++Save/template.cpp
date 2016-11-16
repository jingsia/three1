/*************************************************************************
	> File Name: template.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Mon 07 Nov 2016 02:07:58 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;

class A
{
	public:
		int GetA() { return _a;}
		void SetA(int a) { _a = a;}

	private:
		int _a;
};

template<class T>
class AT:
	public A
{
	protected:
		virtual A* newA() { return new(std::nowthrow) A();}
};

template<class T, class SL = AT<T>>
class ATSL
{
	public:
		AT* newWorker() { return new SL(); }
};

