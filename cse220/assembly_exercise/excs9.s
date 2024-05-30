.data
	arr: .word -3 -1 0 4 6 9 13
.text
main:
	la $a0, arr
	li $a1, 7
	li $a2, 2
	jal binsch
	move $a0, $v0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

binsch:
	addi $sp, $sp, -24
	sw $t3, 20($sp)
	sw $t4, 16($sp)
	sw $ra, 12($sp)
	sw $t2, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	li $t0, 0
	addi $t1, $a1, -1
	li $t2, 2
	div $t1, $t2
	mflo $a1 
	li $t2, 4
	mul $t2, $t2, $a1
	add $a0, $a0, $t2
	jal iter

	lw $t3, 20($sp)
	lw $t4, 16($sp)
	lw $ra, 12($sp)
	lw $t2, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 24
	jr $ra

iter:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $t4, 0($a0)
	bne $t4, $a2, else
		li $v0, 1
		addi $sp, $sp, 4
		jr $ra
else:
	li $t0, 1
	beq $t0, $a1, end
	beq $t1, $a1, end
	sub $t3, $t1, $t0	#high - low
	li $t2, 2
	div $t3, $t2		#diff / 2
	blt $a2, $t4, less

	move $t0, $a1		#low = mid
	mflo $t3
	add $a1, $a1, $t3   #new mid
	li $t2, 4
	mul $t3, $t3, $t2	#get pointer change val
	add $a0, $a0, $t3	#change pointer to mid
	j rec
less:
	move $t1, $a1		#high = mid
	sub $a1, $a1, $t3	#new mid
	li $t2, 4
	mul $t3, $t3, $t2	#get pointer change val
	sub $a0, $a0, $t3
rec:
	jal iter

	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

end:
		li $v0, 0
		addi $sp, $sp, 4
		jr $ra
