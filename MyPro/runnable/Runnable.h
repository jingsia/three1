#ifndef RUNNABLE_H_
#define RUNNABLE_H_

class Runnable
{
public:
	Rubbable();
	virtual ~Runnable();

	virtual void Run() = 0;
};

#endif
