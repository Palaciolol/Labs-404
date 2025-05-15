lab12.o: lab12.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab12.s -c -o lab12.o

lab12.x: lab12.o 
	ld.lld lab12.o -o lab12.x