#include <stdio.h>
#include <stdlib.h>

extern void zameni(float **a, int n, int m);

int main(){
    int n, m;
    scanf("%d%d", &m, &n);
    float **a = NULL;
    a = (float**) malloc(m*sizeof(float*));
    if(a == NULL){
        printf("Err: a\n");
        return 1;
    }
    for(int i = 0; i < n; i++){
        a[i] = (float *) malloc(n*sizeof(float));
        if(a[i] == NULL){
            printf("Err: a[i]\n");
            return 1;
        }
    }
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            scanf("%f", &a[i][j]);
        }
    }
    zameni(a, n, m);

    printf("\n");
    for(int i = 0; i < m; i++){
        for(int j = 0; j < n; j++){
            printf("%f ", a[i][j]);
        }
        printf("\n");
    }
    return 0;
}