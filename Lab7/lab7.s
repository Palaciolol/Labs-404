.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input1:        .space 5  #bits que vão ser codificados
    input2:        .space 8  #7 bits que vão ser decodificados
    output1:       .space 7  #input1 codificado 
    output2:       .space 5  #input2 decodificado 
    subset1:       .space 3  #subset teste(d1d2d4)
    subset2:       .space 3  #subset teste(d1d3d4)
    subset3:       .space 3  #subset teste(d2d3d4)
    result:        .space 1  #caracte 1 ou 0 do resultado da decodificação

.section .text
.align 2

read: 
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input2           #buffer to read the data
    li a2, 8                #size (reads only 5 bytes)
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


//function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output2          #buffer
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
    laco2:
        beq t0, t3, acabou      #confere se já leu os 4 números
        mul a1, a1, t4          #multiplica a1 por 10 e salva em a1
        add t1, a0, t0          #t1 = endereço base da string(a0) + t0(variável contadora)
        lb t2, 0(t1)            #t2 = valor da memória da string no endereço t1
        addi t2, t2, -'0'       #converte t2 para valor numérico
        add a1, a1, t2          #a1 = t2 - '0'
        addi t0, t0, 1          #incrementa a variável de laço
        j laco2                 #salta pro laço de novo
    acabou:
        ret                     #retorna pra main


#a0 --> quantidade de 1 na substring, começa com 0
#a1 --> endereço da substring
count_ones:
    li t0, 0    #variável contadora
    li t1, 3    #variável de fim de laço
    li t4, 0
    laco: 
        beq t0, t1, end #confere se já percorreu a string toda
        add t2, a1, t0 #t2 = endereço base do input(a1) + t0
        lb t3, 0(t2)    #pega o valor da memória e coloca em t3
        addi t3, t3, -'0'   #converte t3 pra valor numérico
        beq t3, t4, aux
        addi t0,t0 , 1
        addi a0, a0, 1
        j laco
    aux:
        addi t0, t0, 1
        j laco
    end:
        ret

#a0 --> quantidade de 1 no subset
#a2 --> endereço do output
set_p:
    li t1, 1
    bne a0, t1, check_again     #se a0 não for 1, checa se ele é 3
    li t2, 1
    ret
    check_again:
        li t1, 3                #temp1 recebe 3
        bne a0, t1,its_zero     #se ele não for 3, então o parity bit é zero
        li t2, 1
        ret

    its_zero:
        li t2, 0
        ret

#a0 -->endereço do input
#a1 -->endereço do output
set_data_in_output:
    lb t1, 0(a0)
    sb t1, 2(a1)

    lb t1, 1(a0)
    sb t1, 4(a1)

    lb t1, 2(a0)
    sb t1, 5(a1)

    lb t1, 3(a0)
    sb t1, 6(a1)
    ret

#a0 -->endereço do input2
#a1 -->endereço do output2
grab_data:
    lb t0, 2(a0)
    sb t0, 0(a1)

    lb t0, 4(a0)
    sb t0, 1(a1)

    lb t0, 5(a0)
    sb t0, 2(a1)

    lb t0, 6(a0)
    sb t0, 3(a1)
    ret

#a0 --> endereço do input2
#a1 --> endereço do output2
first_check:
    #pro p1
    lb t0, 0(a0)        #pega o p1
    addi t0, t0, -'0'   #transforma ele em número

    lb t1, 0(a1)        #pega o d1
    addi t1, t1, -'0'   #transforma ele em número

    lb t2, 1(a1)        #pega o d2
    addi t2, t2, -'0'   #transforma ele em número

    lb t3, 3(a1)        #pega o d4
    addi t3, t3, -'0'   #transforma ele em número

    xor t0, t0, t1      #operação xor
    xor t0, t0, t2      #operação xor
    xor t0, t0, t3      #operação xor

    ret


#a0 --> endereço do input2
#a1 --> endereço do output2
second_check:
    #pro p2
    li a2, 0
    lb t0, 1(a0)        #pega o p2
    addi t0, t0, -'0'   #transforma ele em número

    lb t1, 0(a1)        #pega o d1
    addi t1, t1, -'0'   #transforma ele em número

    lb t2, 2(a1)        #pega o d3
    addi t2, t2, -'0'   #transforma ele em número

    lb t3, 3(a1)        #pega o d4
    addi t3, t3, -'0'   #transforma ele em número

    xor t0, t0, t1      #operação xor
    xor t0, t0, t2      #operação xor
    xor t0, t0, t3      #operação xor

    ret



