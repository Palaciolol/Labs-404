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


void decimal_to_binary(unsigned int decimal, char* binary){
    int i = 0;
    while (decimal != 0){
        int quo = decimal/2;
        int r = decimal % 2;
        decimal = quo;
        binary[i] = r + '0';
        i++;
    }
    while (i < 32){
      binary[i] = '0';
      i++;
    }
    binary[32] = '\0';
}

void decimal_to_hexa(unsigned decimal, char* hexa){
    int i = 0;
    int remainder;
    char temp;
    char hex_digits[] = "0123456789abcdef";

    if (decimal == 0) {
        hexa[i++] = '0';
        return;
    }
    // Armazena os dígitos hexadecimais em ordem reversa
    while (decimal != 0) {
        remainder = decimal % 16;
        hexa[i++] = hex_digits[remainder];
        decimal = decimal / 16;
    }
    hexa[i] = '\0';
}

int strlen(char* string){
  int cont = 0;
  while (string[cont] != '\0'){ //Esse while serve para contar quantos caracteres a palavra procurada tem.
        cont++; 
    }
  return cont;
}

void invert_string(char* string, char* invertida){
    int quant = strlen(string);
    int i;
    for (i = 0; i < quant; i++){
      invertida[i] = string[quant -1 - i];
    }
    invertida[quant] = '\0';
}

int convert_to_number(char *string){
    int num = 0;
    for (int i = 0; string[i] != '\0'; i++){
        if (string[i] >= '0' && string[i] <= '9') {
            num = num * 10 + (string[i] - '0');
        }
    }
    return num;
}

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

void swap_endianness(char* binary, char* binary_endian_swap) {
    for (int i = 0; i < 32; i += 8) {
        for (int j = 0; j < 8; j++) {
            binary_endian_swap[i + j] = binary[31 - i - 7 + j];
        }
    }
    binary_endian_swap[32] = '\0';
}


void remove_zeros(char* old_char, char* new_char) {
    int i = 0, j = 0;
    // Encontrar o primeiro '1' na string binária
    while (old_char[i] == '0' && i < 32) {
        i++;
    }
    // Copiar a parte restante da string binária para new_char
    while (i < 32) {
        new_char[j++] = old_char[i++];
    }
    // Se todos os bits eram zeros, colocar '0' na string
    if (j == 0) {
        new_char[j++] = '0';
    }
    new_char[j] = '\0';
}

int calculate_pot(int base, int exponent){
  int result = 1;
  for (int i = 0; i < exponent; i++){
    result *= base;
  }
  return result;
}

int binary_to_decimal(char* binary){
  int sum = 0;
  int value = strlen(binary);
  for (int i = 0; i < value; i++){
    int result_exponencial = calculate_pot(2, value - i -1);
    sum += (binary[i] - '0') * result_exponencial;
  }
  return sum;
}

int hexa_to_decimal(char* hexa){
  int sum = 0;
  int value = strlen(hexa);
  for (int i = 2; i < value; i++){
    char current_char = hexa[i];
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

void print(char* string, int flag){
  if (flag == 0){
    write(STDOUT_FD, "0b", 2);

  }
  else if (flag == 1){
    write(STDOUT_FD, "0x", 2);

  }
  write(STDOUT_FD, string, strlen(string)); //em binário
  write(STDOUT_FD, "\n", 1);
}

int main()
{
    
  char input[20];
  int n = read(STDIN_FD, input, 20);
  int decimal;
  if (input[1] == 'x'){
    //caso que recebo um número hexadecimal
    int decimal = hexa_to_decimal(input); //converto o número hexa pra decimal
  }
  else{
    int decimal = convert_to_number(input); //convert to decimal
  }
  if (input[0] == '-'){
    decimal = decimal * -1;
  }
  char binary[33];
  decimal_to_binary(decimal, binary); //converto ele pra binário
  char inverted_string[33];
  invert_string(binary, inverted_string); //inverto o binário
  remove_zeros(inverted_string, binary); //removo os zeros
  

  char decimal_string[33];
  convert_to_string(decimal, decimal_string);
  char decimal_inverted[33];
  invert_string(decimal_string, decimal_inverted);

  char binary_swapped[33];
  swap_endianness(inverted_string, binary_swapped);
  remove_zeros(binary_swapped, binary);
  int sum = binary_to_decimal(binary);
  char decimal_string2[33];
  convert_to_string(sum, decimal_string2);
  char decimal_inverted2[33];
  invert_string(decimal_string2, decimal_inverted2);
  

  return 0;
}
void _start()
{
  int ret_code = main();
  exit(ret_code);
}
