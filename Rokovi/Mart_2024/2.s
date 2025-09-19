.text

@extern int BoyOrGirl(char s[]);
@                        r0

.global BoyOrGirl

BoyOrGirl:
    stmfd sp!, {fp, lr}
    mov fp, sp

    stmfd sp!, {r4-r6}
    mov r6, r0  @cuvamo adresu sa r0

start:
    ldrb r1, [r0]  @ucitavamo prvi element
    cmp r1, #0
    beq kraj

    add r2, r0, #1
provera:
    ldrb r3, [r2] @ucitavamo sledeci element
    cmp r3, #0
    beq priprema
    cmp r3, r1
    beq izbaci_el
    add r2, r2, #1
    b provera
izbaci_el:
    add r4, r2, #1
izbaci_petlja:
    ldrb r5, [r4], #1
    strb r5, [r2], #1  @ucitavamo levi element na poziciju desno, i siftujemo se za mesto u levo
    cmp r5, #0
    beq start
    b izbaci_petlja

priprema:
    add r0, r0, #1   @pomeramo r0 za mesto desno
    b start

kraj:
    @ostalo je jos videti da li nova niska ima paran broj elemenata

    mov r0, #0
prebrojavanje:
    ldrb r1, [r6], #1
    cmp r1, #0
    beq kraj_prebrojavanja
    cmp r0, #0
    bne upisi_0
    mov r0, #1
    b prebrojavanje
upisi_0:
    mov r0, #0
    b prebrojavanje

kraj_prebrojavanja:
    
    ldmfd sp!, {r4-r6}

    mov sp, fp
    ldmfd sp!, {fp, pc}