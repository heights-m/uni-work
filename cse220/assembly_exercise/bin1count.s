.data
entr: .asciiz "\nEnter int: "
result: .asciiz "No. of 1's in binary: "
.text
main: 
	la, $a0, entr
	li $v0, 4
	syscall			

	li $t0, 0				#count 0 in t0
	li $t1, 1				#mask in t1
	li $t4, 0				#zero ref val
	li $v0, 5				#get n
	syscall
	move $t2, $v0			#n in t2

again: 
	and $t3, $t1, $t2		# & mask and n
	beq $t4, $t3, skipincr	# if & result = 0, skip incr
	addi $t0, $t0, 1
skipincr: 
	sll $t1, $t1, 1			#bitshift mask
	bne $t1, $t4, again		#if mask!=0, again

	la, $a0, result
	li $v0, 4
	syscall
	move $a0, $t0			#move count
	li $v0, 1
	syscall
	li $v0, 10
	syscall

#algo
#1 init count 0
#2 get int n
#3 init mask 1
#4 get and of mask and n
#5 if and != 0, go to 7
#6 incr count
#7 bitshif mask by 1
#8 if mask != 0, go to 4
#9 print result

