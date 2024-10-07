.globl _start               #this one indicates where the programm begins

.section .data
    input:   .space 14
    largura: .space 3
    altura:  .space 3
    maxval:  .space 3  

.section .text
.align 2

#Use as input t0 for the amount of bytes to be read
read_file:
    mv a2, t0
    la a1, input
    li a7, 63
    ecall
    ret

#Function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, output1          #buffer
    li a2, 8                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall


set_pixel:
    li a0, 100 # x coordinate = 100
    li a1, 200 # y coordinate = 200
    li a2, 0xFFFFFFFF # white pixel
    li a7, 2200 # syscall setPixel (2200)
    ecall
    ret

set_canvas_size:
    mv a0, s2
    mv a1, s3
    li a7, 2201
    ecall 
    ret

open_file:
    la a0, input_file    # address for the file path
    li a1, 0             # flags (0: rdonly, 1: wronly, 2: rdwr)
    li a2, 0             # mode
    li a7, 1024          # syscall open
    ecall
    ret

input_file: .asciz "image.pgm"



close:
    li a0, 3             # file descriptor (fd) 3
    li a7, 57            # syscall close
    ecall
    ret

input_file: .asciz "image.pgm"


#a0 --> endereço da string
#a1 --> variável que vai guardar o valor do número em decimal
convert_to_number:
    li t0, 0        #variavél de laço iniciada em 0
    li t3, 4
    li t4 ,10
    //add t1, a0, t0  #t1 = endereço base da string(a0) + t0(variável contadora)
    laco:
        beq t0, t3, acabou      #confere se já leu os 4 números
        mul a1, a1, t4          #multiplica a1 por 10 e salva em a1
        lb t2, 0(a0)            #t2 = valor da memória da string no endereço t1
        addi t2, t2, -'0'       #converte t2 para valor numérico
        add a1, a1, t2          #a1 = t2 - '0'
        addi a0, a0, 1           
        addi t0, t0, 1          #incrementa a variável de laço
        j laco                 #salta pro laço de novo
    acabou:
        ret                     #retorna pra main


get_width:
    addi sp, sp, -4 #decremeta o sp pra abrir espaço na pilha
    sw ra, 0(sp)    #salva o endereço de retorno na pilha   
    li t0, 1        #t0 = 1
    li t4, ' '      #t4 = ' '
    jal read_file   #le um byte
    la t1, input    #pega o endereço de input
    la t2, largura  #pega o endereço de largura
    lbu t3, 0(t1)   #carrega o valor lido em t3
    sb t3, 0(t2)    #coloca t3 em largura
    jal read_file   #chama a read
    lbu t3, 0(t1)   #pega o valor lido
    beq t3, t4, acabou
    sb t3, 1(t2)    #como é um número, coloca esse número em largura
    jal read_file   #chama a read
    lbu t3, 0(t1)   #pega o valor lido
    beq t3, t4, acabou
    sb t3, 2(t2)    #é um número, então coloca ele em largura

    acabou:
    la a0, largura
    li a1, 0
    jal convert_to_number
    lw ra, 0(sp)    #pega o valor de ra da pilha
    addi sp, sp, 4  #incrementa sp
    ret

get_height:
    addi sp, sp, -4 #decremeta o sp pra abrir espaço na pilha
    sw ra, 0(sp)    #salva o endereço de retorno na pilha   
    li t0, 1        #t0 = 1
    jal read_file   #consome o espaço em branco
    li t4, ' '      #t4 = ' '
    jal read_file   #le um byte
    la t1, input    #pega o endereço de input
    la t2, altura  #pega o endereço de largura
    lbu t3, 0(t1)   #carrega o valor lido em t3
    sb t3, 0(t2)    #coloca t3 em largura
    jal read_file   #chama a read
    lbu t3, 0(t1)   #pega o valor lido
    beq t3, t4, acabou
    sb t3, 1(t2)    #como é um número, coloca esse número em largura
    jal read_file   #chama a read
    lbu t3, 0(t1)   #pega o valor lido
    beq t3, t4, acabou
    sb t3, 2(t2)    #é um número, então coloca ele em largura

    acabou:
    la a0, altura
    li a1, 0
    jal convert_to_number
    li t0, 1
    jal read_file   #consome o \n
    lw ra, 0(sp)    #pega o valor de ra da pilha
    addi sp, sp, 4  #incrementa sp
    ret


percorre_matriz:
    addi sp, sp, -4
    sw ra, 0(sp)
    li t0, 0
    #s3 guarda o número de linhas e s2 o número de colunas
    linha_loop:
    beq t0, s3, acabou          # Se t0 (linha) for igual a s3 (tamanho), termina o loop

    li t1, 0                 # t1 = j (índice da coluna)

    coluna_loop:
    beq t1, s2, proxima_linha # Se t2 (coluna) for igual a s2, pula para a próxima linha
    jal set_pixel


    

    addi t1, t1, 2           # Incrementa o índice da coluna (j)
    j coluna_loop            # Volta para o início do loop de coluna

    proxima_linha:
    # Incrementa a linha e reinicia o loop de colunas
    addi t0, t0, 1           # Incrementa o índice da linha (i)
    j linha_loop             # Volta para o início do loop de linha









    acabou:
    lw ra, 0(sp)    #pega o valor de ra da pilha
    addi sp, sp, 4  #incrementa sp

_start:
    jal open_file   #abre o arquivo e coloca o file descriptor em a0
    mv s1, a0       #coloca o a0 em s1 porque o a0 vai "sujar"
    li t0, 14       #quantidade de bytes descartáveis apriori
    jal read_file   #le os bytes descartáveis
    jal get_width
    mv s2, a1       #coloca a largura em s2
    jal get_height
    mv s3, a1       #coloca a altura em s3
    li t0, 4
    jal read_file   #le o maxval
    li s4, 255      #coloca o maxval em s4
    jal percorre_matriz
    jal set_canvas_size
    jal close
    jal exit
    //agr sim posso ler a matriz

