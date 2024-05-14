.data
entr: .asciiz "Enter a sentence: "
res: .asciiz "Num. of 'c's in sentence: "
.text
main:
	la, $a0, entr
	li $v0, 4
	syscall

	li $t0, 'c'			#t0 is 'c'
	li $t1, '\n'		#t1 is newline
	li $t4, 0			#t4 is count
iter:
	li $v0, 12
	syscall
	move $t3, $v0		#char in t3

	bne $t3, $t0, chk	#if char != 'c', check
	addi $t4, $t4, 1	#increment count
chk:
	bne $t3, $t1, iter	#if char != '\n', iter

	la, $a0, res
	li $v0, 4
	syscall

	move $a0, $t4
	li $v0, 1
	syscall

	li $v0, 10
	syscall

#algo
#1 init count to 0
#2 init newline to \n
#3 get char c
#4 if c != 'c', go to 6
#5 incr count
#6 if c != newline, go to 3
#7 print count
