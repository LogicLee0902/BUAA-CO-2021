ori $1, $1, 1
nop
nop
nop
nop
addu $2, $1, $1
addu $2, $1, $2
subu $2, $2, $1
subu $2, $1, $2
addu $2, $1, $2
nop
nop
nop
nop
lui $1, 0
lui $2, 0
nop
nop
ori $1, $1, 1
nop
nop
nop
nop
addu $2, $1, $1
nop
addu $2, $1, $2
nop
subu $2, $2, $1
nop
subu $2, $1, $2
nop
addu $2, $1, $2
nop
nop
nop
nop
lui $1, 0
lui $2, 0
nop
nop
nop
ori $1, $1, 1
nop
nop
nop
nop
addu $2, $1, $1
nop
nop
addu $2, $1, $2
nop
nop
subu $2, $2, $1
nop
nop
subu $2, $1, $2
nop
nop
addu $2, $1, $2
nop
nop
nop
nop
ori $1, 123
addu $2, $1, $1
subu $3, $1, $1
nop
nop
nop
nop
ori $1, 321
subu $2, $1, $1
addu $3, $1, $1
nop
nop
nop
ori $1, 4321
nop
addu $2, $1, $1
subu $3, $1, $1
nop
nop
nop
nop
ori $1, 54212
nop
subu $2, $1, $1
addu $3, $1, $1
nop
nop
nop
nop
lui $1, 123
addu $2, $1, $1
subu $3, $2, $1
nop
nop
nop
nop
lui $1, 223
subu $3, $2, $1
addu $2, $1, $1
nop
nop
nop
nop
lui $1, 321
nop
addu $2, $1, $2
subu $3, $1, $1
nop
nop
nop
nop
lui $1, 432
nop
subu $3, $1, $1
addu $2, $1, $3
nop
nop
nop
jal label00
addu $2, $1, $31
label00: subu $1, $31, $1
jal label01
subu $1, $31, $1
label01: addu $2, $1, $31
jal label02
nop
label02: addu $2, $1, $31
subu $1, $31, $1
ori $2, $1, 123
ori $3, $1, 432
ori $4, $1, 543
jal label03
nop
label03: subu $1, $31, $1
addu $2, $1, $31
ori $3, $2, 123
ori $4, $2, 234
ori $5, $2, 345
ori $1, $5, 12345
ori $2, $5, 43121
ori $3, $5, 12313
ori $4, $5, 12421
lui $1, 12
ori $2, $1, 123
ori $2, $1, 121
ori $2, $1, 122
ori $2, $1, 143
jal label04
ori $1, $31, 123
label04 : ori $1, $31, 124
ori $1, $31, 125
ori $1, $31, 126
nop
nop
nop
addu $2, $1, $31
beq $2, $1, label05
nop
label05:
addu $3, $1, $31
nop
beq $3, $1, label06
nop
label06: 
addu $4, $1, $31
nop
nop
beq $4, $1, label07
nop
label07:
subu $2, $1, $31
beq $2, $1, label08
nop
label08:
subu $3, $1, $31
nop
beq $3, $1, label09
nop
label09: 
subu $4, $1, $31
nop
nop
beq $4, $1, label10
nop
label10:
ori $1, $4, 12312
beq $1, $31, label11
ori $2, $4, 12312
label11:nop
beq $2, $31, label12
ori $3, $4, 12312
label12: nop
nop
beq $3, $31, label13
ori $4, $3, 43121
label13: nop
nop
nop
beq $4, $31, label14
nop
label14:nop

