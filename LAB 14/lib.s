.globl _start
.globl _system_time
.globl play_note


.bss
.align 4
    isr_stack: .space 1024  #aloca espaço na pilha de ISRs
    isr_stack_end:          #base da pilha de ISRs

.data
    _system_time: .word 0    #global time counter


.text
.align 2
.set gpt, 0xFFFF0100
.set midi, 0xFFFF0300



#a0 --> int ch
#a1 --> int inst
#a2 --> int note
#a3 --> int vel
#a4 --> int dur
play_note:
    li t0, midi         #carrega o adress base do bagulho
    sh a1, 0x02(t0)     #coloca o id
    sb a2, 0x04(t0)     #coloca a note
    sb a3, 0x05(t0)     #coloca a velocidade
    sh a4, 0x06(t0)     #coloca a duração
    sb a0, 0(t0)        #coloca o ch no adress correto
    ret


main_isr:
    csrrw sp, mscratch, sp  #troca sp com mscracth
    addi sp, sp, -16        #aloca espaço na pilha de ISR   
    sw t0, 0(sp)            #salva t0
    sw t1, 4(sp)            #salva t1
    sw t2, 8(sp)            #salva t2
    sw t3, 12(sp)           #salva t3
    
    la t0, _system_time
    lw t1, 0(t0)
    addi t1, t1, 100
    sw t1, 0(t0)

    li t3, gpt
    li t2, 100
    sw t2, 0x08(t3)

    lw t3, 12(sp)           #carrega a2
    lw t2, 8(sp)            #salva a2
    lw t1, 4(sp)            #salva a2
    lw t0, 0(sp)            #salva a2
    addi sp, sp, 16         #desaloca a pilha
    csrrw sp, mscratch, sp  #troca sp com mscrath
    mret


_start:
    la sp, isr_stack_end
    la t0, isr_stack_end    #t0 <= base da pilha
    csrw mscratch, t0       #mscratch <= t0

    csrr t1, mie            #t1 recebe mie
    li t2, 0x800
    or t1, t1, t2
    csrw mie, t1            #mie recebe t1

    csrr t1, mstatus        #t1 recebe mstatus
    ori t1, t1, 0x8         #seta o bit 3 (MIE) do registrador mstatus
    csrw mstatus, t1        #mstatus recebe t1

    la t0, main_isr        #carrega o endereço da main_isr em mtvec
    csrw mtvec, t0         #mtvec recebe o t0

    li t3, gpt
    li t2, 100
    sw t2, 0x08(t3)

    jal main


    






