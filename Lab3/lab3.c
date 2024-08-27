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
  final[count + 3] = '\n';
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
  for (int i = 0; i <= value; i++){
    int result_exponencial = calculate_pot(2, value - i);
    sum += (binary[i] - '0') * result_exponencial;
    
  }
  return sum;
}

int hexa_to_decimal(char* hexa){
  int sum = 0;
  int value = string_lenght(hexa) -2;
  for (int i = 0; i < value; i++){
    char current_char = hexa[i + 2];
    int current_value;
    if (current_char >= '0' && current_char <= '9'){
      current_value = current_char - '0';
    }
    else if (current_char >= 'A' && current_char <= 'F'){
      current_value = current_char - 'A' + 10;
    }
    else if (current_char >= 'a' && current_char <= 'f'){
      current_value = current_char - 'a' + 10;
    }
  int result_exponencial = calculate_pot(16, value - 1 -i);
    sum += current_value * result_exponencial;
  }
  return sum;
}

int calculate_pot(int base, int exponent){
  int result = 1;
  for (int i = 0; i < exponent; i++){
    result *= base;
  }
  return result;
}

void invert_bits(char* inverted_bits, char* binary){
  for (int i = 0; i < string_lenght(binary); i++){
    if (binary[i] == '0'){
      inverted_bits[i] = '1';
    }
    else{
      inverted_bits[i] = '0';
    }
  }
}

char check(int sum){
  if (sum >= 0 && sum <= 9){
    return sum + '0';
  }
  else if (sum == 10){
    return 'a';
  }
  else if (sum == 11){
    return 'b';
  }
  else if (sum == 12){
    return 'c';
  }
  else if (sum == 13){
    return 'd';
  }
  else if (sum == 14){
    return 'e';
  }
  else if (sum == 15){
    return 'f';
  }
  return ' ';
}

void clean_string(char* string){
  for (int i = 0; i < string_lenght(string); i++){
    string[i] = 0;
  }
}

void binary_to_hexa(char* binary, char* hexa){
  hexa[0] = '0';
  hexa[1] = 'x';
  char aux[3];
  int j = 1;
  for(int i = 0; i < string_lenght(binary); i++){
      aux[i] = binary[i];
      if (j % 4 == 0){
        hexa[j + 2] = check(binary_to_decimal(aux));
        clean_string(aux);
      }
      j++;
  }

}

void complete_zeros(char* binary){
  int count = string_lenght(binary);
  for (int i = string_lenght(binary); i < 31; i++){
    binary[i] = 0;
  }
}


int main()
{
    
  char input[20];
  int n = read(STDIN_FD, input, 20);
  
  if (input[1] == 'x'){
    //caso que recebo um número hexadecimal
    int count = string_lenght(input);
    int decimal = hexa_to_decimal(input);
    char* binary_inverted;
    decimal_to_binary(decimal, binary_inverted);
    char* binary;
    invert_string(binary_inverted, binary);
    char* removed_zeros_binary;
    remove_zeros(binary, removed_zeros_binary);
    int count = string_lenght(removed_zeros_binary);
    char*final;
    escrever_binario(final, count, removed_zeros_binary);
    count = count + 3;
    write(STDOUT_FD, final, count); //em binário


    ////////////////////////////////
    if (removed_zeros_binary[0] = '1'){
      char* string;
      char* invertida;
      convert_to_string(decimal, string, invertida);
      for (int i = 0; i < string_lenght(string); i++){
        string[i+1] = string[i];
      }
      string[0] = '-';
      int count2 = string_lenght(string);
      write(STDOUT_FD, string, count2); //em decimal
    }
    else{
      char* string;
      char* invertida;
      convert_to_string(decimal, string, invertida);
      int count2 = string_lenght(string);
      write(STDOUT_FD, string, count2); //em decimal
    }
    ///////////////////////////////

    write(STDOUT_FD, input, count); //em hexa

    ///////////////////////////////

    char* binary_endian_swap;
    char* binary_endian_swap_removed_zeros;
    swap_endianness(binary, binary_endian_swap);

    remove_zeros(binary_endian_swap, binary_endian_swap_removed_zeros);
    int sum = binary_to_decimal(binary_endian_swap_removed_zeros);
    char* string;
    char* invertida;
    convert_to_string(sum, string, invertida);

    int count4 = string_lenght(invertida);
    write(STDOUT_FD, invertida, count4);  //em decimal bugado


    
  }
  else if (input[0] == '-'){
    //caso que recebo um número negativo 
    int count = string_lenght(input);
    write(STDOUT_FD, input, count); //em decimal
    char* aux;
    for (int i = 0; i < count; i++){
      aux[i] = input[1+i]; 
    }
    int decimal = convert_to_number(aux);
    decimal -= 1;
    char* binary_inverted;
    decimal_to_binary(decimal, binary_inverted);
    char* binary;
    invert_string(binary_inverted, binary);
    char* removed_zeros_binary;
    remove_zeros(binary, removed_zeros_binary);
    char* inverted_bits;
    invert_bits(inverted_bits, removed_zeros_binary);
    int count = string_lenght(inverted_bits);
    char*final;
    escrever_binario(final, count, inverted_bits);
    count = count + 3;
    write(STDOUT_FD, final, count); //em binário

    ///////////////////////////////////
    
    write(STDOUT_FD, input, count);

    ///////////////////////////////////

    char* hexa;
    binary_to_hexa(inverted_bits, hexa);
    write(STDOUT_FD, hexa, string_lenght(hexa));
    
    ///////////////////////////////////

    char* invertida;
    invert_string(inverted_bits, invertida);
    complete_zeros(invertida);

    char* invertida_certo;
    invert_string(invertida, invertida_certo);

    char* binary_endian_swap;
    char* binary_endian_swap_removed_zeros;
    swap_endianness(invertida_certo, binary_endian_swap);

    remove_zeros(binary_endian_swap, binary_endian_swap_removed_zeros);
    int sum = binary_to_decimal(binary_endian_swap_removed_zeros);
    char* string;
    char* invertida2;
    convert_to_string(sum, string, invertida2);

    write(STDOUT_FD, invertida2, string_lenght(invertida2));

  }

  else{
  
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
  count = count + 3;
  escrever_binario(final, count, removed_zeros_binary);
  char* hexa;
  decimal_to_hexa(num, hexa);
  char* hexa_inverted ;
  invert_string(hexa_inverted, hexa);
  int count2 = string_lenght(hexa);
  char*final2;
  escrever_hexa(final2, count2, hexa);
  count2 = count + 3;
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
  }


  
  return 0;


}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}