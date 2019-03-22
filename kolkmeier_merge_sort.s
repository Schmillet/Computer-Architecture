#Andrew Kolkmeier
#This program demonstrates a merge sort
#User must enter the unsorted list into the list label
#and the length of the list into the li $s5, (length)
#command

	.data
list: .word 6, 5, 9, 1, 7, 0, -3, 2		#Unsorted List, Must be length of 2^n, max length 32
merge1: .space 16	#Allocates 16 spaces to use for the merge sort
merge2: .space 16	#allocates 16 spaces to use for the merge sort
workList: .space 32

	.text
	.globl main
#initialization
main:
		la $s4, list 				#stores the address of the list into $s4
		li $s5, 8					#stores the length of list
		la $s0, merge1 				#stores address of merge1 into $s0
		li $s1, 1 					#sets length counter to one for merge1 and merge2
		la $s2, merge2 				#stores address of merge into $s2
		la $t2, workArray			#stores the address of workList into $t2
		move $t6, $s5				#makes the length of workList the same as list
		
		move $s6, $zero 			#s6 is the merge1 iteration variable
		move $s7, $zero 			#s7 is the merge2 iteration variable	

		sll $t3, $s1, 2				#length of merge1 times four
		sll $t4, $s3, 2				#length of merge2 times four
		sll $t5, $s5, 2				#length of list times four

#This begins the process for the merge sort
outerLoop:
		bgt $s1, $s5, outerLoopExit
		

		sll $s1, $s1, 1
		j outerLoop
outerLoopExit:


end:
		li $v0, 10
		syscall

mergeRoutine:
		beq $s6, $t3, exit_1 		#while loop conditions
		beq $s7, $t4, exit_1

		lw $t0, 0($s0)				#address pointer to merge1
		lw $t1, 0($s2)				#address pointer to merge2

		bge $t1, $t0, first_else	#if statement condition
		sw $t1, 0($s4)				#stores value of merge2 in workList
		addi $s7 $s7, 4				#increments merge2 iterator
		addi $s2 $s2, 4				#Increments merge2 address
		j First_if_exit

first_else: 
		sw $t0, 0($s4)				#Stores value of merge1 into workList
		addi $s6, $s6, 4			#increments merge1 iterator
		addi $s0, $s0, 4			#increments merge1 address
First_if_exit:
		
		addi $s4, $s4, 4			#increments the workList address

		j mergeRoutine
		
exit_1:

loop_2:
		beq $s6, $t3, exit_2		#Exit loop if merge1 is empty

		sw $t0, 0($s4)				#stores remaining value into workList

		addi $s6, $s6, 4			#increments merge1 iterator
		addi $s0, $s0, 4			#increments merge1 address

		addi $s4, $s4, 4			#increments the workList address

		j loop_2

exit_2:

loop_3:
		beq $s7, $t4, exit_3		#Exit loop if merge2 is empty

		sw $t1, 0($s4)				#stores remaining value into workList

		addi $s7, $s7, 4			#increments merge2 increment
		addi $s2, $s2, 4			#increments merge2 address

		addi $s4, $s4, 4			#increments the workList address

		j loop_3

exit_3:
		jr $ra