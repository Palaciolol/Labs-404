.globl _start               #this one indicates where the programm begins

//function to read data from standart input
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


mystery_function:
    ret

operation:
    addi sp, sp, -32
    la t0, ints        
    la t1, shorts
    la t2, bytes
    lw a0, 0(t0)    #a
    lw a1, 4(t0)    #b
    lh a2, 0(t1)    #c
    lh a3, 4(t1)    #d
    lb a4, 0(t2)    #e
    lb a5, 4(t2)    #f
    lw a6, 8(t0)    #g
    lw a7, 12(t0)   #h
    lb t0, 8(t2)    #i
        
    


_start:
    jal operation
    jal exit
