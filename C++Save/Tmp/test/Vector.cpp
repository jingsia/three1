/*************************************************************************
	> File Name: Vector.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 15 Mar 2016 07:02:01 AM CST
 ************************************************************************/

#include<iostream>
#include<vector>

using namespace std;

struct Record
{
	int _a;
	int _b;
	Record(int s, int x):_a(s),_b(x){}
	Record():_a(0),_b(0){}
};

typedef std::vector<Record *> VRe;

void A(VRe& a)
{
	for(VRe::iterator it = a.begin(), e = a.end(); it != e; ++it)
	{
		Record * s = *it;
		s->_a = 10;
	}
}


int main()
{
	Record m(1, 2);
	VRe m_m;
	m_m.push_back(&m);
	A(m_m);

	std::cout << m_m[0]->_a << std::endl;

	return 0;
}
