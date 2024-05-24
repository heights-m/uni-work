.data
	arr: .word 0, -3, 6, 24, -9, -12, 4, 18, -6, -4
	posi: .asciiz "No. of positive integers: "
	negi: .asciiz "\nNo. of negative integers: "
.text
main:
	la $t0, arr			#pointer in t0
	li $t1, 0			#index in t1
	li $t2, 10			#limit in t2
	li $t3, 0			#pos_count in t3
	li $t5, 0			#neg_count in t5
	###counting positive
iter1:
	lw $t4, 0($t0)		#get element from arr
	bltz $t4, skippos	#if elem is negative, skip
	addi $t3, $t3, 1	#increment pos_count
	jr skipneg
skippos:
	addi $t5, $t5, 1	#increment neg_count
skipneg:
	addi $t0, $t0, 4	#increment pointer
	addi $t1, $t1, 1	#increment index
	blt $t1, $t2, iter1	#if index < limit, iter1

	la $a0, posi
	li $v0, 4
	syscall				#print text
	move $a0, $t3		
	li $v0, 1
	syscall				#print pos_count

	la $a0, negi
	li $v0, 4
	syscall				#print text
	move $a0, $t5		
	li $v0, 1
	syscall				#print neg_count

	li $v0, 10
	syscall
