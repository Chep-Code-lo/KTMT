#include <stdio.h>
void func(int x, int y)
{
    x = x + y;
    printf("%d\n",x);
}
int main()
{
    int a=5;
    int b=7;
    func(a,b);
    printf("Hello\n");
    return 0;
}
