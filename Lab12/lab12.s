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
    sb zero, 0(a1)
    lw ra, 0(sp)         #pega o valor de ra da pilha
    lw a0, 4(sp)
    addi sp, sp, 16       #incrementa sp
    ret


#a0 guarda o tamanho da string original
#a1 ta com o ponteiro , que ta no final
invert_string:  
    la a2, output   #endereço do output
    loop2:
        lbu t1, 0(a1)
        sb t1, 0(a2)
        addi a1, a1, -1
        addi a2, a2, 1
        addi a0, a0, -1
        beqz a0, cabou
        j loop2
    cabou:
        sb zero, 0(a2)
        la a0, output
        ret


#a0 vai ter o endereço da string
strlen:
    li t0, 0    #var contadora
    mv a1, a0   #coloca o endereço em a1
    li t1, 0
    loop4:
        lbu t2, 0(a1)        #carrega o o byte
        beq t1, t2, cabo    #verifica se chegou no '\0'
        addi a1, a1, 1      #incrementa o ponteiro
        addi t0, t0, 1      #incremeta a var contadora
        j loop4

    cabo:
        addi a1, a1, -1
        mv a0, t0       #coloca o tamanho em a0
        ret


#a0 tem o endereço da string que é pra printar
puts:
    addi sp, sp, -16
    sw ra, 0(sp)
    mv a1, a0   #coloca o endereço que vou printar em a1
    li t0, 0    #caractere '\0' , final de string
    loop3:
        lb t1, 0(a1)
        beq t1, t0, acabou2
        jal write2
        addi a1, a1, 1
        j loop3
    acabou2:
        li t0, '\n'
        sb t0, 0(a1)
        jal write2
        lw ra, 0(sp)         #pega o valor de ra da pilha
        addi sp, sp, 16      #incrementa sp
        ret

#a0 --> endereço da string
atoi:
    li t1, '/'
    li t2, 10
    li t3, '+'
    li t4, '-'
    li t6, '*'
    li a1, 0
    li a2, 0
    #lb t5, 0(a0)                #t5 = valor da memória da string no endereço a0
    #bne t5, t4, laco            #se tiver um menos, eu seto uma flag
    #li t6, -1
    #addi a0, a0, 1
    laco:
        lb t5, 0(a0)
        beq t5, zero, acabou    #se o byte caregado for um \0, acabou
        beq t5, t4, acabou      #se o byte carregado for '-'
        beq t5, t3, acabou      #se o byte carregado for '+'
        beq t5, t6, acabou      #se o byte carregado for '*'
        beq t5, t1, acabou      #se o byte carregado for '/'
        mul a1, a1, t2          #multiplica a1 por 10 e salva em a1
        addi t5, t5, -'0'       #converte t2 para valor numérico
        add a1, a1, t5          #a1 = a1 + t5
        addi a0, a0, 1          #a0 = a0 + 1
        addi a2, a2, 1          #a2 += 1
        j laco
        
    acabou:
        #li t0, -1
        #beq t6, t0, negativo
        #j cont3
        #negativo:
        #neg a1, a1
        #mv a0, a1
        #ret
        #cont3:
        mv a0, a1
        mv a1, t5
        ret    

#a0 --> esse registrador guarda o valor do número a ser convertido
#a1 --> endereço da string que eu vou por os valores
#a2 --> base pra qual eu vou converter
itoa:
    addi sp, sp, -16
    sw a1, 0(sp)    
    bnez a0, cont4
    li t0,'0'
    sb t0, 0(a1)
    sb zero, 1(a1)
    lw a0, 0(sp)         #pega o valor de ra da pilha
    addi sp, sp, 16      #incrementa sp
    ret
    cont4:
    li t0, 0             #variável de fim de laço
    li t2, 10            #eu suponho que a base é 10
    mv t3, a0            #coloco o número a ser convertido em t3
    bne a2, t2, base_16
    blt a0, t0, menor_que_zero
    j loop_aux
    menor_que_zero:
    li t5, '-'
    sb t5, 0(a1)
    neg t3, t3
    neg a0, a0
    addi a1, a1, 1 
    j loop_aux
    base_16:
    li t2, 16
    loop_aux:
    beq t3, zero, cont
    addi a1, a1, 1
    div t3, t3, t2
    j loop_aux
    cont:
    sb zero, 0(a1)
    addi a1, a1, -1
    laco2:
        li t1, 10
        beq a0, zero, fim      #confere se o número já é igual a zero(fim do laço)
        remu t3, a0, t2        #pega o resto da divisão pela base
        bge t3, t1, soma_55    #confere se o número é maior ou igual a 10
        addi t3, t3 ,'0'       #t3 recebe ele mesmo mais o caractere 0 pra transformar em string
        j cont2
        soma_55:
        addi t3, t3, 'A'-10
        cont2:
        sb t3, 0(a1)           #coloco esse byte na posição correta da string
        addi a1, a1, -1        #subtrai a1
        divu a0, a0, t2        #a0 recebe ele mesmo dividido pela base
        j laco2                #pula pro laço de novo
    fim:
        lw a0, 0(sp)         #pega o valor de ra da pilha
        addi sp, sp, 16      #incrementa sp
        ret


ope1:
    la a0, input
    jal gets
    jal puts
    j finaliza


ope2:
    la a0, input
    jal gets
    jal strlen
    jal invert_string
    jal puts
    j finaliza


ope3:
    la a0, input
    jal gets
    jal atoi
    la a1, output
    li a2, 16
    jal itoa
    jal puts
    j finaliza



ope4:
    la a0 , input
    jal gets
    jal atoi
    #a0 vai ter o número e a1 o sinal
    mv s0, a0   #s0 guarda o primeiro número
    mv s1, a1   #s1 guarda o sinal
    la a0, input
    addi a2, a2, 1
    add a0, a0, a2
    jal atoi
    mv s2, a0
    li t0, '-'
    beq t0, s1, subtrai
    li t0, '+'
    beq t0, s1, adicao
    li t0, '*'
    beq t0, s1, multiplica
    li t0, '/'
    beq t0, s1, divide
    #j finaliza
    subtrai:
        li a0, 0
        sub a0, s0, s2
        la a1, output
        li a2, 10
        jal itoa
        jal puts 
        j finaliza

    adicao:
        li a0, 0
        add a0, s0, s2
        la a1, output
        li a2, 10
        jal itoa
        jal puts
        j finaliza
    
    multiplica:
        li a0, 0
        mul a0, s0, s2
        la a1, output
        li a2, 10
        jal itoa
        jal puts
        j finaliza
    
    divide:
        li a0, 0
        div a0, s0, s2
        la a1, output
        li a2, 10
        jal itoa
        jal puts
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