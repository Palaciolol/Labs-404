.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 400  #número a ser lido
    output:       .space 400  #output
    
.section .text
.align 2
.set port_adress, 0xFFFF0100


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall              #syscall


#a0 --> endereço que vai salvar os bytes
gets_serial:
    addi sp, sp, -16        #aloca espaço na pilha
    sw ra, 0(sp)            #salva o ra
    sw a0, 4(sp)            #salva o a0
    li t0, '\n'             #t0 = '\n'
    li t3, 0xFFFF0100      #pega o endereço base do serial port
    1:
    li t2, 1                #t2 = 1
    sb t2, 0x02(t3)         #seta como 1, pra ler
    2:
    lbu t2, 0x02(t3)        
    bnez t2, 2b
    
    lbu t1, 0x03(t3)        #carrego esse byte que eu acabei de ler
    beq t1, t0, 1f         #verifica se o byte é o '\n'
    sb t1, 0(a0)            #coloco esse byte no endereço certo
    addi a0, a0, 1          #incrementa o ponteiro
    j 1b     

    1:
    sb zero, 0(a0)          #coloca o '\0' no final da string
    lw ra, 0(sp)            #pega o valor de ra da pilha
    lw a0, 4(sp)            #pega o a0 da pilha
    addi sp, sp, 16         #incrementa sp
    ret                     #retorna


#a0 guarda o tamanho da string original
#a1 ta com o ponteiro , que ta no final
invert_string:  
    la a2, output   #endereço do output
    1:
        lbu t1, 0(a1)
        sb t1, 0(a2)
        addi a1, a1, -1
        addi a2, a2, 1
        addi a0, a0, -1
        beqz a0, 1f
        j 1b
    1:
        sb zero, 0(a2)
        la a0, output
        ret


#a0 vai ter o endereço da string
strlen:
    li t0, 0    #var contadora
    mv a1, a0   #coloca o endereço em a1
    li t1, 0
    1:
        lbu t2, 0(a1)        #carrega o o byte
        beq t1, t2, 1f    #verifica se chegou no '\0'
        addi a1, a1, 1      #incrementa o ponteiro
        addi t0, t0, 1      #incremeta a var contadora
        j 1b

    1:
        addi a1, a1, -1
        mv a0, t0       #coloca o tamanho em a0
        ret


#a0 tem o endereço da string que é pra printar
puts_serial:
    addi sp, sp, -16            #aloca espaço na pilha
    sw ra, 0(sp)                #salva o ra na pilha
    li s6, port_adress          #carrega o endereço base 
    1:
        lbu t1, 0(a0)           #carrega o byte que é pra printar
        beqz t1, 1f             #byte = '\0'
        sb t1, 0x01(s6)         #coloca esse byte no endereço pra printar
        li t2, 1                #t2 = 1 
        sb t2, 0(s6)            #trigger pra printar
        2:
        lbu t2, 0(s6)
        bnez t2, 2b

        addi a0, a0, 1
        j 1b
    1:
        li t0, '\n'
        sb t0, 0x01(s6)
        li t2, 1
        sb t2, 0(s6)
        3:
        lbu t2, 0(s6)
        bnez t2, 3b

        lw ra, 0(sp)            #pega o valor de ra da pilha
        addi sp, sp, 16         #incrementa sp
        ret


#a0 --> endereço da string
atoi:
    li t1, '/'      
    li t2, 10
    li t3, '+'
    li t4, '-'
    li t6, '*'
    li a1, 0                    #número
    li a2, 2                    #var contadora que vai ser útil
    li a3, ' '
    lbu t5, 0(a0)               #t5 = valor da memória da string no endereço a0
    bne t5, t4, 1f              #se tiver um menos, eu seto uma flag
    li t0, -1                   #flag que o número é negativo
    addi a0, a0, 1              #incrementa o endereço
    addi a2, a2, 1
    1:
        lbu t5, 0(a0)           #carrega o byte em t5
        beqz t5, 1f             #se o byte caregado for um \0, acabou
        beq t5, t4, 1f          #se o byte carregado for '-'
        beq t5, t3, 1f          #se o byte carregado for '+'
        beq t5, t6, 1f          #se o byte carregado for '*'
        beq t5, t1, 1f          #se o byte carregado for '/'
        beq t5, a3, eh_space          #se for espaço eu ignoro
        mul a1, a1, t2          #multiplica a1 por 10 e salva em a1
        addi t5, t5, -'0'       #converte t2 para valor numérico
        add a1, a1, t5          #a1 = a1 + t5
        eh_space:
        addi a0, a0, 1          #a0 = a0 + 1
        addi a2, a2, 1          #a2 += 1
        j 1b
        
    1:
        li t1, -1               #temporário pra comparar com a flag
        bne t1, t0, positivo    #verifica se o número é negativo
        neg a1, a1              #transforma a1 em negativo             
        positivo:
        mv a0, a1               #coloca o valor em a0
        mv a1, t5               #coloca o possível sinal em a1
        ret    

