.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:     .space 20  #buffer
    Yb:        .space 4   #ordenada de b
    Xc:        .space 4   #absissa de c
    time:      .space 4   #tempo geral
    timeR:     .space 4   #Tr
    output:    .space 12  #output

.section .text
.align 2

read: 
    mv a2, a0
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input           #buffer to read the data
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


//function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output          #buffer
    li a2, 12               #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


#a0 --> esse registrador guarda o valor do número a ser convertido
#a1 --> endereço da string
#a2 --> valor de onde eu vou começar a por os valores
convert_to_string:
    li t0, 0        #variável de fim de laço
    li t1, 0        #variável contadora
    li t2, 10       #variável que guarda o valor 10
    li t5, 4        #variável que guarda o valor 4
    //add t4, a1, a2  #t4 = endereço base da string(a1) + a2(onde eu devo começar a por os valores) - t1(variável contadora)
    add a1, a1, a2
    laco3:
        beq a0, t0, complete_zeros        #confere se o número já é igual a zero(fim do laço)
        remu t3, a0, t2         #pega o resto da divisão por 10
        //sub t4, t4, t1          #t4 = endereço base da string(a1) - t1
        add t3, t3 , '0'        #t3 recebe ele mesmo mais o caractere 0 pra transformar em string
        sb t3, 0(a1)            #coloco esse byte na posição correta da string
        addi t1, t1, 1          #incrementa a variável contadora
        addi a1, a1, -1
        divu a0, a0, t2         #a0 recebe ele mesmo dividido por 10
        j laco3                 #pula pro laço de novo
     complete_zeros:
        beq t1,t5 ,fim3         # if t0 <= t1 then target
        addi t1, t1, 1          #incrementa a variável contadora
        li t6 , 0
        add t6, t6, '0'
        sb t6, 0(a1)
        addi a1, a1, -1
        j complete_zeros
    fim3:
        ret




#a0 --> endereço da string
#a1 --> variável que vai guardar o valor do número em decimal
convert_to_number:
    li t0, 0        #variavél de laço iniciada em 0
    li t3, 4
    li t4 ,10
    //add t1, a0, t0  #t1 = endereço base da string(a0) + t0(variável contadora)
    laco2:
        beq t0, t3, acabou      #confere se já leu os 4 números
        mul a1, a1, t4          #multiplica a1 por 10 e salva em a1
        lb t2, 0(a0)            #t2 = valor da memória da string no endereço t1
        addi t2, t2, -'0'       #converte t2 para valor numérico
        add a1, a1, t2          #a1 = t2 - '0'
        addi a0,a0,1           
        addi t0, t0, 1          #incrementa a variável de laço
        j laco2                 #salta pro laço de novo
    acabou:
        ret                     #retorna pra main



#a0 --> número que representa a posição inicial do corte da string
#a1 --> número que representa a final do corte da string
#t0 --> variável temporária que aponta pra posição inicial que eu quero do input
#t1 --> variável temporária que aponta pra posição inicial da string onde eu quero salvar as coisas
slice_string:       #função pra dar slice na string
    li t2, 0        #esse é o meu i
    li t3, 0        #esse é o meu j
    mv t2, a0       #setando o valor de i como start
    laco1:
        beq t2, a1, finish          #confere se o i já incrementou até chegar no final
        add t4, t0, t2              #t4 = endereço base de input(t0) + t2(variável contadora)
        lb t5, 0(t4)                #pega o valor da memória e coloca num registrador
        add t6, t1, t3              #t6 = endereço base da string(t1) + t3(variável contadora)
        sb t5, 0(t6)                #coloca o byte na porra da string
        addi t2, t2, 1              #incrementa o t2
        addi t3, t3, 1              #incrementa o t3
        j laco1                     #jumpa pro laço
    finish:
        ret

negative_number_y:
    li t2, -1
    la t0, output
    li t1, '-'
    sb t1, 6(t0)
    mul s8, s8, t2
    j check_positive_or_neg_x

negative_number_x:
    li t2, -1
    la t0, output
    li t1, '-'
    sb t1, 0(t0)
    mul s9, s9, t2
    j continuation_here
    

calculate_y:
    li t1, 2
    mul t0, s1, s1 #t0 = Yb²
    add t0, t0, s5 #t0 = t0 + Da²
    sub t0, t0, s6 #t0 = t0 - Db²
    div t0, t0, t1
    div t0, t0, s1
    ret


calculate_x:
    li t1, 2
    mul t0, s2, s2 #t0 = Xc²
    add t0, t0, s5 #t0 = t0 + Da²
    sub t0, t0, s7 #t0 = t0 - Dc²
    div t0, t0, t1
    div t0, t0, s2
    ret

