.data
	sentn: .space 99 
	entr: .asciiz "Enter a sentence: "
	res: .asciiz "\nWord-reversed: "
.text
main: 
	la $a0, entr
	li $v0, 4
	syscall

	la $t0, sentn			#get address
	li $t1, 100				#len in t1

	move $a0, $t0			#pointer in t0
	move $a1, $t1			#len in t1
	li $v0, 8
	syscall					#read string

	li $t3, ' '				#reference vars
	li $t4, '\n'
	li $t1, 1				#reset len

count:
		lb $t2, 0($t0)		#get char
		beq $t2, $t4, rvprn #if char = '\n', rvprn
		addi $t0, $t0, 1	#next index
		addi $t1, $t1, 1	#increment counter
		j count				#loop
rvprn:
	la $a0, res
	li $v0, 4
	syscall	
	li $t5, 0				#charcount in t5

revs:
	addi $t0, $t0, -1		#go to prev index
	lb $t2, 0($t0)			#get char
	addi $t1, $t1, -1		#decrement counter	
	move $t6, $t0			#copy current address
	beq $t2, $t3, printchk	#if char = ' ', printwrd
	beq $t1, $0, printchk	#if counter = 0, printwrd
	addi $t5, $t5, 1		#increment charcount
	j skipword

printwrd:	
		addi $t6, $t6, 1	#go to next index
		lb $t2, 0($t6)		#get char
		beq $t5, $0, psp	#if charcount = 0, psp
		move $a0, $t2
		li $v0, 11			#print char
		syscall
		addi $t5, $t5, -1	#decrement charcount
		j printwrd

skipword:
	bgtz $t1, revs			#if counter > 0, revs

	li $v0, 10
	syscall

psp:
	move $a0, $t3
	li $v0, 11				#print space
	syscall
	j revs

printchk:
	beq $t5, $0, skipword
	j printwrd

#algo
# (assume start point is ' ' or '\n' = skip)
# go to prev index
# decrement counter
# if char is ' ' OR counter = -1
#	(save current index
#	2 go to next index (using a diff reg as pointer)
#	 if char is ' ' or '\n'
#		(go to start)
#	 print char
#	 go to 2)
#  if counter is not < 0, go to start
