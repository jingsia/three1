/*************************************************************************
	> File Name: thread.c
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Thu 31 Mar 2016 06:32:11 AM CST
 ************************************************************************/

#include<stdio.h>
#include<pthread.h>

/*线程1*/
void thread_1(void)
{
	int i = 0;
	for(i = 0; i <= 6; ++i)
	{
		printf("this is a pthread_1.\n");
		if(i == 2)
			pthread_exit(0);
		sleep(1);
	}
}

/*线程2*/
void thread_2(void)
{
	int i = 0;
	for(i = 0; i < 3; ++i)
	{
		printf("this is a pthread_2.\n");
	}
	pthread_exit(0);
}

int main(void)
{
	pthread_t id_1, id_2;
	int i, ret;

	/*创建线程1*/
	ret = pthread_create(&id_1, NULL, (void *) thread_1, NULL);
	if(ret != 0)
	{
		printf("create pthread error! \n");
		return -1;
	}

	/*创建线程2*/
	ret = pthread_create(&id_2, NULL, (void *) thread_2, NULL);
	if(ret != 0)
	{
		printf("create pthread error! \n");
		return -1;
	}

	/*等待线程结束*/
	/*
	 * 代码中如果没有pthread_join主线程会很快结束从而使整个进程结束，从而使创建的线程没有机会开始执行就结束了。加入pthread_join后，主线程会一直等待直到等待的线程结束自己才结束，使创建的线程有机会执行。
	 * */
	pthread_join(id_1, NULL);
	pthread_join(id_2, NULL);

	return 0;
}

/* >主线程 
 * 当一个程序启动时，就有一个进程被操作系统（OS）创建，与此同时一个线程也立刻运行，该线程通常叫做程序的主线程（Main Thread），因为它是程序开始时就执行的，如果你需要再创建线程，那么创建的线程就是这个主线程的子线程。每个进程至少都有一个主线程，在Winform中，应该就是创建GUI的线程。    主线程的重要性体现在两方面：1.是产生其他子线程的线程；2.通常它必须最后完成执行比如执行各种关闭动作。
 * */

/*
 *一个线程不能被多个线程等待，否则第一个接收到信号的线程成功返回，其余调用pthread_join的线程则返回错误代码ESRCH。
 * */
