.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input:        .space 400  #número a ser lido

.section .text
.align 2


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

SUM1:
    add a0, a0, a1
    ret

mystery_function:
    ret



#a0 --> first value
#a1 --> second value 
#a2 --> third value
my_function:
    addi sp, sp, -16
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)
    jal SUM1
    #a0 tá com o valor de SUM1 agora
    lw t0, 4(sp)            #carrega o valor inicial de a0 da pilha
    mv a1, t0               #move esse valor pra a1
    #chama a mystery_function, com a0 sendo a soma de a0 e a1, e a1 sendo o a0 inicial
    jal mystery_function
    #acho que vc supõe que o retorno da mystery ta em a0 e faz as coisas, mas ta estranho
    lw t0, 8(sp)            #carrega o valor de a1 da pilha
    sub t0, t0, a0          #t0 = a1 - retorno da mystery
    add t0, t0, a2          #não mudei a2 até agr, então aux tá calculado em t0

    mv a0, t0               #coloca o valor de aux em a0 pra chamar a mystery
    lw a1, 8(sp)            #carrega o valor de a1 da pilha
    jal mystery_function    #chama a mystery
    sub a2, a2, a0          #supõe que o retorno da mystery tá em a0
    add a2, a2, t0          #t0 ainda tá com o valor de aux
    mv a0, a2
    lw ra, 0(sp)
    ret


_start:
    jal my_function
    jal exit
