.globl fill_array_int, fill_array_short, fill_array_char               

.section .text
.align 2


fill_array_int:
    addi sp, sp, -4
    sw ra, 0(sp)        #coloca o ra na pilha
    mv t2, sp           #coloca o endereço de sp em t2
    addi sp, sp, -416   #aloca espaço na pilha
    mv a0, sp
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sw t0, 0(sp)    #salva t0, na pilha
        addi t0, t0, 1  #incrementa t0
        addi sp, sp, 4  #incrementa a stack
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    jal mystery_function_int    #chama a mystery
    mv sp, t2               #recupera o sp
    lw ra, 0(sp)            #carrega o ra
    ret                     #retorna 

fill_array_short:
    sw ra, 0(sp)        #coloca o ra na pilha
    mv t2, sp           #coloca o endereço de sp em t2
    addi sp, sp, -216   #aloca espaço na pilha
    mv a0, sp
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sw t0, 0(sp)    #salva t0, na pilha
        addi t0, t0, 1  #incrementa t0
        addi sp, sp, 2  #incrementa a stack
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    jal mystery_function_short    #chama a mystery
    mv sp, t2               #recupera o sp
    lw ra, 0(sp)            #carrega o ra
    ret    


fill_array_char:
    sw ra, 0(sp)        #coloca o ra na pilha
    mv t2, sp           #coloca o endereço de sp em t2
    addi sp, sp, -112   #aloca espaço na pilha
    mv a0, sp
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sw t0, 0(sp)    #salva t0, na pilha
        addi t0, t0, 1  #incrementa t0
        addi sp, sp, 1  #incrementa a stack
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    jal mystery_function_char    #chama a mystery
    mv sp, t2               #recupera o sp
    lw ra, 0(sp)            #carrega o ra
    addi sp, sp, 4
    ret    


