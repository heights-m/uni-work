.data
str: .asciiz "Enter a number "
outstr: .asciiz "The sum is "
.text
main: la $a0, str
	li $v0, 4
	syscall
	li $t0, 0
	li $t1, 1
	li $v0, 5
	syscall
	move $t2, $v0
again: 	add $t0, $t0, $t1
	addi $t1, $t1, 1
	ble $t1, $t2, again
	la $a0, outstr
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall
