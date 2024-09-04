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
	srli	a0, a0, 1
	sw	a0, -24(s0)
	lw	a0, -12(s0)
	andi	a0, a0, 1
	sw	a0, -28(s0)
	lw	a0, -24(s0)
	sw	a0, -12(s0)
	lw	a0, -28(s0)
	addi	a0, a0, 48
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
	lw	a1, -20(s0)
	li	a0, 31
	blt	a0, a1, .LBB3_6
	j	.LBB3_5
.LBB3_5:                                #   in Loop: Header=BB3_4 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB3_4
.LBB3_6:
	lw	a1, -16(s0)
	li	a0, 0
	sb	a0, 32(a1)
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
	addi	sp, sp, -48
	sw	ra, 44(sp)                      # 4-byte Folded Spill
	sw	s0, 40(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 48
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	sb	a0, -28(s0)
	lui	a0, 419414
	addi	a0, a0, 1123
	sw	a0, -32(s0)
	lui	a0, 402964
	addi	a0, a0, -1736
	sw	a0, -36(s0)
	lui	a0, 226147
	addi	a0, a0, 1332
	sw	a0, -40(s0)
	lui	a0, 209699
	addi	a0, a0, 304
	sw	a0, -44(s0)
	lw	a0, -12(s0)
	bnez	a0, .LBB4_2
	j	.LBB4_1
.LBB4_1:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	addi	a2, a1, 1
	sw	a2, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB4_9
.LBB4_2:
	j	.LBB4_3
.LBB4_3:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	beqz	a0, .LBB4_5
	j	.LBB4_4
.LBB4_4:                                #   in Loop: Header=BB4_3 Depth=1
	lw	a0, -12(s0)
	andi	a0, a0, 15
	sw	a0, -24(s0)
	lw	a1, -24(s0)
	addi	a0, s0, -44
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	lw	a2, -20(s0)
	addi	a3, a2, 1
	sw	a3, -20(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	lw	a0, -12(s0)
	srli	a0, a0, 4
	sw	a0, -12(s0)
	j	.LBB4_3
.LBB4_5:
	j	.LBB4_6
.LBB4_6:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -20(s0)
	li	a0, 7
	blt	a0, a1, .LBB4_8
	j	.LBB4_7
.LBB4_7:                                #   in Loop: Header=BB4_6 Depth=1
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB4_6
.LBB4_8:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	j	.LBB4_9
.LBB4_9:
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end4:
	.size	decimal_to_hexa, .Lfunc_end4-decimal_to_hexa
                                        # -- End function
	.globl	string_lenght                   # -- Begin function string_lenght
	.p2align	2
	.type	string_lenght,@function
string_lenght:                          # @string_lenght
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	li	a0, 0
	sw	a0, -16(s0)
	j	.LBB5_1
.LBB5_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 1
	sw	a1, -20(s0)                     # 4-byte Folded Spill
	bnez	a0, .LBB5_3
	j	.LBB5_2
.LBB5_2:                                #   in Loop: Header=BB5_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -16(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	addi	a0, a0, -10
	snez	a0, a0
	sw	a0, -20(s0)                     # 4-byte Folded Spill
	j	.LBB5_3
.LBB5_3:                                #   in Loop: Header=BB5_1 Depth=1
	lw	a0, -20(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB5_5
	j	.LBB5_4
.LBB5_4:                                #   in Loop: Header=BB5_1 Depth=1
	lw	a0, -16(s0)
	addi	a0, a0, 1
	sw	a0, -16(s0)
	j	.LBB5_1
.LBB5_5:
	lw	a0, -16(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
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
	lw	a0, -12(s0)
	call	string_lenght
	sw	a0, -20(s0)
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB6_1
.LBB6_1:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB6_4
	j	.LBB6_2
.LBB6_2:                                #   in Loop: Header=BB6_1 Depth=1
	lw	a0, -12(s0)
	lw	a3, -20(s0)
	lw	a2, -24(s0)
	not	a1, a2
	add	a1, a1, a3
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB6_3
.LBB6_3:                                #   in Loop: Header=BB6_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB6_1
.LBB6_4:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
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
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	beqz	a0, .LBB7_7
	j	.LBB7_2
.LBB7_2:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a1, 48
	blt	a0, a1, .LBB7_5
	j	.LBB7_3
.LBB7_3:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a1, 0(a0)
	li	a0, 57
	blt	a0, a1, .LBB7_5
	j	.LBB7_4
.LBB7_4:                                #   in Loop: Header=BB7_1 Depth=1
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
	j	.LBB7_5
.LBB7_5:                                #   in Loop: Header=BB7_1 Depth=1
	j	.LBB7_6
.LBB7_6:                                #   in Loop: Header=BB7_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB7_1
.LBB7_7:
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
	li	a0, 0
	sw	a0, -20(s0)
	li	a0, 1
	bnez	a0, .LBB8_2
	j	.LBB8_1
.LBB8_1:
	lw	a1, -12(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	j	.LBB8_2
.LBB8_2:
	lw	a0, -12(s0)
	bnez	a0, .LBB8_4
	j	.LBB8_3
.LBB8_3:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	addi	a2, a1, 1
	sw	a2, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB8_8
.LBB8_4:
	j	.LBB8_5
.LBB8_5:                                # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	beqz	a0, .LBB8_7
	j	.LBB8_6
.LBB8_6:                                #   in Loop: Header=BB8_5 Depth=1
	lw	a0, -12(s0)
	lui	a1, 838861
	addi	a1, a1, -819
	mulhu	a2, a0, a1
	srli	a2, a2, 3
	li	a3, 10
	mul	a2, a2, a3
	sub	a0, a0, a2
	ori	a0, a0, 48
	lw	a2, -16(s0)
	lw	a3, -20(s0)
	addi	a4, a3, 1
	sw	a4, -20(s0)
	add	a2, a2, a3
	sb	a0, 0(a2)
	lw	a0, -12(s0)
	mulhu	a0, a0, a1
	srli	a0, a0, 3
	sw	a0, -12(s0)
	j	.LBB8_5
.LBB8_7:
	j	.LBB8_8
.LBB8_8:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end8:
	.size	convert_to_string, .Lfunc_end8-convert_to_string
                                        # -- End function
	.globl	convert_to_string2              # -- Begin function convert_to_string2
	.p2align	2
	.type	convert_to_string2,@function
convert_to_string2:                     # @convert_to_string2
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	lw	a0, -12(s0)
	bgez	a0, .LBB9_2
	j	.LBB9_1
.LBB9_1:
	lw	a1, -12(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -12(s0)
	j	.LBB9_2
.LBB9_2:
	lw	a0, -12(s0)
	bnez	a0, .LBB9_4
	j	.LBB9_3
.LBB9_3:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	addi	a2, a1, 1
	sw	a2, -20(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB9_8
.LBB9_4:
	j	.LBB9_5
.LBB9_5:                                # =>This Inner Loop Header: Depth=1
	lw	a1, -12(s0)
	li	a0, 0
	bge	a0, a1, .LBB9_7
	j	.LBB9_6
.LBB9_6:                                #   in Loop: Header=BB9_5 Depth=1
	lw	a0, -12(s0)
	lui	a1, 419430
	addi	a1, a1, 1639
	mulh	a2, a0, a1
	srli	a3, a2, 31
	srli	a2, a2, 2
	add	a2, a2, a3
	li	a3, 10
	mul	a2, a2, a3
	sub	a0, a0, a2
	addi	a0, a0, 48
	lw	a2, -16(s0)
	lw	a3, -20(s0)
	addi	a4, a3, 1
	sw	a4, -20(s0)
	add	a2, a2, a3
	sb	a0, 0(a2)
	lw	a0, -12(s0)
	mulh	a0, a0, a1
	srli	a1, a0, 31
	srai	a0, a0, 2
	add	a0, a0, a1
	sw	a0, -12(s0)
	j	.LBB9_5
.LBB9_7:
	j	.LBB9_8
.LBB9_8:
	lw	a0, -16(s0)
	lw	a1, -20(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end9:
	.size	convert_to_string2, .Lfunc_end9-convert_to_string2
                                        # -- End function
	.globl	swap_endianness                 # -- Begin function swap_endianness
	.p2align	2
	.type	swap_endianness,@function
swap_endianness:                        # @swap_endianness
# %bb.0:
	addi	sp, sp, -32
	sw	ra, 28(sp)                      # 4-byte Folded Spill
	sw	s0, 24(sp)                      # 4-byte Folded Spill
	addi	s0, sp, 32
	sw	a0, -12(s0)
	sw	a1, -16(s0)
	li	a0, 0
	sw	a0, -20(s0)
	j	.LBB10_1
.LBB10_1:                               # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_3 Depth 2
	lw	a1, -20(s0)
	li	a0, 31
	blt	a0, a1, .LBB10_8
	j	.LBB10_2
.LBB10_2:                               #   in Loop: Header=BB10_1 Depth=1
	li	a0, 0
	sw	a0, -24(s0)
	j	.LBB10_3
.LBB10_3:                               #   Parent Loop BB10_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	lw	a1, -24(s0)
	li	a0, 7
	blt	a0, a1, .LBB10_6
	j	.LBB10_4
.LBB10_4:                               #   in Loop: Header=BB10_3 Depth=2
	lw	a1, -12(s0)
	lw	a2, -20(s0)
	lw	a3, -24(s0)
	sub	a0, a3, a2
	add	a0, a0, a1
	lbu	a0, 24(a0)
	lw	a1, -16(s0)
	add	a2, a2, a3
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB10_5
.LBB10_5:                               #   in Loop: Header=BB10_3 Depth=2
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB10_3
.LBB10_6:                               #   in Loop: Header=BB10_1 Depth=1
	j	.LBB10_7
.LBB10_7:                               #   in Loop: Header=BB10_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 8
	sw	a0, -20(s0)
	j	.LBB10_1
.LBB10_8:
	lw	a1, -16(s0)
	li	a0, 0
	sb	a0, 32(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end10:
	.size	swap_endianness, .Lfunc_end10-swap_endianness
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
	j	.LBB11_1
.LBB11_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	li	a2, 0
	li	a1, 48
	sw	a2, -28(s0)                     # 4-byte Folded Spill
	bne	a0, a1, .LBB11_3
	j	.LBB11_2
.LBB11_2:                               #   in Loop: Header=BB11_1 Depth=1
	lw	a0, -20(s0)
	slti	a0, a0, 32
	sw	a0, -28(s0)                     # 4-byte Folded Spill
	j	.LBB11_3
.LBB11_3:                               #   in Loop: Header=BB11_1 Depth=1
	lw	a0, -28(s0)                     # 4-byte Folded Reload
	andi	a0, a0, 1
	beqz	a0, .LBB11_5
	j	.LBB11_4
.LBB11_4:                               #   in Loop: Header=BB11_1 Depth=1
	lw	a0, -20(s0)
	addi	a0, a0, 1
	sw	a0, -20(s0)
	j	.LBB11_1
.LBB11_5:
	j	.LBB11_6
.LBB11_6:                               # =>This Inner Loop Header: Depth=1
	lw	a1, -20(s0)
	li	a0, 31
	blt	a0, a1, .LBB11_8
	j	.LBB11_7
.LBB11_7:                               #   in Loop: Header=BB11_6 Depth=1
	lw	a0, -12(s0)
	lw	a1, -20(s0)
	addi	a2, a1, 1
	sw	a2, -20(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	lw	a1, -16(s0)
	lw	a2, -24(s0)
	addi	a3, a2, 1
	sw	a3, -24(s0)
	add	a1, a1, a2
	sb	a0, 0(a1)
	j	.LBB11_6
.LBB11_8:
	lw	a0, -24(s0)
	bnez	a0, .LBB11_10
	j	.LBB11_9
.LBB11_9:
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	addi	a2, a1, 1
	sw	a2, -24(s0)
	add	a1, a0, a1
	li	a0, 48
	sb	a0, 0(a1)
	j	.LBB11_10
.LBB11_10:
	lw	a0, -16(s0)
	lw	a1, -24(s0)
	add	a1, a0, a1
	li	a0, 0
	sb	a0, 0(a1)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end11:
	.size	remove_zeros, .Lfunc_end11-remove_zeros
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
	j	.LBB12_1
.LBB12_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -16(s0)
	bge	a0, a1, .LBB12_4
	j	.LBB12_2
.LBB12_2:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a1, -12(s0)
	lw	a0, -20(s0)
	mul	a0, a0, a1
	sw	a0, -20(s0)
	j	.LBB12_3
.LBB12_3:                               #   in Loop: Header=BB12_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB12_1
.LBB12_4:
	lw	a0, -20(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end12:
	.size	calculate_pot, .Lfunc_end12-calculate_pot
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
	sw	a1, -20(s0)
	sw	a0, -24(s0)
	j	.LBB13_1
.LBB13_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB13_4
	j	.LBB13_2
.LBB13_2:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a1, -20(s0)
	lw	a0, -24(s0)
	not	a0, a0
	add	a1, a0, a1
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
	j	.LBB13_3
.LBB13_3:                               #   in Loop: Header=BB13_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB13_1
.LBB13_4:
	lw	a0, -16(s0)
	lw	ra, 28(sp)                      # 4-byte Folded Reload
	lw	s0, 24(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 32
	ret
.Lfunc_end13:
	.size	binary_to_decimal, .Lfunc_end13-binary_to_decimal
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
	sw	a0, -16(s0)
	lw	a0, -12(s0)
	call	string_lenght
	sw	a0, -20(s0)
	li	a0, 2
	sw	a0, -24(s0)
	j	.LBB14_1
.LBB14_1:                               # =>This Inner Loop Header: Depth=1
	lw	a0, -24(s0)
	lw	a1, -20(s0)
	bge	a0, a1, .LBB14_15
	j	.LBB14_2
.LBB14_2:                               #   in Loop: Header=BB14_1 Depth=1
	lw	a0, -12(s0)
	lw	a1, -24(s0)
	add	a0, a0, a1
	lbu	a0, 0(a0)
	sb	a0, -25(s0)
	lbu	a0, -25(s0)
	li	a1, 48
	blt	a0, a1, .LBB14_5
	j	.LBB14_3
.LBB14_3:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 57
	blt	a0, a1, .LBB14_5
	j	.LBB14_4
.LBB14_4:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -48
	sw	a0, -32(s0)
	j	.LBB14_13
.LBB14_5:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a0, -25(s0)
	li	a1, 65
	blt	a0, a1, .LBB14_8
	j	.LBB14_6
.LBB14_6:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 70
	blt	a0, a1, .LBB14_8
	j	.LBB14_7
.LBB14_7:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -55
	sw	a0, -32(s0)
	j	.LBB14_12
.LBB14_8:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a0, -25(s0)
	li	a1, 97
	blt	a0, a1, .LBB14_11
	j	.LBB14_9
.LBB14_9:                               #   in Loop: Header=BB14_1 Depth=1
	lbu	a1, -25(s0)
	li	a0, 102
	blt	a0, a1, .LBB14_11
	j	.LBB14_10
.LBB14_10:                              #   in Loop: Header=BB14_1 Depth=1
	lbu	a0, -25(s0)
	addi	a0, a0, -87
	sw	a0, -32(s0)
	j	.LBB14_11
.LBB14_11:                              #   in Loop: Header=BB14_1 Depth=1
	j	.LBB14_12
.LBB14_12:                              #   in Loop: Header=BB14_1 Depth=1
	j	.LBB14_13
.LBB14_13:                              #   in Loop: Header=BB14_1 Depth=1
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
	j	.LBB14_14
.LBB14_14:                              #   in Loop: Header=BB14_1 Depth=1
	lw	a0, -24(s0)
	addi	a0, a0, 1
	sw	a0, -24(s0)
	j	.LBB14_1
.LBB14_15:
	lw	a0, -16(s0)
	lw	ra, 44(sp)                      # 4-byte Folded Reload
	lw	s0, 40(sp)                      # 4-byte Folded Reload
	addi	sp, sp, 48
	ret
.Lfunc_end14:
	.size	hexa_to_decimal, .Lfunc_end14-hexa_to_decimal
                                        # -- End function
	.globl	main                            # -- Begin function main
	.p2align	2
	.type	main,@function
main:                                   # @main
# %bb.0:
	addi	sp, sp, -816
	sw	ra, 812(sp)                     # 4-byte Folded Spill
	sw	s0, 808(sp)                     # 4-byte Folded Spill
	addi	s0, sp, 816
	li	a0, 0
	sw	a0, -12(s0)
	addi	a1, s0, -32
	li	a2, 20
	call	read
	sw	a0, -36(s0)
	lbu	a0, -31(s0)
	li	a1, 120
	bne	a0, a1, .LBB15_4
	j	.LBB15_1
.LBB15_1:
	addi	a0, s0, -32
	call	hexa_to_decimal
	sw	a0, -40(s0)
	lw	a0, -40(s0)
	addi	a1, s0, -73
	sw	a1, -684(s0)                    # 4-byte Folded Spill
	call	decimal_to_binary
	lw	a0, -684(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -106
	sw	a1, -688(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a0, -688(s0)                    # 4-byte Folded Reload
	lw	a1, -684(s0)                    # 4-byte Folded Reload
	call	remove_zeros
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	li	a0, 1
	sw	a0, -680(s0)                    # 4-byte Folded Spill
	li	a2, 2
	call	write
	lw	a0, -684(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -684(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -680(s0)                    # 4-byte Folded Reload
	call	write
	lw	a2, -680(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	mv	a0, a2
	call	write
	lw	a0, -40(s0)
	addi	a1, s0, -139
	sw	a1, -676(s0)                    # 4-byte Folded Spill
	call	convert_to_string2
	lw	a0, -676(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -172
	call	invert_string
	lw	a0, -40(s0)
	bgez	a0, .LBB15_3
	j	.LBB15_2
.LBB15_2:
	lui	a0, %hi(.L.str.2)
	addi	a1, a0, %lo(.L.str.2)
	li	a2, 1
	mv	a0, a2
	call	write
	j	.LBB15_3
.LBB15_3:
	addi	a0, s0, -172
	sw	a0, -720(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -720(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	li	a0, 1
	sw	a0, -692(s0)                    # 4-byte Folded Spill
	call	write
	lw	a2, -692(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	sw	a1, -696(s0)                    # 4-byte Folded Spill
	mv	a0, a2
	call	write
	addi	a0, s0, -32
	sw	a0, -716(s0)                    # 4-byte Folded Spill
	call	string_lenght
	lw	a1, -716(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -692(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -696(s0)                    # 4-byte Folded Reload
	lw	a2, -692(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	addi	a0, s0, -106
	addi	a1, s0, -205
	sw	a1, -712(s0)                    # 4-byte Folded Spill
	call	swap_endianness
	lw	a0, -712(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -73
	sw	a1, -708(s0)                    # 4-byte Folded Spill
	call	remove_zeros
	lw	a0, -708(s0)                    # 4-byte Folded Reload
	call	binary_to_decimal
	sw	a0, -212(s0)
	lw	a0, -212(s0)
	addi	a1, s0, -245
	sw	a1, -704(s0)                    # 4-byte Folded Spill
	call	convert_to_string
	lw	a0, -704(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -278
	sw	a1, -700(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a0, -700(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -700(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -692(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -696(s0)                    # 4-byte Folded Reload
	lw	a2, -692(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	j	.LBB15_8
.LBB15_4:
	lbu	a0, -32(s0)
	li	a1, 45
	bne	a0, a1, .LBB15_6
	j	.LBB15_5
.LBB15_5:
	addi	a0, s0, -32
	sw	a0, -760(s0)                    # 4-byte Folded Spill
	call	convert_to_number
	sw	a0, -284(s0)
	lw	a1, -284(s0)
	li	a0, 0
	sub	a0, a0, a1
	sw	a0, -284(s0)
	lw	a0, -284(s0)
	addi	a1, s0, -317
	sw	a1, -764(s0)                    # 4-byte Folded Spill
	call	decimal_to_binary
	lw	a0, -764(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -350
	sw	a1, -744(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a1, -764(s0)                    # 4-byte Folded Reload
	lw	a0, -744(s0)                    # 4-byte Folded Reload
	call	remove_zeros
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	li	a0, 1
	sw	a0, -724(s0)                    # 4-byte Folded Spill
	li	a2, 2
	sw	a2, -752(s0)                    # 4-byte Folded Spill
	call	write
	lw	a0, -764(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -764(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -724(s0)                    # 4-byte Folded Reload
	call	write
	lw	a2, -724(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	sw	a1, -728(s0)                    # 4-byte Folded Spill
	mv	a0, a2
	call	write
	lw	a0, -760(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -760(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -724(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -728(s0)                    # 4-byte Folded Reload
	lw	a2, -724(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	lw	a0, -284(s0)
	addi	a1, s0, -359
	sw	a1, -756(s0)                    # 4-byte Folded Spill
	call	decimal_to_hexa
	lw	a0, -756(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -368
	sw	a1, -748(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a2, -752(s0)                    # 4-byte Folded Reload
	lw	a0, -724(s0)                    # 4-byte Folded Reload
	lui	a1, %hi(.L.str.3)
	addi	a1, a1, %lo(.L.str.3)
	call	write
	lw	a0, -748(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -748(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -724(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -728(s0)                    # 4-byte Folded Reload
	lw	a2, -724(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	lw	a0, -744(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -401
	sw	a1, -740(s0)                    # 4-byte Folded Spill
	call	swap_endianness
	lw	a1, -740(s0)                    # 4-byte Folded Reload
	mv	a0, a1
	call	remove_zeros
	lw	a0, -740(s0)                    # 4-byte Folded Reload
	call	binary_to_decimal
	sw	a0, -408(s0)
	lw	a0, -408(s0)
	addi	a1, s0, -441
	sw	a1, -736(s0)                    # 4-byte Folded Spill
	call	convert_to_string
	lw	a0, -736(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -474
	sw	a1, -732(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a0, -732(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -732(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -724(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -728(s0)                    # 4-byte Folded Reload
	lw	a2, -724(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	j	.LBB15_7
.LBB15_6:
	addi	a0, s0, -32
	sw	a0, -804(s0)                    # 4-byte Folded Spill
	call	convert_to_number
	sw	a0, -480(s0)
	lw	a0, -480(s0)
	addi	a1, s0, -513
	sw	a1, -808(s0)                    # 4-byte Folded Spill
	call	decimal_to_binary
	lw	a0, -808(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -546
	sw	a1, -788(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a1, -808(s0)                    # 4-byte Folded Reload
	lw	a0, -788(s0)                    # 4-byte Folded Reload
	call	remove_zeros
	lui	a0, %hi(.L.str)
	addi	a1, a0, %lo(.L.str)
	li	a0, 1
	sw	a0, -768(s0)                    # 4-byte Folded Spill
	li	a2, 2
	sw	a2, -796(s0)                    # 4-byte Folded Spill
	call	write
	lw	a0, -808(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -808(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -768(s0)                    # 4-byte Folded Reload
	call	write
	lw	a2, -768(s0)                    # 4-byte Folded Reload
	lui	a0, %hi(.L.str.1)
	addi	a1, a0, %lo(.L.str.1)
	sw	a1, -772(s0)                    # 4-byte Folded Spill
	mv	a0, a2
	call	write
	lw	a0, -804(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -804(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -768(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -772(s0)                    # 4-byte Folded Reload
	lw	a2, -768(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	lw	a0, -480(s0)
	addi	a1, s0, -555
	sw	a1, -800(s0)                    # 4-byte Folded Spill
	call	decimal_to_hexa
	lw	a0, -800(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -564
	sw	a1, -792(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a2, -796(s0)                    # 4-byte Folded Reload
	lw	a0, -768(s0)                    # 4-byte Folded Reload
	lui	a1, %hi(.L.str.3)
	addi	a1, a1, %lo(.L.str.3)
	call	write
	lw	a0, -792(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -792(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -768(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -772(s0)                    # 4-byte Folded Reload
	lw	a2, -768(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	lw	a0, -788(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -597
	sw	a1, -784(s0)                    # 4-byte Folded Spill
	call	swap_endianness
	lw	a1, -784(s0)                    # 4-byte Folded Reload
	mv	a0, a1
	call	remove_zeros
	lw	a0, -784(s0)                    # 4-byte Folded Reload
	call	binary_to_decimal
	sw	a0, -604(s0)
	lw	a0, -604(s0)
	addi	a1, s0, -637
	sw	a1, -780(s0)                    # 4-byte Folded Spill
	call	convert_to_string
	lw	a0, -780(s0)                    # 4-byte Folded Reload
	addi	a1, s0, -670
	sw	a1, -776(s0)                    # 4-byte Folded Spill
	call	invert_string
	lw	a0, -776(s0)                    # 4-byte Folded Reload
	call	string_lenght
	lw	a1, -776(s0)                    # 4-byte Folded Reload
	mv	a2, a0
	lw	a0, -768(s0)                    # 4-byte Folded Reload
	call	write
	lw	a1, -772(s0)                    # 4-byte Folded Reload
	lw	a2, -768(s0)                    # 4-byte Folded Reload
	mv	a0, a2
	call	write
	j	.LBB15_7
.LBB15_7:
	j	.LBB15_8
.LBB15_8:
	li	a0, 0
	lw	ra, 812(sp)                     # 4-byte Folded Reload
	lw	s0, 808(sp)                     # 4-byte Folded Reload
	addi	sp, sp, 816
	ret
.Lfunc_end15:
	.size	main, .Lfunc_end15-main
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
.Lfunc_end16:
	.size	_start, .Lfunc_end16-_start
                                        # -- End function
	.type	.L__const.decimal_to_hexa.hex_digits,@object # @__const.decimal_to_hexa.hex_digits
	.section	.rodata.str1.1,"aMS",@progbits,1
.L__const.decimal_to_hexa.hex_digits:
	.asciz	"0123456789abcdef"
	.size	.L__const.decimal_to_hexa.hex_digits, 17

	.type	.L.str,@object                  # @.str
.L.str:
	.asciz	"0b"
	.size	.L.str, 3

	.type	.L.str.1,@object                # @.str.1
.L.str.1:
	.asciz	"\n"
	.size	.L.str.1, 2

	.type	.L.str.2,@object                # @.str.2
.L.str.2:
	.asciz	"-"
	.size	.L.str.2, 2

	.type	.L.str.3,@object                # @.str.3
.L.str.3:
	.asciz	"0x"
	.size	.L.str.3, 3

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
	.addrsig_sym convert_to_string2
	.addrsig_sym swap_endianness
	.addrsig_sym remove_zeros
	.addrsig_sym calculate_pot
	.addrsig_sym binary_to_decimal
	.addrsig_sym hexa_to_decimal
	.addrsig_sym main
