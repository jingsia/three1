/*************************************************************************
	> File Name: Stack.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 17 May 2016 04:00:33 PM CST
 ************************************************************************/

#include<iostream>
using namespace std;
#include<vector>

template<typename T>
class Stack
{
public:
	void Push(const T& a);
	void Pop();
	T Top() const;
	bool Empty() { return _a.empty(); }
private:
	std::vector<T> _a;
}