#a0 --> endereço do input2
#a1 --> endereço do output2
third_check:
    #pro p3
    li a2, 0
    lb t0, 3(a0)        #pega o p3
    addi t0, t0, -'0'   #transforma ele em número

    lb t1, 1(a1)        #pega o d2
    addi t1, t1, -'0'   #transforma ele em número

    lb t2, 2(a1)        #pega o d3
    addi t2, t2, -'0'   #transforma ele em número

    lb t3, 3(a1)        #pega o d4
    addi t3, t3, -'0'   #transforma ele em número

    xor t0, t0, t1      #operação xor
    xor t0, t0, t2      #operação xor
    xor t0, t0, t3      #operação xor

    ret



_start: 
    jal read
    /*
    la a0, input1   #salva em a0 o endereço de começo do input
    la a1, subset1  #salva em a1 o endereço de começo do subset1

    lb t0, 0(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t0
    lb t1, 1(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t1
    lb t2, 3(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t2

    //agr eu quero pegar desse registrador e colocar na memória
    sb t0, 0(a1)    #pega o valor do registrador t0 e coloca na primeira posição do subset
    sb t1, 1(a1)    #pega o valor do registrador t1 e coloca na segunda posição do subset
    sb t2, 2(a1)    #pega o valor do registrador t2 e coloca na terceira posição do subset
    
    ///////////////////////////////////////////////////

    la a1, subset2  
    lb t0, 0(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t0
    lb t1, 2(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t1
    lb t2, 3(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t2

    sb t0, 0(a1)    #pega o valor do registrador t0 e coloca na primeira posição do subset
    sb t1, 1(a1)    #pega o valor do registrador t1 e coloca na segunda posição do subset
    sb t2, 2(a1)    #pega o valor do registrador t2 e coloca na terceira posição do subset
    
    ///////////////////////////////////////////////////////////////////////////////////////////

    la a1, subset3  
    lb t0, 1(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t0
    lb t1, 2(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t1
    lb t2, 3(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t2

    //agr eu quero pegar desse registrador e colocar na memória
    sb t0, 0(a1)    #pega o valor do registrador t0 e coloca na primeira posição do subset
    sb t1, 1(a1)    #pega o valor do registrador t1 e coloca na segunda posição do subset
    sb t2, 2(a1)    #pega o valor do registrador t2 e coloca na terceira posição do subset
    

    ////////////////////////////////
    li a0, 0        #quantidade de 1 na substring
    la a1, subset1  #endereço do subset1
    la a2, output1  #endereço do output1
    jal count_ones  #função que conta a quantidade de 1 no subset e guarda isso em a0
    jal set_p       #função que retorna se o parity bit é 1 ou 0 e guarda isso em t2
    sb t2, 0(a2)    #coloca o p na posição correta
    /////////////
    li a0, 0        #quantidade de 1 na substring
    la a1, subset1  #endereço do subset1
    jal count_ones  #função que conta a quantidade de 1 no subset e guarda isso em a0
    jal set_p       #função que retorna se o parity bit é 1 ou 0 e guarda isso em t2
    sb t2, 1(a2)    #coloca o p na posição correta
    //////////////
    li a0, 0        #quantidade de 1 na substring
    la a1, subset1  #endereço do subset1
    jal count_ones  #função que conta a quantidade de 1 no subset e guarda isso em a0
    jal set_p       #função que retorna se o parity bit é 1 ou 0 e guarda isso em t2
    sb t2, 3(a2)    #coloca o p na posição correta
    //////////////////////////////////////
    la a0, input1
    la a1, output1
    jal set_data_in_output
    */
    
    /////////////////////////////////////////////////////////////
    //SEGUNDA PARTE DO LAB
    la a0, input2
    la a1, output2
    jal grab_data
    li a2, 1
    jal first_check
    beq t0, a2,finaliza
    jal second_check
    beq t0, a2, finaliza
    jal third_check
    beq t0, a2, finaliza

    jal write //imprime a decodificação
    jal write //imprime o 0 pq deu certo
    jal exit

    finaliza:
        jal write //imprime a decodificação
        jal write //imprime o 1 pq deu erro
        jal exit 

    

    
    

    

