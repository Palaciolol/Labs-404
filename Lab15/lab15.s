.globl _start
.globl control_logic

.bss
.align 4
    isr_stack: .space 1024  #aloca espaço na pilha de ISRs
    isr_stack_end:          #base da pilha de ISRs

.data
    x_pos: .word 0

.text
.align 4
.set car_adress, 0xFFFF0100

int_handler:
    csrrw sp, mscratch, sp  #troca sp com mscracth
    addi sp, sp, -32        #aloca espaço na pilha de ISR   
    sw t0, 0(sp)            #salva t0
    sw a0, 4(sp)            #salva t1
    sw a1, 8(sp)            #salva t2
    sw t1, 12(sp)           #salva t3
    sw a7, 16(sp)
    sw t2, 20(sp)

    li t0, 10
    beq t0, a7, set_engine_and_steering
    li t0, 15
    beq t0, a7, get_position
    li t0, 11
    beq t0, a7, set_hand_brake


    restaura_contexto:
    lw t2, 20(sp)           #carrega a2
    lw a7, 16(sp)           #carrega a2
    lw t1, 12(sp)           #carrega a2
    lw a1, 8(sp)            #salva a2
    lw a0, 4(sp)            #salva a2
    lw t0, 0(sp)            #salva a2
    addi sp, sp, 32         #desaloca a pilha
    csrrw sp, mscratch, sp  #troca sp com mscrath
    mret


set_engine_and_steering:
    li t2, car_adress   #pega o endereço base do carro
    sb a1, 0x20(t2)     #esquerda
    sb a0, 0x21(t2)     #coloca o carro pra ir pra frente
    j restaura_contexto
    

get_position:
    li t2, car_adress
    lw t1, 0x10(t2)     #carrega o valor de x em t1
    sw t1, 0(a0)        #coloca o valor em a0 
    j restaura_contexto


set_hand_brake:
    li t2, car_adress
    sb a0, 0x22(t2)
    j restaura_contexto


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
    csrw mstatus, t1

    csrr t1, mstatus        #Update the mstatus.MPP
    li t2, ~0x1800          #field (bits 11 and 12)
    and t1, t1, t2          #with value 00 (U-mode)
    csrw mstatus, t1
    la t0, user_main        #Loads the user software
    csrw mepc, t0           #entry point into mepc
    mret                    #PC <= MEPC; mode <= MPP;

    csrr t0, mepc           #load return address (address of the instruction that invoked the syscall)
    addi t0, t0, 4          #adds 4 to the return address (to return after ecall)
    csrw mepc, t0           #stores the return address back on mepc
    mret                    #recover remaining context (pc <- mepc)
    jal user_main


control_logic:
    li a0, 1        #coloca o carro pra ir pra frente
    li a1, -15      #coloca o carro pra ir pra esquerda
    li a7, 10       #código da syscall
    ecall           #chama a syscall

    check_coordinate:
        li t2, car_adress
        li t0, 1            #temporário que guarda 1
        sb t0, 0(t2)        #bota o GPS pra ler coordenada
        1:
            lbu t0, 0(t2)        #carrega pra ver se o GPS leu
            bnez t0, 1b
        
        la a0, x_pos
        li a7, 15   #já que ele leu, posso chamar a syscall pra pegar a posição
        ecall       #chama a syscall
        
    la a0, x_pos
    lw t1, 0(a0)
    li t0, 120
    sub t1, t1, t0
    li t2, 15
    bltu t1, t2, can_stop
    j check_coordinate


    can_stop:
        li a0, 0
        li a1, -15
        li a7, 10
        ecall

        li a0, 1
        li a7, 11
        ecall

    #j infinite_loop
    ret

