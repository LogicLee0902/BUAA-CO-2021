.data
	Conv:.space 400
	Kernel:.space 400
	Ans:.space 400
	Space:.asciiz " "
	Enter:.asciiz "\n"
	
.macro Input(%In)
	li $v0, 5
	syscall
	move %In, $v0
.end_macro	

.macro GetIndex(%Index, %row, %column, %rank)
	mult %row, %rank
	mflo %Index
	add %Index, %Index, %column
	sll %Index, %Index, 2
.end_macro	

.macro GetSum(%Sum, %row, %column, %rank_c, %rank_k)
	li $t3, 0
	li %Sum, 0
	for_7:
		beq $t3, $s2 for_7_end
		li, $t4, 0
		for_8:
			beq $t4, $s3, for_8_end
			GetIndex($t5, $t3, $t4, %rank_k) # address of the kernel
			lw $t6, Kernel($t5)
			add $t7, $t3, %row
			add $t8, $t4, %column
			GetIndex($t5, $t7, $t8, %rank_c) # address of the Conv
			lw $t9, Conv($t5)
			mult $t6, $t9
			mflo $t6
			add %Sum, %Sum, $t6
			addi $t4, $t4, 1
			j for_8
		for_8_end:
			addi $t3, $t3, 1
			j for_7
	for_7_end:	

.end_macro

.text
	Input($s0) #s0 = m1
	Input($s1) #s1 = n1
	Input($s2) #s2 = m2
	Input($s3) #s3 = n2
	
	li $t0, 0
	for_1:
		beq $t0, $s0, for_1_end
		li $t1, 0
		for_2:
			beq $t1, $s1, for_2_end
			Input($t2) #t2 is the element
			GetIndex($t3, $t0, $t1, $s1) #t3 the right address
			sw $t2, Conv($t3)
			addi $t1, $t1, 1
			j for_2
		for_2_end:
		addi $t0, $t0, 1
		j for_1
	for_1_end:
	
	li $t0, 0
	for_3:
		beq $t0, $s2, for_3_end
		li $t1, 0
		for_4:
			beq $t1, $s3, for_4_end
			Input($t2) #t2 is the element
			GetIndex($t3, $t0, $t1, $s3) #t3 the right address
			sw $t2, Kernel($t3)
			addi $t1, $t1, 1
			j for_4
		for_4_end:
		addi $t0, $t0, 1
		j for_3
	
	for_3_end:
	sub $s4, $s0, $s2
	addi $s4, $s4, 1 # m1 -m2 +1
	sub $s5, $s1, $s3
	addi $s5 , $s5, 1 # n1 - n2 + 1
	
	li $t0, 0 # i = 0
	for_5:
		beq $t0, $s4, for_5_end
		li $t1, 0 # j = 0
		li $t2, 0 # sum_unit = 0
		for_6:
			beq $t1, $s5, for_6_end 
			GetSum($t2, $t0, $t1, $s1, $s3)
			GetIndex($t3, $t0, $t1, $s5)
			sw $t2, Ans($t3) 
			addi $t1, $t1, 1
			j for_6
		for_6_end:
		addi $t0, $t0, 1
		j for_5
			
	for_5_end:
	li $t0, 0
	for_9:
		beq $t0, $s4, for_9_end
		li $t1, 0
		for_10:
			beq $t1, $s5, for_10_end
			GetIndex($t2, $t0, $t1, $s5)
			lw $a0, Ans($t2)
			li $v0, 1
			syscall
			la $a0, Space
			li $v0, 4
			syscall
			addi $t1, $t1, 1
			j for_10
		for_10_end:
			addi $t0, $t0, 1
			la $a0, Enter
			li $v0, 4
			syscall
			j for_9
	for_9_end:
	li $v0, 10
	syscall
