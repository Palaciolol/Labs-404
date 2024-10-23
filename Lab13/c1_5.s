.globl operation              

.section .text
.align 2


#a0 --> int a
#a1 --> int b
#a2 --> short c
#a3 --> short d
#a4 --> char e 
#a5 --> char f
#a6 --> int g
#a7 --> int h
#0(sp) --> char i 
#4(sp) --> char j
#8(sp) --> short k
#12(sp) --> short l
#16(sp) --> int m
#20(sp) --> int n
operation:
    lw t0, 20(sp)   #carrega o n
    lw t1, 16(sp)   #carrega o m   
    lw t2, 12(sp)   #carrega o l
    lw t3, 8(sp)    #carrega o k
    lw t4, 4(sp)    #carrega o j
    lw t5, 0(sp)    #carrega o i

    addi sp, sp, -36
    sw a0, 0(sp)    #coloca o a0 na pilha
    sw a1, 4(sp)    #coloca o a1 na pilha
    sw a2, 8(sp)    #coloca o a2 na pilha
    sw a3, 12(sp)   #coloca o a3 na pilha
    sw a4, 16(sp)   #coloca o a4 na pilha
    sw a5, 20(sp)   #coloca o a5 na pilha
    sw a6, 24(sp)   #coloca o a6 na pilha
    sw a7, 28(sp)   #coloca o a7 na pilha
    sw ra, 32(sp)   #salva o ra na pilha

    mv a0, t0       #coloca o valor de n em a0
    mv a1, t1       #coloca o valor de m em a1
    mv a2, t2       #coloca o valor de l em a2
    mv a3, t3       #coloca o valor de k em a3
    mv a4, t4       #coloca o valor de j em a4
    mv a5, t5       #coloca o valor de i em a5
    lw a6, 28(sp)   #coloca o valor de h em a6   
    lw a7, 24(sp)   #coloca o valor de g em a7

    lw t0, 20(sp)   #carrega o f da pilha
    lw t1, 16(sp)   #carrega o e da pilha
    lw t2, 12(sp)   #carrega o d da pilha
    lw t3, 8(sp)    #carrega o c da pilha
    lw t4, 4(sp)    #carrega o b da pilha
    lw t5, 0(sp)    #carrega o a da pilha
            
    addi sp, sp, 36
    sw t0, 0(sp)    #coloca o f na pilha
    sw t1, 4(sp)    #coloca o e na pilha
    sw t2, 8(sp)    #coloca o d na pilha
    sw t3, 12(sp)   #coloca o c na pilha
    sw t4, 16(sp)   #coloca o b na pilha
    sw t5, 20(sp)   #coloca o a na pilha

    jal mystery_function
    addi sp, sp, -4
    lw ra, 0(sp)
    addi sp, sp, 4
    ret

