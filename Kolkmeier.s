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
		sll  $t0, $s6, 2	#setting up list1 iterator
		add  $t0, $t0, $s0
		lw	 $t3, 0($t0) 	#address of list1[i]

		sll  $t1, $s7, 2	#setting up the list2 iterator
		add  $t1, $t1, $s2
		lw   $t4, 0($t1)	#address of list2[i]

		sll  $t2, $s8, 2 	#setting up combinedlist iterator
		add  $t2, $t2, $s4
		lw   $t5, 0($t2) 	#address of combinedlist[i]
#loop_1:
		beqz $s1, exit_1 	#while loop conditions
		beqz $s3, exit_1
		#1st if statement
		bge  $t4, $t3, else_1 #if statement condition

		move $t5, $t3		  #combinedlist[i] = list1[i]
		subu $s1, $s1, $t6
		addi $t3, 4

		j first_if_exit		  #if statement exit

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

