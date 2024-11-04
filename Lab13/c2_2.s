.globl middle_value_int, middle_value_short, middle_value_char, value_matrix               

.section .text
.align 2

#a0 --> ponteiro pro array de int
#a1 --> tamanho do array
middle_value_int:
    srli a1, a1, 1
    slli a1, a1, 2
    add a0, a1 , a0
    lw a0, 0(a0)
    ret

#a0 --> ponteiro pro array de short
#a1 --> tamanho do array
middle_value_short:
    srli a1, a1, 1
    slli a1, a1, 1
    add a0, a1 , a0
    lh a0, 0(a0)
    ret

#a0 --> ponteiro pro array de char
#a1 --> tamanho do array
middle_value_char:
    srli a1, a1, 1  
    add a0, a1 , a0
    lb a0, 0(a0)
    ret


#a0 --> ponteiro pro array de array de int
#a1 --> linha
#a2 --> coluna
value_matrix:
    li t1, 42
    mul t2, t1, a1  
    add t2, t2, a2
    slli t2, t2, 2
    add a0, a0,t2
    lw a0, 0(a0)
    ret

