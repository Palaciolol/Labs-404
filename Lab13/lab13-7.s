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


#a0 --> ponteiro pro array de int
#a1 --> tamanho do array
middle_value_int:


#a0 --> ponteiro pro array de short
#a1 --> tamanho do array
middle_value_short:


#a0 --> ponteiro pro array de char
#a1 --> tamanho do array
middle_value_char:



#a0 --> ponteiro pro array de array de int
#a1 --> linha
#a2 --> coluna
value_matrix:



_start:
    jal my_function
    jal exit
