.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 13  #bits que vão ser codificados
    subset1:       .space 3  #subset teste(d1d2d4)
    subset2:       .space 3  #subset teste(d1d3d4)
    subset3:       .space 3  #subset teste(d2d3d4)
    output1:       .space 8  #input1 codificado 
    output2:       .space 5  #input2 decodificado 
    result:        .space 2  #caracte 1 ou 0 do resultado da decodificação

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
    la a1, output1          #buffer
    li a2, 8                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 

write2:
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output2          #buffer
    li a2, 5                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


write3:
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, result            #buffer
    li a2, 2                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

#a0 --> quantidade de 1 na substring, começa com 0
#a1 --> endereço da substring
#a2 --> endereço do output1
count_ones:
    li t0, 0    #variável contadora
    li t1, 3    #variável de fim de laço
    li t4, 0
    laco: 
        beq t0, t1, end     #confere se já percorreu a string toda
        add t2, a1, t0      #t2 = endereço base do input(a1) + t0
        lb t3, 0(t2)        #pega o valor da memória e coloca em t3
        addi t3, t3, -'0'   #converte t3 pra valor numérico
        beq t3, t4, aux     #se o valor na posição for 0, chama aux
        addi t0,t0 , 1      #incrementa variável contadora
        addi a0, a0, 1      #incremeta a quantidade de 1
        j laco
    aux:
        addi t0, t0, 1      #incrementa a variável contadora
        j laco              #pula pro laço
    end:
        ret                 #retorna pra main

#a0 --> quantidade de 1 no subset
#a2 --> endereço do output
set_p:
    li t1, 1
    bne a0, t1, check_again     #se a0 não for 1, checa se ele é 3
    li t2, 1                    #p recebe 1
    ret
    check_again:
        li t1, 3                #temp1 recebe 3
        bne a0, t1,its_zero     #se ele não for 3, então o parity bit é zero
        li t2, 1                #p recebe 1
        ret                     #retorna pra main

    its_zero:
        li t2, 0                #p recebe 0
        ret                     #retorna pra main

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

#a0 -->endereço do input
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

#a0 --> endereço do input
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
    lb t0, 3(a0)        #pega o p3
    addi t0, t0, -'0'  #transforma ele em número

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
    li a0, 5
    jal read
    
    la a0, input   #salva em a0 o endereço de começo do input
    la a1, subset1 #salva em a1 o endereço de começo do subset1
    lb t0, 0(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t0
    lb t1, 1(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t1
    lb t2, 3(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t2

    //agr eu quero pegar desse registrador e colocar na memória
    sb t0, 0(a1)    #pega o valor do registrador t0 e coloca na primeira posição do subset
    sb t1, 1(a1)    #pega o valor do registrador t1 e coloca na segunda posição do subset
    sb t2, 2(a1)    #pega o valor do registrador t2 e coloca na terceira posição do subset
    
    ///////////////////////////////////////////////////

    la a1, subset2 #salva em a1 o endereço do começo do subset2
    lb t0, 0(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t0
    lb t1, 2(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t1
    lb t2, 3(a0)   #pega o valor da primeiro posição que eu quero do input e coloca no registrador t2

    sb t0, 0(a1)    #pega o valor do registrador t0 e coloca na primeira posição do subset
    sb t1, 1(a1)    #pega o valor do registrador t1 e coloca na segunda posição do subset
    sb t2, 2(a1)    #pega o valor do registrador t2 e coloca na terceira posição do subset

    ///////////////////////////////////////////////////////////////////////////////////////////

    la a1, subset3 #salva em a1 o endereço do começo do subset3 
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
    addi t2, t2,'0'
    sb t2, 0(a2)    #coloca o p na posição correta
    /////////////
    li a0, 0        #quantidade de 1 na substring
    la a1, subset2  #endereço do subset1
    la a2, output1  #endereço do output1
    jal count_ones  #função que conta a quantidade de 1 no subset e guarda isso em a0
    jal set_p       #função que retorna se o parity bit é 1 ou 0 e guarda isso em t2
    addi t2, t2,'0'
    sb t2, 1(a2)    #coloca o p na posição correta
    //////////////
    li a0, 0        #quantidade de 1 na substring
    la a1, subset3  #endereço do subset1
    la a2, output1  #endereço do output1
    jal count_ones  #função que conta a quantidade de 1 no subset e guarda isso em a0
    jal set_p       #função que retorna se o parity bit é 1 ou 0 e guarda isso em t2
    addi t2, t2,'0'
    sb t2, 3(a2)    #coloca o p na posição correta
    //////////////////////////////////////
    la a0, input
    la a1, output1
    jal set_data_in_output
    la a1, output1
    li t0, '\n'
    sb t0, 7(a1)
    
    
    /////////////////////////////////////////////////////////////
    //SEGUNDA PARTE DO LAB
    li a0, 8
    jal read
    la a0, input
    la a1, output2
    jal grab_data
    li t0, '\n'
    la a1, output2
    sb t0, 4(a1)

    la a0, input
    la a1, output2
    li a2, 1
    jal first_check
    beq t0, a2,finaliza
    jal second_check
    beq t0, a2, finaliza
    jal third_check
    beq t0, a2, finaliza


    la a0, result
    li t0, '0'
    sb t0, 0(a0)
    li t1, '\n'
    sb t1, 1(a0)
    jal write
    jal write2
    jal write3 //imprime o 0 pq deu certo
    jal exit

    finaliza:
        la a0, result
        li t0, '1'
        sb t0, 0(a0)
        li t1, '\n'
        sb t1, 1(a0)
        jal write
        jal write2
        jal write3 //imprime o 1 pq deu erro
        jal exit 

    

    
    

    


