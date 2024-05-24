.data
	arr: .space 40
	entr: .asciiz "Enter integer: "
.text
main:
	la $a0, arr
	li $a1, 10
	jal readint
	li $v0, 10
	syscall

readint:
	addi $sp, $sp, -12
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)

	move $t0, $a0		#pointer in t0
	move $t1, $a1		#len in t1
	li $t2, 0			#counter in t2
iter:
	la $a0, entr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t0)		#store int
	addi $t0, $t0, 4	#incr pointer
	addi $t2, $t2, 1	#incr counter
	blt $t2, $t1, iter
	
	lw $t2, 0($sp)
	lw $t1, 4($sp)
	lw $t0, 8($sp)
	addi $sp, $sp, 12
	jr $ra
