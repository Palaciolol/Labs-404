.globl operation              


.data
    ints:  .word 1, -2, 7, -8, 13, -14      
    shorts:  .half 3, -4, 11, -12     
    bytes:  .byte 5, -6, 9, -10
    
.section .text
.align 2

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

operation:
    addi sp, sp,-32 #aloca espaço na pilha
    sw ra, 24(sp)   #salva o ra na pilha
    la t0, ints     #endereço de ints   
    la t1, shorts   #endereço de shorts
    la t2, bytes    #endreço de bytes
    lw a0, 0(t0)    #carrega o a
    lw a1, 4(t0)    #carraga o b
    lh a2, 0(t1)    #carrega o c
    lh a3, 2(t1)    #carrega o d
    lb a4, 0(t2)    #carrega o e
    lb a5, 1(t2)    #carrega o f
    lw a6, 8(t0)    #carrega o g
    lw a7, 12(t0)   #carrega o h
    lb t3, 2(t2)    #carrega o i
    sw t3, 0(sp)    #coloca i na pilha
    lb t4, 3(t2)    #carrega o j
    sw t4, 4(sp)    #coloca j na pilha
    lh t5, 4(t1)    #carrega o k
    sw t5, 8(sp)    #coloca k na pilha
    lh t6, 6(t1)    #carrega o l
    sw t6, 12(sp)   #coloca l na pilha
    lw t3, 16(t0)   #carrega o m
    sw t3, 16(sp)   #coloca m na pilha
    lw t4, 20(t0)   #carrega o n
    sw t4, 20(sp)   #coloca n na pilha
    jal mystery_function
    lw ra, 24(sp)   #pega o ra
    addi sp, sp, 32 #desaloca a pilha
    ret

