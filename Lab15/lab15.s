.globl _start
.globl control_logic

.text
.align 4

int_handler:
    csrrw sp, mscratch, sp  #troca sp com mscracth
    addi sp, sp, -32        #aloca espaço na pilha de ISR   
    sw t0, 0(sp)            #salva t0
    sw t1, 4(sp)            #salva t1
    sw t2, 8(sp)            #salva t2
    sw t3, 12(sp)           #salva t3
    

    li t4, 10
    beq t4, a7, ir_pra_frente



    lw t3, 12(sp)           #carrega a2
    lw t2, 8(sp)            #salva a2
    lw t1, 4(sp)            #salva a2
    lw t0, 0(sp)            #salva a2
    addi sp, sp, 32         #desaloca a pilha
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
  csrw ms

  csrr t0, mepc     #load return address (address of the instruction that invoked the syscall)
  addi t0, t0, 4    #adds 4 to the return address (to return after ecall)
  csrw mepc, t0     #stores the return address back on mepc
  mret              #recover remaining context (pc <- mepc)
  jal user_main


control_logic:
    li a0, 1
    li a1, -15
    li a7, 10
    ecall 
    ret

