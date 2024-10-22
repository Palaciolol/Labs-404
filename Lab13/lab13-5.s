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

mystery_function:
    ret


#a0 --> first value
#a1 --> second value 
#a2 --> third value

operation:


_start:
    jal operation
    jal exit
