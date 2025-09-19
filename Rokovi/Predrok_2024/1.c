#include <stdio.h>


extern float expMac (float x, int n);

int main(){
    float x;
    int n;
    scanf("%f%d", &x, &n);
    printf("%f\n", expMac(x, n));

    return 0;
}