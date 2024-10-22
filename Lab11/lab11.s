.globl _start               #this one indicates where the programm begins

.section .text

.align 2
.set car_adress, 0xFFFF0100


busy_waiting:
    li t0, 1            #temporário que guarda 1
    sb t0, 0(s1)        #bota o GPS pra ler coordenada
    lb t0, 0(s1)        #carrega pra ver se o GPS leu
    beqz t0, gps_leu    

gps_leu:
    li t0, 120
    lw t1, 0x10(s1)     #carrega o valor de x em t1
    sub t1, t1, t0
    li t2, 15
    bltu t1, t2, can_stop
    j busy_waiting

can_stop:
    li t0, 0
    li t1, 1
    sb t0, 0x21(s1)
    sb t1, 0x22(s1)
    j waiting

waiting:
    li s7, 95000
    li t3, 0
    loop:
        beq s7, t3, exit
        addi t3, t3, 1
        j loop

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


_start:
    li s1, car_adress   #pega o endereço base do carro
    li t0, 1
    li t1, -15
    sb t1, 0x20(s1)     #esquerda
    sb t0, 0x21(s1)     #coloca o carro pra ir pra frente
    jal busy_waiting


    
    
