.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.data
    a:  .word 1      
    b:  .word -2     
    c:  .half 3
    d:  .half -4
    e:  .byte 5
    f:  .byte -6
    g:  .word 7
    h:  .word -8
    i:  .byte 9
    j:  .byte -10
    k:  .half 11
    l:  .half -12
    m:  .word 13
    n:  .word -14
    
.section .text
.align 2

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


mystery_function:
    ret

operation:
    la t0, a
    


_start:
    jal operation
    jal exit
