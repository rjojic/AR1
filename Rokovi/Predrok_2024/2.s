.text
.align 2
@extern void ObrisiParne(char s[], char t[]);
@                          r0         r1



.global ObrisiParne

ObrisiParne:
    stmfd sp!, {fp, lr}
    mov fp, sp

    @koristimo i moramo cuvati vrednosti za r4-r6
    stmfd sp!, {r4-r6}
    @u r2 cemo ucitavati sledeci char

start:
    ldrb r2, [r0], #1
    strb r2, [r1], #1 @svaki element koji ucitamo u r2, automatski upisujemo u r1 
    cmp r2, #0
    beq kraj

    mov r3, r0  @u r3 prepisujemo adresu iz r0
trazenje_prvog_duplikata:
    ldrb r4, [r3]
    cmp r4, #0
    beq start
    cmp r4, r2
    beq izbaci
    add r3, r3, #1 @spremamo da ucitamo naredni element
    b trazenje_prvog_duplikata
izbaci:
    add r5, r3, #1
petlja:
    ldrb r6, [r5]
    strb r6, [r3] @ucitavamo element iz r5 i upisujemo u r3
    cmp r6, #0
    beq start
    add r5, r5, #1
    add r3, r3, #1
    b petlja

kraj:
    ldmfd sp!, {r4-r6}
    mov sp, fp

    ldmfd sp!, {fp, pc}