#a0 --> esse registrador guarda o valor do número a ser convertido
#a1 --> endereço da string que eu vou por os valores
#a2 --> base pra qual eu vou converter
itoa:
    addi sp, sp, -16     #aloca espaço na pilha
    sw a1, 0(sp)         #guarda o endereço da string na pilha
    bnez a0, cont        #verifica se o número é 0
    li t0, '0'           #carectere '0'               
    sb t0, 0(a1)         #coloca o '0' em a1
    sb zero, 1(a1)       #coloca o '\0' em a1
    lw a0, 0(sp)         #pega o valor de ra da pilha
    addi sp, sp, 16      #incrementa sp
    ret
    cont:
    li t0, 0                    #variável de fim de laço
    li t2, 10                   #eu suponho que a base é 10
    mv t3, a0                   #coloco o número a ser convertido em t3
    bne a2, t2, base_16         #verifica se é base 16
    blt a0, t0, menor_que_zero  #verifico se o número é menor que zero
    j 1f
    menor_que_zero:
    li t5, '-'
    sb t5, 0(a1)
    neg t3, t3
    neg a0, a0
    addi a1, a1, 1
    j 1f
    base_16:
    li t2, 16
    1:
    beqz t3,  cont2
    addi a1, a1, 1
    divu t3, t3, t2
    j 1b
    cont2:
    sb zero, 0(a1)
    addi a1, a1, -1
    2:
        li t1, 10
        beq a0, zero, 2f      #confere se o número já é igual a zero(fim do laço)
        remu t3, a0, t2        #pega o resto da divisão pela base
        bge t3, t1, soma_55    #confere se o número é maior ou igual a 10
        addi t3, t3 ,'0'       #t3 recebe ele mesmo mais o caractere 0 pra transformar em string
        j cont3
        soma_55:
        addi t3, t3, 'A'- 10
        cont3:
        sb t3, 0(a1)           #coloco esse byte na posição correta da string
        addi a1, a1, -1        #subtrai a1
        divu a0, a0, t2        #a0 recebe ele mesmo dividido pela base
        j 2b               #pula pro laço de novo
    2:
        lw a0, 0(sp)         #pega o valor de a0 da pilha
        addi sp, sp, 16      #incrementa sp
        ret


ope1:
    la a0, input
    jal gets_serial
    jal puts_serial
    j exit


ope2:
    la a0, input
    jal gets_serial
    jal strlen
    jal invert_string
    jal puts_serial
    j exit


ope3:
    la a0, input
    jal gets_serial
    jal atoi
    la a1, output
    li a2, 16
    jal itoa
    jal puts_serial
    j exit



ope4:
    la a0 , input       #carrega o endereço de input
    jal gets_serial           #lê o input até o \n
    jal atoi            #chama a asci to int
    mv s0, a0           #s0 guarda o primeiro número
    mv s1, a1           #s1 guarda o sinal
    la a0, input        #carrega o input de novo
    add a0, a0, a2      #incrementa o endereço base pra ler o segundo número
    li t0, 0            #reseta t0 pra ele nao pegar que o segundo número é negativo
    jal atoi            #chama a ascii to int
    mv s2, a0           #s2 vai ter o segundo número
    li t0, '-'         
    beq t0, s1, subtrai
    li t0, '+'        
    beq t0, s1, adicao
    li t0, '*'
    beq t0, s1, multiplica
    li t0, '/'
    beq t0, s1, divide
    subtrai:
        sub a0, s0, s2      #a0 = primeiro - segundo
        la a1, input        #a1 recebe o endereço do output
        li a2, 10           #base 10
        jal itoa            #int to ascii
        jal puts_serial          #printa
        j exit

    adicao:
        add a0, s0, s2
        la a1, input
        li a2, 10
        jal itoa
        jal puts_serial
        j exit
    
    multiplica:
        mul a0, s0, s2
        la a1, input   
        li a2, 10
        jal itoa
        jal puts_serial
        j exit
    
    divide:
        div a0, s0, s2
        la a1, input
        li a2, 10
        jal itoa
        jal puts_serial
        j exit

_start:
    la a0, input    #endereço pra salvar o input
    jal gets_serial       #lê o input
    li s1, '1'    
    li s2, '2'
    li s3, '3'
    li s4, '4'
    lbu s5, 0(a0)
    beq s1, s5, ope1
    beq s2, s5, ope2
    beq s3, s5, ope3
    beq s4, s5, ope4