/*************************************************************************
	> File Name: attribute.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Fri 24 Jun 2016 04:42:32 PM CST
 ************************************************************************/
#include <iostream>

void breforemain() __attribute__((constructor));
void aftermain() __attribute__((destructor));
class AAA{
	public:
		      AAA(){std::cout << "before main function AAA" << std::endl;}
			        ~AAA(){std::cout << "after main function AAA" << std::endl;}
};
AAA aaa;
void breforemain()
{
	    std::cout << "before main function" << std::endl;
}

void aftermain()
{
	    std::cout << "after main function" << std::endl;
}

int main(int argc,char** argv)
{
	    std::cout << "in main function" << std::endl;
		    return 0;
}
