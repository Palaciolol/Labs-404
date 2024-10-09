.globl _start               #this one indicates where the programm begins

.section .data
    input:         .space 262159
    col:           .space 3
    linhas:        .space 3
    maxval:        .space 3  
    input_file: .asciz "image.pgm"


.section .text  
.align 2

#Use as input a3 for the amount of bytes to be read
read_file:
    mv a2, a3
    la a1, input
    li a7, 63
    ecall
    ret

exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

set_pixel:
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

close:
    li a0, 3             # file descriptor (fd) 3
    li a7, 57            # syscall close
    ecall
    ret

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

#recebe o endereço que vai salvar os 3 btes em a0
get_bytes:
    addi sp, sp, -4
    sw ra, 0(sp)
    mv t6, a0       #move o endereço que vai salvar os bytes pra t6
    la t5, input    #a1 = endereço do input
    li t1, ' '      #espaço 
    li t2, '\n'     #\n
    li t4, 0        #contadora
    loop:
    li a3, 1    
    mv a0, s1    
    jal read_file
    lb t3, 0(t5)
    beq t3, t1, sai
    beq t3, t2, sai
    sb t3, 0(t6)
    addi t6, t6, 1
    addi t4, t4, 1
    j loop
    sai:
    mv a0, t4
    lw ra, 0(sp)         #pega o valor de ra da pilha
    addi sp, sp, 4       #incrementa sp
    ret

percorre_matriz:
    addi sp, sp, -4
    sw ra, 0(sp)
    li s6, 0        #indice da linha
    la s8, input    #pega o endereço do input
    #s3 guarda o número de linhas e s2 o número de colunas
    linha_loop:
    beq s6, s3, acabou3      #se s6 for igual a s3, termina o loop
    li s7, 0                 #s7 = j (índice da coluna)
    coluna_loop:
    beq s7, s2, proxima_linha   #se s7 (coluna) for igual a s2, pula para a próxima linha
    lbu a1, 0(s8)        #pega o byte e coloca em a1
    jal aplica_filtro    #aplica o filtro
    slli a2, a1, 8       #desloca o gray value (a1) 8 bits para a esquerda para preparar o Blue
    ori a2, a2, 255      #coloca o Alpha no lugar certo (bits 0-7)
    slli t4, a1, 16      #desloca o gray value (a1) 16 bits para a esquerda para preparar o Green
    or a2, a2, t4        #coloca o Blue e Alpha (já preparados) no registro
    slli t5, a1, 24      #desloca o gray value (a1) 24 bits para a esquerda para preparar o Red
    or a2, a2, t5        #coloca Red, Green, Blue e Alpha no registro a2
    mv a0, s7            #coloca o valor da linha em a0
    mv a1, s6            #coloca o valor da coluna em a1
    jal set_pixel        #chama a set_pixel
    addi s7, s7, 1       #incrementa o índice da coluna (j)
    addi s8, s8, 1       #incrementa o ponteiro do input
    j coluna_loop        #volta para o início do loop de coluna
    proxima_linha:
    addi s6, s6, 1       #incrementa o índice da linha (i)
    j linha_loop         #volta para o início do loop de linha
    acabou3:
    lw ra, 0(sp)         #pega o valor de ra da pilha
    addi sp, sp, 4       #incrementa sp
    ret

#s6 --> indice da linha que eu to
#s7 --> indice da coluna que eu to
#s3 --> número total de linhas
#s2 --> número total de colunas
#a1 --> byte lido
#s8 --> endereço do byte lido
aplica_filtro:
    mv t0, s3   #coloca o número de linhas em t0
    mv t1, s2   #coloca o número de colunas em t1
    addi t0, t0, -1     #essa é a condição de borda
    addi t1, t1, -1     #border condition
    li t2, 0            #condição de borda
    beq t2, s6, ta_na_borda
    beq t2, s7, ta_na_borda
    beq t0, s6, ta_na_borda       #confere se eu to na primeira ou ultima linha
    beq t1, s7, ta_na_borda       #primeira ou ultima coluna
    li s5, 0        #s5 guarda a soma de todos em volta
    li t0, 8        #t0 = 8
    mul a1, a1,t0   #a1 = 8a1
    mv t0, s8       #coloca o endereço do byte em t0
    sub t0, t0 ,s2  #subtrai uma largura
    lbu t3, 0(t0)   #carrega o byte acima
    add s5, s5, t3  #junta a soma
    lbu t3, -1(t0)  #carrega o byte à esquerda
    add s5, s5, t3  #junta a soma
    lbu t3, 1(t0)   #carrega o byte à direta
    add s5, s5, t3  #junta a soma
    add t0, t0, s2  #soma a largura
    lbu t3, -1(t0)  #carrega a esquerda
    add s5, s5, t3  #soma
    lbu t3, 1(t0)   #carrega a direta
    add s5, s5, t3  #soma
    add t0, t0, s2  #soma a largura
    lbu t3, 0(t0)   #pega o pixel abaixo
    add s5, s5, t3  #soma
    lbu t3, -1(t0)  #pega a esquerda
    add s5, s5, t3  #soma
    lbu t3, 1(t0)   #pega a direita
    add s5, s5, t3  #soma
    sub a1, a1, s5  #a1 = 8a1 - s5
    li t0, 0
    blt a1, t0, menor_que_zero
    li t0, 255
    bge a1, t0, maior_que_255
    ret
    menor_que_zero:
    li a1, 0
    ret
    maior_que_255:
    li a1, 255
    ret
    ta_na_borda:
    li a1, 0
    ret

_start:
    jal open_file   #abre o arquivo e coloca o file descriptor em a0
    mv s1, a0       #coloca o a0 em s1 porque o a0 vai "sujar"
    li a3, 3        #quantidade de bytes descartáveis apriori
    jal read_file   #le os bytes descartáveis
    la a0, col      #argumeto pra get_bytes
    jal get_bytes   #pega a quant_col e coloca em a1
    mv a2, a0       #argumento de convert
    la a0, col      #argumento de convert
    li a1, 0        #arg de convert
    jal convert_to_number   #chama a função
    mv s2, a0       #coloca a quant_col em s2
    la a0, linhas   #argumento pra get_3bytes
    jal get_bytes   #pega a quant_linhas e coloca em a1  
    la a0, linhas   #arg de convert
    li a1, 0        #arg de convet
    mv a2, t4       #arg de convert
    jal convert_to_number   #chama a função
    mv s3, a0       #coloca a quant_linhas em s3
    li a3, 4        #bytes pra ler o maxval
    mv a0, s1       #garante que o a0 vai estar certo
    jal read_file   #le o maxval
    jal set_canvas_size #seta o tamanho do canvas
    mul a3, s3, s2      #a3 = total de bytes
    mv a0, s1       #garante
    jal read_file
    jal percorre_matriz #chama a função
    jal close       #chama função
    jal exit        #chama função

