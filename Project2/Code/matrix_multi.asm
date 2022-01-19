.data
	matrix_a:.space 400
	matrix_b:.space 400
	matrix_c:.space 400
	space:.asciiz " "
	enter:.asciiz "\n"
	
.macro GetIndex(%Index, %row, %column, %rank)
	mult %row, %rank
	mflo %Index
	add %Index, %Index, %column
	sll %Index, %Index, 2
.end_macro	
	
.text
	li $v0, 5
	syscall
	move $s0, $v0

#store MatrixA
	li $t0, 0 # t0 is i, i = 0;
for_1:
	beq $t0, $s0, for_1_end
	li $t1, 0 #t0 is j, j = 0;
	for_2:
		beq $t1, $s0, for_2_end
		li $v0, 5
		syscall
		move $t2, $v0 #store the input number
		GetIndex($t3, $t0, $t1, $s0) # t3 is the address of the data
		sw $t2, matrix_a($t3)
		addi $t1, $t1, 1 #j++
		j for_2
	for_2_end:
	addi $t0, $t0, 1 #i++
	j for_1
	
for_1_end:

#store	MatrixB
	li $t0, 0 # t0 is i, i = 0;
	for_3:
		beq $t0, $s0, for_3_end
		li $t1, 0 #t0 is j, j = 0;
		for_4:
			beq $t1, $s0, for_4_end
			li $v0, 5
			syscall
			move $t2, $v0 #store the input number
			GetIndex($t3, $t0, $t1, $s0) # t3 is the address of the data
			sw $t2, matrix_b($t3)
			addi $t1, $t1, 1 #j++
			j for_4
		for_4_end:
		addi $t0, $t0, 1 #i++
		j for_3
	
	for_3_end:
	
	li $t0, 0 # i = 0
	li $t7, 0 #aim_j = 0
	for_5:
		beq $t0, $s0, for_5_end
		li $t7, 0
		for_7:
			beq $t7, $s0, for_7_end
			li $t1, 0 #t1 is j,
			li $t2, 0 #t2 is the sum, sum = 0	
		for_6:
			beq $t1, $s0, for_6_end
			GetIndex($t3, $t0, $t1, $s0) #t3 is the address of the a[i, j]
			lw $t4, matrix_a($t3) #t4 is a[i,j]
			GetIndex($t3, $t1, $t7, $s0) #t3 is the address of the b[j, aim_j]
			lw $t5, matrix_b($t3) #t5 is b[j, i]	
			mult $t4, $t5
			mflo $t6 #t6 is the a[i,j]*b[j,i]
			add $t2, $t2, $t6 #the unit val of the answer matrix
			addi $t1, $t1, 1
			j for_6
		for_6_end:	
		GetIndex($t3, $t0, $t7, $s0) #t3 is the address of the ans[i, aim_j]
		sw $t2, matrix_c($t3)
		addi $t7, $t7, 1
		j for_7 
		for_7_end:
		addi $t0, $t0, 1
		j for_5	
		
	for_5_end:
	li $t0, 0 # t0 is i, i = 0;
	for_8:
		beq $t0, $s0, for_8_end
		li $t1, 0 #t0 is j, j = 0;
		for_9:
			beq $t1, $s0, for_9_end
			GetIndex($t3, $t0, $t1, $s0) # t3 is the address of the ans[i, j]
			lw $t2, matrix_c($t3) #ans[i, j]
			move $a0, $t2
			li $v0, 1
			syscall
			addi $t1, $t1, 1 #j++
			la $a0, space
			li $v0, 4
			syscall
			j for_9
		for_9_end:
		li $v0, 4
		la $a0 enter
		syscall
		addi $t0, $t0, 1 #i++
		j for_8
	for_8_end:
		li $v0, 10
		syscall