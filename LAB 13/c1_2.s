.globl my_function

.section .text
.align 2

#a0 --> first value
#a1 --> second value 
#a2 --> third value
my_function:
    addi sp, sp, -16
    sw ra, 0(sp)        #salva o ra na pilha
    sw a0, 4(sp)        #salva o a0 na pilha
    sw a1, 8(sp)        #salva o a1 na pilha
    sw a2, 12(sp)       #salva o a2 na pilha
    add a0, a0, a1      #calcula a soma dos dois primeiros números
    lw a1, 4(sp)        #carrega o valor inicial de a0 da pilha e coloca em a1
    jal mystery_function#chama a mystery
    lw a1, 8(sp)        #carrega o valor de a1 da pilha
    sub a0, a1, a0      #a0 = a1 - a0(retorno da mystery)
    add a0, a0, a2      #não mudei a2 até agr, então aux tá calculado em a0
    sw a0, 4(sp)        #salva o aux na pilha n lugar do a0
    lw a1, 8(sp)        #carrega o a1 da pilha
    jal mystery_function#chama a mystery
    sub a0, a2, a0      #a0 = a2 - a0
    lw t0, 4(sp)        #carrega o valor de aux da pilha
    add a0, a0 , t0     #a0 = a0 + t0
    lw ra, 0(sp)        #pega o ra da pilha
    addi sp, sp, 16     #incrementa a pilha
    ret


