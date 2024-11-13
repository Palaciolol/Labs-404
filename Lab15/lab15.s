.globl _start
.globl control_logic

.bss
.align 4
    isr_stack: .space 1024  #aloca espaço na pilha de ISRs
    isr_stack_end:          #base da pilha de ISRs
    user_stack: .space 4096 #aloca espaço na pilha do usuário 
    user_stack_end:         #base da pilha do usuário

.text
.align 4
.set car_adress, 0xFFFF0100

int_handler:
    csrrw sp, mscratch, sp  #troca sp com mscracth
    addi sp, sp, -16        #aloca espaço na pilha de ISR   
    sw t0, 0(sp)            #salva t0
    sw t1, 4(sp)            #salva t1
    sw t2, 8(sp)            #salva t2

    li t0, 10
    beq t0, a7, set_engine_and_steering
    li t0, 15
    beq t0, a7, get_position
    li t0, 11
    beq t0, a7, set_hand_brake


    restaura_contexto:
    lw t2, 8(sp)            #carrega t2
    lw t1, 4(sp)            #carrega t1
    lw t0, 0(sp)            #carrega t0
    addi sp, sp, 16         #desaloca a pilha
    csrrw sp, mscratch, sp  #troca sp com mscrath

    csrr t0, mepc
    addi t0, t0, 4
    csrw mepc, t0
    mret


set_engine_and_steering:
    li t2, car_adress   #pega o endereço base do carro
    sb a1, 0x20(t2)     #esquerda
    sb a0, 0x21(t2)     #coloca o carro pra ir pra frente
    j restaura_contexto
    


get_position:
    li t2, car_adress
    li t0, 1            #temporário que guarda 1
    sb t0, 0(t2)        #bota o GPS pra ler coordenada
    1:
        lb t0, 0(t2)        #carrega pra ver se o GPS leu
        bnez t0, 1b
    lw t1, 0x10(t2)     #carrega o valor de x em t1
    sw t1, 0(a0)        #coloca o valor em a0
    lw t1, 0x14(t2)
    sw t1, 0(a1)
    lw t1, 0x18(t2)
    sw t1, 0(a2)

    j restaura_contexto



set_hand_brake:
    li t2, car_adress
    sb a0, 0x22(t2)
    j restaura_contexto


_start:
    la sp, user_stack_end
    la t0, isr_stack_end    #t0 <= base da pilha
    csrw mscratch, t0       #mscratch <= t0

    csrr t1, mie            #t1 recebe mie
    li t2, 0x800            #t2 recebe 2048
    or t1, t1, t2           #t1 = t1 or t2
    csrw mie, t1            #mie recebe t1

    csrr t1, mstatus        #t1 recebe mstatus
    ori t1, t1, 0x8         #seta o bit 3 (MIE) do registrador mstatus
    csrw mstatus, t1

    la t0, int_handler      #carrega o endereço da main_isr em mtvec
    csrw mtvec, t0          #mtvec recebe o t0

    csrr t1, mstatus        #Update the mstatus.MPP
    li t2, ~0x1800          #field (bits 11 and 12)
    and t1, t1, t2          #with value 00 (U-mode)
    csrw mstatus, t1        
    la t0, user_main        #Loads the user software
    csrw mepc, t0           #entry point into mepc
    mret


control_logic:
    li a0, 1        #coloca o carro pra ir pra frente
    li a1, -15      #coloca o carro pra ir pra esquerda
    li a7, 10       #código da syscall
    ecall           #chama a syscall

    addi sp, sp, -16
    mv a0, sp
    addi a1, sp, 4
    addi a2, sp, 8
    li a7, 15
    1:
        ecall
        lw t0, 0(sp)
        li t1, 135
        # sub t1, t1, t0
        # li t2, 15
        blt t0, t1, can_stop
        j 1b

    can_stop:
        li a0, 0
        li a1, -15
        li a7, 10
        ecall

        li a0, 1
        li a7, 11
        ecall
    addi sp, sp, 16

    ret

