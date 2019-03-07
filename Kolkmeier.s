#Andrew Kolkmeier
#This program merges two ordered lists
	.data
list1:			.word 1, 2, 5, 8
list1_size: 	.word 4
list2: 			.word 3, 4, 6, 7
list2_size:		.word 4
combined_list:  .word 0 

	.text
	.globl main
main:	
		#initialization
		la $t0, list1 #stores address of list 1 $t0
		lw $s0, list1_size #stores size of list 1 $s0
		la $t1, list2 #stores address of list 2 in $t1
		lw $s1, list2_size #stores size of list 2 $s1
		add $s2, $s0, $s1 #stores the size of combined list in $s2






