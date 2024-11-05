.globl node_creation

.section .text
.align 2

node_creation:
    addi sp, sp, -4
    sw ra, 0(sp)    #salva o ra na stack
    addi sp, sp, -32 #aloca espaço na pilha
    mv a0, sp       #coloca o sp no a0
    li t0, 30       #carrega o valor 30
    sw t0, 0(sp)    #coloca o 30 na stack
    li t0, 25       #carrega o 25
    sw t0, 4(sp)    #coloca o 25 na stack
    li t0, 64       #carrega o 64
    sw t0, 5(sp)    #coloca o 64 na stack
    li t0, -12      #carrega o -12
    sw t0, 6(sp)    #coloca o -12 na stack
    jal mystery_function
    addi sp, sp, 32
    lw ra, 0(sp)    #recupera o ra
    addi sp, sp, 4
    ret

