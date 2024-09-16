.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input_address: .space 20  #buffer
    string:        .space 4   #string que vai guardar os números
    output_adress: .space 20  #output 


.section .text
.align 2

read: 
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input_address    #buffer to read the data
    li a2, 20               #size (reads only 5 bytes)
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


//function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, string           #buffer
    li a2, 4                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

_start: 
    jal read