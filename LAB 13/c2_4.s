.globl node_op               

.section .text
.align 2

#a0 --> endereço de um node
node_op:
    lw t0, 0(a0)    #carrega o int em t0
    addi a0, a0, 4  #pula o int
    lb t1, 0(a0)    #carrega o primeiro char
    addi a0, a0, 1  #pula o byte
    lb t2, 0(a0)    #carrega o segundo char
    addi a0, a0, 1  #pula o byte
    lh t3, 0(a0)    #carrega o short
    add a0, t0, t1  
    sub a0, a0, t2
    add a0, a0, t3
    ret 






