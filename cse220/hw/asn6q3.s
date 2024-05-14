.data
entr: .asciiz "Enter an odd pos int: "
.text
main:
	la, $a0, entr
	li $v0, 4
	syscall

	li $t0, 0			#count = t0
	li $v0, 5
	syscall
	move $t1, $v0		#n = t1

	li $t2, 5
	andi $t2, $t1, 1	#find if odd
	beq $t2, $t0, end	#if even, end
	ble $t1, $t2, end	#if smaller than 5, end
						#1 & 3 not hollow

hd:	li $a0, '*'			#print *
	li $v0, 11
	syscall
	addi $t0, $t0, 1	#increment count

	blt $t0, $t1, hd	#if count < n, hd

	li $t0, 2			#linecount = t0
	li $t2, 1			#charcount = t2
	sub $t3, $t1, $t2	#n-1
	sra $t3, $t3, 1		#/2
	addi $t3, $t3, 1	#+1 numlines = t3
	
body:
	li $t2, 1			#charcount = 1
	li $a0, '\n'
	li $v0, 11
	syscall
iter:
	beq $t2, $t0, astx	#if charcnt = linecnt, astx
	sub $t4, $t1, $t0
	addi, $t4, $t4, 1	#get n - linecnt + 1
	beq $t2, $t4, astx	#if charcnt = ^, astx

	li $a0, ' '
	li $v0, 11
	syscall
	j skipastx
astx:
	li $a0, '*'
	li $v0, 11
	syscall
skipastx:
	addi $t2, $t2, 1	#increment charcnt
	blt $t2, $t1, iter	#if charcnt < n, iter
	addi $t0, $t0, 1	#increment linecount
	blt $t0, $t3, body	#if linecnt < numlines, body
	
	li $t2, 1			#charcnt = 1
	li $a0, '\n'
	li $v0, 11
	syscall
	
tl:	li $a0, ' '
	li $v0, 11
	syscall

	addi $t2, $t2, 1	#increment charcnt
	blt $t2, $t3, tl	#if charcnt < numlines, tl

	li $a0, '*'
	li $v0, 11
	syscall
end:
	li $v0, 10
	syscall

#algo
#1 init count 0
#2 get n
#3 if n is not odd || positive, end
#4 print *
#5 incr count
#6 if count < n, go to 4
#7 set numlines to (n-1)/2+1
#8 set linecount to 2
#9 set charcnt to 1 & print '\n'
#10 if charcnt = linecount, go to 12.2
#11 if charcnt = n - linecount + 1, go to 12.2
#12 print ' '
#	go to 13
#	print *
#13 incr linecount
#14 if linecount < numlines, go to 9
#15 set charcnt to 1
#16 print ' '
#17 incr charcnt
#18 if charcnt < numlines, go to 16
#19 print *
#20 end
#
