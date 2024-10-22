.globl my_var, increment_my_var

.data
    my_var: .word 10

.section .text
.align 2

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall              #syscall


increment_my_var:
    # addi sp, sp, -48
    # sw s0, 44(sp)       # Salva o registrador s0 na pilha
    # sw s1, 40(sp)       # Salva o registrador s1 na pilha
    # sw s2, 36(sp)       # Salva o registrador s2 na pilha
    # sw s3, 32(sp)       # Salva o registrador s3 na pilha
    # sw s4, 28(sp)       # Salva o registrador s4 na pilha
    # sw s5, 24(sp)       # Salva o registrador s5 na pilha
    # sw s6, 20(sp)       # Salva o registrador s6 na pilha
    # sw s7, 16(sp)       # Salva o registrador s7 na pilha
    # sw s8, 12(sp)       # Salva o registrador s8 na pilha
    # sw s9, 8(sp)        # Salva o registrador s9 na pilha
    # sw s10, 4(sp)       # Salva o registrador s10 na pilha
    # sw s11, 0(sp)       # Salva o registrador s11 na pilha
    la t0, my_var
    lw t1, 0(t0)
    addi t1, t1, 1
    sw t1, 0(t0)
    # lw s0, 44(sp)       # Restaura o registrador s0
    # lw s1, 40(sp)       # Restaura o registrador s1
    # lw s2, 36(sp)       # Restaura o registrador s2
    # lw s3, 32(sp)       # Restaura o registrador s3
    # lw s4, 28(sp)       # Restaura o registrador s4
    # lw s5, 24(sp)       # Restaura o registrador s5
    # lw s6, 20(sp)       # Restaura o registrador s6
    # lw s7, 16(sp)       # Restaura o registrador s7
    # lw s8, 12(sp)       # Restaura o registrador s8
    # lw s9, 8(sp)        # Restaura o registrador s9
    # lw s10, 4(sp)       # Restaura o registrador s10
    # lw s11, 0(sp)       # Restaura o registrador s11
    # addi sp, sp, 48     # Libera o espaço da pilha
    ret





