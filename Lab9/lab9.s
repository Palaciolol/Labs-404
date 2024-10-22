.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.bss
    input:        .space 7  #número a ser lido
    number:       .space 6  #número sem o sinal
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
#a2 --> reg que guarda quantos bytes são pra converter
convert_to_number:
    li t0, 0        #variavél de laço iniciada em 0
    li t4 ,10
    laco:
        beq t0, a2, acabou      #confere se já leu todos os bytes
        mul a1, a1, t4          #multiplica a1 por 10 e salva em a1
        lb t2, 0(a0)            #t2 = valor da memória da string no endereço a0
        addi t2, t2, -'0'       #converte t2 para valor numérico
        add a1, a1, t2          #a1 = a1 + t2
        addi a0, a0, 1          #a0 = a0 + 1
        addi t0, t0, 1          #incrementa a variável de laço
        j laco                  #salta pro laço de novo
    acabou:
        mv a0, a1
        ret                     #retorna pra main



#a0 --> esse registrador guarda o valor do número a ser convertido
#a1 --> endereço da string
#a2 --> valor de onde eu vou começar a por os valores
convert_to_string:
    li t0, 0        #variável de fim de laço
    li t2, 10       #variável que guarda o valor 10
    add a1, a1, a2  #a1= a1+ a2(onde eu começo a por os valores)
    laco2:
        beq a0, t0, fim        #confere se o número já é igual a zero(fim do laço)
        remu t3, a0, t2        #pega o resto da divisão por 10
        addi t3, t3 ,'0'        #t3 recebe ele mesmo mais o caractere 0 pra transformar em string
        sb t3, 0(a1)           #coloco esse byte na posição correta da string
        addi a1, a1, -1
        divu a0, a0, t2        #a0 recebe ele mesmo dividido por 10
        j laco2                #pula pro laço de novo
    fim:
        ret

#recebe o endereço que vai salvar os bytes em a0
#recebe o endereço do input em a1
#devolve a quantidade de bytes da string em a0
get_bytes:
    li t0, 0    #var contadora
    li t1, '\n'
    loop:
    lb t2, 0(a1)
    beq t2, t1, sai
    sb t2, 0(a0)
    addi a0, a0, 1
    addi a1, a1, 1
    addi t0, t0, 1
    j loop
    sai:
    mv a0, t0
    ret

_start:
    li a0, 7    
    jal read
    la t0, input
    lb t1, 0(t0)
    li t2, '-'
    bne t1, t2, positivo
    la a0, number
    la a1, input
    addi a1, a1, 1
    jal get_bytes
    mv a2, a0
    li a1, 0
    la a0, number
    jal convert_to_number
    li t0, -1
    mul a0, a0, t0
    j cont
    positivo:
    la a0, number
    la a1, input
    jal get_bytes
    mv a2, a0
    li a1, 0
    la a0, number
    jal convert_to_number
    cont:
    la t0, head_node    #ponteiro para o primeiro nó (head_node)
    li t1, 0            #indice da lista (inicia em 0)
    loop2:
    beqz t0, not_found  #se NEXT == 0, fim da lista (não encontrado)
    lw t3, 0(t0)        #carrega VAL1
    lw t4, 4(t0)        #carrega VAL2
    add t5, t3, t4      #t5 = VAL1 + VAL2
    beq t5, a0, found   #se VAL1 + VAL2 == a0, vai para found
    lw t0, 8(t0)        #carrega o próximo nó
    addi t1, t1, 1      #incrementa o índice
    j loop2              #recomeça o loop

    found:
    //o índice tá em t1
    mv a0, t1   #o índice tá em a0

    li t0, 10   #t0 = 10
    li t1, 100  #t1 = 100
    blt a0, t0, menor_que_10
    blt a0, t1, menor_que_100
    la a1, output
    li a2, 2
    jal convert_to_string
    li t0, '\n'
    la a1, output
    sb t0, 3(a1)
    jal write
    jal exit
    menor_que_10:
    la a1, output
    add a0, a0, '0'
    sb a0, 0(a1)
    li t0, '\n'
    sb t0, 1(a1)
    jal write
    jal exit
    menor_que_100:
    la a1, output
    li a2, 1
    jal convert_to_string
    li t0, '\n'
    la a1, output
    sb t0, 2(a1)
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

   



