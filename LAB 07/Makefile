lab7.o: lab7.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab7.s -c -o lab7.o

lab7.x: lab7.o 
	ld.lld lab7.o -o lab7.x