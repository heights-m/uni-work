.data
	arr: .word 14, -5, 0, 3 , 9 , 24, 7
	res: .asciiz "\nSum of array is: "
.text
main:#excs 1
	la $a0, arr
	li $a1, 7
	jal printarr
	#excs 2
	la $a0, arr
	li $a1, 7
	jal arrsum
	move $t0, $v0		#func result in t0
	la $a0, res
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

arrsum:
	addi $sp, $sp, -20
	sw $t0, 16($sp)
	sw $t1, 12($sp)
	sw $t2, 8($sp)
	sw $t3, 4($sp)
	sw $t4, 0($sp)

	move $t0, $a0		#pointer in t0
	move $t1, $a1		#len in t1
	li $t2, 0			#sum in t2
	li $t3, 0			#counter in t3
iter1:
	lw $t4, 0($t0)		#get elem in t4
	add $t2, $t2, $t4	#add to sum
	addi $t0, $t0, 4	#incr pointer
	addi $t3, $t3, 1	#incr counter
	blt $t3, $t1, iter1	
	add $v0, $t2, $0

	lw $t4, 0($sp)
	lw $t3, 4($sp)
	lw $t2, 8($sp)
	lw $t1, 12($sp)
	lw $t0, 16($sp)
	addi $sp, $sp, 20
	jr $ra

printarr:
	addi $sp, $sp, -16
	sw $t0, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)

	li $t0, 0			#counter = t0
	move $t1, $a1		#limit = t1
	move $t2, $a0		#pointer = t2
iter: 
	lw $t3, 0($t2)		#get elem
	move $a0, $t3
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
	addi $t2, $t2, 4	#incr pointer
	addi $t0, $t0, 1	#incr counter
	blt $t0, $t1, iter
	
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $t0, 12($sp)
	addi $sp, $sp, 16
	jr $ra
