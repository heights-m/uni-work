.data
entr: .asciiz "Enter integer: "
rslt: .asciiz "Multiplication result: "
.text
main:
	la, $a0, entr
	li $v0, 4
	syscall

	li $t0, 1		#mask in t0
	li $t1, 0		#zero ref value
	li $t5, 0		#result in t5

	li $v0, 5		#get n1
	syscall
	move $t2, $v0	#n1 in t2

	li $v0, 4
	syscall
	li $v0, 5		#get n2
	syscall
	move $t3, $v0	#n2 in t3

again:
	and $t4, $t0, $t3		#get mask & n2
	beq $t4, $t1, skipadd	#if ^ = 0, skip add
	add $t5, $t5, $t2		#add n1 to result
skipadd:	
	sll $t0, $t0, 1			#bitshift mask and n1
	sll $t2, $t2, 1
	bne $t0, $t1, again		#if mask != 0, again

	la, $a0, rslt
	li $v0, 4
	syscall
	move $a0, $t5
	li $v0, 1
	syscall
	li $v0, 10
	syscall

#algo
#1 get n1 and n2
#2 set mask to 1
#3 set result to 0
#4 set n2bit to mask & n2
#5 if n2bit = 0, go to 7
#6 add n1 to result
#7 bitshift << mask
#8 bitshift << n1
#9 if mask != 0, go to 4
#10 print result
