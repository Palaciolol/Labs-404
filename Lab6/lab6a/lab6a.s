.globl _start               #this one indicates where the programm begins

//function to read data from standart input
.section .data
    input_address: .space 20  #buffer
    output_adress: .space 20  #output 


.section .text
.align 2

read: 
    li a0, 0                #file descriptor = 0 (stdin)
    la a1, input_address    #buffer to read the data
    li a2, 20                #size (reads only 5 bytes)
    li a7, 63               #syscall read (63)
    ecall
    ret                     #retorno da função


//function to write data on the standart output
write: 
    li a0, 1                #file descriptor = 1 (stdout)
    la a1, input_address    #buffer
    li a2, 20                #size
    li a7, 64               #syscall write (64)
    ecall
    ret                     #retorno da função 


exit:
    li a0, 0           #isso daqui é pra finalizar o programa
    li a7, 93          #syscall de exit
    ecall

/*
int convert_to_number(char *string){
    int num = 0;
    for (int i = 0; string[i] != '\0'; i++){
        if (string[i] >= '0' && string[i] <= '9') {
            num = num * 10 + (string[i] - '0');
        }
    }
    return num;
}
*/

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

/*
convert_to_number:
    li t1, 0                    #temp que vai armazenar o valor do número em decimal
    lw t2, 0(input_address)     #temp que vai armazenar começo da string
    laco:
        beq t2, ' ', acabou 
        mul t3, t1, 10
        add t2, t2, -'0'
        add t1, t2, t3
        addi input_address, input_address, 1

    acabou:
        ret

convert_to_string:
    #nada por ora


void slice(char* input, int start, int end, char* string){
  int i = 0,j;
  for (j = 0, i = start; i <= end; i++, j++){
    string[j] = input[i];
  }
  string[j] = '\0';
}
*/


_start:                 #this is where the programm begins
    jal read           #chamada da função read
    jal write          #chamada da função write
    //passo a passo pra esse código
    //1- dá slice na string
    //2- converte isso pra número
    //3- calcula a raiz disso
    //4- transforma em string de novo colocando no vetor de char
    //5- faz isso 4 vezes 
    jal exit
    






    