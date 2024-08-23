int read(int __fd, const void *__buf, int __n){
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall write code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)  // Output list
    : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
  __asm__ __volatile__(
    "mv a0, %0           # file descriptor\n"
    "mv a1, %1           # buffer \n"
    "mv a2, %2           # size \n"
    "li a7, 64           # syscall write (64) \n"
    "ecall"
    :   // Output list
    :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
}

void exit(int code)
{
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}

#define STDIN_FD  0
#define STDOUT_FD 1


void decimal_to_binary(int decimal, char* binary){
    char binary[33];
    int i = 0;
    while (decimal > 2){
        int quo = decimal/2;
        int r = decimal % 2;
        decimal = quo;
        binary[i] = r;
        i++;
    }
    if (decimal == 2){
        binary[i] = 0;
    }
    else{
        binary[i] = 1;
    }
    
}

void decimal_to_hexa(int decimal, char* hexa){
    char hexa[33];
    int i = 0;
    while (decimal > 16){
        int quo = decimal/16;
        int r = decimal % 16;
        decimal = quo;
        hexa[i] = r;
        i++;
    }
    if (decimal == 16){
        hexa[i] = 0;
    }
    else{
        hexa[i] = 1;
    }
    
}

char* hexa_to_decimal(int hexa){
    
}

int string_lenght(char* string){
  int cont = 0;
  while (string[cont] != '\0'){ //Esse while serve para contar quantas letras a palavra procurada tem.
        cont++; 
    }
  return cont;
}

void invert_string(char* string, char* invertida){
    int i = 0, j = 0, tam = 0;
    char invertida[33];
    int quant = string_lenght(string);
    tam = quant;
    for (i = 0; i < quant; i++){
        invertida[i] = string[tam-1];
        tam--;
    }
    invertida[i] = '\0';
    
}

int convert_to_number(char *string){
    int num = 0;
    for (int i = 0; i < 20; i++){
      num = num * 10 + (string[i] - '0');
    }
    
    return num;
}


void convert_to_string(int num){
  char* string =  ' ';
  int i = 0;
  int temp = num;
  while (temp > 0){
    string[i] = (temp % 10) + '0';
    i++;
  }
  string[i] = '\0';
  char* string_invertida;
  invert_string(string, string_invertida);
}

void escrever_binario(char* final, int count, char* binary_inverted){
  final[0] = '0';
  final[1] = 'b';
  for (int i = 0; i < count; i++){
    final[2 + i] = binary_inverted[i];
  }
}

void escrever_hexa(char* final, int count, char* hexa_inverted){
  final[0] = '0';
  final[1] = 'x';
  for (int i = 0; i < count; i++){
    final[2 + i] = hexa_inverted[i];
  }
}

void rewrite_hexa(char* input, int count){
  for (int i = 0; i < count - 2 ; i++){
    input[i] = input[i+2];
  }
}

int main()
{
    
  char input[20];
  int n = read(STDIN_FD, input, 20);
  char first_caracter = input[0];
  
  if (input[1] == 'x'){
    //caso que recebo um número hexadecimal
    int count = string_lenght(input);
    int hexa = convert_to_number(input);
    char* hexa; 
    hexa_to_decimal(hexa);
    int decimal = convert_to_number(hexa);
    char* xx;
    //decimal_to_binary(decimal);
    write(STDOUT_FD, hexa, 33); //em binário
    write(STDOUT_FD, hexa, 33); //o próprio número em decimal
    write(STDOUT_FD, hexa, 33);  //em hexadecimal
    write(STDOUT_FD, hexa, 33);  //em decimal bugado
  }
  else if (input[0] == '-'){
    //caso que recebo um número negativo 
    int num = 0;
    write(STDOUT_FD, num, 33); //em binário
    write(STDOUT_FD, num, 33); //o próprio número em decimal
    write(STDOUT_FD, num, 33);  //em hexadecimal
    write(STDOUT_FD, num, 33);  //em decimal bugado
  }

  else{
    //caso que recebo um número positivo
    int num = convert_to_number(input);  //converto a string pra número
    char* binary; //char que armazena o binário invertido
    decimal_to_binary(num, binary); //coloco esse número em uma string de binário
    char* binary_inverted; //char que armazena o binário 
    invert_string(binary, binary_inverted); //inverto essa string de binário
    int count = string_lenght(binary_inverted);
    char*final;
    escrever_binario(final, count, binary_inverted);
    count = count + 2;
    char* hexa;
    decimal_to_hexa(num, hexa);
    char* hexa_inverted ;
    invert_string(hexa, hexa_inverted);
    int count2 = string_lenght(hexa_inverted);
    char*final2;
    escrever_hexa(final2, count2, hexa_inverted);
    count2 = count + 2;
    int count3 = string_lenght(input);
    write(STDOUT_FD, final, count); //em binário
    write(STDOUT_FD, num, count3); //o próprio número em decimal
    write(STDOUT_FD, final2, count2);  //em hexadecimal
    //write(STDOUT_FD, num, 33);  //em decimal bugado
  }
  
  return 0;


}
