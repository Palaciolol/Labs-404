.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 400  #número a ser lido

.section .text
.align 2


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


#a0 --> ponteiro pro primeiro int
#a1 --> ponteiro pro segundo int
swap_int:



#a0 --> ponteiro pro primeiro short
#a1 --> ponteiro pro segundo short
swap_short:


#a0 --> ponteiro pro primeiro char
#a1 --> ponteiro pro segundo char
swap_char:


_start:
    jal swap_int
    jal exit
