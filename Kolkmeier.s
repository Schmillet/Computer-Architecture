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
		move $s8, $zero 		#s8 is the combined list iteration variable

		li $t6, 1

loop_1: #main merge loop
		
else_1: move $t5, $t4
		subu $s3, $s3, $t6
		addi $t4, 4

first_if_exit:
		j loop_1

exit_1:

loop_2:


exit_2:
		addi $t9, $zero, 0
print:
		beq $t9, 32, print_exit

		lw $t7, 0($s4)

		addi $t9, $t9, 4

		#prints current number
		li $v0, 1
		move $a0, $t7
		syscall

		#prints new line
		li $v0, 4
		la $a0, newLine
		syscall

		addi $s4, 4

		j print

print_exit:
end:
		li $v0, 10
		syscall

