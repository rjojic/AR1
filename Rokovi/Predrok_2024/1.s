.intel_syntax noprefix

#extern float expMax (float x, int n);
#                      xmm0      rdi

.global expMac

expMac:
    enter 0,0
    push r8
    
    shufps xmm0, xmm0, 0b00000000   #xmm0 x x x x 
    movups xmm1, xmm0               #xmm1 x x x x
    mulss xmm1, xmm0                #xmm1 x x x x2
    shufps xmm1, xmm1, 0b01000100   #xmm1 x x2 x x2
    mulss xmm1, xmm0                #xmm1 x x2 x x3
    shufps xmm1, xmm1, 0b11100000   #xmm1 x x2 x3 x3
    mulss xmm1, xmm0                #xmm1 x x2 x3 x4
    
    mov r8, 1
    cvtsi2ss xmm2, r8               #xmm2 _ _ _ 1
    shufps xmm2, xmm2, 0b00000000   #xmm2 1 1 1 1
    mov r8, 2
    cvtsi2ss xmm2, r8               #xmm2 1 1 1 2
    shufps xmm2, xmm2, 0b01000100   #xmm2 1 2 1 2
    mov r8, 6
    cvtsi2ss xmm2, r8               #xmm2 1 2 1 6
    shufps xmm2, xmm2, 0b11100000   #xmm2 1 2 6 6
    mov r8, 24
    cvtsi2ss xmm2, r8               #xmm2 1 2 6 24

    mov r8, 1
    cvtsi2ss xmm3, r8              #xmm3 _ _ _ 1
    shufps xmm3, xmm3, 0b00000000  #xmm3 1 1 1 1
    mov r8, 2
    cvtsi2ss xmm3, r8              #xmm3 1 1 1 2
    shufps xmm3, xmm3, 0b01000100  #xmm3 1 2 1 2
    mov r8, 3
    cvtsi2ss xmm3, r8              #xmm3 1 2 1 3
    shufps xmm3, xmm3, 0b11100000  #xmm3 1 2 3 3
    mov r8, 4
    cvtsi2ss xmm3, r8              #xmm3 1 2 3 4

    movups xmm4, xmm0              #xmm4 x x x x 
    mulps xmm4, xmm4               #xmm4 x2 x2 x2 x2
    mulps xmm4, xmm4               #xmm4 x4 x4 x4 x4

    xorps xmm0, xmm0               #xmm0 0 0 0 0

    mov r8, 1
    cvtsi2ss xmm6, r8             #xmm6 _ _ _ 1
    shufps xmm6, xmm6, 0b00000000 #xmm6 1 1 1 1
start:
    cmp rdi, 0
    jle kraj

    movups xmm5, xmm1 #u xmm5 racunamo naredna cetiri clana
    divps xmm5, xmm2
    addps xmm0, xmm5  #sabiramo naredna cetiri clana, vrednosti cuvamo u xmm0

    #spremamo xmm1 i xmm2 za sledecu iteraciju
    mulps xmm1, xmm4 #mnozimo sve clanove iz xmm1 sa x4

    addps xmm3, xmm6
    mulps xmm2, xmm3 #1
    addps xmm3, xmm6
    mulps xmm2, xmm3 #2
    addps xmm3, xmm6
    mulps xmm2, xmm3 #3
    addps xmm3, xmm6
    mulps xmm2, xmm3 #4

    sub rdi, 4
    jmp start

kraj:
    movhlps xmm1, xmm0
    addps xmm0, xmm1
    movups xmm1, xmm0
    shufps xmm1, xmm1, 0b01010101
    addss xmm0, xmm1
    mov r8, 1
    cvtsi2ss xmm1, r8
    addss xmm0, xmm1

    pop r8
    leave
    ret