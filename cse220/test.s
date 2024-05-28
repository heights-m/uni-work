.data
.text
main: li $t0, 5
	addi $t0, $t0, -2
		li $v0, 1
		move $a0, $t0
	syscall

	li $v0, 10
	syscall
