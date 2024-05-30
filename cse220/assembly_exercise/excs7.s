.data
	arr: .word 1, 24, 0, 8, 3, 2, -3
.text
main:
	la $a0, arr
	li $a1, 7
	jal getmax
	move $a0, $v0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

getmax:
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $a0, 4($sp)
	sw $t0, 0($sp)

	li $t0, 1
	bne $a1, $t0, else
		addi $sp, $sp, 12
		lw $v0, 0($a0)
		jr $ra
else:
	addi $a0, $a0, 4
	addi $a1, $a1, -1
	jal getmax

	lw $t0, 0($sp)
	lw $a0, 4($sp)
	lw $ra, 8($sp)
	addi $sp, $sp, 12

	lw $t0, 0($a0)
	ble $t0, $v0, skip
		move $v0, $t0
skip:
	jr $ra
