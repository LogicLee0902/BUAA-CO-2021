.data
	String:.space 40
	
	
.text

	li $v0, 5
	syscall
	move $s0, $v0
	
	li $t0, 0 #t0 = i
	for_1:
		beq $t0, $s0, for_1_end
		li $v0, 12
		syscall
		move $t1, $v0
		sb $t1 String($t0)
		addi $t0, $t0, 1
		j for_1
	for_1_end:
	li $a2, 2
	div $t0, $a2
	mflo $t1
	li $t0, 0
	li $s1, 1 #s1 as flag, flag = 1;
	for_2:
		beq $t0, $t1, for_2_end
		lb $t2, String($t0) #a[i]
		sub $t3, $s0, $t0
		subi $t3, $t3, 1 #j = n - i - 1
		lb $t4, String($t3) #a[j]
		addi $t0, $t0, 1
		beq $t2, $t4, for_2 #if same, then goto the for
		li $s1, 0#not the same, change flag 
	for_2_end:
	move $a0, $s1
	li $v0, 1
	syscall
	li $v0, 10
	syscall