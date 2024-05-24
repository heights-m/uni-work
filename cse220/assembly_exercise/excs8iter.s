.data
	str: .asciiz "The apple arduently carries an agonya"
.text
main:
	la $a0, str
	li $a1, 37
	jal rplace_a

	la $a0, str
	li $v0, 4
	syscall
	li $v0, 10
	syscall

rplace_a:
	addi $sp, $sp, -24
	sw $t0, 20($sp)
	sw $t1, 16($sp)
	sw $t2, 12($sp)
	sw $t3, 8($sp)
	sw $t4, 4($sp)
	sw $t5, 0($sp)

	move $t0, $a0		#pointer in t0
	move $t1, $a1		#len in t1
	li $t2, 0			#counter in t2
	li $t4, 'a'
	li $t5, '#'
iter:
	lb $t3, 0($t0)		#get char
	bne $t3, $t4, skip
	sb $t5, 0($t0)		#rewrite with #
skip:
	addi $t0, $t0, 1	#incr pointer
	addi $t2, $t2, 1	#incr counter
	blt $t2, $t1, iter
	
	lw $t5, 0($sp)
	lw $t4, 4($sp)
	lw $t3, 8($sp)
	lw $t2, 12($sp)
	lw $t1, 16($sp)
	lw $t0, 20($sp)
	addi $sp, $sp, 24
	jr $ra
