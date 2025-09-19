#include <stdio.h>
#include <stdlib.h>

extern void prefiks(float *a, int n, float *b);

int main(){
    float *a;
    float *b;
    int n;
    scanf("%d", &n);
    a = (float*) malloc(n*sizeof(float));
    b = (float*) malloc(n*sizeof(float));

    if(a == NULL || b == NULL){
        printf("Greska pri alokaciji memorije\n");
        return 1;
    }

    for(int i = 0; i < n; i++){
        scanf("%f", &a[i]);
    }

    prefiks(a, n, b);

    for(int i = 0; i < n; i++){
        printf("%f ", b[i]);
    }

    printf("\n");

    return 0;
}