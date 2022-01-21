.data
	ar: .space 8192
	fushu1: .word -12288
	fushu2: .word -0x00003004
	fushu3: .word -0x00003008
	fushu4: .word -0x00003020
	fushu5: .word -0x00003010
	
	fushu6: .word -0x00010000
	fushu7: .word -0x00010004
	fushu8: .word -0x00020000
	fushu9: .word -0x00020004
.text
	ori $7, $0, 4
	ori $8, $0, 8
	ori $9, $0, 12
	ori $10, $0, 16
	ori $11, $0, 20
	
	sw $11, ar($7)
	sw $7, ar($8)
	sw $8, ar($9)
	sw $9, ar($10)
	sw $10, ar($11)
	
	lui $20, 0xffff
	ori $20, $20, 0xcfe0
	 
	jal label1
	lw $12, -0x0000302c($31)
	jal label2
	lw $13, -0x00003030($31)
	jal label3
	lw $14, -0x00003034($31)
	nop
	

	j __end__
	nop
	
	label1: jr $ra
	nop
	label2: jr $ra
	nop
	label3: jr $ra
	nop
	
	__end__:
	
	lui $12, 0
	lw $12, 4($12)
	
	lui $13, 0
	lw $14, 8($13)
	lui $14 0
	lw $15, 16($14)
	