.text
.align 2

@extern void zameniRimske(char s[], char t[]);
@                            r0       r1

.global zameniRimske

zameniRimske:
    stmfd sp!, {fp, lr}
    mov fp, sp

    @u r2 cuvamo trenutnu cifru

start:
    ldrb r2, [r0]
    cmp r2, #0
    beq kraj
    cmp r2, #'I'
    beq p_I 
    cmp r2, #'V'
    beq p_V 
    cmp r2, #'X'
    beq p_X
    b upisi

p_I:
    ldrb r2, [r0, #1]
    cmp r2, #'I'
    beq p_II
    cmp r2, #'V'
    beq p_IV
    cmp r2, #'X'
    beq p_IX
    b z_1

p_V:
    ldrb r2, [r0, #1]
    cmp r2, #'I'
    beq p_VI 
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_5

p_X:
    b z_10

p_II:
    ldrb r2, [r0, #2]
    cmp r2, #'I'
    beq p_III
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_2

p_IV:
    ldrb r2, [r0, #2]
    cmp r2, #'I'
    beq preskoci_z
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_4

p_IX:
    ldrb r2, [r0, #2]
    cmp r2, #'I'
    beq preskoci_z
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_9

p_VI:
    ldrb r2, [r0, #2]
    cmp r2, #'I'
    beq p_VII
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_6

p_III:
    ldrb r2, [r0, #3]
    cmp r2, #'I'
    beq preskoci_z
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_3

p_VII:
    ldrb r2, [r0, #3]
    cmp r2, #'I'
    beq p_VIII
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_7

p_VIII:
    ldrb r2, [r0, #4]
    cmp r2, #'I'
    beq preskoci_z
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b z_8

z_1:
    mov r2, #'1'
    strb r2, [r1], #1
    b preskoci
z_2:
    mov r2, #'2'
    strb r2, [r1], #1
    b preskoci
z_3:
    mov r2, #'3'
    strb r2, [r1], #1
    b preskoci
z_4:
    mov  r2, #'4'
    strb r2, [r1], #1
    b preskoci 
z_5:
    mov r2, #'5'
    strb r2, [r1], #1
    b preskoci
z_6:
    mov r2, #'6'
    strb r2, [r1], #1
    b preskoci
z_7:
    mov r2, #'7'
    strb r2, [r1], #1
    b preskoci
z_8:
    mov r2, #'8'
    strb r2, [r1], #1
    b preskoci
z_9:
    mov r2, #'9'
    strb r2, [r1], #1
    b preskoci
z_10:
    mov r2, #'1'
    strb r2, [r1], #1
    mov r2, #'0'
    strb r2, [r1], #1

preskoci:
    ldrb r2, [r0], #1
    cmp r2, #'I'
    beq preskoci
    cmp r2, #'V'
    beq preskoci
    cmp r2, #'X'
    beq preskoci
    b upisi
preskoci_z:
    ldrb r2, [r0], #1
    strb r2, [r1], #1
    cmp r2, #'I'
    beq preskoci_z
    cmp r2, #'V'
    beq preskoci_z
    cmp r2, #'X'
    beq preskoci_z
    b start


upisi:
    strb r2, [r1], #1
    add r0, r0, #1
    b start

kraj:
    strb r2, [r1] @upisujemo \0
    mov sp, fp

    ldmfd sp!, {fp, pc}