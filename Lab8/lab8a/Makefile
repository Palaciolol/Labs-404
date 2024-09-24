lab8a.o: lab8a.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab8a.s -c -o lab8a.o

lab8a.x: lab8a.o 
	ld.lld lab8a.o -o lab8a.x