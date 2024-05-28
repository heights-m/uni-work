.data
	entr: .asciiz "Enter an integer: "
	rslt: .asciiz "Sum: "
.text
main:
	la $a0, entr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $a1, $v0
	li $a0, 1
	jal sumrec
	move $t0, $v0
	la $a0, rslt
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	li $v0, 10
	syscall

sumrec:
	addi $sp, $sp, -8
	sw $a0, 4($sp)	
	sw $ra, 0($sp)	
	blt $a0, $a1, else		#if x != n, else
	add $v0, $0, $a0		#return n = x
	addi $sp, $sp, 8
	jr $ra
else:
	addi $a0, $a0, 1		#n = n + 1
	jal sumrec				#rec
	lw $ra, 0($sp)			#restore
	lw $a0, 4($sp)
	addi $sp, $sp, 8
	add $v0, $a0, $v0		#n + sumrec(n+1)
	jr $ra
