.globl swap_int, swap_short, swap_char              


.section .text
.align 2


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


#a0 --> ponteiro pro primeiro int
#a1 --> ponteiro pro segundo int
swap_int:
    lw t1, 0(a0)    #carrega o valor do primeiro int
    lw t2, 0(a1)    #carrega o valor do segundo int
    sw t2, 0(a0)    #coloca o segundo int no endereço do primeiro  
    sw t1, 0(a1)    #coloca o primeiro int no endereço do segundo
    mv a0, zero
    ret


#a0 --> ponteiro pro primeiro short
#a1 --> ponteiro pro segundo short
swap_short:
    lh t1, 0(a0)    #carrega o valor do primeiro int
    lh t2, 0(a1)    #carrega o valor do segundo int
    sh t2, 0(a0)    #coloca o segundo int no endereço do primeiro  
    sh t1, 0(a1)    #coloca o primeiro int no endereço do segundo
    mv a0, zero
    ret


#a0 --> ponteiro pro primeiro char
#a1 --> ponteiro pro segundo char
swap_char:
    lb t1, 0(a0)    #carrega o valor do primeiro int
    lb t2, 0(a1)    #carrega o valor do segundo int
    sb t2, 0(a0)    #coloca o segundo int no endereço do primeiro  
    sb t1, 0(a1)    #coloca o primeiro int no endereço do segundo
    mv a0, zero
    ret
