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
	addi $sp, $sp, 
	lw $a0, 
	lw $a1
	lw $t0
	move $t0, $a0
	lw
	#print elem of current index
	#if len = 1, return
	#else decrement len
	#increment arr pointer
	#recurse
