#Andrew Kolkmeier
#This program merges two ordered lists
#For this to work for now, you must manually enter in the values
#of each input list in their respective labels. Also, the length
#must be manually entered as well

	.data
list1:			.word 1, 2, 5, 8
list2: 			.word 3, 4, 6, 7
combined_list:  .word 0
newLine: 		.asciiz " "


	.text
	.globl main

main:	#initialization
		la $s0, list1 				#stores address of list 1 $s0
		li $s1, 4 					#stores size of list 1 $s1
		la $s2, list2 				#stores address of list 2 in $s2
		li $s3, 4					#stores size of list 2 $s3
		la $s4, combined_list 		#stores the address of the combined list in $s4
		add $s5, $s1, $s3			#stores the size of combined list in $s5

		move $s6, $zero 			#s6 is the list 1 iteration variable
		move $s7, $zero 			#s7 is the list 2 iteration variable	

		sll $t3, $s1, 2				#length of list1 times four
		sll $t4, $s3, 2				#length of list2 times four
		sll $t5, $s5, 2				#length of combined_list times four
		
 #main merge loop
loop_1:
		beq $s6, $t3, exit_1 		#while loop conditions
		beq $s7, $t4, exit_1

		lw $t0, 0($s0)				#address pointer to list 1
		

		lw $t1, 0($s2)				#address pointer to list 2
		

		lw $t2, 0($s4)				#address pointer to list 3

		bge $t1, $t0, first_else	#If statement condition
		sw $t1, 0($s4)				#stores value in list2 in combined_list
		addi $s7 $s7, 4				#increments list 2 iterator
		addi $s2 $s2, 4				#Increments list 2 address
		j First_if_exit

first_else: 
		sw $t0, 0($s4)			#Stores value of list1 into combined_list
		addi $s6, $s6, 4		#increments list 1 iterator
		addi $s0, $s0, 4		#increments list 1 address
First_if_exit:
		
		addi $s4, $s4, 4			#increments the combined_list address

		j loop_1
		
exit_1:

loop_2:
		beq $s6, $t3, exit_2			#Exit loop if list1 is empty

		sw $t0, 0($s4)				#stores remaining value into combined_list

		addi $s6, $s6, 4			#increments list 1 increment
		addi $s0, $s0, 4			#increments list 1 address

		addi $s4, $s4, 4			#increments the combined_list address

		j loop_2

exit_2:


loop_3:
		beq $s7, $t4, exit_3			#Exit loop if list2 is empty

		sw $t1, 0($s4)				#stores remaining value into combined_list

		addi $s7, $s7, 4			#increments list 2 increment
		addi $s2, $s2, 4			#increments list 2 address

		addi $s4, $s4, 4			#increments the combined_list address

		j loop_3

exit_3:
		sub $s4, $s4, $t5     		#Sets the address for combined_list back to the front

		addi $t9, $zero, 0			#$t9 is the index for the while loop 
print:
		beq $t9, $t5, print_exit

		lw $t7, 0($s4) 				#Address pointer to combined_list

		addi $t9, $t9, 4 			#increments the index for the while loop

		#prints current number
		li $v0, 1
		move $a0, $t7
		syscall

		#prints new line
		li $v0, 4
		la $a0, newLine
		syscall

		addi $s4, 4 				#increments address for combined_list

		j print 					#jumps back to top of loop

print_exit:
end:
		li $v0, 10
		syscall