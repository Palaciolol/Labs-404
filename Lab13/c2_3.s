.globl fill_array_int, fill_array_short, fill_array_char               

.section .text
.align 2


fill_array_int:
    addi sp, sp, -404   #aloca espaço na pilha
    sw ra, 400(sp)
    mv t2, sp           #coloca o endereço de sp em t2
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sw t0, 0(t2)    #salva t0, na pilha
        addi t2, t2, 4  #incrementa a stack
        addi t0, t0, 1  #incrementa t0
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    mv a0, sp
    jal mystery_function_int    #chama a mystery
    lw ra, 400(sp)            #carrega o ra
    addi sp, sp, 404
    ret                     #retorna 

fill_array_short:
    addi sp, sp, -204   #aloca espaço na pilha
    sw ra, 200(sp)        #coloca o ra na pilha
    mv t2, sp           #coloca o endereço de sp em t2
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sh t0, 0(t2)    #salva t0, na pilha
        addi t2, t2, 2  #incrementa a stack
        addi t0, t0, 1  #incrementa t0
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    mv a0, sp
    jal mystery_function_short    #chama a mystery
    lw ra, 200(sp)            #carrega o ra
    addi sp, sp, 204
    ret    


fill_array_char:
    addi sp, sp, -104
    sw ra, 100(sp)        #coloca o ra na pilha
    mv t2, sp           #coloca o endereço de sp em t2
    li t0, 0            #inicia variável de laço
    li t1, 100          #inicia variável de fim de laço
    1:
        bge t0, t1, 1f  #se t0 >= t1, fim  
        sb t0, 0(t2)    #salva t0, na pilha
        addi t0, t0, 1  #incrementa t0
        addi t2, t2, 1  #incrementa a stack
        j 1b            #continua o loop
    1:
    #tenho que chamar a mystery com o adress do array em a0
    mv a0, sp
    jal mystery_function_char    #chama a mystery
    lw ra, 100(sp)            #carrega o ra
    addi sp, sp, 104
    ret    


