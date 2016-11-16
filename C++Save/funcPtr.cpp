#include <stdio.h>
int max(int x, int y) { return x + y;}

class A
{
public:
	int GetA() { return _a;}
	template<typename hdrType, typename dataType>
	void SetA(hdrType (*ptr)(hdrType, dataType)) { ptr = max; _a = (*ptr)(10, 20);}

private:
	int _a;
};

int main()
{
	int (*ptr)(int, int);
	int a = 10;
	int b = 20;

	int c;
	ptr = max;
	c = (*ptr)(a, b);
	printf("%d\n", c);

	A as;
	as.SetA<int, int>(ptr);
	printf("%d\n", as.GetA());
	return 0;
}
