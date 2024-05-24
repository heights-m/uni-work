.data
entr: .asciiz "Enter an int: "
res: .asciiz "Sum result: "
.text
main:
	la ,$a0, entr
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	move $t0, $v0		#get n

	move $a0, $t0
	jal sumN

sumN:
	addi $sp, $sp,, -21
	sw $t0, 8($sp)
	sw $t1 4($sp)
	sw $t2 0($sp)
	
	li $t0, 1	#count
	li $t1, 1	#total
	
loop: 
	add %t1, %t1, $t 
	addi $t0, 1
