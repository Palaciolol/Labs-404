.globl operation              

.section .text
.align 2    

operation:
    li a0, 1
    li a1, -2
    li a2, 3
    li a3, -4
    li a4, 5
    li a5, -6
    li a6, 7
    li a7, -8
    addi sp, sp, -32
    li t1, 9
    sw t1, 0(sp)
    li t1, -10
    sw t1, 4(sp)
    li t1, 11
    sw t1, 8(sp)
    li t1, -12
    sw t1, 12(sp)
    li t1, 13
    sw t1, 16(sp)
    li t1, -14
    sw t1, 20(sp)
    sw ra, 24(sp)
    jal mystery_function
    lw ra, 24(sp)
    addi sp, sp, 32
    ret
