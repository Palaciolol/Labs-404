.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:       .space 13  #bits que vão ser codificados

.section .text
.align 2

#Use as input a0 for the amount of bytes to be read
read: 
    mv a2, a0
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input           #buffer to read the data
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


#Function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output1          #buffer
    li a2, 8                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


set_pixel:
    li a0, 100 # x coordinate = 100
    li a1, 200 # y coordinate = 200
    li a2, 0xFFFFFFFF # white pixel
    li a7, 2200 # syscall setPixel (2200)
    ecall
    ret


open_file:
    la a0, input_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open
    ecall
    ret

input_file: .asciz "image.pgm"



close:
    li a0, 3             # file descriptor (fd) 3
    li a7, 57            # syscall close
    ecall
    ret

input_file: .asciz "image.pgm"




_start:
    jal open_file