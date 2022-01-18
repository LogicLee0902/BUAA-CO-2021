.data
	Ans:.space 250
	#carry:.space 12
	
.text
	li $v0, 5
	syscall
	move $s0, $v0
	li $s1, 49 # for the int converted to the char
	sb $s1, Ans+1 #intial s[0] = 1
	subi $s1, $s1, 1 # "0"
	li $s2, 10
	
	li $t0, 1
	li $t1, 1 #t1 as lenth
	li $t2, 0 #carry bit
for_1:
	bgt $t0, $s0, for_1_end
	li $t3, 1 #current lenth
	move $t7, $t1
	for_2: #use byte as the unit
		bgt $t3, $t1 for_2_end
		lb $t4, Ans($t3) #the stored one, namely already calculated part
		sub $t4, $t4, $s1  # converted to the integer
		mult $t4, $t0 
		mflo $t4
		add $t4, $t4, $t2 #do not forget the carry bit
		# abstract bit by bit from the result and store them
		div $t4, $s2
		mfhi $t5 # result % 10
		add $t5, $t5, $s1
		sb $t5, Ans($t3) 	 
		mflo $t5
		#if_1:
		#	beq $t5, $0, else
		move $t2, $t5 #update the carry bit
	#	else:
		addi $t3, $t3, 1
		j for_2
	for_2_end:	
	while_1:
	#Deal with the last digit and last carry-bit, the lenth may longer than 1-bit
		beq $t2, $0, while_1_end		
		addi $t1, $t1, 1
		div $t2, $s2
		mfhi $t5
		add $t5, $s1, $t5
		sb $t5, Ans($t1)
		mflo $t2 
		j while_1
	while_1_end:
	addi $t0, $t0, 1
	j for_1

for_1_end:

move $t6, $t1
for_3:
	ble $t6, $0, for_3_end
	lb $a0, Ans($t6)
	li $v0, 11
	syscall
	subi $t6, $t6, 1
	j for_3

for_3_end:
li $v0, 10
syscall
