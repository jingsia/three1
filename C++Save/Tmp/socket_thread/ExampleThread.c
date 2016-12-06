/*************************************************************************
	> File Name: ExampleThread.c
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 31 Mar 2016 06:24:32 AM CST
 ************************************************************************/

#include<stdio.h>
#include<pthread.h>
void thread(void)
{
	int i;
	for(i =0; i< 3;++i)
	{
		printf("this is a pthread.\n");
	}
}

int main(void)
{
	pthread_t id;
	int i, ret;

	ret=pthread_create(&id, NULL, (void*)thread, NULL);
	if(ret)
	{
		printf("create pthread error. \n");
		//exit(1);
	}

	for(i = 0; i < 3; ++i)
		printf("this is the main process.\n");
	pthread_join(id, NULL);
	return 0;
}
