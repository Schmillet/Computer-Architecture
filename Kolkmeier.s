#Andrew Kolkmeier
#This program merges two ordered lists
	.data
list1:			.word 1, 2, 5, 8
list1_size: 	.word 4
list2: 			.word 3, 4, 6, 7
list2_size:		.word 4
combined_list:  .word 0, 0, 0, 0, 0, 0, 0, 0

	.text
	.globl main

main:	#initialization
		la $t0, list1 #stores address of list 1 $t0
		lw $s0, list1_size #stores size of list 1 $s0
		la $t1, list2 #stores address of list 2 in $t1
		lw $s1, list2_size #stores size of list 2 $s1
		la $t3, combined_list #stores the address of the combined list in $t3
		add $s2, $s0, $s1 #stores the size of combined list in $s2

		move $s3, $zero #s3 is the list 1 iteration variable
		move $s4, $zero #s4 is the list 2 iteration variable
		move $s5, $zero #s5 is the combined list iteration variable
		move $s6, $zero #s5 is the while loop iterator

loop_1: #main merge loop
		beq $s6, print



print:


end:

