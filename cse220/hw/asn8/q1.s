.data
	str: .asciiz "Printed in reverse!"
	txt: .asciiz "String reversed: "
.text
main:
	la $a0, txt
	li $v0, 4
	syscall

	la $a0, str
	jal prinrev

	li $v0, 10
	syscall

prinrev:
	addi $sp, $sp, -12
	sw $a0, 8($sp)
	sw $ra, 4($sp)
	sw $t1, 0($sp)

	lb $t1, 0($a0)		#load currrent char
	bne $t1, $0, else	#if char != '\0', else
	addi $sp, $sp, 12	#restore stack
	jr $ra
else:
	addi $a0, $a0, 1	#increment pointer
	
	jal prinrev


	lw $a0, 8($sp)
	lw $ra, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12	#restore stack

	move $t1, $a0
	lb $a0, 0($t1)		#get current char
	li $v0, 11			#print char in $a0
	syscall
	move $a0, $t1		#restore address in a0

	jr $ra
