.globl operation              

.section .text
.align 2


#a0 --> int a
#a1 --> int b
#a2 --> short c
#a3 --> short d
#a4 --> char e 
#a5 --> char f
#a5 --> int g
#a7 --> int h
#0(sp) --> char i 
#4(sp) --> char j
#8(sp) --> short k
#12(sp) --> short l
#16(sp) --> int m
#20(sp) --> int n
operation:
    lw t1, 8(sp)    #carrega o k em t1
    lw t2, 16(sp)   #carrega o m em t2
    add t3, a1, a2  #b+c
    sub t3, t3, a5  #b+c-f
    add t3, t3, a7  #b+c-f+h
    add t3, t3, t1  #b+c-f+h+k
    sub t3, t3, t2  #b+c-f+h+k-m
    mv a0, t3
    ret
