.data 
	s1: .asciiz "abcdefg"
	s2: .asciiz "abcdefz"
	txt: .asciiz "Result: "
.text
main:

strcmp:
	addi $sp, $sp,

iter:
	lb $t0, 0($a0)		#get char from s1
	lb $t1, 0($a1)		#get char from s2
	beq $t0, $t1, cont	#if chars equal, cont
		bgt $t1, $t0,	#if s2 > s1, 
		li $v0, -1		#set v0 = -1
		j end			

cont:
