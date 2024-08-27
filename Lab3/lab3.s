	.text
	.attribute	4, 16
	.attribute	5, "rv32i2p1_m2p0_a2p1_f2p2_d2p2_zicsr2p0_zifencei2p0"
	.file	"lab3.c"
	.globl	read                            # -- Begin function read
	.p2align	2
	.type	read,@function
read:                                   # @read
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 63	# syscall write code (63) 
	ecall	# invoke syscall 
	mv	a3, a0	# move return value to ret_val

	#NO_APP
	sw	a3, -28(s0)                     # 4-byte Folded Spill
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	sw	a0, -24(s0)
	lw	a0, -24(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end0:
	.size	read, .Lfunc_end0-read
                                        # -- End function
	.globl	write                           # -- Begin function write
	.p2align	2
	.type	write,@function
write:                                  # @write
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	lw	a3, -12(s0)
	lw	a4, -16(s0)
	lw	a5, -20(s0)
	#APP
	mv	a0, a3	# file descriptor
	mv	a1, a4	# buffer 
	mv	a2, a5	# size 
	li	a7, 64	# syscall write (64) 
	ecall
	#NO_APP
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end1:
	.size	write, .Lfunc_end1-write
                                        # -- End function
	.globl	exit                            # -- Begin function exit
	.p2align	2
	.type	exit,@function
exit:                                   # @exit
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a1, -12(s0)
	#APP
	mv	a0, a1	# return code
	li	a7, 93	# syscall exit (64) 
	ecall
	#NO_APP
.Lfunc_end2:
	.size	exit, .Lfunc_end2-exit
                                        # -- End function
	.globl	decimal_to_binary               # -- Begin function decimal_to_binary
	.p2align	2
	.type	decimal_to_binary,@function
decimal_to_binary:                      # @decimal_to_binary
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB3_1
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	beqz	a0, .LBB3_3
	j	.LBB3_2
.LBB3_2:                                #   in Loop: Header=BB3_1 Depth=1
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a0, a0, a1
	srai	a0, a0, 1
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	srli	a1, a0, 31
	add	a1, a0, a1
	andi	a1, a1, -2
	sub	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB3_1
.LBB3_3:
	j	.LBB3_4
.LBB3_4:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	li	a1, 32
	beq	a0, a1, .LBB3_6
	j	.LBB3_5
.LBB3_5:                                #   in Loop: Header=BB3_4 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB3_4
.LBB3_6:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end3:
	.size	decimal_to_binary, .Lfunc_end3-decimal_to_binary
                                        # -- End function
	.globl	decimal_to_hexa                 # -- Begin function decimal_to_hexa
	.p2align	2
	.type	decimal_to_hexa,@function
decimal_to_hexa:                        # @decimal_to_hexa
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB4_1
.LBB4_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	beqz	a0, .LBB4_21
	j	.LBB4_2
.LBB4_2:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a0, a0, a1
	srai	a0, a0, 4
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	srai	a1, a0, 31
	srli	a1, a1, 28
	add	a1, a0, a1
	andi	a1, a1, -16
	sub	a0, a0, a1
	sw	a0, -28(s0)
	lw	a0, -28(s0)
	li	a1, 10
	bne	a0, a1, .LBB4_4
	j	.LBB4_3
.LBB4_3:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 97
	sb	a0, 0(a1)
	j	.LBB4_20
.LBB4_4:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	li	a1, 11
	bne	a0, a1, .LBB4_6
	j	.LBB4_5
.LBB4_5:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 98
	sb	a0, 0(a1)
	j	.LBB4_19
.LBB4_6:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	li	a1, 12
	bne	a0, a1, .LBB4_8
	j	.LBB4_7
.LBB4_7:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 99
	sb	a0, 0(a1)
	j	.LBB4_18
.LBB4_8:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	li	a1, 13
	bne	a0, a1, .LBB4_10
	j	.LBB4_9
.LBB4_9:                                #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 100
	sb	a0, 0(a1)
	j	.LBB4_17
.LBB4_10:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	li	a1, 14
	bne	a0, a1, .LBB4_12
	j	.LBB4_11
.LBB4_11:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 101
	sb	a0, 0(a1)
	j	.LBB4_16
.LBB4_12:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	li	a1, 15
	bne	a0, a1, .LBB4_14
	j	.LBB4_13
.LBB4_13:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 102
	sb	a0, 0(a1)
	j	.LBB4_15
.LBB4_14:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -28(s0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB4_15
.LBB4_15:                               #   in Loop: Header=BB4_1 Depth=1
	j	.LBB4_16
.LBB4_16:                               #   in Loop: Header=BB4_1 Depth=1
	j	.LBB4_17
.LBB4_17:                               #   in Loop: Header=BB4_1 Depth=1
	j	.LBB4_18
.LBB4_18:                               #   in Loop: Header=BB4_1 Depth=1
	j	.LBB4_19
.LBB4_19:                               #   in Loop: Header=BB4_1 Depth=1
	j	.LBB4_20
.LBB4_20:                               #   in Loop: Header=BB4_1 Depth=1
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB4_1
.LBB4_21:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end4:
	.size	decimal_to_hexa, .Lfunc_end4-decimal_to_hexa
                                        # -- End function
	.globl	string_lenght                   # -- Begin function string_lenght
	.p2align	2
	.type	string_lenght,@function
string_lenght:                          # @string_lenght
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	j	.LBB5_1
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	beqz	a0, .LBB5_3
	j	.LBB5_2
.LBB5_2:                                #   in Loop: Header=BB5_1 Depth=1
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB5_1
.LBB5_3:
	lw	a0, -16(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end5:
	.size	string_lenght, .Lfunc_end5-string_lenght
                                        # -- End function
	.globl	invert_string                   # -- Begin function invert_string
	.p2align	2
	.type	invert_string,@function
invert_string:                          # @invert_string
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	sw	a1, -28(s0)
	lw	a1, -28(s0)
	sw	a1, -24(s0)
	sw	a0, -20(s0)
	j	.LBB6_1
.LBB6_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	lw	a1, -28(s0)
	bge	a0, a1, .LBB6_4
	j	.LBB6_2
.LBB6_2:                                #   in Loop: Header=BB6_1 Depth=1
	lw	a1, -12(s0)
	lw	a0, -24(s0)
	add	a0, a0, a1
	lbu	a0, -1(a0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -24(s0)
	addi	a0, a0, -1
	sw	a0, -24(s0)
	j	.LBB6_3
.LBB6_3:                                #   in Loop: Header=BB6_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB6_1
.LBB6_4:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	a1, -16(s0)
	lw	a0, -20(s0)
	add	a1, a0, a1
	li	a0, 10
	sb	a0, 1(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end6:
	.size	invert_string, .Lfunc_end6-invert_string
                                        # -- End function
	.globl	convert_to_number               # -- Begin function convert_to_number
	.p2align	2
	.type	convert_to_number,@function
convert_to_number:                      # @convert_to_number
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB7_4
	j	.LBB7_2
.LBB7_2:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -16(s0)
	li	a1, 10
	mul	a1, a0, a1
	lw	a0, -12(s0)
	lw	a2, -20(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	add	a0, a0, a1
	addi	a0, a0, -48
	sw	a0, -16(s0)
	j	.LBB7_3
.LBB7_3:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_4:
	lw	a0, -16(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end7:
	.size	convert_to_number, .Lfunc_end7-convert_to_number
                                        # -- End function
	.globl	convert_to_string               # -- Begin function convert_to_string
	.p2align	2
	.type	convert_to_string,@function
convert_to_string:                      # @convert_to_string
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	sw	a2, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	sw	a0, -28(s0)
	j	.LBB8_1
.LBB8_1:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -28(s0)
	li	a0, 0
	bge	a0, a1, .LBB8_3
	j	.LBB8_2
.LBB8_2:                                #   in Loop: Header=BB8_1 Depth=1
	lw	a0, -28(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a1, a0, a1
	srli	a2, a1, 31
	srli	a1, a1, 2
	add	a1, a1, a2
	li	a2, 10
	mul	a1, a1, a2
	sub	a0, a0, a1
	addi	a0, a0, 48
	lw	a1, -16(s0)
	lw	a2, -24(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB8_1
.LBB8_3:
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	call	invert_string
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	convert_to_string, .Lfunc_end8-convert_to_string
                                        # -- End function
	.globl	escrever_binario                # -- Begin function escrever_binario
	.p2align	2
	.type	escrever_binario,@function
escrever_binario:                       # @escrever_binario
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -12(s0)
	li	a0, 48
	sb	a0, 0(a1)
	lw	a1, -12(s0)
	li	a0, 98
	sb	a0, 1(a1)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB9_1
.LBB9_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	lw	a0, -16(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB9_4
	j	.LBB9_2
.LBB9_2:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -12(s0)
	add	a1, a1, a2
	sb	a0, 2(a1)
	j	.LBB9_3
.LBB9_3:                                #   in Loop: Header=BB9_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB9_1
.LBB9_4:
	lw	a0, -12(s0)
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	call	string_lenght
	mv	a1, a0
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	add	a1, a0, a1
	li	a0, 10
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	escrever_binario, .Lfunc_end9-escrever_binario
                                        # -- End function
	.globl	escrever_hexa                   # -- Begin function escrever_hexa
	.p2align	2
	.type	escrever_hexa,@function
escrever_hexa:                          # @escrever_hexa
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -12(s0)
	li	a0, 48
	sb	a0, 0(a1)
	lw	a1, -12(s0)
	li	a0, 120
	sb	a0, 1(a1)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB10_1
.LBB10_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	lw	a0, -16(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB10_4
	j	.LBB10_2
.LBB10_2:                               #   in Loop: Header=BB10_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a2, -12(s0)
	add	a1, a1, a2
	sb	a0, 2(a1)
	j	.LBB10_3
.LBB10_3:                               #   in Loop: Header=BB10_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB10_1
.LBB10_4:
	lw	a0, -12(s0)
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	call	string_lenght
	mv	a1, a0
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	add	a1, a0, a1
	li	a0, 10
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	escrever_hexa, .Lfunc_end10-escrever_hexa
                                        # -- End function
	.globl	rewrite_hexa                    # -- Begin function rewrite_hexa
	.p2align	2
	.type	rewrite_hexa,@function
rewrite_hexa:                           # @rewrite_hexa
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB11_1
.LBB11_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	lw	a1, -16(s0)
	addi	a1, a1, -2
	bge	a0, a1, .LBB11_4
	j	.LBB11_2
.LBB11_2:                               #   in Loop: Header=BB11_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	lbu	a0, 2(a1)
	sb	a0, 0(a1)
	j	.LBB11_3
.LBB11_3:                               #   in Loop: Header=BB11_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB11_1
.LBB11_4:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end11:
	.size	rewrite_hexa, .Lfunc_end11-rewrite_hexa
                                        # -- End function
	.globl	swap_endianness                 # -- Begin function swap_endianness
	.p2align	2
	.type	swap_endianness,@function
swap_endianness:                        # @swap_endianness
# %bb.0:
	addi	sp, sp, -64
	sw	ra, 60(sp)                      # 4-byte Folded Spill
	sw	s0, 56(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 64
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -48(s0)
	j	.LBB12_1
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
	lw	a1, -48(s0)
	li	a0, 31
	blt	a0, a1, .LBB12_18
	j	.LBB12_2
.LBB12_2:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a1, -48(s0)
	li	a0, 7
	blt	a0, a1, .LBB12_4
	j	.LBB12_3
.LBB12_3:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -48(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, s0, -23
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_16
.LBB12_4:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -48(s0)
	li	a1, 8
	blt	a0, a1, .LBB12_7
	j	.LBB12_5
.LBB12_5:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a1, -48(s0)
	li	a0, 15
	blt	a0, a1, .LBB12_7
	j	.LBB12_6
.LBB12_6:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -48(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, s0, -30
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_15
.LBB12_7:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -48(s0)
	li	a1, 16
	blt	a0, a1, .LBB12_10
	j	.LBB12_8
.LBB12_8:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a1, -48(s0)
	li	a0, 23
	blt	a0, a1, .LBB12_10
	j	.LBB12_9
.LBB12_9:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -48(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, s0, -37
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_14
.LBB12_10:                              #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -48(s0)
	li	a1, 24
	blt	a0, a1, .LBB12_13
	j	.LBB12_11
.LBB12_11:                              #   in Loop: Header=BB12_1 Depth=1
	lw	a1, -48(s0)
	li	a0, 31
	blt	a0, a1, .LBB12_13
	j	.LBB12_12
.LBB12_12:                              #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -48(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, s0, -44
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_13
.LBB12_13:                              #   in Loop: Header=BB12_1 Depth=1
	j	.LBB12_14
.LBB12_14:                              #   in Loop: Header=BB12_1 Depth=1
	j	.LBB12_15
.LBB12_15:                              #   in Loop: Header=BB12_1 Depth=1
	j	.LBB12_16
.LBB12_16:                              #   in Loop: Header=BB12_1 Depth=1
	j	.LBB12_17
.LBB12_17:                              #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -48(s0)
	addi	a0, a0, 1
	sw	a0, -48(s0)
	j	.LBB12_1
.LBB12_18:
	li	a0, 0
	sw	a0, -52(s0)
	j	.LBB12_19
.LBB12_19:                              # =>This Inner Loop Header: Depth=1
	lw	a1, -52(s0)
	li	a0, 31
	blt	a0, a1, .LBB12_36
	j	.LBB12_20
.LBB12_20:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a1, -52(s0)
	li	a0, 7
	blt	a0, a1, .LBB12_22
	j	.LBB12_21
.LBB12_21:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a2, -52(s0)
	addi	a0, s0, -44
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_34
.LBB12_22:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a0, -52(s0)
	li	a1, 8
	blt	a0, a1, .LBB12_25
	j	.LBB12_23
.LBB12_23:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a1, -52(s0)
	li	a0, 15
	blt	a0, a1, .LBB12_25
	j	.LBB12_24
.LBB12_24:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a2, -52(s0)
	addi	a0, s0, -37
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_33
.LBB12_25:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a0, -52(s0)
	li	a1, 16
	blt	a0, a1, .LBB12_28
	j	.LBB12_26
.LBB12_26:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a1, -52(s0)
	li	a0, 23
	blt	a0, a1, .LBB12_28
	j	.LBB12_27
.LBB12_27:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a2, -52(s0)
	addi	a0, s0, -30
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_32
.LBB12_28:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a0, -52(s0)
	li	a1, 24
	blt	a0, a1, .LBB12_31
	j	.LBB12_29
.LBB12_29:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a1, -52(s0)
	li	a0, 31
	blt	a0, a1, .LBB12_31
	j	.LBB12_30
.LBB12_30:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a2, -52(s0)
	addi	a0, s0, -23
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB12_31
.LBB12_31:                              #   in Loop: Header=BB12_19 Depth=1
	j	.LBB12_32
.LBB12_32:                              #   in Loop: Header=BB12_19 Depth=1
	j	.LBB12_33
.LBB12_33:                              #   in Loop: Header=BB12_19 Depth=1
	j	.LBB12_34
.LBB12_34:                              #   in Loop: Header=BB12_19 Depth=1
	j	.LBB12_35
.LBB12_35:                              #   in Loop: Header=BB12_19 Depth=1
	lw	a0, -52(s0)
	addi	a0, a0, 1
	sw	a0, -52(s0)
	j	.LBB12_19
.LBB12_36:
	lw	ra, 60(sp)                      # 4-byte Folded Reload
	lw	s0, 56(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 64
	ret
.Lfunc_end12:
	.size	swap_endianness, .Lfunc_end12-swap_endianness
                                        # -- End function
	.globl	remove_zeros                    # -- Begin function remove_zeros
	.p2align	2
	.type	remove_zeros,@function
remove_zeros:                           # @remove_zeros
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sw	a0, -24(s0)
	j	.LBB13_1
.LBB13_1:                               # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	li	a0, 31
	blt	a0, a1, .LBB13_9
	j	.LBB13_2
.LBB13_2:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a0, -20(s0)
	bnez	a0, .LBB13_6
	j	.LBB13_3
.LBB13_3:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB13_5
	j	.LBB13_4
.LBB13_4:                               #   in Loop: Header=BB13_1 Depth=1
	li	a0, 1
	sw	a0, -20(s0)
	j	.LBB13_5
.LBB13_5:                               #   in Loop: Header=BB13_1 Depth=1
	j	.LBB13_7
.LBB13_6:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -24(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB13_7
.LBB13_7:                               #   in Loop: Header=BB13_1 Depth=1
	j	.LBB13_8
.LBB13_8:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB13_1
.LBB13_9:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end13:
	.size	remove_zeros, .Lfunc_end13-remove_zeros
                                        # -- End function
	.globl	calculate_pot                   # -- Begin function calculate_pot
	.p2align	2
	.type	calculate_pot,@function
calculate_pot:                          # @calculate_pot
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 1
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB14_1
.LBB14_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB14_4
	j	.LBB14_2
.LBB14_2:                               #   in Loop: Header=BB14_1 Depth=1
	lw	a1, -12(s0)
	lw	a0, -20(s0)
	mul	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB14_3
.LBB14_3:                               #   in Loop: Header=BB14_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB14_1
.LBB14_4:
	lw	a0, -20(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end14:
	.size	calculate_pot, .Lfunc_end14-calculate_pot
                                        # -- End function
	.globl	binary_to_decimal               # -- Begin function binary_to_decimal
	.p2align	2
	.type	binary_to_decimal,@function
binary_to_decimal:                      # @binary_to_decimal
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -32(s0)                     # 4-byte Folded Spill
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -32(s0)                     # 4-byte Folded Reload
	addi	a1, a1, -1
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	j	.LBB15_1
.LBB15_1:                               # =>This Inner Loop Header: Depth=1
	lw	a1, -24(s0)
	lw	a0, -20(s0)
	blt	a0, a1, .LBB15_4
	j	.LBB15_2
.LBB15_2:                               #   in Loop: Header=BB15_1 Depth=1
	lw	a0, -20(s0)
	lw	a1, -24(s0)
	sub	a1, a0, a1
	li	a0, 2
	call	calculate_pot
	sw	a0, -28(s0)
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -48
	lw	a1, -28(s0)
	mul	a1, a0, a1
	lw	a0, -16(s0)
	add	a0, a0, a1
	sw	a0, -16(s0)
	j	.LBB15_3
.LBB15_3:                               #   in Loop: Header=BB15_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB15_1
.LBB15_4:
	lw	a0, -16(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end15:
	.size	binary_to_decimal, .Lfunc_end15-binary_to_decimal
                                        # -- End function
	.globl	hexa_to_decimal                 # -- Begin function hexa_to_decimal
	.p2align	2
	.type	hexa_to_decimal,@function
hexa_to_decimal:                        # @hexa_to_decimal
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -40(s0)                     # 4-byte Folded Spill
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -40(s0)                     # 4-byte Folded Reload
	addi	a1, a1, -2
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	j	.LBB16_1
.LBB16_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB16_15
	j	.LBB16_2
.LBB16_2:                               #   in Loop: Header=BB16_1 Depth=1
	lw	a1, -12(s0)
	lw	a0, -24(s0)
	add	a0, a0, a1
	lbu	a0, 2(a0)
	sb	a0, -25(s0)
	lbu	a0, -25(s0)
	li	a1, 48
	blt	a0, a1, .LBB16_5
	j	.LBB16_3
.LBB16_3:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 57
	blt	a0, a1, .LBB16_5
	j	.LBB16_4
.LBB16_4:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -48
	sw	a0, -32(s0)
	j	.LBB16_13
.LBB16_5:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a0, -25(s0)
	li	a1, 65
	blt	a0, a1, .LBB16_8
	j	.LBB16_6
.LBB16_6:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 70
	blt	a0, a1, .LBB16_8
	j	.LBB16_7
.LBB16_7:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -55
	sw	a0, -32(s0)
	j	.LBB16_12
.LBB16_8:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a0, -25(s0)
	li	a1, 97
	blt	a0, a1, .LBB16_11
	j	.LBB16_9
.LBB16_9:                               #   in Loop: Header=BB16_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 102
	blt	a0, a1, .LBB16_11
	j	.LBB16_10
.LBB16_10:                              #   in Loop: Header=BB16_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -87
	sw	a0, -32(s0)
	j	.LBB16_11
.LBB16_11:                              #   in Loop: Header=BB16_1 Depth=1
	j	.LBB16_12
.LBB16_12:                              #   in Loop: Header=BB16_1 Depth=1
	j	.LBB16_13
.LBB16_13:                              #   in Loop: Header=BB16_1 Depth=1
	lw	a1, -20(s0)
	lw	a0, -24(s0)
	not	a0, a0
	add	a1, a0, a1
	li	a0, 16
	call	calculate_pot
	sw	a0, -36(s0)
	lw	a0, -32(s0)
	lw	a1, -36(s0)
	mul	a1, a0, a1
	lw	a0, -16(s0)
	add	a0, a0, a1
	sw	a0, -16(s0)
	j	.LBB16_14
.LBB16_14:                              #   in Loop: Header=BB16_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB16_1
.LBB16_15:
	lw	a0, -16(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end16:
	.size	hexa_to_decimal, .Lfunc_end16-hexa_to_decimal
                                        # -- End function
	.globl	invert_bits                     # -- Begin function invert_bits
	.p2align	2
	.type	invert_bits,@function
invert_bits:                            # @invert_bits
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB17_1
.LBB17_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -20(s0)
	sw	a0, -24(s0)                     # 4-byte Folded Spill
	lw	a0, -16(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -24(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB17_7
	j	.LBB17_2
.LBB17_2:                               #   in Loop: Header=BB17_1 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	bne	a0, a1, .LBB17_4
	j	.LBB17_3
.LBB17_3:                               #   in Loop: Header=BB17_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 49
	sb	a0, 0(a1)
	j	.LBB17_5
.LBB17_4:                               #   in Loop: Header=BB17_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB17_5
.LBB17_5:                               #   in Loop: Header=BB17_1 Depth=1
	j	.LBB17_6
.LBB17_6:                               #   in Loop: Header=BB17_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB17_1
.LBB17_7:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end17:
	.size	invert_bits, .Lfunc_end17-invert_bits
                                        # -- End function
	.globl	check                           # -- Begin function check
	.p2align	2
	.type	check,@function
check:                                  # @check
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -16(s0)
	lw	a0, -16(s0)
	bltz	a0, .LBB18_3
	j	.LBB18_1
.LBB18_1:
	lw	a1, -16(s0)
	li	a0, 9
	blt	a0, a1, .LBB18_3
	j	.LBB18_2
.LBB18_2:
	lw	a0, -16(s0)
	addi	a0, a0, 48
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_3:
	lw	a0, -16(s0)
	li	a1, 10
	bne	a0, a1, .LBB18_5
	j	.LBB18_4
.LBB18_4:
	li	a0, 97
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_5:
	lw	a0, -16(s0)
	li	a1, 11
	bne	a0, a1, .LBB18_7
	j	.LBB18_6
.LBB18_6:
	li	a0, 98
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_7:
	lw	a0, -16(s0)
	li	a1, 12
	bne	a0, a1, .LBB18_9
	j	.LBB18_8
.LBB18_8:
	li	a0, 99
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_9:
	lw	a0, -16(s0)
	li	a1, 13
	bne	a0, a1, .LBB18_11
	j	.LBB18_10
.LBB18_10:
	li	a0, 100
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_11:
	lw	a0, -16(s0)
	li	a1, 14
	bne	a0, a1, .LBB18_13
	j	.LBB18_12
.LBB18_12:
	li	a0, 101
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_13:
	lw	a0, -16(s0)
	li	a1, 15
	bne	a0, a1, .LBB18_15
	j	.LBB18_14
.LBB18_14:
	li	a0, 102
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_15:
	j	.LBB18_16
.LBB18_16:
	j	.LBB18_17
.LBB18_17:
	j	.LBB18_18
.LBB18_18:
	j	.LBB18_19
.LBB18_19:
	j	.LBB18_20
.LBB18_20:
	j	.LBB18_21
.LBB18_21:
	li	a0, 32
	sb	a0, -9(s0)
	j	.LBB18_22
.LBB18_22:
	lbu	a0, -9(s0)
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end18:
	.size	check, .Lfunc_end18-check
                                        # -- End function
	.globl	clean_string                    # -- Begin function clean_string
	.p2align	2
	.type	clean_string,@function
clean_string:                           # @clean_string
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	j	.LBB19_1
.LBB19_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -16(s0)
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB19_4
	j	.LBB19_2
.LBB19_2:                               #   in Loop: Header=BB19_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB19_3
.LBB19_3:                               #   in Loop: Header=BB19_1 Depth=1
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB19_1
.LBB19_4:
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end19:
	.size	clean_string, .Lfunc_end19-clean_string
                                        # -- End function
	.globl	binary_to_hexa                  # -- Begin function binary_to_hexa
	.p2align	2
	.type	binary_to_hexa,@function
binary_to_hexa:                         # @binary_to_hexa
# %bb.0:
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	lw	a1, -16(s0)
	li	a0, 48
	sb	a0, 0(a1)
	lw	a1, -16(s0)
	li	a0, 120
	sb	a0, 1(a1)
	li	a0, 1
	sw	a0, -24(s0)
	li	a0, 0
	sw	a0, -28(s0)
	j	.LBB20_1
.LBB20_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -28(s0)
	sw	a0, -36(s0)                     # 4-byte Folded Spill
	lw	a0, -12(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -36(s0)                     # 4-byte Folded Reload
	bge	a0, a1, .LBB20_9
	j	.LBB20_2
.LBB20_2:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -12(s0)
	lw	a2, -28(s0)
	add	a0, a0, a2
	lbu	a0, 0(a0)
	addi	a1, s0, -19
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -24(s0)
	srai	a1, a0, 31
	srli	a1, a1, 30
	add	a1, a0, a1
	andi	a1, a1, -4
	sub	a0, a0, a1
	bnez	a0, .LBB20_7
	j	.LBB20_3
.LBB20_3:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -24(s0)
	li	a1, 4
	bne	a0, a1, .LBB20_5
	j	.LBB20_4
.LBB20_4:                               #   in Loop: Header=BB20_1 Depth=1
	addi	a0, s0, -19
	sw	a0, -40(s0)                     # 4-byte Folded Spill
	call	binary_to_decimal
	call	check
	mv	a1, a0
	lw	a0, -40(s0)                     # 4-byte Folded Reload
	lw	a3, -16(s0)
	lw	a2, -28(s0)
	add	a2, a2, a3
	sb	a1, 2(a2)
	call	clean_string
	j	.LBB20_6
.LBB20_5:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a1, -32(s0)
	addi	a0, s0, -19
	sw	a0, -44(s0)                     # 4-byte Folded Spill
	call	remove_zeros
	lw	a0, -32(s0)
	call	binary_to_decimal
	call	check
	mv	a1, a0
	lw	a0, -44(s0)                     # 4-byte Folded Reload
	lw	a3, -16(s0)
	lw	a2, -28(s0)
	add	a2, a2, a3
	sb	a1, 2(a2)
	call	clean_string
	j	.LBB20_6
.LBB20_6:                               #   in Loop: Header=BB20_1 Depth=1
	j	.LBB20_7
.LBB20_7:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB20_8
.LBB20_8:                               #   in Loop: Header=BB20_1 Depth=1
	lw	a0, -28(s0)
	addi	a0, a0, 1
	sw	a0, -28(s0)
	j	.LBB20_1
.LBB20_9:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end20:
	.size	binary_to_hexa, .Lfunc_end20-binary_to_hexa
                                        # -- End function
	.globl	complete_zeros                  # -- Begin function complete_zeros
	.p2align	2
	.type	complete_zeros,@function
complete_zeros:                         # @complete_zeros
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	string_lenght
	sw	a0, -16(s0)
	j	.LBB21_1
.LBB21_1:                               # =>This Inner Loop Header: Depth=1
	lw	a1, -16(s0)
	li	a0, 30
	blt	a0, a1, .LBB21_4
	j	.LBB21_2
.LBB21_2:                               #   in Loop: Header=BB21_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB21_3
.LBB21_3:                               #   in Loop: Header=BB21_1 Depth=1
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB21_1
.LBB21_4:
	lw	ra, 12(sp)                      # 4-byte Folded Reload
	lw	s0, 8(sp)                       # 4-byte Folded Reload
	addi	sp, sp, 16
	ret
.Lfunc_end21:
	.size	complete_zeros, .Lfunc_end21-complete_zeros
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -304
	sw	ra, 300(sp)                     # 4-byte Folded Spill
	sw	s0, 296(sp)                     # 4-byte Folded Spill
	addi	s0, sp, 304
	li	a0, 0
	sw	a0, -12(s0)
	addi	a1, s0, -32
	li	a2, 20
	call	read
	sw	a0, -36(s0)
	lbu	a0, -31(s0)
	li	a1, 120
	bne	a0, a1, .LBB22_9
	j	.LBB22_1
.LBB22_1:
	addi	a0, s0, -32
	call	hexa_to_decimal
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	lw	a1, -44(s0)
	call	decimal_to_binary
	lw	a0, -44(s0)
	lw	a1, -48(s0)
	call	invert_string
	lw	a0, -48(s0)
	lw	a1, -52(s0)
	call	remove_zeros
	lw	a0, -56(s0)
	lw	a1, -52(s0)
	call	escrever_binario
	lw	a0, -56(s0)
	sw	a0, -228(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -228(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	call	write
	lw	a0, -52(s0)
	lbu	a0, 0(a0)
	li	a1, 49
	bne	a0, a1, .LBB22_7
	j	.LBB22_2
.LBB22_2:
	lw	a0, -60(s0)
	lw	a1, -52(s0)
	call	invert_bits
	lw	a0, -60(s0)
	call	binary_to_decimal
	sw	a0, -64(s0)
	lw	a0, -64(s0)
	addi	a0, a0, 1
	sw	a0, -64(s0)
	lw	a0, -64(s0)
	lw	a1, -68(s0)
	lw	a2, -72(s0)
	call	convert_to_string
	li	a0, 0
	sw	a0, -76(s0)
	j	.LBB22_3
.LBB22_3:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -76(s0)
	sw	a0, -232(s0)                    # 4-byte Folded Spill
	lw	a0, -72(s0)
	call	string_lenght
	mv	a1, a0
	lw	a0, -232(s0)                    # 4-byte Folded Reload
	bge	a0, a1, .LBB22_6
	j	.LBB22_4
.LBB22_4:                               #   in Loop: Header=BB22_3 Depth=1
	lw	a0, -72(s0)
	lw	a1, -76(s0)
	add	a1, a0, a1
	lbu	a0, 0(a1)
	sb	a0, 1(a1)
	j	.LBB22_5
.LBB22_5:                               #   in Loop: Header=BB22_3 Depth=1
	lw	a0, -76(s0)
	addi	a0, a0, 1
	sw	a0, -76(s0)
	j	.LBB22_3
.LBB22_6:
	lw	a1, -72(s0)
	li	a0, 45
	sb	a0, 0(a1)
	lw	a0, -72(s0)
	sw	a0, -240(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -240(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	sw	a0, -236(s0)                    # 4-byte Folded Spill
	call	write
	lw	a2, -236(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	mv	a0, a2
	call	write
	j	.LBB22_8
.LBB22_7:
	lw	a0, -40(s0)
	lw	a1, -80(s0)
	lw	a2, -84(s0)
	call	convert_to_string
	lw	a0, -84(s0)
	sw	a0, -244(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -244(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	call	write
	j	.LBB22_8
.LBB22_8:
	addi	a0, s0, -32
	sw	a0, -256(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -256(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	sw	a0, -248(s0)                    # 4-byte Folded Spill
	call	write
	lw	a0, -48(s0)
	lw	a1, -88(s0)
	call	swap_endianness
	lw	a0, -88(s0)
	lw	a1, -92(s0)
	call	remove_zeros
	lw	a0, -92(s0)
	call	binary_to_decimal
	sw	a0, -96(s0)
	lw	a0, -96(s0)
	lw	a1, -100(s0)
	lw	a2, -104(s0)
	call	convert_to_string
	lw	a0, -104(s0)
	sw	a0, -252(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -252(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -248(s0)                    # 4-byte Folded Reload
	call	write
	j	.LBB22_17
.LBB22_9:
	lbu	a0, -32(s0)
	li	a1, 45
	bne	a0, a1, .LBB22_15
	j	.LBB22_10
.LBB22_10:
	li	a0, 0
	sw	a0, -112(s0)
	j	.LBB22_11
.LBB22_11:                              # =>This Inner Loop Header: Depth=1
	lw	a0, -112(s0)
	sw	a0, -260(s0)                    # 4-byte Folded Spill
	addi	a0, s0, -32
	call	string_lenght
	mv	a1, a0
	lw	a0, -260(s0)                    # 4-byte Folded Reload
	addi	a1, a1, -1
	bge	a0, a1, .LBB22_14
	j	.LBB22_12
.LBB22_12:                              #   in Loop: Header=BB22_11 Depth=1
	lw	a2, -112(s0)
	addi	a0, s0, -32
	add	a0, a2, a0
	lbu	a0, 1(a0)
	lw	a1, -108(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB22_13
.LBB22_13:                              #   in Loop: Header=BB22_11 Depth=1
	lw	a0, -112(s0)
	addi	a0, a0, 1
	sw	a0, -112(s0)
	j	.LBB22_11
.LBB22_14:
	lw	a0, -108(s0)
	call	convert_to_number
	sw	a0, -116(s0)
	lw	a0, -116(s0)
	addi	a0, a0, -1
	sw	a0, -116(s0)
	lw	a0, -116(s0)
	lw	a1, -120(s0)
	call	decimal_to_binary
	lw	a0, -120(s0)
	lw	a1, -124(s0)
	call	invert_string
	lw	a0, -124(s0)
	lw	a1, -128(s0)
	call	remove_zeros
	lw	a0, -132(s0)
	lw	a1, -128(s0)
	call	invert_bits
	lw	a0, -136(s0)
	lw	a1, -132(s0)
	call	escrever_binario
	lw	a0, -136(s0)
	sw	a0, -280(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -280(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	sw	a0, -264(s0)                    # 4-byte Folded Spill
	call	write
	addi	a0, s0, -32
	sw	a0, -276(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -276(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -264(s0)                    # 4-byte Folded Reload
	call	write
	lw	a0, -132(s0)
	lw	a1, -140(s0)
	call	binary_to_hexa
	lw	a0, -140(s0)
	sw	a0, -272(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -272(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -264(s0)                    # 4-byte Folded Reload
	call	write
	lw	a2, -264(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	mv	a0, a2
	call	write
	lw	a0, -132(s0)
	lw	a1, -144(s0)
	call	invert_string
	lw	a0, -144(s0)
	call	complete_zeros
	lw	a0, -144(s0)
	lw	a1, -148(s0)
	call	invert_string
	lw	a0, -148(s0)
	lw	a1, -152(s0)
	call	swap_endianness
	lw	a0, -152(s0)
	lw	a1, -156(s0)
	call	remove_zeros
	lw	a0, -156(s0)
	call	binary_to_decimal
	sw	a0, -160(s0)
	lw	a0, -160(s0)
	lw	a1, -164(s0)
	lw	a2, -168(s0)
	call	convert_to_string
	lw	a0, -168(s0)
	sw	a0, -268(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -268(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -264(s0)                    # 4-byte Folded Reload
	call	write
	j	.LBB22_16
.LBB22_15:
	addi	a0, s0, -32
	sw	a0, -296(s0)                    # 4-byte Folded Spill
	call	convert_to_number
	sw	a0, -172(s0)
	lw	a0, -172(s0)
	lw	a1, -176(s0)
	call	decimal_to_binary
	lw	a0, -176(s0)
	lw	a1, -180(s0)
	call	invert_string
	lw	a0, -180(s0)
	lw	a1, -184(s0)
	call	remove_zeros
	lw	a0, -188(s0)
	lw	a1, -184(s0)
	call	escrever_binario
	lw	a0, -188(s0)
	sw	a0, -300(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -300(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	sw	a0, -284(s0)                    # 4-byte Folded Spill
	call	write
	lw	a0, -296(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -296(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -284(s0)                    # 4-byte Folded Reload
	call	write
	lw	a0, -172(s0)
	lw	a1, -192(s0)
	call	decimal_to_hexa
	lw	a0, -192(s0)
	lw	a1, -196(s0)
	call	invert_string
	lw	a0, -196(s0)
	call	string_lenght
	sw	a0, -200(s0)
	lw	a0, -204(s0)
	lw	a1, -196(s0)
	call	escrever_hexa
	lw	a0, -204(s0)
	sw	a0, -292(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -292(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -284(s0)                    # 4-byte Folded Reload
	call	write
	lw	a0, -180(s0)
	lw	a1, -208(s0)
	call	swap_endianness
	lw	a0, -208(s0)
	lw	a1, -212(s0)
	call	remove_zeros
	lw	a0, -212(s0)
	call	binary_to_decimal
	sw	a0, -216(s0)
	lw	a0, -216(s0)
	lw	a1, -220(s0)
	lw	a2, -224(s0)
	call	convert_to_string
	lw	a0, -224(s0)
	sw	a0, -288(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -288(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -284(s0)                    # 4-byte Folded Reload
	call	write
	j	.LBB22_16
.LBB22_16:
	j	.LBB22_17
.LBB22_17:
	li	a0, 0
	lw	ra, 300(sp)                     # 4-byte Folded Reload
	lw	s0, 296(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 304
	ret
.Lfunc_end22:
	.size	main, .Lfunc_end22-main
                                        # -- End function
	.globl	_start                          # -- Begin function _start
	.p2align	2
	.type	_start,@function
_start:                                 # @_start
# %bb.0:
	addi	sp, sp, -16
	sw	ra, 12(sp)                      # 4-byte Folded Spill
	sw	s0, 8(sp)                       # 4-byte Folded Spill
	addi	s0, sp, 16
	call	main
	sw	a0, -12(s0)
	lw	a0, -12(s0)
	call	exit
.Lfunc_end23:
	.size	_start, .Lfunc_end23-_start
                                        # -- End function
	.type	.L.str,@object                  # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"\n"
	.size	.L.str, 2

	.ident	"clang version 18.1.8"
	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym read
	.addrsig_sym write
	.addrsig_sym exit
	.addrsig_sym decimal_to_binary
	.addrsig_sym decimal_to_hexa
	.addrsig_sym string_lenght
	.addrsig_sym invert_string
	.addrsig_sym convert_to_number
	.addrsig_sym convert_to_string
	.addrsig_sym escrever_binario
	.addrsig_sym escrever_hexa
	.addrsig_sym swap_endianness
	.addrsig_sym remove_zeros
	.addrsig_sym calculate_pot
	.addrsig_sym binary_to_decimal
	.addrsig_sym hexa_to_decimal
	.addrsig_sym invert_bits
	.addrsig_sym check
	.addrsig_sym clean_string
	.addrsig_sym binary_to_hexa
	.addrsig_sym complete_zeros
	.addrsig_sym main