lui $1, 12312
beq $1, $31, label15
lui $2, 12312
label15:nop
beq $2, $31, label16
lui $3, 12312
label16: nop
nop
beq $3, $31, label17
lui $4, 43121
label17: nop
nop
nop
beq $4, $31, label18
nop
label18:nop
jal label19
nop
label19: beq $31, $1, label20 
nop
label20: jal label21 
nop
label21: nop
beq $31, $1, label22 
nop
label22: jal label23
nop
label23: nop
nop
beq $31, $1, label24
nop
label24: 
ori $2, $0, 16
addu $1, $31, $31
sw $1, -16($2)
sw $1, -12($2)
sw $1, -8($2)
sw $1, 12($0)
subu $1, $1, $31
sw $1, 0($0)
sw $1, 4($0)
sw $1, 8($0)
sw $1, 12($0)
ori $1, $1, 5324
sw $1, 0($0)
sw $1, 4($0)
sw $1, 8($0)
sw $1, 12($0)
lui $1, 12
sw $1, 0($0)
sw $1, 4($0)
sw $1, 8($0)
sw $1, 12($0)
jal label25
sw $31, -16($2)
label25: sw $31, 4($0)
sw $31, 8($0)
sw $31, 12($0)
ori $1, $0, 4
jal label26
addu $31, $31, $1
nop
j label27
nop
label26: jr $31
nop
label27: jal label28
addu $31, $31, $1
nop
j label29
nop
label28: nop
jr $31
nop
label29: jal label30 
addu $31, $31, $1
nop
j label31 
nop
label30: nop
nop
jr $31
nop
label31: nop
nop

ori $1, $0, 4
jal label32 
addu $31, $31, $1
j label33
nop
label32: subu $31, $31, $1
jr $31
nop
label33: jal label34
addu $31, $31, $1
j label35
nop
label34: subu $31, $31, $1
nop
jr $31
nop
label35: jal label36
addu $31, $31, $1
j label37
nop
label36: subu $31, $31, $1
nop
nop
jr $31
nop
label37: nop

ori $9, $9, 0x3000
jal label38
subu $31, $31, $9
j label39
nop
label38: ori $31, $31, 0x3000
jr $31
nop

label39: jal label40
subu $31, $31, $9
j label41
nop
label40: ori $31, $31, 0x3000
nop
jr $31
nop

label41: jal label42
subu $31, $31, $9
j label43
nop
label42: ori $31, $31, 0x3000
nop
nop
jr $31
nop

label43: jal label44
nop
j label45
nop
label44: jr $31
nop

label45: jal label46
nop
j label47
nop
label46: nop
jr $31
nop

label47: jal label48
nop
j label49
nop
label48: nop
nop
nop
jr $31

label49: nop

ori $1, $0, 0
lw $1, 0($0)
addu $2, $1, $1
addu $3, $2, $1
addu $4, $3, $1
addu $5, $4, $1
ori $1, $0, 0
nop
nop
nop
nop
lw $1, 0($0)
subu $2, $1, $1
subu $3, $2, $1
subu $4, $3, $1
subu $5, $4, $1
lw $2, 0($0)
ori $1, $2, 123
ori $1, $2, 321
ori $1, $2, 245
ori $1, $2, 1234
lw $3, 0($0)
beq $3, $1, label50 
nop
beq $3, $1, label50 
nop
beq $3, $1, label50
nop
beq $3, $1, label50
nop
label50: nop
lw $4, 0($0)
sw $4, 0x2000($0)
sw $4, 0x2004($0)
sw $4, 0x2008($0)
sw $4, 0x200c($0)
ori $9, $0, 0x3000
subu $4, $4, $9
sw $4, 0x0000($4)
jal label51 
sw $31, 0($0)
jal label52 
sw $31, 0($0)
jal label53 
sw $31, 0($0)
j label54 
label51: lw $1, 0($0)
jr $1
nop
label52: lw $1, 0($0)
nop
jr $1
nop
label53: lw $1, 0($0)
nop
nop
jr $1
label54: nop
ori $2, $0, 4
addu $1, $2, $0
lw $3, 0($1)
lw $3, 4($1)
lw $3, 8($1)
lw $3, -4($1)
subu $3, $1, $1
lw $4, 0($3)
lw $4, 4($3)
lw $4, 8($3)
lw $4, 12($3)
ori $3, $0, 8
lw $2, -8($3)
lw $2, -4($3)
lw $2, 0($3)
lw $2, 4($3)
sw $3, 0($0)
lw $1, 0($0)
lw $2, 0($1)
lw $2, -4($1)
lw $2, 4($1)
lw $2, -8($1)
ori $2, $0, 123
lui $2, 0
lw $3, 0($2)
lw $3, 4($2)
lw $3, 8($2)
lw $3, 12($2)
jal label55
lw $4, -0x3000($31)
label55: lw $4, -0x3000($31)
lw $4, -0x3000($31)
lw $4, -0x3000($31)
sw $1, 0($4)
