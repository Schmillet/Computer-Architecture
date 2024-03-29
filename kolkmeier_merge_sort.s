#Andrew Kolkmeier
#This program demonstrates a merge sort
#User must enter every value of list separately

	.data
list: .space 128		#Unsorted List, Must be even number, max length 32
listLength: .space 8	#stores length of list entered by user
merge1: .space 64	#Allocates 16 spaces to use for the merge sort
merge2: .space 64	#allocates 16 spaces to use for the merge sort
workList: .space 128	#allocates 32 spaces to use for the merge sort
space: .asciiz " "
prompt1: .asciiz "Enter the length of the list to be sorted(must be even number, 32 or under): "
prompt2: .asciiz "Enter the list value: "

	.text
	.globl main
#initialization
main:
keyboard:
        li $s6, 0                   #input loop index
        la $s7, list                #loads address of list into $s7

        li $v0, 4                   #print string       
        la $a0, prompt1             #prints prompt for length of list
        syscall

        li $v0, 5                   #read int
        syscall
        sw $v0, listLength          #stores length into listLength

        lw $s5, listLength          #loads the length of list into $s5

        

keyboardLoop:
        beq $s6, $s5, setup
        li $v0, 4                   #print string
        la $a0, prompt2             #prints prompt for list contents
        syscall
        li $v0, 5                   #read int
        syscall
        sw $v0, 0($s7)              #stores int into list
        addi $s6, $s6, 1            #incrememts loop index
        addi $s7, $s7, 4            #increments list address
        j keyboardLoop

		
setup:
		la $s4, list 				#stores the address of the list into $s4
		la $s3, list 				#also stores address of list for initLoop
		lw $s5, listLength			#stores the length of list
		move $t9, $s5				#makes a copy of the list length
		la $s0, merge1 				#stores address of merge1 into $s0
		li $s1, 1 					#sets length counter to one for merge1 and merge2
		la $s2, merge2 				#stores address of merge into $s2
		la $t2, workList			#stores the address of workList into $t2
		move $t6, $s5				#makes the length of workList the same as list
		
		move $s6, $zero 			#s6 is the merge1 iteration variable
		move $s7, $zero 			#s7 is the merge2 iteration variable	

		sll $t3, $s1, 2				#length of merge1 times four
		sll $t5, $s5, 2				#length of list and workList times four

		move $s8, $zero				#used to increment the merge1Loop
		move $t4, $zero				#used to increment the merge2Loop
		sra $t7, $t9, 1				#used to increment the inner merge sort loop

#This begins the process for the merge sort
outerLoop:
		beq $s1, $s5, outerLoopExit
		la $s3, list 				#resets the list address copy
		li $t4, 0					#resets $t4. DO NOT TOUCH
		sll $t3, $s1, 2				#length of merge1 times four, used in merge subroutine
		la $s4, list 				#resets list address
		sra $t7, $t9, 1				#resets inner loop index
		la $t2, workList 			#resets the workList address

innerLoop:
		beq $t7, $t9, innerLoopExit
		move $s6, $zero				#resets merge1 counter
		move $s7, $zero				#resets merge2 counter
		la $s0, merge1 				#resets merge1 address
		la $s2, merge2 				#resets merge2 address

#these two loops load the correct values into merge1 and merge2
merge1Loop:
		beq $s8, $s1, merge1LoopExit
		lw $t8, 0($s3)				#loads the first word from list into $t8
		sw $t8, 0($s0)				#stores the first word from list into merge1 to be used in the merge subroutine
		addi $s3, 4					#increments the list address to access next set of words
		addi $s0, 4					#increments the merge1 address
		addi $s8, $s8, 1			#increments the loop counter
		j merge1Loop

merge1LoopExit:
		li $s8, 0					#resets merge1 loop counter

merge2Loop:
		beq $t4, $s1, merge2LoopExit
		lw $t8, 0($s3)				#loads the next word from list into $t8
		sw $t8, 0($s2)				#stores word from $t8 into workList
		addi $s3, 4					#increments the list address
		addi $s2, 4					#increments the merge2 address
		addi $t4, $t4, 1			#increments the loop counter
		j merge2Loop

merge2LoopExit:
		li $t4, 0					#resets merge2 loop counter
		la $s0, merge1 				#resets the merge1 address
		la $s2, merge2 				#resets the merge2 address
		jal mergeRoutine
		addi $t7, $t7, 1			#increments the innerLoop index
		j innerLoop

innerLoopExit:
		sll $s1, $s1, 1				#increases the length of both merge1 and merge2
		la $s0, merge1 				#resets the merge1 address
		la $s2, merge2 				#resets the merge2 address
		jal listCopy				#copies workList into list
		sra $t9, $t9, 1				#halves the length of the copy of list used for innerLoop condition 
		j outerLoop

outerLoopExit:

		move $t7, $zero				#sets $t7 to zero to be used as an address pointer in print
		move $t9, $zero				#sets $t9 to zero to be used as the loop index for print
		sub $s4, $s4, $t5

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

#-----------------------------MERGE SUBROUTINE START----------------------------#
mergeRoutine:
		beq $s6, $t3, exit_1 		#while loop conditions
		beq $s7, $t3, exit_1

		

		lw $t0, 0($s0)				#address pointer to merge1
		lw $t1, 0($s2)				#address pointer to merge2

		bge $t1, $t0, first_else	#if statement condition
		sw $t1, 0($t2)				#stores value of merge2 in workList
		addi $s7 $s7, 4				#increments merge2 iterator
		addi $s2 $s2, 4				#Increments merge2 address
		j First_if_exit

first_else: 
		sw $t0, 0($t2)				#Stores value of merge1 into workList
		addi $s6, $s6, 4			#increments merge1 iterator
		addi $s0, $s0, 4			#increments merge1 address
First_if_exit:
		
		addi $t2, $t2, 4			#increments the workList address

		j mergeRoutine
		
exit_1:

loop_2:
		beq $s6, $t3, exit_2		#Exit loop if merge1 is empty

		lw $t0, 0($s0)				#loads next value of merge1
		sw $t0, 0($t2)				#stores remaining value into workList

		addi $s6, $s6, 4			#increments merge1 iterator
		addi $s0, $s0, 4			#increments merge1 address

		addi $t2, $t2, 4			#increments the workList address

		j loop_2

exit_2:

loop_3:
		beq $s7, $t3, exit_3		#Exit loop if merge2 is empty

		lw $t1, 0($s2)				#loads next value of merge2
		sw $t1, 0($t2)				#stores remaining value into workList

		addi $s7, $s7, 4			#increments merge2 increment
		addi $s2, $s2, 4			#increments merge2 address

		addi $t2, $t2, 4			#increments the workList address

		j loop_3

exit_3:
		jr $ra 						#jumps back to where jal mergeRoutine was called

#-----------------------------------LIST COPY SUBROUTINE---------------------------#
listCopy:
		sub $sp, $sp, 16			#makes space for five items on stack
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