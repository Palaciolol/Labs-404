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

unsigned convert_to_number(char *string){
    int num = 0;
    for (int i = 1; string[i] != '\0'; i++){
        if (string[i] >= '0' && string[i] <= '9') {
            num = num * 10 + (string[i] - '0');
        }
    }
    if(string[0] == '-'){
      num = num * -1;
    }
    return num;
}

void slice(char* input, int start, int end, char* string){
  int i = 0,j;
  for (j = 0, i = start; i <= end; i++, j++){
    string[j] = input[i];
  }
  string[j] = '\0';
}

void hex_code(int val){
    char hex[11];
    unsigned int uval = (unsigned int) val, aux;

    hex[0] = '0';
    hex[1] = 'x';
    hex[10] = '\n';

    for (int i = 9; i > 1; i--){
        aux = uval % 16;
        if (aux >= 10)
            hex[i] = aux - 10 + 'A';
        else
            hex[i] = aux + '0';
        uval = uval / 16;
    }
    write(1, hex, 11);
}


int main(){
    char input[30];
    int n = read(STDIN_FD, input, 30);
    char str1[6], str2[6] ,str3[6], str4[6], str5[6];
    slice(input, 0, 4, str1);
    slice(input, 6, 10, str2);
    slice(input, 12, 16, str3);
    slice(input, 18, 22, str4);
    slice(input, 24, 28, str5);

    unsigned result = 0;
    unsigned x = convert_to_number(str1);
    x = x << 29;
    x = x >> 29;
    result = result | x;

    x = convert_to_number(str2);
    x = x << 24;
    x = x >> 21;
    result = result | x;

    x = convert_to_number(str3);
    x = x << 27;
    x = x >> 16;
    result = result |  x;

    x = convert_to_number(str4);
    x = x << 27;
    x = x >> 11;
    result = result | x;

    x = convert_to_number(str5);
    x = x << 21;
    result = result | x;

    hex_code(result);

    return 0;
}




void _start()
{
  int ret_code = main();
  exit(ret_code);
}


