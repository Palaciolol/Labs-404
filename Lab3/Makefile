lab3.s: lab3.c
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab3.c -S -o lab3.s

lab3.o: lab3.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab3.s -c -o lab3.o

prog.x: lab3.o 
	ld.lld lab3.o -o prog.x




