.data
	array: .space 12288
.text
	ori $8, $0, 4
	ori $9, $0, 8
	ori $10, $0, 12
	ori $11, $0, 16
	ori $12, $0, 20
	ori $13, $0, 24
	ori $14, $0, 28
	ori $14, $0, 32
	
	
	lui $20, 0xabc
	lui $21, 1234
	lui $22, 114
	lui $23, 514
	lui $24, 695
	
	sw $24, array($8)
	lw $26, array($8)
	sw $26, array($9)
	lw $27, array($9)
	sw $27, array($10)
	
	sw $8, array($8)
	sw $9, array($9)
	sw $10, array($10)
	sw $11, array($11)
	sw $12, array($12)
	sw $13, array($13)
	sw $14, array($14)
	
	
	sw $8, array($8)
	lw $8, array($8)
	lw $9, array($8)
	lw $22, array($8)
	sw $9, array($9)
	lw $23, array($9)
	sw $10, array($10)
	sw $10, array($10)
	sw $10, array($10)
	lw $10, array($11)
	lw $11, array($10)
	lw $13, array($12)
	lw $14, array($13)
	lw $12, array($13)
	lw $13, array($12)
	lw $13, array($12)
	lw $10, array($11)
	lw $12, array($10)
	lw $9, array($10)
	lw $10, array($9)
	addu $11, $10, $9
	lw $10, array($11)
	addu $10, $10, $8
	lw $9, array($10)
	subu $9, $12, $9
	lw $8, array($9)
	addu $8, $8, $8
	
	lw $9, array($8)
	ori $10, $9, 12
	ori $11, $10, 20
	lw $10, array($10)
	ori $10, $10, 8
	lw $8, array($8)
	ori $12, $8, 12
	lw $13, array($12)
	ori $14, $13, 4
	
	
	
	
	
	
	