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

fill_array_int:
    #declara um array
    #percorre o array preencehndo ele
    #chama mystery

fill_array_short:
    #declara um array
    #percorre o array preencehndo ele
    #chama mystery


fill_array_char:
    #declara um array
    #percorre o array preencehndo ele
    #chama mystery




_start:
    jal my_function
    jal exit
