.data
entr: .asciiz "Enter int N: "
max: .asciiz "Max: "
.text
main: la $a0, entr
	li $v0, 4
	syscall
	li $t0 0				#var max
	li $t1 0				#var count
	li $v0, 5				#get N
	syscall
	move $t2, $v0			#write N into t2
	ble $t2, $t1, end		#if N <= 0, end
	la $a0, entr
	li $v0, 4
	syscall
	li $v0, 5				#get 1st input
	syscall
	move $t0, $v0			#write input into max
	addi $t1, $t1, 1		#increment count
	j check					#if count>=N, end
again: la $a0, entr
	li $v0, 4
	syscall
	li $v0, 5
	syscall					#get next input
	move $t3, $v0			#write input into t3
	addi $t1, $t1, 1		#incr count
	bgt $t3, $t0, rewrite	#if input>max, rewrite
check: blt $t1, $t2, again	#if count<N, again
	la $a0, max			
	li $v0, 4				#print max string
	syscall
	li $v0, 1			
	move $a0, $t0			#print max
	syscall
end: li $v0, 10				#exit
	syscall
rewrite: 
	move $t0, $t3			#rewrite max
	j check	

