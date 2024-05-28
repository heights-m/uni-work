.data
	arr: .word 14, -5, 0, 3 , 9 , 24, 7
	res: .asciiz "\nSum of array is: "
.text
main:#excs 1
	la $a0, arr
	li $a1, 7
	jal printarr

	li $v0, 10
	syscall

printarr:
	addi $sp, $sp, -20
	sw $ra, 16($sp)
	sw $a0, 12($sp)
	sw $a1, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	move $t0, $a0		#addr in t0
	lw $a0, 0($t0)
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
	li $t1, 1
	bne $a1, $t1, else	#if len != 1, else
		addi $sp, $sp, 20
		jr $ra
else:
	addi $a1, $a1, -1	#decr len
	move $a0, $t0
	addi $a0, $a0, 4
	jal printarr
	lw $t1, 0($sp)
	lw $t0, 4($sp)
	lw $a1, 8($sp)
	lw $a0, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20
	jr $ra
	#print elem of current index
	#if len = 1, return
	#else decrement len
	#increment arr pointer
	#recurse
