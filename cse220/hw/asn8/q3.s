.data 
	s1: .asciiz "abcdea"
	s2: .asciiz "abcdef"
	txt: .asciiz "Result: "
.text
main:
	la $a0, s1
	la $a1, s2
	jal strcmp

	move $t0, $v0
	la $a0, txt
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall

	li $v0, 10
	syscall

strcmp:
	addi $sp, $sp, -12		#save to stack
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)

	lb $t0, 0($a0)			#get char from s1
	lb $t1, 0($a1)			#get char from s2
	beq $t0, $0, s1end 
	beq $t1, $0, s2end
	beq $t0, $t1, cont		#if chars equal, cont
		bgt $t0, $t1, big	#if s1 > s2, big
		li $v0, -1			#set v0 = -1
		j end
big:
		li $v0, 1			#set v0 = 1
		j end
cont:
	addi $a0, $a0, 1		#incr s1
	addi $a1, $a1, 1		#incr s2
	jal strcmp				#recursive call
end:
	lw $ra, 8($sp)
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12		#deallocate stack
	jr $ra
	
s1end:
	beq $t1, $0, eqlen		#both strings ended
	li $v0, -1				#s1 smaller
	j end
eqlen:
	li $v0, 0
	j end
s2end:						#s2 is shorter
	li $v0, 1
	j end
