.intel_syntax noprefix

.text

#extern void prefiks(float *a, int n, float *b);
#                      rdi       rsi     rdx


.global prefiks

prefiks:
    enter 0,0
    push r8
    xorps xmm0, xmm0 #u xmm0 smestamo 0
po_cetri:
    cmp rsi, 4
    jl po_jedan
    movups xmm1, [rdi]
    addss xmm1, xmm0               #xmm1    d      c    b     a 
    #zelimo                         xmm1 d+c+b+a c+b+a b+a    a
    movups xmm2, xmm1              #xmm2    d     c     b     a
    shufps xmm2, xmm2, 0b00000000  #xmm2    a     a     a     a 
    movups xmm3, xmm1              #xmm3    d     c     b     a
    shufps xmm3, xmm3, 0b11100101  #xmm3    d     c     b     b
    addss xmm2, xmm3               #xmm2    a     a     a    a+b
    shufps xmm2, xmm2, 0b01000100  #xmm2    a    a+b    a    a+b
    shufps xmm3, xmm3, 0b11100110  #xmm3    d     c     a     c
    addss xmm2, xmm3               #xmm2    a    a+b    a   a+b+c 
    shufps xmm2, xmm2, 0b00100100  #xmm2   a+b+c a+b    a   a+b+c 
    mov r8, 0
    cvtsi2ss xmm2, r8              #xmm2  a+b+c  a+b    a     0
    addps xmm1, xmm2               #xmm1  d+c+b+a c+b+a b+a   a

    movups [rdx], xmm1            #upisujemo xmm1 na rdx
    movups xmm2, xmm1              #xmm2  d+c+b+a c+ba  b+a   a 
    shufps xmm2, xmm2, 0b11111111  #xmm2  d+c+b+a d+c+b+a d+c+b+a d+c+b+a 
    movss xmm0, xmm2               #spremamo se za narednu masku

    add rdi, 16
    add rdx, 16
    sub rsi, 4
    jmp po_cetri

po_jedan:
    cmp rsi, 0
    je kraj
    movss xmm1, [rdi]
    addss xmm1, xmm0
    movss xmm0, xmm1
    movss [rdx], xmm1

    add rdi, 4
    add rdx, 4
    sub rsi, 1
    jmp po_jedan

kraj:
    pop r8
    leave
    ret