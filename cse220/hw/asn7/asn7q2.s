.data
	arr: .space 40
	entr: .asciiz "Enter an integer: "
	arrprin: .asciiz "Array: "
	sortarr: .asciiz "\nSorted array: "
.text
main:
	la $t0, arr				#pointer in t0
	li $t1, 10				#limit in t1
	li $t2, 0				#count in t2

getarr:
	la $a0, entr
	li $v0, 4
	syscall					#print prompt
	li $v0, 5
	syscall					#get int

	sw $v0, 0($t0)			#add to arr
	addi $t0, $t0, 4		#increment pointer
	addi $t2, $t2, 1		#increment count
	blt $t2, $t1, getarr	#if count < lim, getarr
	
	la $a0, arrprin
	li $v0, 4
	syscall
	la $a0, arr				#move address to a0
	li $a1, 10				#limit to a1
	jal printarr

	la $t0, arr				#reset pointer
	li $t2, 0				#reset count
	li $t3, 1				#index in t3

sort:
	lw $t5, 0($t0)			#get first elem = min
	move $t6, $t0			#min address
	move $t7, $t0			#save start index
	addi $t0, $t0, 4		#incr address
loop:
	lw $t4, 0($t0)			#get elem
	bge $t4, $t5, skip		#if elem >= min, skip
	move $t5, $t4			#min = elem
	move $t6, $t0			#min_addr = current
skip:
	addi $t2, $t2, 1		#incr count
	addi $t0, $t0, 4		#incr address
	blt $t2, $t1, loop		#if count < lim, loop

	lw $t4, 0($t7)			#get elem at start
	sw $t5, 0($t7)			#start index = min
	sw $t4, 0($t6)			#prev min index = start

	addi $t3, $t3, 1		#incr index
	move $t2, $t3			#count = index
	move $t0, $t7			#set addr to prev start point
	addi $t0, $t0, 4		#increment addr
	blt $t3, $t1, sort		#if index < lim, sort

	la $a0, sortarr 
	li $v0, 4
	syscall
	la $a0, arr				#move address to a0
	li $a1, 10				#limit to a1
	jal printarr

	li $v0, 10
	syscall

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
