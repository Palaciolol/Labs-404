.globl node_creation

.section .text
.align 2

node_creation:
    addi sp, sp, -4
    sw ra, 0(sp)    #salva o ra na stack
    mv t0, sp       #coloca o sp no t0
    addi sp, sp, -112   #aloca espaço na pilha
    mv a0, sp       #coloca o sp no a0
    li t1, 30       #carrega o valor 30
    sw t1, 0(sp)    #coloca o 30 na stack
    li t1, 25       #carrega o 25
    addi sp, sp, 4  #incrementa a stack
    sw t1, 0(sp)    #coloca o 25 na stack
    li t1, 64       #carrega o 64
    addi sp, sp, 1  #incrementa a stack
    sw t1, 0(sp)    #coloca o 64 na stack
    li t1, -12      #carrega o -12
    addi sp, sp ,1  #incrementa  a stack
    sw t1, 0(sp)    #coloca o -12 na stack
    jal mystery_function
    mv sp, t0       #recupera o sp
    lw ra, 0(sp)    #recupera o ra
    addi sp, sp, 4
    ret

