#include <stdio.h>

extern int binomniKoeficijent(int n, int k);

int main(){
    int n, k;
    scanf("%d%d", &n, &k);
    printf("%d\n", binomniKoeficijent(n,k));

    return 0;
}