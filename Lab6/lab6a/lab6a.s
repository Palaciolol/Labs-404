.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input_address: .space 20  #buffer
    string:        .space 4   #string que vai guardar os números
    output_adress: .space 20  #output 


.section .text
.align 2

read: 
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input_address    #buffer to read the data
    li a2, 20               #size (reads only 5 bytes)
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


//function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output_adress            #buffer
    li a2, 20                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

/*


void convert_to_string(unsigned int  num, char* string) {
    int i = 0;
    if (num < 0){
      num = num * -1;
    }
    if (num == 0) {
        string[i++] = '0';
    } else {
        while (num > 0) {
            string[i++] = (num % 10) + '0';
            num /= 10;
        }
    }
    string[i] = '\0';  // Adiciona o caractere nulo
}
*/
#a0 --> esse registrador guarda o valor da raiz quadrada
#a1 --> endereço da string
#a2 --> valor de onde eu vou começar a por os valores
convert_to_string:
    li t0, 0        #variável de fim de laço
    li t1, 0        #variável contadora
    li t2, 10       #variável que guarda o valor 10
    li t5, 5        #variável que guarda o valor 4
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

#a0 --> número que será calculada a raiz quadrada
calculate_sqrt:
    li t0, 0        #variável de laço
    li t1, 10       #variável de fim de laço
    li t2, 2        #variável que guarda o 2
    divu t3, a0, t2         #divide o número por 2 e salva em t3(k)
    while:
        beq t0, t1, fim         #confere se chegou o fim do laço 
        divu t4, a0, t3         #divide o número por t3(y/k)    
        add t3, t3, t4          #t3 recebe ele mesmo + t4(que é a divisão do número por t3)
        divu t5, t3, t2         #t5(variável final) recebe t3 dividido por 2(k')
        addi t0, t0 ,1
        mv t3, t5               #copia o valor de t5 pra a0
        j while
    fim:
        ret
_start:                 
    jal read          
    //passo a passo pra esse código
    //1- dá slice na string   OKKKKKK PORRAAAAAA
    //0-4, 5-9, 10- 14, 15-19
    li a0 , 0
    li a1 , 4
    la t0, input_address
    la t1, string
    jal slice_string

    //2- converte isso pra número  OKKKKK EU ACHOOOOO
    la a0, string
    li a1, 0
    jal convert_to_number
    

    //3- calcula a raiz disso       OKKKKKKKK EU ACHOOO
    //o valor do número em decimal tá em a1
    mv a0, a1       
    jal calculate_sqrt


    //4- transforma em string de novo colocando no vetor de char
    //o valor da raiz quadrada ta em a0
    mv a0, t3
    la a1, output_adress               #o endereço de string tá em a1 agr
    li a2, 3                    #endereço que é pra eu começar a escrever os números de trás pra frente
    jal convert_to_string       #chama a função de converter pra string
    ///////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////

    li a0 , 5
    li a1 , 9
    la t0, input_address
    la t1, string
    jal slice_string

    //2- converte isso pra número  OKKKKK EU ACHOOOOO
    la a0, string
    li a1, 0
    jal convert_to_number
    

    //3- calcula a raiz disso       OKKKKKKKK EU ACHOOO
    //o valor do número em decimal tá em a1
    mv a0, a1       
    jal calculate_sqrt


    //4- transforma em string de novo colocando no vetor de char
    //o valor da raiz quadrada ta em a0
    mv a0, t3
    la a1, output_adress               #o endereço de string tá em a1 agr
    li a2, 8                    #endereço que é pra eu começar a escrever os números de trás pra frente
    jal convert_to_string       #chama a função de converter pra string
    ////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////
    li a0 , 10
    li a1 , 14
    la t0, input_address
    la t1, string
    jal slice_string

    //2- converte isso pra número  OKKKKK EU ACHOOOOO
    la a0, string
    li a1, 0
    jal convert_to_number
    

    //3- calcula a raiz disso       OKKKKKKKK EU ACHOOO
    //o valor do número em decimal tá em a1
    mv a0, a1       
    jal calculate_sqrt


    //4- transforma em string de novo colocando no vetor de char
    //o valor da raiz quadrada ta em a0
    mv a0, t3
    la a1, output_adress               #o endereço de string tá em a1 agr
    li a2, 13                    #endereço que é pra eu começar a escrever os números de trás pra frente
    jal convert_to_string       #chama a função de converter pra string
    /////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////
    li a0 , 15
    li a1 , 19
    la t0, input_address
    la t1, string
    jal slice_string

    //2- converte isso pra número  OKKKKK EU ACHOOOOO
    la a0, string
    li a1, 0
    jal convert_to_number
    

    //3- calcula a raiz disso       OKKKKKKKK EU ACHOOO
    //o valor do número em decimal tá em a1
    mv a0, a1       
    jal calculate_sqrt


    //4- transforma em string de novo colocando no vetor de char
    //o valor da raiz quadrada ta em a0
    mv a0, t3
    la a1, output_adress               #o endereço de string tá em a1 agr
    li a2, 18                    #endereço que é pra eu começar a escrever os números de trás pra frente
    jal convert_to_string       #chama a função de converter pra string

    la a1, output_adress               #o endereço de string tá em a1 agr
    li t0, ' '
    sb t0, 4(a1)
    sb t0, 9(a1)
    sb t0, 14(a1)
    li t0, '\n'
    sb t0, 19(a1)
    jal write
    jal exit


    






    