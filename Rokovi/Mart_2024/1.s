.intel_syntax noprefix

.text

#extern int binomniKoeficijent(int n, int k);
#                                rdi    rsi

.global binomniKoeficijent

binomniKoeficijent:
    enter 0,0

    push r8
    mov r8, 1
    cvtsi2ss xmm0, r8
    shufps xmm0, xmm0, 0b00000000 #xmm0  1 1 1 1
    cvtsi2ss xmm3, r8
    shufps xmm3, xmm3, 0b00000000 #xmm3  1 1 1 1
    cmp rsi, 4
    jl ubaci_jedan
    #inace ubacujemo 4
    mov r8, rdi
    cvtsi2ss xmm1, r8             #xmm1 _ _ _ n
    shufps xmm1, xmm1, 0b00000000 #xmm1 n n n n 
    sub r8, 1
    cvtsi2ss xmm1, r8             #xmm1 n n n n-1
    shufps xmm1, xmm1, 0b01000100 #xmm1 n n-1 n n-1
    sub r8, 1
    cvtsi2ss xmm1, r8             #xmm1 n n-1 n n-2
    shufps xmm1, xmm1, 0b11100000 #xmm1 n n-1 n-2 n-2
    sub r8, 1
    cvtsi2ss xmm1, r8             #xmm1 n n-1 n-2 n-3 ovo zelimo

    mov r8, rsi
    cvtsi2ss xmm2, r8             #xmm2 _ _ _ k 
    shufps xmm2, xmm2, 0b00000000 #xmm2 k k k k 
    sub r8, 1
    cvtsi2ss xmm2, r8             #xmm2 k k k k-1
    shufps xmm2, xmm2, 0b01000100 #xmm2 k k-1 k k-1
    sub r8, 1
    cvtsi2ss xmm2, r8             #xmm2 k k-1 k k-2
    shufps xmm2, xmm2, 0b11100000 #xmm2 k k-1 k-2 k-2
    sub r8, 1
    cvtsi2ss xmm2, r8             #xmm2 k k-1 k-2 k-3 ovo zelimo
    sub rsi, 4
    
    mulps xmm0, xmm1
    divps xmm0, xmm2
    jmp start
ubaci_jedan:
    mov r8, rdi
    cvtsi2ss xmm1, r8
    mov r8, rsi
    cvtsi2ss xmm2, r8
    sub rsi, 1
    mulss xmm0, xmm1
    divss xmm0, xmm2

start:
    cmp rsi, 4
    jl po_jedan
    subps xmm1, xmm3
    subps xmm2, xmm3
    sub rsi, 4
    mulps xmm0, xmm1
    divps xmm0, xmm2
    jmp start

po_jedan:
    cmp rsi, 0
    je kraj
    subss xmm1, xmm3
    subss xmm2, xmm3
    sub rsi, 1
    mulss xmm0, xmm1
    divss xmm0, xmm2
    jmp po_jedan

kraj:
    movhlps xmm1, xmm0
    mulps xmm0, xmm1
    movups xmm1, xmm0
    shufps xmm1, xmm1, 0b01010101
    mulss xmm0, xmm1
    cvtss2si rax, xmm0

    pop r8
    leave