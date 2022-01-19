.data
	matrix:.space 400
	Flag:.space 400
	stack:.space 1600
	Move_x:.space 20
	Move_y:.space 20 
	

.macro Input(%In)
	li $v0, 5
	syscall
	move %In, $v0
.end_macro	
	
.macro GetIndex(%Index, %row, %column %rank)
	mult %row, %rank
	mflo %Index
	add %Index, %Index, %column
	sll %Index, %Index, 2
.end_macro

.text
	

	Input($s0)
	Input($s1)
	li $t0, 0
	for_1:
		beq $t0, $s0, for_1_end
		li $t1, 0
		for_2:
			beq $t1, $s1, for_2_end
			Input($t2)
			GetIndex($t3, $t0, $t1, $s1)
			sw $t2, matrix($t3)
			addi $t1, $t1, 1
			j for_2
		for_2_end:
		addi $t0, $t0, 1
		j for_1
	
	
	for_1_end:
	Input($s2)
	subi $s2, $s2, 1
	Input($s3) #s2, s3 describe the start
	subi $s3, $s3, 1
	Input($s4)
	subi $s4, $s4, 1
	Input($s5) #s4, s5 describe the end
	subi $s5, $s5, 1
	
	li $s6, 1 # Const
	
	GetIndex($t3, $s2, $s3, $s1)
	sw $s6, Flag($t3)
	
	li $v1, 0
	li $s7, -1
	
	# create the movement
	sw $s6, Move_x
	sw $0, Move_x+4
	sw $s7, Move_x+8
	sw $0, Move_x+12
	sw $0, Move_y
	sw $s6, Move_y+4
	sw $0, Move_y+8
	sw $s7, Move_y+12
	
	move $a0, $s2
	move $a1, $s3
	jal Dfs
	move $a0, $v1
	li $v0, 1
	syscall
	li $v0, 10
	syscall
	
Dfs:
	move $t0, $a0
	move $t1, $a1
	# check whther or not has reach to the final
	seq $t2, $t0, $s4
	seq $t3, $t1, $s5
	and $t2, $t2, $t3
	if_1:
		bne $t2, $s6, else_1
		addi $v1, $v1, 1
		jr $ra	
	else_1:
	#sw $s6, Flag($t3) #Flag[x][y] = 1
	li $t4, 0
	li $s7, 4
	#subi $sp, $sp, 36
	for_3:
		beq $t4,$s7, for_3_end
		sll $t7, $t4, 2
		lw $t5, Move_x($t7)
		lw $t6, Move_y($t7)
		#calculate the next step
		add $t5, $t0, $t5
		add $t6, $t1, $t6 
		#check if it is legal
		blt $t5, $0, else 
		bge $t5, $s0, else # x' >= 0 and x' < n
		blt $t6, $0, else
		bge $t6, $s1, else # y' >= 0 and y' < m
		GetIndex($t3, $t5, $t6, $s1)
		lw $t2, Flag($t3)
		beq $t2, $s6, else #flag[x'][y'] != 1
		lw $t2, matrix($t3)
		beq $t2, $s6, else # matrix[x'][y'] == 0
		
		move $a0, $t5
		move $a1, $t6
		
		#sw $t6, 36($sp)
		sw $s6, Flag($t3)
		
		sw $t3, 0($sp)
		subi $sp, $sp, 4
		sw $t4, 0($sp)
		subi $sp, $sp, 4
		sw $t1, 0($sp)
		subi $sp, $sp, 4
		sw $t0, 0($sp)
		subi $sp, $sp, 4
		sw $ra, 0($sp)
		subi $sp, $sp, 4
		
		jal Dfs
		
		addi $sp, $sp, 4
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		lw $t1, 0($sp)
		addi $sp, $sp, 4
		lw $t4, 0($sp)
		addi $sp, $sp, 4
		lw $t3, 0($sp)
		
		sw $0, Flag($t3)
		
		else:
		addi $t4, $t4, 1
		j for_3
		
	for_3_end:
	#GetIndex($t3, $t0, $t1, $s1)
	#sw $0, Flag($t3)
	#addi $sp, $sp, 36
	jr $ra
	
	  
		
