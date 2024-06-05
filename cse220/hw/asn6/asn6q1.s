.data
entr: .asciiz "Enter integer: "
res: .asciiz "Result is: "
.text
main:
	la, $a0, entr
	li $v0, 4
	syscall

	li $t0, 1			#count is t0
	li $t1, 0			#sum is t1
	li $t2, 1			#mod ref 1 is t2

	li $v0, 5			#get n
	syscall
	move $t3, $v0		#n in t3

	bgt $t0, $t3, end	#if count>n, end

iter:
	mul $t4, $t0, $t0	#t4 haas count^2
	andi $t5, $t0, 1	#get count && 1
	beq $t5, $t2, odd	#if ^ is 1, odd

	sub $t1, $t1, $t4	#sum = sum - count^2
	j chk				#jump to check

odd:
	add $t1, $t1, $t4	#sum = sum + count^2
chk:
	addi $t0, $t0, 1	#increment count
	ble $t0, $t3, iter	#if count <= n, iter

	la, $a0, res		#print result sum
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 1
	syscall
end:
	li $v0, 10
	syscall

#algo
#1 init count to 1
#2 init sum to 0
#3 get n input
#4 if count > n, end
#5 set square to count * count
#6 if count%2 is 1, go to 9
#7 sub square from sum
#8 go to 
#9 add square to sum
#10 incr count
#11 if count <= n, go to 5 
#12 end
