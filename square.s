#This code calculates the square of the number in arg and arg2

	.data	
arg:	.word	0
arg2:	.word	0


	.text
	.globl main
main:
	li $v0, 5
	syscall
	add $14, $v0, $zero #stores input into register 14
	sw $14, arg #places the input into the first spot of arg

	li $v0, 5
	syscall
	add $15, $v0, $zero
	sw $15, arg2

	la	$13, arg	#loads address of arg into register $13
	lw	$12, 0($13) #loads arg into register $12
	lw	$13, 0($13) #loads arg into register $13, overriding the address

	addi	$11, $zero, 0 #places 0 into $11
	beqz	$12, fin	  #checks if $12, our loop counter is equal to zero to finish the code

	la	$10, arg    #loads address of arg into register $1
	lw	$9, 4($10)  #loads arg into register $9
	lw	$10, 4($10) #loads arg into register $10, overriding the address

	addi	$8, $zero, 0
	beqz	$9, fin

fori: #iteration for first arg
	add	$11, $11, $12	
	addi	$13, $13, -1
	bnez	$13, fori	

fori2: #iteration for second arg
	add	$8, $8, $9	
	addi	$10, $10, -1
	bnez	$10, fori2	

print: #prints the two answers
	li $v0, 1
	move $a0, $11
	syscall

	li $v0, 1
	move $a0, $8
	syscall

fin: #ends program
	li	$v0, 10
	syscall			
