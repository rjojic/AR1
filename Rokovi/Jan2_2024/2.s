.text
.align 2
@extern void zameniJava(char s[], char t[]);
@                          r0        r1

@ J a v a d a lj e
@ 0 1 2 3 

.global zameniJava

zameniJava:
    stmfd sp!, {fp, lr}
    mov fp, sp

start:
    @u r2 upisujemo sledeci element
    ldrb r2, [r0]
    cmp r2, #'J'
    bne nastavi
    ldrb r3, [r0, #1]
    cmp r3, #'a'
    bne nastavi
    ldrb r3, [r0, #2]
    cmp r3, #'v'
    bne nastavi
    ldrb r3, [r0, #3]
    cmp r3, #'a'
    bne nastavi

    mov r2, #'C'
    add r0, r0, #3
nastavi:
    strb r2, [r1], #1
    cmp r2, #0
    beq kraj
    add r0, r0, #1
    b start

kraj:
    mov sp, fp
    ldmfd sp!, {fp, pc}