lab8b.o: lab8b.s
	clang --target=riscv32 -march=rv32g -mabi=ilp32d -mno-relax lab8b.s -c -o lab8b.o

lab8b.x: lab8b.o 
	ld.lld lab8b.o -o lab8b.x