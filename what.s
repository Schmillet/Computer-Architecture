	.data	
arg:	.word	5

	.text
	.globl main
main:
	la	$13, arg	
	lw	$12, 0($13) 
	lw	$13, 0($13)

	addi	$11, $zero, 0
	beqz	$12, fin		
fori:
	add	$11, $11, $12	
	addi	$13, $13, -1
	bnez	$13, fori		
fin:
	li	$v0, 10
	syscall			
