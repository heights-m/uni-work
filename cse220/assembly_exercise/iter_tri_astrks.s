.data
entr: .asciiz "Enter an int: "
astrks: .asciiz "* "
newln: .asciiz "\n"
.text
main: la $a0, entr
	li $v0, 4
	syscall
	li $t0 1			#init count to t0
	li $t1 0			#init index to t1
	li $v0, 5			#get N
	syscall
	move $t2, $v0		#write n into t2
	ble $t2, $t1, end
again:	la $a0, astrks
	li $v0, 4
	syscall				#print astrks
	addi $t1, $t1, 1	#incr index
	blt $t1, $t0, again	#if index < count, again
	addi $t0, $t0, 1	#incr count
	li $t1 0			#index = 0
	la $a0, newln
	li $v0, 4
	syscall				#print newline
	ble $t0, $t2, again	#if count <= n, again
end: li $v0, 10
	syscall

#algorithm
#1 get int n
#2 init count 1
#3 init index 0
#4 print "* "
#5 increment index
#6 if index < count, go to 4
#7 increment count
#  set index to 0
#8 print newline
#9 if count <= n, go to 4
