.data
	symbol:.space 28
	array:.space 28
	stack:.space 200
	enter:.asciiz "\n"
	space:.asciiz " "
.text

main:
	li $s2, 1
	la $sp, stack
	addi $sp, $sp, 200 #Get to the Space of the Stack
	li $v0, 5
	syscall
	move $s0, $v0
	li $a1, 0
	jal Permutation
	li $v0, 10
	syscall

Permutation:
	move $t0, $a1 #t0 = index
	if_1:
		blt $t0, $s0, else_1
		li $t1, 0 #t1 = i
		for_1:
			beq $t1, $s0, for_1_end
			sll $t2, $t1, 2
			lw $a0, array($t2)
			li $v0, 1
			syscall
			la $a0, space
			li, $v0, 4
			syscall
			addi $t1, $t1, 1
			j for_1
		for_1_end:
			la $a0, enter
			li $v0, 4
			syscall
			jr $ra
	else_1:
	subi $sp, $sp, 28
	li $t1, 0
	for_2:
		beq $t1, $s0, for_2_end
		sll $t2, $t1, 2 #address
		lw $t3 symbol($t2) #symbol[i]
 		if_2:
			beq $t3, $s2, else
			sll $t4, $t0, 2
			addi $t5, $t1, 1
			sw $t5, array($t4)
			sw $s2, symbol($t2)
			
			sw $t1, 24($sp)
			sw $t0, 20($sp)
			sw $ra, 16($sp)
			
			addi $a1, $t0, 1
			jal Permutation
			lw $ra, 16($sp)
			lw $t0, 20($sp)
			lw $t1, 24($sp)
			sll $t2, $t1, 2
			sw $0, symbol($t2)
			
		else:
		
		addi $t1, $t1, 1
		j for_2

	for_2_end:
		addiu $sp, $sp, 28
		jr $ra
	