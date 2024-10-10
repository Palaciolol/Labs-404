.section .bss
    buffer: .skip 400

.section .text

.globl exit
exit:
    /*
        input: a0: valor de saida
    */
    addi a7, zero, 93 
    ecall

.globl linked_list_search
linked_list_search:
    /*
        input:
            a0: recebe o ponteiro da struct
            a1: o valor esperado da soma
        output:
            a0: o valor (int) da saida do programa
    */

    addi sp, sp, -16
    sw ra, 0(sp)

    add a2, zero, zero #a2: cont

1: #laço
    beq a0, zero, 2f
        
        lw t0, 0(a0)
        lw t1, 4(a0)
        add t0, t0, t1 #soma de var1 e var2

        beq t0, a1, 1f #somaNo == somaEsperada: acabo o codigo

        addi a2, a2, 1 #cont++
        lw a0, 8(a0) #atualizo o ponteiro

    j 1b #volto no laço

2:
    addi a2, zero, -1 #a2 o contador passa a ser -1
1:
    add a0, zero, a2 

    lw ra, 0(sp)
    addi sp, sp, 16
    ret

strlen:
    /*
        OBS: A string tem que ter um '\n' no final

        input:
            a0: o endereço do inicio da string
        output:
            a0: o tamanho da string
    */
    add a1, zero, zero #a1: contador
    addi a2, zero, '\n' #o limite do for

1: #for
    lb t0, 0(a0)
    beq t0, a2, 1f # achei o fim
    addi a0, a0, 1 #pego o proximo elemento do vetor
    addi a1, a1, 1 #contador++
    j 1b
1:
    add a0, zero, a1
    ret

.globl atoi
atoi:
    /*
        input:
            a0: o endereço da string
        output:
            a0: o valor convertido
    */
    addi sp, sp, -16 # aloco no pilha
    sw ra, 12(sp)
    sw a0, 8(sp) # salvo a0

    jal strlen
    lw a1, 8(sp) # endereco da string
    addi t0, zero, '-'
    lb t1, 0 (a1)
    bne t0, t1, 2f # str[0] != '-': pulo para 2f
    add a1, a1, a0
    addi a1, a1, -1 # somo o tamanho da string e subtraio um para começar do fim
    addi a2, zero, 1 # defino a potencia da base
    add a3, zero, a0 # movo o tamanho pra a3
    addi a3, a3, -1 #  limite do for
    add a4, zero, zero # int i = 0
    add a0, zero, zero # int n = 0
    addi a5, zero, 1 # o numero é negativo
    j 1f

2:
    add a1, a1, a0
    addi a1, a1, -1 # somo o tamanho da string e subtraio um para começar do fim
    addi a2, zero, 1 # defino a potencia da base
    add a3, zero, a0 #  limite do for
    add a4, zero, zero # int i = 0
    add a0, zero, zero # int n = 0
    add a5, zero, zero # o numero é positivo


1:
    beq a3, a4, 1f # i == tamanho da string: acabo o codigo
    lb t0, 0(a1)
    addi t0, t0, -48
    mul t0, t0, a2
    add a0, a0, t0 #somo o digito

    li t0, 10     # atualizo a potencia
    mul a2, a2, t0

    addi a1, a1, -1 # ponteiro--
    addi a4, a4, 1 #i++
    j 1b
1:
    beq a5, zero, 1f
    addi t0, zero, -1
    mul a0, a0, t0

1:
    lw ra, 12(sp)
    addi sp, sp, 16 #desaloco no pilha
    ret

nDigitos:
    /*
        input: 
            a0: int que desejo saber quantos bytes ele oculparia sendo um char
            a1: a base
        
        output:
            a0: tamanho
    */
    bne a0, zero, 1f
    addi a0, zero, 2
    ret

1:
    blt a0, zero, 2f #é negativa, preciso de um byte para o sinal
    add a2, zero, a1 #base
    add a1, zero, zero #contador
    j 1f #pulo para o começo do for
2:
    add a2, zero, a1 #base
    add a1, zero, zero #contador

1: #começo do for
    beq a0, zero, 1f
    div a0, a0, a2 #int=int/10
    addi a1, a1, 1
    j 1b
1:
    addi a0, a1, 1 #movo para a saida
    ret

.globl itoa
itoa:
    /*
        input:
            a0: o valor a ser convertido
            a1: o endereço da string onde irei salvar
            a2: a base
        output:
            void
    */
    addi sp, sp, -16 #aloco no pilha
    sw ra, 12(sp)
    sw a0, 8(sp)
    sw a1, 4(sp)
    sw a2, 0(sp)
    
    mv a1, a2
    jal nDigitos
    add a3, zero, a0 #possui o tamanho que será oculpado com o '\n'
    lw a0, 8(sp)
    lw a1, 4(sp)
    lw a2, 0(sp)

    bge a0, zero, 2f #ajusto o '-', se o numero for negativo
    addi t0, zero, '-'
    sb t0, 0(a1) #ajusto o primeiro byte para '-'
    addi t0, zero, -1
    mul a0, a0, t0 #deixo o numero positivo
    addi a1, a1, 1

2:
    add a1, a1, a3 #  irei preencher de trás para frente
    addi a1, a1, -1 #volto um byte
    addi t0, zero, '\n'
    sb t0, 0(a1) #ajusto o ultimo para '\n'
    addi a1, a1, -1 #volto um byte
    add a3, zero, a2 # "int base = 10"

1: # laço
    rem t1, a0, a3 # t1= a0 % a3
    div a0, a0, a3 # a0 = a0/a3 e a0
    addi t0, zero, 10
    bge t1, t0, 2f
    addi t1, t1, 48 #  transformo em "char"
    j 3f

2:
    addi t1, t1, 55 #  transformo em "char"

3:
    sb t1, 0(a1) # armazeno o resto da divisão

    addi a1, a1, -1 # volto um no char
    beq a0, zero, 1f #acabei o numero
    j 1b #else volta no laço

1:
    lw ra, 12(sp) 
    lw a0, 4(sp) #pego onde a str está salva
    addi sp, sp, 16 #desaloco no pilha
    ret

.globl puts
puts:
    /*
            input:
            a0: endereço que deve mandar pra saida
        output:
            void
    */
    addi sp, sp, -16 #aloco no pilha
    sw ra, 0(sp)

    addi a1, zero, 1     #size
    addi a2, zero, '\n' #o limite do for
    add a3, zero, a0

1: #for
    lb t0, 0(a3)
    beq t0, a2, 1f # achei o fim
    addi a3, a3, 1 #atualizo o vetor
    addi a1, a1, 1 #atualizo o tamaho
    j 1b
1:

    #write
    mv a2, a1           #size
    mv a1, a0           # buffer
    li a0, 1            # file descriptor = 1 (stdout)
    li a7, 64           # syscall write (64)
    ecall
    #______________________


    lw ra, 0(sp)
    addi sp, sp, 16 #desaloco no pilha
    ret
   

.globl gets
gets:
     /*
        input:
            a0: o endereço do vetor
    */
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)

    addi a3, zero, '\n' # salvo para economizar instrução
    add  a1, zero, a0   # ponteiro

1:  
    li a0, 0            # fd input
    # a1 já possui um endereço
    li a2, 1            # size (reads 1 byte)
    li a7, 63           # syscall rea d (63)
    ecall

    lb t0, 0(a1)
    addi a1, a1, 1 # ajusto o ponterio
    bne t0, a3, 1b #str[lido] != '\n'

    lw ra, 0(sp)
    lw a0, 4(sp)
    addi sp, sp, 16 # desaloco no pilha
    ret