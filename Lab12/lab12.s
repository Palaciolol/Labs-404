.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 400  #número a ser lido
    output:       .space 400  #output

.section .text
.align 2

#Use as input a0 for the amount of bytes to be read
read: 
    mv a2, a0
    li a0, 0               #file descriptor = 0 (stdin)
    la a1, input           #buffer to read the data
    li a7, 63              #syscall read (63)
    ecall
    ret                    #retorno da função

read2: 
    li a0, 0                #file descriptor = 0 (stdin)
    li a2, 1                #vou ler 1 byte
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


#Function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, input            #buffer
    li a2, 6                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


//function to write data on the standart output
write2: 
    li a0, 1                #file descriptor = 1 (stdout)
    li a2, 1                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

#a0 --> endereço que vai salvar os bytes
gets:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)
    mv a1, a0       #move o endereço que vai salvar os bytes pra a1
    li t0, '\n'     #\n
    loop:
    jal read2        #leio um byte
    lbu t1, 0(a1)    #carrego esse byte que eu acabei de ler
    beq t1, t0, sai 
    addi a1, a1, 1
    j loop
    sai:
    lw ra, 0(sp)         #pega o valor de ra da pilha
    lw a0, 4(sp)
    addi sp, sp, 16       #incrementa sp
    ret


#a0 guarda o tamanho da string original
invert_string:  
    li t0, 0        #var contadora
    la a1, input    #endereço do input
    la a2, output   #endereço do output
    add a2, a2, a0  #a2 += a0
    li t1, '\n'
    sb t1, 1(a2)
    addi a2, a2, -1
    loop2:
        lb t1, 0(a1)
        sb t1, 0(a2)
        beq t0, a0, cabou
        addi a1, a1, 1
        addi a2, a2, -1
    cabou:
        la a0, output
        ret


#a0 vai ter o endereço da string
strlen:
    li t0, 0    #var contadora
    mv a1, a0   #coloca o endereço em a1
    li t1, '\n'
    loop:
        lb t2, 0(a0)        #carrega o o byte
        beq t1, t2, cabo    #verifica se chegou no \n
        addi a0, a0, 1      #incrementa o ponteiro
        addi t0, t0, 1      #incremeta a var contadora
        j loop

    cabo:
        mv a0, t0       #coloca o tamanho em a0
        ret


#a0 tem o endereço da string que é pra printar
puts:
    addi sp, sp, -16
    sw ra, 0(sp)
    mv a1, a0   #coloca o endereço que vou printar em a1
    li t0, '\n'    #caractere '\0' , final de string
    loop3:
        lb t1, 0(a1)
        beq t1, t0, acabou2
        jal write2
        addi a1, a1, 1
        j loop3
    acabou2:
        jal write2
        lw ra, 0(sp)         #pega o valor de ra da pilha
        addi sp, sp, 16      #incrementa sp
        ret

#a0 --> endereço da string
atoi:
    li t2, 10
    li t4, '-'
    li a1, 0
    lb t5, 0(a0)            #t5 = valor da memória da string no endereço a0
    bne t5, t4, laco  #se tiver um menos, eu seto uma flag
    li t6, -1
    addi a0, a0, 1
    laco:
        lb t5, 0(a0)
        beq t5, zero, acabou    #se o byte caregado for um \0, acabou
        mul a1, a1, t2          #multiplica a1 por 10 e salva em a1
        addi t5, t5, -'0'       #converte t2 para valor numérico
        add a1, a1, t5          #a1 = a1 + t5
        addi a0, a0, 1          #a0 = a0 + 1
        j laco
        
    acabou:
        li t0, -1
        beq t6, t0, negativo
        j cont3
        negativo:
        neg a1, a1
        mv a0, a1
        ret
        cont3:
        mv a0, a1
        ret    


ope1:
    la a0, input
    jal gets
    jal write
    j finaliza


ope2:
    la a0, input
    jal strlen
    jal invert_string
    jal puts
    j finaliza


ope3:



    j finaliza



ope4:
    j finaliza

_start:
    li a0, 2    #lê dois bytes
    jal read    #chama a read
    li s1, '1'    
    li s2, '2'
    li s3, '3'
    li s4, '4'
    la t0, input
    lb s5, 0(t0)
    beq s1, s5, ope1
    beq s2, s5, ope2
    beq s3, s5, ope3
    beq s4, s5, ope4
    finaliza:
    jal exit