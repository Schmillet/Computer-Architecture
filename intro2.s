		     .data
			     .globl first 
	first:	 .word 9, 8, 7, 6, 5
			     .word 4
			     .word 3
			     .word 2
	last:		.word 1

        		.text
			#.globl main
	main:      
			      la    $16, last		# cannot be "lui"
        		la    $20, first
        		li    $17, 0
	loop:   	lw    $19, 0($20)
        		add   $17, $17, $19	# $17 stores sum
        		addi  $20, $20, 4
        		sle   $18, $20, $16
        		bnez  $18, loop
            move  $a0, $17
            li    $v0, 1
            syscall
            li    $v0, 5
            syscall
        		li    $v0, 10
            syscall                 # exit
