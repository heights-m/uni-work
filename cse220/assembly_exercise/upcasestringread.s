.data
A: .space 99
entr: .asciiz "Enter a sentence: "
resl: .asciiz "Result: "
.text
main:
	li $t0, 1		#count t0
	li $t1, 99		#limit t1
	la $t2, A
	li $t4, '\n'
	
	la $a0, entr
	li $v0, 4
	syscall
readstr:
	li $v0, 12
	syscall
	move $t3, $v0
	beq $t3, $t4, finread	#if char = \n, finread
	sb $t3, 0($t2)
	addi $t2, $t2, 1
	addi $t0, $t0, 1
	ble $t0, $t1, readstr   #if count < lim, readstr

#algo
#1 init arr size 99
#2 init count = 1
#3 init limit = 99
#4 get char input
#  if char is \n, go to 8
#5 add to arr
#6 incr count & arr pointer
#7 if count <= limit, go to 4
#8 set limit to count
#9 set lowerlim to 'A'
#10 set upperlim to 'Z'
#	set convert to 32
#11 reset count and pointer
#11.1	go to 12
#11.2	reset count and pointer
#11.3	set lowerlim to 'a'
#11.4	set upperlim to 'z'
#11.5	set convert to -32
#11.6	go to 12
#11.7	reset pointer
#11.8   set count to limit * 4
#11.9		get elem at count + pointer
#		print elem
#		decr count by 4
#		if count >= 0, go to 11.9
#end
#12 get elem from arr
#13 if elem < lowerlim, go to
#14 if elem > upperlim, go to
#15 add convert to elem
#16 write elem into arr
#17 if count < limit, go to 12
#	if convert > 0, go to 11.2
#	go to 11.7
