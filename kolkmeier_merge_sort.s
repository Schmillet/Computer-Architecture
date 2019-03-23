#Andrew Kolkmeier
#This program demonstrates a merge sort
#User must enter the unsorted list into the list label
#and the length of the list into the li $s5, (length)
#command

	.data
space: 		.asciiz " "
list: .word 6, 5, 9, 1, 7, 0, -3, 2		#Unsorted List, Must be length of 2^n, max length 32
merge1: .space 16	#Allocates 16 spaces to use for the merge sort
merge2: .space 16	#allocates 16 spaces to use for the merge sort
workList: .space 32	#allocates 32 spaces to use for the merge sort

	.text
	.globl main
#initialization
main:
		la $s4, list 				#stores the address of the list into $s4
		la $s3, list 				#also stores address of list for initLoop
		li $s5, 8					#stores the length of list
		la $s0, merge1 				#stores address of merge1 into $s0
		li $s1, 1 					#sets length counter to one for merge1 and merge2
		la $s2, merge2 				#stores address of merge into $s2
		la $t2, workList			#stores the address of workList into $t2
		move $t6, $s5				#makes the length of workList the same as list
		
		move $s6, $zero 			#s6 is the merge1 iteration variable
		move $s7, $zero 			#s7 is the merge2 iteration variable	

		sll $t3, $s1, 2				#length of merge1 times four
		sll $t5, $s5, 2				#length of list and workList times four

		move $s8, $s1				#used to increment the initLoop inside the sort loops

#This begins the process for the merge sort
outerLoop:
		beq $s1, $t5, outerLoopExit
innerLoop:
		beq $s8, $s5, innerLoopExit

		jal mergeRoutine
		sll $s8, $s8, 1				#increments the innerLoop index
		j innerLoop

innerLoopExit:
		sll $s1, $s1, 1				#increases the length of both merge1 and merge2
		jal copyList				#copies workList into list
		j outerLoop

outerLoopExit:

		move $t7, $zero				#sets $t7 to zero to be used as an address pointer in print
		move $t9, $zero				#sets $t9 to zero to be used as the loop index for print

print:
		beq $t9, $t5, print_exit

		lw $t7, 0($s4) 				#Address pointer to list

		addi $t9, $t9, 4 			#increments the index for the while loop

		#prints current number
		li $v0, 1
		move $a0, $t7
		syscall

		#prints new line
		li $v0, 4
		la $a0, space
		syscall

		addi $s4, 4 				#increments address for list

		j print 					#jumps back to top of loop

print_exit:

end:
		li $v0, 10
		syscall

#MERGE SUBROUTINE START#
mergeRoutine:
		beq $s6, $t3, exit_1 		#while loop conditions
		beq $s7, $t3, exit_1

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
		beq $s7, $t3, exit_3		#Exit loop if merge2 is empty

		sw $t1, 0($s4)				#stores remaining value into workList

		addi $s7, $s7, 4			#increments merge2 increment
		addi $s2, $s2, 4			#increments merge2 address

		addi $s4, $s4, 4			#increments the workList address

		j loop_3

exit_3:
		jr $ra 						#jumps back to where jal mergeRoutine was called

#LIST COPY SUBROUTINE#
listCopy:
		sub $sp, $sa, 16			#makes space for five items on stack
		sw $s4, 0($sp)				#stores list address in the stack
		sw $t2, 4($sp)				#stores workList address in the stack
		sw $s1, 8($sp)				#stores merge length into the stack
		sw $t3, 12($sp)				#stores length of merge times 4 into the stack

		la $s4, list 				#sets $s4 to the address of list to be incremented
		la $t2, workList			#sets $t2 to the address of workList to be incremented
		move $s1, $zero				#sets $s1 to zero to increment the copy loop

copyLoop:
		beq $s1, $t5, copyLoopExit	#ends loop if the loop index is equal to the list length

		lw $t3, 0($t2)				#loads the first word of workList into $t3

		addi $s1, $s1, 4			#increments loop index

		sw $t3, 0($s4)				#stores word at the index of workList into the index of list

		addi $t2, $t2, 4			#increments the workList address
		addi $s4, $s4, 4			#increments the list address

		j copyLoop

copyLoopExit:
		lw $t4, 0($sp)				#restores the list address to $t4
		lw $t2, 4($sp)				#restores workList address to $t2
		lw $s1, 8($sp)				#restores merge length to $s1
		lw $t3, 12($sp)				#restores length of merge time 4 to $t3
		addi $sp, $sp, 16			#deletes 4 items from the stack

		jr $ra 						#jumps back to where jal copyList was called