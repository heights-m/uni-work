.data
	A: .space 40
	entr: .asciiz "Enter an int: "
	res: .asciiz "Result: "
.text
main:
	li $t0, 0			#counter in t0 = 0
	li $t1, 10			#limit in t1 = 10
	la, $t2, A			#arr in t2
read:
	la, $a0, entr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	sw $v0, 0($t2)		#store num
	addi $t2, $t2, 4	#incr arr pointer
	addi $t0, $t0, 1	#incr counter
	blt $t0, $t1, read	#if counter < limit, read

	li $t0, 0			#set coutner to 0
	la, $t2, A			#reset pointer
	li $t3, 0			#set ref int t3

	la, $a0, res
	li $v0, 4
	syscall
pos:
	lw $t4, 0($t2)		#get arr elem
	blt $t4, $t3, skip1	#if elem < 0, skip1
	move $a0, $t4
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
skip1:
	addi $t0, $t0, 1	#incr counter
	addi $t2, $t2, 4	#incr pointer
	blt $t0, $t1, pos	#if counter < lim, pos
	
	li $t0, 0			#set coutner to 0
	la, $t2, A			#reset pointer
negi:
	lw $t4, 0($t2)		#get arr elem
	bge $t4, $t3, skip2	#if elem >= 0, skip2
	move $a0, $t4
	li $v0, 1
	syscall
	li $a0, ' '
	li $v0, 11
	syscall
skip2:
	addi $t0, $t0, 1	#incr counter
	addi $t2, $t2, 4	#incr pointer
	blt $t0, $t1, negi	#if counter < lim, neg
	
	li $v0, 10
	syscall


#algo
#1 init array pointer
#2 init counter = 0, limit = 10
#3 read int
#4 store into array
#5 incr counter
#6 if counter < limit, go to 3
#7 set counter = 0, set ref = 0
#8 set pointer to start
#9 get element from array
#10 if elem < ref, go to 12
#11 print elem
#12 increment count and pointer
#13 if count < limit, go to 9
#14 repeat for negative
