#include <stdio.h>


extern void zameniJava(char s[], char t[]);

int main() {
    char s[100];
    char t[100];
    scanf("%s", s);
    zameniJava(s, t);
    printf("%s\n", t);

    return 0;
}