.text
.align 4

int_handler:
  ###### Syscall and Interrupts handler ######
    set_engine_and_steering:
        






    get_position:




    hand_break:



  


    csrr t0, mepc     #load return address (address of the instruction that invoked the syscall)
    addi t0, t0, 4    #adds 4 to the return address (to return after ecall)
    csrw mepc, t0     #stores the return address back on mepc
    mret              #recover remaining context (pc <- mepc)


.globl _start
_start:

  la t0, int_handler  # Load the address of the routine that will handle interrupts
  csrw mtvec, t0      # (and syscalls) on the register MTVEC to set the interrupt array.



.globl control_logic
control_logic:
    jal set_engine_and_steering

