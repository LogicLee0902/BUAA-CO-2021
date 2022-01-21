ori $28, $0, 0
ori $29, $0, 0
ori $t0, $0, 5
sw $t0, 0($0)
ori $t0, $0, 10
sw $t0, 4($0)
ori $t0, $0, 6
sw $t0, 8($0)
ori $t0, $0, 5
sw $t0, 12($0)
ori $t0, $0, 6
sw $t0, 16($0)
ori $t0, $0, 7
sw $t0, 20($0)
ori $t0, $0, 4
sw $t0, 24($0)
ori $t0, $0, 4
sw $t0, 28($0)
ori $t0, $0, 9
sw $t0, 32($0)
ori $t0, $0, 7
sw $t0, 36($0)
ori $t0, $0, 0
sw $t0, 40($0)
ori $t0, $0, 1
sw $t0, 44($0)
ori $t0, $0, 7
sw $t0, 48($0)
ori $t0, $0, 2
sw $t0, 52($0)
ori $t0, $0, 0
sw $t0, 56($0)
ori $t0, $0, 2
sw $t0, 60($0)
ori $t0, $0, 2
sw $t0, 64($0)
ori $t0, $0, 6
sw $t0, 68($0)
ori $t0, $0, 3
sw $t0, 72($0)
ori $t0, $0, 3
sw $t0, 76($0)
jal label1
nop
label1: jr $31
addi $31, $31, 8
jalr $8, $31
nop
jr $8
addi $8, $8, 8
jal label2
nop
label2: jalr $8, $31
addi $31, $31, 8
jalr $8, $31
nop
jalr $31, $8
addi $8, $8, 8
addi $31, $0, 12548
sw $31, 0($0)
lw $17, 0($0)
nop
nop
jr $17
sw $0, 0($0)
addi $9, $0, 0
addi $31, $0, 12580
sw $31, 0($0)
lw $14, 0($0)
nop
nop
jalr $9, $14
sw $0, 0($0)
bne $9, $0, label3
addi $9, $9, 1
addi $9, $9, 1
label3: ori $2, $0, 0x7ffc
addi $15, $0, 12615
and $15, $15, $2
jr $15
nop
addi $20, $0, 0
ori $8, $0, 0x7ffc
addi $27, $0, 12639
and $27, $27, $8
jalr $20, $27
nop
bgtz $20, label4
addi $20, $20, 1
addi $20, $20, 1
label4: ori $15, $0, 1
ori $20, $0, 12672
mult $15, $20
mflo $15
jr $15
nop
addi $30, $0, 0
ori $15, $0, 1
ori $20, $0, 12700
mult $15, $20
mflo $15
jalr $30, $15
nop
bne $30, $0, label5
addi $30, $30, 1
addi $30, $30, 1
label5: mtlo $0
ori $31, $0, 3
ori $19, $0, 6
lw $31, 6($19)
mflo $19
addu $19, $19, $31
sw $31, 23($31)
mult $31, $31
ori $31, $31, 1
addi $31, $31, 12755
jalr $19, $31
lw $19, -12740($31)
ori $19, $31, 0
mflo $19
sw $19, -12740($31)
subu $31, $31, $19
sra $31, $31, 0
addi $19, $19, 12767
jr $19
sra $19, $31, 0
lui $31, 0
lw $19, -12703($19)
mflo $19
ori $t0, $0, 8
sw $t0, 20($0)
ori $t0, $0, 0
sw $t0, 28($0)
ori $13, $0, 8
ori $30, $0, 7
lui $30, 0
ori $13, $30, 4
lw $30, 0($30)
mtlo $30
mtlo $30
sra $30, $30, 1
bgez $13, label6
lw $30, 0($13)
ori $30, $13, 4
lui $13, 0
lw $30, -4($13)
addu $13, $13, $30
label6: sra $30, $13, 1
sra $30, $13, 1
ori $31, $0, 3
mult $31, $31
lw $31, 21($31)
ori $31, $31, 5
sw $31, 27($31)
mtlo $31
sw $31, 15($31)
jal label7
sra $31, $31, 0
label7: div $31, $31
mtlo $31
sw $31, -12884($31)
mtlo $31
addi $31, $31, 28
jr $31
sw $31, -12924($31)
lw $31, -12916($31)
lui $31, 0
sra $31, $31, 0
ori $t0, $0, 10
sw $t0, 20($0)
ori $t0, $0, 9
sw $t0, 24($0)
ori $t0, $0, 2
sw $t0, 32($0)
ori $t0, $0, 7
sw $t0, 36($0)
jal label8
addi $31, $31, 4
label8: jr $31
nop
addi $31, $0, 0
jal label9
nop
label9: bne $31, $0, label10
nop
label10: nop
ori $31, $0, 7
ori $15, $0, 8
lui $15, 0
ori $31, $15, 3
sra $31, $15, 0
ori $31, $31, 3
sw $31, 28($15)
lui $15, 0
addi $31, $31, 13073
jalr $15, $31
lui $15, 0
sw $31, -13036($31)
lui $15, 0
subu $31, $31, $31
lw $15, 0($15)
ori $15, $15, 7
addi $15, $15, 13101
jr $15
sw $15, 40($31)
ori $15, $31, 4
ori $15, $15, 4
sw $15, 16($31)
ori $t0, $0, 3
sw $t0, 16($0)
ori $t0, $0, 5
sw $t0, 28($0)
ori $t0, $0, 4
sw $t0, 40($0)
ori $12, $0, 3
ori $17, $0, 7
sw $12, 1($12)
mflo $17
addu $17, $12, $12
addu $12, $17, $12
mflo $17
div $17, $12
beq $17, $17, label11
lw $17, 23($12)
addu $17, $17, $17
mult $12, $17
mflo $17
lui $17, 0
label11: mflo $17
sra $12, $12, 0
ori $t0, $0, 2
sw $t0, 4($0)
ori $31, $0, 0
ori $31, $31, 1
mult $31, $31
sw $31, 11($31)
lui $31, 0
addu $31, $31, $31
mult $31, $31
jal label12
mflo $31
label12: ori $31, $31, 7
mtlo $31
mtlo $31
lui $31, 0
addi $31, $31, 13280
jr $31
mflo $31
addu $31, $31, $31
ori $31, $31, 0
mult $31, $31
ori $t0, $0, 6
sw $t0, 12($0)
jal label13
addi $31, $31, 4
label13: jr $31
nop
addi $31, $0, 0
jal label14
nop
label14: bne $31, $0, label15
nop
label15: nop
ori $10, $0, 1
ori $15, $0, 6
lui $15, 0
mtlo $15
lui $10, 0
mtlo $15
mtlo $15
addu $15, $10, $15
beq $10, $10, label16
lui $10, 0
sw $15, 28($10)
sw $10, 4($10)
sra $15, $15, 0
sra $15, $10, 1
label16: mtlo $15
addu $15, $10, $10
ori $15, $0, 4
ori $12, $0, 5
sra $12, $12, 1
mult $12, $12
sra $12, $12, 1
mflo $12
mult $15, $12
lui $15, 0
beq $15, $12, label17
sw $12, 12($15)
sw $15, 4($12)
mtlo $12
mtlo $12
sw $15, 8($12)
label17: sra $12, $12, 0
lw $12, 20($15)
ori $t0, $0, 8
sw $t0, 8($0)
ori $t0, $0, 4
sw $t0, 12($0)
ori $26, $0, 9
ori $16, $0, 9
mtlo $16
mflo $16
sra $16, $16, 1
mult $16, $16
mflo $26
addu $16, $16, $16
beq $26, $26, label18
lui $26, 0
lui $16, 0
sw $26, 8($16)
mflo $16
mflo $16
label18: lui $16, 0
lui $26, 0
ori $31, $0, 9
ori $2, $0, 3
mult $31, $31
lw $31, 11($31)
lui $31, 0
mult $31, $31
ori $31, $2, 6
sra $31, $31, 0
addi $31, $31, 13585
jalr $2, $31
sw $2, -13576($31)
mtlo $2
div $31, $2
sw $2, -13576($2)
sra $2, $31, 0
lw $31, -13560($2)
addi $2, $2, 32
jr $2
mflo $2
mflo $2
lui $2, 0
lw $31, 8($2)
ori $t0, $0, 7
sw $t0, 16($0)
ori $31, $0, 8
mflo $31
sra $31, $31, 0
addu $31, $31, $31
addu $31, $31, $31
ori $31, $31, 4
sra $31, $31, 0
jal label19
lui $31, 0
label19: addu $31, $31, $31
ori $31, $31, 4
lui $31, 0
addu $31, $31, $31
addi $31, $31, 13708
jr $31
subu $31, $31, $31
ori $31, $31, 2
mult $31, $31
sra $31, $31, 1
jal label20
addi $31, $31, 4
label20: jr $31
nop
addi $31, $0, 0
jal label21
nop
label21: bgtz $31, label22
nop
label22: nop
ori $12, $0, 9
ori $17, $0, 6
mflo $17
sw $17, 27($12)
lui $17, 0
lui $12, 0
sw $12, 4($12)
lw $12, 24($17)
bgez $17, label23
mult $12, $12
sra $12, $12, 1
addu $12, $17, $12
mflo $17
ori $17, $12, 4
label23: sra $17, $12, 1
sra $17, $17, 0
ori $t0, $0, 3
sw $t0, 4($0)
ori $t0, $0, 8
sw $t0, 36($0)
ori $31, $0, 7
ori $18, $0, 1
sw $31, 23($18)
mflo $18
mtlo $18
sw $18, 21($31)
mult $31, $18
lw $18, -61($18)
addi $31, $31, 13877
jalr $18, $31
lw $18, -13876($31)
addu $31, $18, $18
lui $18, 0
sw $18, 16($31)
sw $18, 16($31)
ori $31, $18, 0
addi $18, $18, 13916
jr $18
sra $31, $18, 0
mtlo $18
lui $31, 0
sra $18, $18, 0
ori $t0, $0, 0
sw $t0, 24($0)
ori $t0, $0, 10
sw $t0, 28($0)
ori $t0, $0, 1
sw $t0, 32($0)
ori $31, $0, 8
ori $19, $0, 8
addu $31, $19, $31
sw $19, 24($31)
addu $31, $31, $19
mflo $31
sra $19, $31, 1
mtlo $19
addi $31, $31, 80
jalr $19, $31
lw $31, -13984($31)
lui $19, 0
sra $19, $31, 0
lui $19, 0
lw $31, 40($19)
sw $19, 24($19)
addi $19, $19, 14028
jr $19
mflo $31
sra $31, $19, 0
mtlo $19
lui $31, 0
ori $t0, $0, 7
sw $t0, 24($0)
ori $t0, $0, 8
sw $t0, 40($0)
ori $16, $0, 5
ori $20, $0, 8
mtlo $16
addu $20, $20, $20
lui $16, 0
lui $16, 0
addu $16, $16, $16
ori $20, $20, 6
bgez $16, label24
sra $16, $20, 1
addu $16, $16, $16
lw $16, 29($16)
sra $20, $16, 0
mult $20, $16
label24: mtlo $16
mtlo $20
ori $31, $0, 3
ori $18, $0, 9
lw $18, 23($18)
lw $18, 25($31)
sra $18, $31, 1
lui $31, 0
lui $18, 0
sw $31, 36($31)
addi $31, $31, 14164
jalr $18, $31
sra $31, $31, 0
mflo $31
ori $31, $18, 2
subu $18, $31, $18
mtlo $31
sw $18, 2($18)
addi $18, $18, 14194
jr $18
ori $31, $18, 1
div $31, $31
ori $18, $31, 1
mtlo $31
ori $t0, $0, 3
sw $t0, 4($0)
ori $t0, $0, 0
sw $t0, 36($0)
ori $25, $0, 1
ori $14, $0, 10
addu $25, $25, $25
sra $25, $25, 0
mflo $25
subu $25, $25, $14
mult $14, $14
mflo $14
bgez $25, label25
sra $25, $14, 1
ori $25, $25, 0
mtlo $25
ori $14, $25, 6
div $25, $25
label25: sra $25, $25, 1
lw $25, -60($14)
ori $19, $0, 4
ori $15, $0, 10
lui $15, 0
mult $19, $19
addu $19, $19, $19
sw $15, -4($19)
lw $15, 0($19)
sw $15, 32($19)
bgez $19, label26
ori $15, $15, 3
addu $19, $15, $19
sw $19, -7($15)
mflo $19
mult $19, $19
label26: mflo $15
lw $19, 4($19)
ori $t0, $0, 1
sw $t0, 4($0)
ori $t0, $0, 3
sw $t0, 40($0)
ori $31, $0, 0
addu $31, $31, $31
ori $31, $31, 2
mtlo $31
lui $31, 0
sra $31, $31, 1
mflo $31
jal label27
sw $31, -14388($31)
label27: mflo $31
mult $31, $31
mflo $31
lui $31, 0
addi $31, $31, 14432
jr $31
lui $31, 0
lw $31, 4($31)
sra $31, $31, 0
ori $31, $31, 6
ori $t0, $0, 4
sw $t0, 16($0)
jal label28
addi $31, $31, 4
label28: jr $31
nop
addi $31, $0, 0
jal label29
nop
label29: bne $31, $0, label30
nop
label30: nop
ori $31, $0, 10
ori $22, $0, 3
sra $31, $22, 0
sra $22, $31, 1
mflo $31
mtlo $31
mtlo $22
sw $22, 23($22)
addi $31, $31, 14532
jalr $22, $31
sw $31, -14536($22)
lui $22, 0
ori $31, $22, 2
ori $22, $22, 4
mflo $22
mtlo $31
addi $22, $22, 14567
jr $22
sw $22, 2($31)
lw $31, 34($31)
lui $22, 0
ori $31, $31, 5
ori $t0, $0, 8
sw $t0, 0($0)
ori $t0, $0, 9
sw $t0, 4($0)
ori $t0, $0, 10
sw $t0, 24($0)
ori $31, $0, 8
ori $7, $0, 6
sw $7, 32($31)
mult $31, $31
sw $31, 0($31)
ori $31, $31, 1
ori $7, $7, 2
sra $7, $31, 0
addi $31, $31, 14639
jalr $7, $31
mflo $7
ori $7, $7, 2
sw $7, -62($7)
ori $7, $7, 2
lui $31, 0
sra $7, $7, 1
addi $7, $7, 14647
jr $7
ori $7, $31, 5
lw $7, 20($31)
mtlo $31
ori $31, $7, 7
ori $t0, $0, 1
sw $t0, 4($0)
ori $t0, $0, 4
sw $t0, 8($0)
ori $t0, $0, 6
sw $t0, 40($0)
ori $26, $0, 9
ori $21, $0, 3
ori $26, $21, 4
lui $21, 0
ori $26, $21, 5
ori $21, $21, 3
mflo $26
mult $21, $21
beq $21, $21, label31
mtlo $26
mult $21, $26
lw $26, 33($21)
sra $21, $26, 0
sw $21, 13($21)
label31: mult $26, $26
mflo $21
ori $27, $0, 2
ori $14, $0, 2
sw $14, 2($27)
mtlo $27
mult $27, $27
mtlo $14
mtlo $27
addu $27, $27, $14
beq $27, $14, label32
sw $14, 8($27)
sra $14, $27, 1
ori $14, $27, 0
sw $27, 16($27)
mflo $14
label32: sra $27, $14, 1
lui $27, 0
ori $t0, $0, 7
sw $t0, 4($0)
ori $t0, $0, 2
sw $t0, 12($0)
ori $t0, $0, 4
sw $t0, 20($0)
ori $31, $0, 2
ori $28, $0, 0
addu $31, $28, $31
sw $31, 18($31)
mtlo $31
mflo $31
sra $31, $28, 0
mult $31, $31
addi $31, $31, 14912
jalr $28, $31
sra $28, $31, 1
lui $31, 0
mflo $28
lw $31, 20($28)
lui $28, 0
mtlo $31
addi $28, $28, 14944
jr $28
ori $31, $31, 6
sw $28, 10($31)
mflo $28
sra $28, $31, 1
ori $t0, $0, 7
sw $t0, 16($0)
ori $t0, $0, 0
sw $t0, 20($0)
ori $31, $0, 1
ori $17, $0, 6
mult $17, $17
lui $31, 0
lui $17, 0
addu $17, $17, $31
sw $31, 36($31)
lui $17, 0
addi $31, $31, 15016
jalr $17, $31
subu $31, $17, $17
subu $17, $17, $31
sra $17, $17, 0
sw $31, -14984($17)
lw $31, 16($31)
mult $31, $31
addi $17, $17, 32
jr $17
mult $31, $31
subu $17, $17, $31
sra $31, $17, 1
mflo $31
ori $t0, $0, 6
sw $t0, 32($0)
ori $t0, $0, 1
sw $t0, 36($0)
ori $31, $0, 3
ori $22, $0, 7
lui $31, 0
mflo $31
mflo $31
mtlo $22
lw $31, 21($22)
lui $22, 0
addi $31, $31, 15110
jalr $22, $31
mflo $22
lui $22, 0
ori $22, $22, 0
lui $22, 0
mtlo $22
sw $31, -15108($31)
addi $22, $22, 15152
jr $22
mtlo $22
sra $31, $31, 1
sw $22, -7520($31)
mtlo $31
ori $t0, $0, 9
sw $t0, 12($0)
ori $t0, $0, 5
sw $t0, 40($0)
ori $5, $0, 10
ori $29, $0, 4
lw $5, -10($5)
mflo $29
sra $5, $5, 0
subu $29, $29, $5
sw $5, -7528($29)
sw $29, 12($5)
beq $5, $29, label33
mflo $29
lui $29, 0
mult $5, $29
addu $5, $5, $5
ori $29, $29, 6
label33: ori $5, $5, 2
mflo $29
ori $t0, $0, 4
sw $t0, 20($0)
ori $t0, $0, 3
sw $t0, 24($0)
ori $24, $0, 7
ori $2, $0, 9
ori $2, $2, 7
mtlo $24
lui $24, 0
sw $2, -15($2)
mflo $24
lw $2, 21($2)
beq $24, $2, label34
mtlo $24
mflo $2
sw $24, 29($2)
mflo $2
mflo $2
label34: sra $24, $2, 0
sra $2, $2, 1
ori $t0, $0, 9
sw $t0, 0($0)
ori $t0, $0, 4
sw $t0, 36($0)
ori $24, $0, 8
ori $8, $0, 7
mtlo $8
sra $24, $8, 0
mflo $8
sw $24, 5($8)
mult $24, $24
mflo $24
bgez $8, label35
ori $24, $24, 7
ori $8, $24, 0
ori $8, $24, 7
lw $24, -27($24)
lui $8, 0
label35: mflo $24
ori $24, $8, 3
ori $t0, $0, 5
sw $t0, 12($0)
ori $22, $0, 6
ori $26, $0, 4
sw $22, 0($26)
mflo $26
addu $22, $22, $22
ori $26, $22, 6
mult $22, $26
mflo $26
bgez $22, label36
mflo $22
mflo $22
sra $26, $22, 0
lui $22, 0
addu $22, $22, $26
label36: sw $22, -156($26)
ori $26, $22, 1
ori $t0, $0, 5
sw $t0, 4($0)
ori $t0, $0, 7
sw $t0, 12($0)
