.globl my_var, increment_my_var

.data
    my_var: .word 10

.section .text
.align 2


increment_my_var:
    la t0, my_var
    lw t1, 0(t0)
    addi t1, t1, 1
    sw t1, 0(t0)
    ret





