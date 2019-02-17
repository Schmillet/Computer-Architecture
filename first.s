			.data
			.globl first 
	first:	.word 5
			.word 4
			.word 3
			.word 2
	last:		.word 1
        
			.text
        	.globl main
	main:	
            la    	$s1, first
            lw      $s2, 0($s1)
        	lw      $s5, 4($s1)
        	add     $s2, $s2, $s5
        	lw      $s5, 8($s1)
        	add     $s2, $s2, $s5
        	lw      $s5, 12($s1)
        	add     $s2, $s2, $s5
        	addi    $s2, $s2, 1
			li 	$v0, 10
            syscall                 # exit

 