.intel_syntax noprefix

#extern void zameni(float **a, int n, int m);
#                      rdi       rsi    rdx

.global zameni

zameni:
    enter 0,0
    push r8 #gornji spoljni brojac [i]
    #rdx donji spoljni brojac [i]
    push r9 #unutrasnji brojac [j]
    push r10 #pocetak gornje vrste
    push r11 #pocetak donje vrste
    xor r8, r8
    sub rdx, 1

prva_petlja:
    cmp r8, rdx
    jge kraj
    mov r10, [rdi + 8*r8]
    mov r11, [rdi + 8*rdx]
    #krece zamena
    mov r9, rsi
po_cetri:
    cmp r9, 4
    jl po_jedan
    movups xmm0, [r10]
    movups xmm1, [r11]

    movups [r10], xmm1
    movups [r11], xmm0

    add r10, 16
    add r11, 16
    sub r9, 4
    jmp po_cetri
po_jedan:
    cmp r9, 0
    je kraj_zamene
    movss xmm0, [r10]
    movss xmm1, [r11]

    movss [r10], xmm1
    movss [r11], xmm0
    add r10, 4
    add r11, 4
    sub r9, 1
    jmp po_jedan
kraj_zamene:
    add r8, 1
    sub rdx, 1
    jmp prva_petlja

kraj:
    pop r11
    pop r10
    pop r9
    pop r8

    leave
    ret