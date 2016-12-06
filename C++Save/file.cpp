/*************************************************************************
	> File Name: aaa.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Wed 02 Nov 2016 09:54:13 AM CST
 ************************************************************************/

#include<iostream>
#include<stdio.h>
using namespace std;

int main()
{
	printf("%d\n", 111);

	/*
	FILE* FSPOINTER;
	FSPOINTER = fopen("HELLOA.TXT", "wb");
	fprintf(FSPOINTER, "%d\n", 123456);
	fclose(FSPOINTER);

	FILE* fp;
	fp = fopen("HELLOA.TXT", "a");
	fprintf(fp, "%d\n", 123456);
	fclose(fp);
*/
	FILE* fp;
	fp = fopen("HELLOA.TXT", "a");
	fprintf(fp, "%d\n", 12345678);
	fclose(fp);

	printf("ssss,%d\n", 567);
	return 0;
}
