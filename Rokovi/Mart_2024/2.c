#include <stdio.h>

extern int BoyOrGirl(char s[]);

int main(){
    char s[100];
    scanf("%s", s);
    int x = BoyOrGirl(s);
    //printf("%s\n", s); //debug
    printf("%d\n",x);
    return 0;
}