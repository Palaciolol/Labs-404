# Testing Code for Exercise 8.1.1
    .globl _start
    _start:
       la t5, my_var
       lw t6, 0(t5)
       li t5, 10
       bne t5, t6, __test_fail_initial_value
       li s0, 0xABCDEFAB
       li s1, 0xABCDEFAB
       li s2, 0xABCDEFAB
       li s3, 0xABCDEFAB
       li s4, 0xABCDEFAB
       li s5, 0xABCDEFAB
       li s6, 0xABCDEFAB
       li s7, 0xABCDEFAB
       li s8, 0xABCDEFAB
       li s9, 0xABCDEFAB
       li s10, 0xABCDEFAB
       li s11, 0xABCDEFAB
       li sp, 0x7FFFFFC 
       jal increment_my_var
       li t0, 0xABCDEFAB
       bne s0, t0, __test_fail_callee_save
       bne s1, t0, __test_fail_callee_save
       bne s2, t0, __test_fail_callee_save
       bne s3, t0, __test_fail_callee_save
       bne s4, t0, __test_fail_callee_save
       bne s5, t0, __test_fail_callee_save
       bne s7, t0, __test_fail_callee_save
       bne s8, t0, __test_fail_callee_save
       bne s9, t0, __test_fail_callee_save
       bne s10, t0, __test_fail_callee_save
       bne s11, t0, __test_fail_callee_save
       li t0, 0x7FFFFFC
       bne sp, t0, __test_fail_callee_save
       la t5, my_var
       lw t6, 0(t5)
       li t5, 11
       bne t5, t6, __test_fail_increment
       jal increment_my_var
jal increment_my_var
jal increment_my_var

       la t5, my_var
       lw t6, 0(t5)
       li t5, 14
       bne t5, t6, __test_fail_increment
       li t1, 1
       li t2, 1
       li t3, 1
       j __after_check
    __test_fail_initial_value:
       li t1, 0
       li t2, 1
       li t3, 1
       j __after_check
    __test_fail_callee_save:
       li t2, 0
       li t1, 1
       li t3, 1
       j __after_check
    __test_fail_increment:
       li t3, 0
       li t1, 1
       li t2, 1
       j __after_check
    __after_check:
      li a0, 0
      li a7, 93
      ecall 
    