positive_number_x:
    la t0, output
    li t1, '+'
    sb t1, 0(t0)
    j continuation_here

positive_number_y:
    la t0, output
    li t1, '+'
    sb t1, 6(t0)
    j check_positive_or_neg_x

check_positive_or_neg_y:
    li t0, 0
    blt s8, t0, negative_number_y
    jal positive_number_y

check_positive_or_neg_x:
    li t0, 0
    blt s9, t0, negative_number_x
    jal positive_number_x



_start: 
    li a0, 12   #argumento do read
    jal read    #chama a read
    li a0, 1    #de onde o input vai começar a ser cortado
    li a1, 5    #fim do corte do input
    la t0, input    #endereço do input
    la t1, Yb       #endereço onde eu vou salvar o corte do input
    jal slice_string    #finalmente chama a slice string
    la a0, Yb       #argumento 
    li a1, 0        #argumento
    jal convert_to_number   #chama a função
    la t0, input    #pega o endereço do input
    lb t1, 0(t0)    #pega o primeiro byte do input
    li t2, '-'      #negativo
    bne t1, t2, positive_number
    li t2, -1
    mul a1, a1, t2
    positive_number:
    #no final disso aq, o a1 tem o valor de Yb
    #que eu vou passsar pra s1 pra guardar 
    mv s1, a1 #s1 = Yb(COM SINAL)
    //////////////////////////////////////////
    li a0, 7    #posição start do slice
    li a1, 11   #final do slice
    la t0, input    #argumento do slice
    la t1, Xc       #argumento do slice
    jal slice_string    #slice
    la a0, Xc   #argumento do convert_to_number
    li a1, 0    #convert_to_number
    jal convert_to_number
    la t0, input    
    lb t1, 6(t0)
    li t2, '-'
    bne t1, t2, positive_number2
    li t2, -1
    mul a1, a1, t2
    positive_number2:
    mv s2, a1 #s2 = Xc (COM SINAL)
    //////////////////////////////////////////
    li a0, 20
    jal read
    li a0, 0
    li a1, 4
    la t0, input
    la t1, time
    jal slice_string
    la a0, time
    li a1, 0
    jal convert_to_number
    mv s3, a1 #COLOCA O TEMPO DE A em S3
    //////////////////////////////////////////////
    li a0, 15
    li a1, 19
    la t0, input
    la t1, timeR
    jal slice_string
    la a0, timeR
    li a1, 0
    jal convert_to_number
    mv s4, a1   #COLOCA O TEMPO DE R EM S4
    sub t1, s4, s3
    li t0, 3
    mul s5, t0, t1
    li t0, 10
    div s5, s5, t0 #s5 GUARDA O VALOR DE D-a
    ///////////////////////////////////////////////////
    li a0, 5
    li a1, 9
    la t0, input
    la t1, time
    jal slice_string
    la a0, time
    li a1, 0
    jal convert_to_number
    mv s3, a1 #COLOCA O TEMPO DE B em S3
    sub t1, s4, s3
    li t0, 3
    mul s6, t0, t1
    li t0, 10
    div s6, s6, t0 #s5 GUARDA O VALOR DE D-b
    //////////////////////////////////////////////////
    li a0, 10
    li a1, 14
    la t0, input
    la t1, time
    jal slice_string
    la a0, time
    li a1, 0
    jal convert_to_number
    mv s3, a1 #COLOCA O TEMPO DE C em S3
    sub t1, s4, s3
    li t0, 3
    mul s7, t0, t1
    li t0, 10
    div s7, s7, t0 #s5 GUARDA O VALOR DE D-c
    #agr eu tenho tudo, só jogar na fórmula
    mul s5, s5, s5      #FAZENDO a distância de A ao quadrado
    mul s6, s6, s6      #FAZENDO a distância de B ao quadrado
    mul s7, s7, s7      #Fazendo a distância de C ao quadrado
    ////////////////////////////////////////////////
    jal calculate_y     #retorna o valor de y em t0
    mv s8, t0           #salva valor de y em s8(COM SINAL)
    jal calculate_x     #retorna o valor de x em t0
    mv s9, t0           #salva valor de x em s9(COM SINAL)
    jal check_positive_or_neg_y
    continuation_here:
        mv a0, s8
        la a1, output
        li a2, 10
        jal convert_to_string
        ////////////////////////////
        mv a0, s9
        la a1, output
        li a2, 4
        jal convert_to_string
        ///////////////////////
        la t0, output
        li t1, ' '
        sb t1, 5(t0)
        li t1, '\n'
        sb t1, 11(t0)
        jal write
        jal exit

