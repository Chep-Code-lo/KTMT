#include <stdio.h>
#include <string.h>
extern void mem_display();
extern void mem_copy();
int main()
{
    char *cStr = "String is C language";
    int size = strlen(cStr);
    mem_display(cStr, size);
    char c[size];
    mem_copy(cStr,c , size);
    mem_display(c , size);
    return 0;
}