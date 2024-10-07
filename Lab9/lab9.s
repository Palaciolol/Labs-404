.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 7  #número a ser lido
    output:       .space 4  #output

.section .text
.align 2

#Use as input a0 for the amount of bytes to be read
read: 
    mv a2, a0
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input           #buffer to read the data
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


#Function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output          #buffer
    li a2, 4                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

#a0 --> endereço da string
#a1 --> variável que vai guardar o valor do número em decimal
convert_to_number:
    
    li t0, 0        #variavél de laço iniciada em 0
    li t3, 5
    li t4 ,10
    //add t1, a0, t0  #t1 = endereço base da string(a0) + t0(variável contadora)
    laco:
        beq t0, t3, acabou      #confere se já leu os 4 números
        mul a1, a1, t4          #multiplica a1 por 10 e salva em a1
        lb t2, 0(a0)            #t2 = valor da memória da string no endereço t1
        addi t2, t2, -'0'       #converte t2 para valor numérico
        add a1, a1, t2          #a1 = t2 - '0'
        addi a0, a0, 1          #incremeta o ponteiro
        addi t0, t0, 1          #incrementa a variável de laço
        j laco                 #salta pro laço de novo
    acabou:
        ret                     #retorna pra main

#a0 --> esse registrador guarda o valor do número a ser convertido
#a1 --> endereço da string
#a2 --> valor de onde eu vou começar a por os valores
convert_to_string:
    li t0, 0        #variável de fim de laço
    li t1, 0        #variável contadora
    li t2, 10       #variável que guarda o valor 10
    li t5, 5        #variável que guarda o valor 5
    add a1, a1, a2
    laco2:
        beq a0, t0, fim        #confere se o número já é igual a zero(fim do laço)
        remu t3, a0, t2         #pega o resto da divisão por 10
        //sub t4, t4, t1        #t4 = endereço base da string(a1) - t1
        add t3, t3 , '0'        #t3 recebe ele mesmo mais o caractere 0 pra transformar em string
        sb t3, 0(a1)            #coloco esse byte na posição correta da string
        addi t1, t1, 1          #incrementa a variável contadora
        addi a1, a1, -1
        divu a0, a0, t2         #a0 recebe ele mesmo dividido por 10
        j laco2                 #pula pro laço de novo
    fim:
        ret


_start:
    li a0, 7        #le no máximo 7 carecteres do input
    jal read        #chama a função read
    la a0, input    #a0 recebe endereço do input
    lb t0, 0(a0)    #t0 recebe o primeiro caractere
    li a1, 0        #a1 é inicializado com 0
    li t1, '-'      #t1 = 45(menos em ASCII)
    bne t0, t1, cont    #verifica se o número é negativo ou positivo
    addi a0, a0, 1      #se o número for negativo, incremeta o a0
    cont:
    la a0, input
    li a1, 0
    jal convert_to_number
    la t0, input    #a0 recebe endereço do input
    lb t1, 0(t0)    #t0 recebe o primeiro caractere
    li t2, '-'       #t1 = 45(menos em ASCII)
    bne t1, t2, cont2
    li t0, -1
    mul a1, a1, t0

    cont2:
    la t0, head_node    #ponteiro para o primeiro nó (head_node)
    li t1, 0            #indice da lista (inicia em 0)

    loop:
    beqz t0, not_found  #se NEXT == 0, fim da lista (não encontrado)
    lw t3, 0(t0)        #carrega VAL1
    lw t4, 4(t0)        #carrega VAL2
    add t5, t3, t4      #t5 = VAL1 + VAL2
    beq t5, a1, found   #se VAL1 + VAL2 == a1, vai para found
    lw t0, 8(t0)        #carrega o próximo nó
    addi t1, t1, 1      #incrementa o índice
    j loop              #recomeça o loop

    found:
    //o índice tá em t1
    mv a0, t1
    la a1 ,output
    li t0, 10
    li t1, 100
    blt a0, t0, kek
    blt a0, t1, kek2
    li a2, 2
    jal convert_to_string
    la t0, output
    li t1, '\n'
    sb t1, 3(t0)
    jal write
    jal exit
    kek:
    li a2, 0
    jal convert_to_string
    la t0 ,output
    li t1, '\n'
    sb t1, 1(t0)
    jal write
    jal exit
    kek2:
    li a2, 1
    jal convert_to_string
    la t0 ,output
    li t1, '\n'
    sb t1, 2(t0)
    jal write
    jal exit

    not_found:
    la t0, output
    li t1, '-'
    sb t1, 0(t0)
    li t1, '1'
    sb t1, 1(t0)
    li t1, '\n'
    sb t1, 2(t0)
    jal write
    jal exit

   



