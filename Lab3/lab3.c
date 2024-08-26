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



#define STDIN_FD  0
#define STDOUT_FD 1


void decimal_to_binary(int decimal, char* binary){
    int i = 0;
    while (decimal != 0){
        int quo = decimal/2;
        int r = decimal % 2;
        decimal = quo;
        binary[i] = r;
        i++;
    }
    while (i != 32){
      binary[i] = 0;
      i++;
    }

}

void decimal_to_hexa(int decimal, char* hexa){
    int i = 0;
    while (decimal != 0){
        int quo = decimal/16;
        int r = decimal % 16;
        if (r == 10){
          hexa[i] = 'A';
        }
        else if (r == 11){
          hexa[i] = 'B';
        }
        else if (r == 12){
          hexa[i] = 'C';
        }
        else if (r == 13){
          hexa[i] = 'D';
        }
        else if (r == 14){
          hexa[i] = 'E';
        }
        else if (r == 15){
          hexa[i] = 'F';
        }
        else{
          hexa[i] = r;
        }
        decimal = quo;
        i++;
    }
    
}

int string_lenght(char* string){
  int cont = 0;
  while (string[cont] != '\0'){ //Esse while serve para contar quantos caracteres a palavra procurada tem.
        cont++; 
    }
  return cont;
}

void invert_string(char* string, char* invertida){
    int i = 0,tam = 0;
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


void convert_to_string(int num, char* string, char* invertida){
  int i = 0;
  int temp = num;
  while (temp > 0){
    string[i] = (temp % 10) + '0';
    i++;
  }
  string[i] = '\0';
  invert_string(string, invertida);
}

void escrever_binario(char* final, int count, char* removed_zeros_binary){
  final[0] = '0';
  final[1] = 'b';
  for (int i = 0; i < count; i++){
    final[i + 2] = removed_zeros_binary[i];
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

void swap_endianness(char* binary, char* binary_endian_swap){
  char first_8_bits[7];
  char second_8_bits[7];
  char third_8_bits[7];
  char fourth_8_bits[7];
  for (int i = 0; i <= 31; i++){
    if (i <= 7){
      first_8_bits[i] = binary[i];
    }
    else if (8 <= i && i <= 15){
      second_8_bits[i] = binary[i];
    }
    else if (16 <= i && i <= 23){
      third_8_bits[i] = binary[i];
    }
    else if (24 <= i && i <= 31){
      fourth_8_bits[i] = binary[i];
    }
  }

  for (int i = 0; i <= 31; i++){
    if (i <= 7){
      binary_endian_swap[i] = fourth_8_bits[i];
    }
    else if (8 <= i && i <= 15){
      binary_endian_swap[i] = third_8_bits[i];
    }
    else if (16 <= i && i <= 23){
      binary_endian_swap[i] = second_8_bits[i];
    }
    else if (24 <= i && i <= 31){
      binary_endian_swap[i] = first_8_bits[i];
    }
  }
  
}
void remove_zeros(char* old_char, char* new_char){
  int find_first_1 = 0; 
  for (int i = 0; i <= 31; i++){
    if (find_first_1 == 0){
      if (old_char[i] == '1'){
        find_first_1 = 1;
      }
    }
    else{
      new_char[i] = old_char[i];
    }
  }
}



int binary_to_decimal(char* binary){
  int sum = 0;
  int value = string_lenght(binary) -1;
  for (int i = 0; i < value; i++){
    sum = (binary[i] - '0') * 2 * (value - i);
    
  }
  return sum;
}


int main()
{
    
  char input[20];
  int n = read(STDIN_FD, input, 20);
  /*
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
    */
  //caso que recebo um número positivo
  int num = convert_to_number(input);  //converto a string pra número
  char* binary_inverted; //char que armazena o binário invertido
  decimal_to_binary(num, binary_inverted); //coloco esse número em uma string de binário
  char* binary; //char que armazena o binário 
  invert_string(binary_inverted, binary); //inverto essa string de binário
  char* removed_zeros_binary;
  remove_zeros(binary, removed_zeros_binary);

  int count = string_lenght(removed_zeros_binary);
  char*final;
  escrever_binario(final, count, removed_zeros_binary);
  count = count + 2;
  char* hexa;
  decimal_to_hexa(num, hexa);
  char* hexa_inverted ;
  invert_string(hexa_inverted, hexa);
  int count2 = string_lenght(hexa);
  char*final2;
  escrever_hexa(final2, count2, hexa);
  count2 = count + 2;
  int count3 = string_lenght(input);  

  char* binary_endian_swap;
  char* binary_endian_swap_removed_zeros;
  swap_endianness(binary, binary_endian_swap);

  remove_zeros(binary_endian_swap, binary_endian_swap_removed_zeros);
  int sum = binary_to_decimal(binary_endian_swap_removed_zeros);
  char* string;
  char* invertida;
  convert_to_string(sum, string, invertida);

  int count4 = string_lenght(invertida);

  write(STDOUT_FD, final, count); //em binário
  write(STDOUT_FD, input, count3); //o próprio número em decimal
  write(STDOUT_FD, final2, count2);  //em hexadecimal
  write(STDOUT_FD, invertida, count4);  //em decimal bugado
  


  
  return 0;


}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}