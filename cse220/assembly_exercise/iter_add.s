.data
entr: .asciiz "Enter integer: "
result: .asciiz "Result of multiplication: "
.text
main: la $a0, entr
	li $v0, 4
	syscall				#print string
	li $t2 0			#set result to 0
	li $t3 0			#set count to 0			
	li $v0, 5	
	syscall
	move $t0, $v0		#write n1 to t0
	li $v0, 4
	syscall				#print string
	li $v0, 5
	syscall
	move $t1, $v0		#write n2 to t1
	ble $t1, $t2, end	#if n2 <= 0, end
again:	add $t2, $t2, $t0	#add n1 to result
	addi $t3, $t3, 1	#incr count
	blt $t3, $t1, again
end: la $a0, result
	li $v0, 4
	syscall
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 10
	syscall

#algoritm plan
#read n1 and n2
#init result to 0
#add n1 to init
#decrement n2
#if n2 > 0, go back to add
#print result
