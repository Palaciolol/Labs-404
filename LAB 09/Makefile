lab9.o: lab9.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab9.s -c -o lab9.o

lab9.x: lab9.o 
	ld.lld lab9.o -o lab9.x