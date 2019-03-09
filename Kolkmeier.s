#Andrew Kolkmeier
#This program merges two ordered lists
	.data
list1:			.word 1, 2, 5, 8
list1_size: 	.word 4
list2: 			.word 3, 4, 6, 7
list2_size:		.word 4
combined_list:  .word 0, 0, 0, 0, 0, 0, 0, 0
newLine: 		.asciiz "\n"

	.text
	.globl main

main:	#initialization
		la $s0, list1 			#stores address of list 1 $s0
		li $s1, 4 		#stores size of list 1 $s1
		la $s2, list2 			#stores address of list 2 in $s2
		li $s3, 4 		#stores size of list 2 $s3
		la $s4, combined_list 	#stores the address of the combined list in $s4
		add $s5, $s1, $s3		#stores the size of combined list in $s5

		move $s6, $zero 		#s6 is the list 1 iteration variable
		move $s7, $zero 		#s7 is the list 2 iteration variable	
		move $s8, $zero			#s8 is the combined list iterator
		
 #main merge loop
loop_1:
		beq $s6, 16, exit_1 	#while loop conditions
		beq $s7, 16, exit_1

		lw $t0, 0($s0)			#address pointer to list 1
		

		lw $t1, 0($s2)			#address pointer to list 2
		

		lw $t2, 0($s4)			#address pointer to list 3

		bge $t1, $t0, first_else	#If statement condition
		sw $t2, 0($s0)
		addi $s6, $s6, 4		#increments list 1 iterator
		addi $s0, $s0, 4		#Increments list 1 address
		j First_if_exit

first_else: sw $t2, 0($s2)
			addi, $s7, $s7, 4
			addi, $s2, $s2, 4
First_if_exit:
		
		addi $s4, $s4, 0		#increments the combined_list address

		j exit_1
		
exit_1:

loop_2:


exit_2:


loop_3:

exit_3:
		sub $s4, $s4, 32
		#$t9 is the index for the while loop, this makes sure that it is zero
		addi $t9, $zero, 0
print:
		beq $t9, 32, print_exit

		lw $t7, 0($s4) #Address pointer to combined_list

		addi $t9, $t9, 4 #increments the index for the while loop

		#prints current number
		li $v0, 1
		move $a0, $t7
		syscall

		#prints new line
		li $v0, 4
		la $a0, newLine
		syscall

		addi $s4, 4 #increments address for combined_list

		j print #jumps back to top of loop

print_exit:
end:
		li $v0, 10
		syscall

