/*************************************************************************
	> File Name: socket.cpp
	> Author: yangjx
	> Mail: yangjx@126.com 
	> Created Time: Tue 22 Mar 2016 02:55:54 PM CST
 ************************************************************************/

//1.结构

struct sockaddr
{
	unsigned short sa_family; //地址类型 AF_XXX, AF_INET 为TCP
	char sa_data[14];	//14字节协议地址
};

struct sockaddr_in
{
	unsigned short sin_family;	//地址类型
	unsigned short int sin_port; //端口号
	struct in_addr sin_addr;	//IP地址
	unsigned sin_zero[8];	//填充地址,一般赋值为0
};

struct in_addr
{
	unsigned long s_addr;
}

//2.创建socket
#include <sys/types.h>
#include <sys/socket.h>

int socket(int domain, int type, int protocol);
/*
 * 参数说明:
 *	>	Domain用来指定创建套接字所使用的协议族:
 *	>   AF_UNIX : 创建只在本机进行通信的套接字
 *	>	AF_INET : 使用IPV4 TCP/IP协议
 *	>	AF_INET6 : 使用IPV6 TCP/IP协议
 *
 *	>   Type指定套接字的类型:
 *	>	SOCK_STREAM : 创建TCP流套接字
 *	>	SOCK_DGRAM : 创建UDP数据包套接字
 *	>	SOCK_RAW : 创建原始套接字
 *
 *	创建TCPSOCKET : int sock_fd = socket(AF_INET, SOCK_STREAM, 0);
 *	创建UDPSOCKET ： int socket_fd = socket(AF_INET, SOCK_DGRAM, 0);
 *
 * */

//3.建立连接
#include<sys/types.h>
#include<sys/socket.h>
int connect(int sockfd, struct sockaddr * serv_addr, socklen_t addrlen);

//4.绑定socket
#include<sys/types.h>
#include<sys/socket.h>
int bind(int sockfd, struct sockaddr * my_addr, socklen_t addrlen);

//5.在套接字上监听
#include <sys/socket.h>
int listen(int s, int backlog);

//6.接受连接
#include <sys/types.h>
#include <sys/socket.h>
int accept(int s, struct sockaddr *addr, socklen_t *addrlen);

//7.TCP套接字的数据传输
#include <sys/types.h>
#include <sys/socket.h>
ssize_t send(int s, const void *msg, size_t len, int flags);
ssize_t recv(int s, void *buf, size_t len, int flags);

//8. UDP套接字的数据传输
  #include <sys/types.h>
  #include <sys/socket.h>
  ssize_t sendto(int s,const void *msg,size_t len,int flags,const struct sockaddr *to,socken_t len); //发送数据
	  ssize_t recvfrom(int s,const void *buf,size_t len,int flags,const struct sockaddr *from,socken_t fromlen); //接收数据

//9. 关闭套接字
#include <unistd.h>
	  int close(int fd);

#include <sys/socket.h>
int shutdown(int s, int how);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//主要系统调用函数

//1 大小端模式转换
#include <netinet/in.h>
uint32_t htonl(uint32_t hostlong); //host to network long
unit16_t htons(unit16_t hostshort);//htons to network short
uint32_t ntohl(uint32_t netlong);
uint16_t ntohs(uint16_t netshort);

//2) inet函数

Int inet_aton(const char *cp,struct in_addr *inp)；//将字符串IP地址转化成网络字节顺序的二进制形式
char* inet_ntoa(struct in_addr in);//跟上面相反
//还有 inet_addr ,inet_network,inet_lnaof,inet_imakeaddr,inet_netof;
//查看man inet
//

//11 获取和设置套接字属性

#include <sys/types.h>
#include <sys/socket.h>
Int getsockopt(int s,int level,int optname.void *optval,socklen_t *optlen);
Int setsockopt(int s,int level,int optname,const void *optval,socklen_t optlen);

//12 多路复用select
  #include <sys/select.h>
  #include <sys/time.h>
  #include <sys/types.h>
  #include <unistd.h>

  Int select(int n,fd_set *readfds, fd_set *writefds, fd_set *exceptfds,struct timeval *timeout);
