.globl _start



.bss
irs_stack: .space 1024
irs_stack_end:
_system_time:


.section .text
.align 2
.set gpt, 0xFFFF0100
.set midi, 0xFFFF0300



play_note:


interrupt:
    #salva o contexto
    #lida
    #volta
    ret



_start:
    la t0, isr_stack_end # t0 <= base da pilha
    csrw mscratch, t0 # mscratch <= t0

    csrr t1, mie # Seta o bit 11 (MEIE)
    li t2, 0x800 # do registrador mie
    or t1, t1, t2
    csrw mie, t1


    csrr t1, mstatus # Seta o bit 3 (MIE)
    ori t1, t1, 0x8 # do registrador mstatus
    csrw mstatus, t1

    la t0, interrupt # Carrega o endereço da main_isr
    csrw mtvec, t0 # em mtvec
    
    


    jal main




