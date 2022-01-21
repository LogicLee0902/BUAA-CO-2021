ori $28, $0, 0
ori $29, $0, 0
j label1
lui $14, 5826
ori $11, $0, 0
sw $11, 4($11)
label1: ori $11, $0, 0
lw $14, 0($11)
ori $11, $0, 0
sw $14, 0($11)
ori $14, $0, 0
sw $14, 0($14)
j label2
ori $11, $0, 0
lw $14, 8($11)
ori $14, $0, 0
lw $14, 4($14)
label2: lui $14, 3187
subu $11, $11, $11
j label3
lui $11, 46574
addu $11, $14, $14
label3: ori $11, $0, 0
sw $11, 4($11)
j label4
lui $11, 46708
lui $11, 32942
label4: addu $11, $11, $14
jal label5
ori $11, $0, 16
subu $11, $11, $14
label5: addu $11, $11, $31
jr $11
nop
lui $11, 9707
ori $11, $0, 0
lw $11, 4($11)
subu $11, $11, $14
ori $14, $11, 36047
addu $11, $14, $14
ori $14, $14, 31411
j label6
ori $11, $0, 0
lw $14, 4($11)
lui $11, 6257
label6: subu $11, $11, $11
jal label7
ori $11, $0, 16
ori $11, $14, 26568
label7: addu $11, $11, $31
jr $11
nop
ori $11, $14, 49488
j label8
subu $11, $11, $11
ori $14, $11, 62872
label8: lui $14, 14587
subu $11, $11, $11
ori $14, $0, 0
sw $11, 4($14)
jal label9
ori $11, $0, 16
subu $11, $11, $11
label9: addu $11, $11, $31
jr $11
nop
ori $14, $0, 0
sw $11, 0($14)
ori $14, $0, 0
lw $11, 8($14)
ori $11, $14, 14803
jal label10
ori $11, $0, 16
ori $11, $14, 44735
label10: addu $11, $11, $31
jr $11
nop
ori $11, $11, 28716
jal label11
ori $11, $0, 16
lui $11, 10659
label11: addu $11, $11, $31
jr $11
nop
ori $11, $0, 0
sw $14, 4($11)
subu $11, $11, $11
ori $14, $0, 0
sw $11, 8($14)
addu $11, $11, $11
addu $11, $14, $14
ori $14, $0, 0
sw $14, 0($14)
ori $11, $11, 35176
addu $11, $14, $11
beq $11, $11, label12
ori $11, $0, 0
sw $11, 4($11)
addu $11, $14, $11
label12: ori $11, $0, 0
sw $14, 12($11)
subu $11, $14, $11
ori $11, $0, 0
sw $11, 12($11)
ori $14, $0, 0
lw $11, 4($14)
jal label13
ori $11, $0, 16
lui $11, 29270
label13: addu $11, $11, $31
jr $11
nop
addu $14, $11, $11
jal label14
ori $11, $0, 16
lui $14, 62104
label14: addu $11, $11, $31
jr $11
nop
ori $11, $11, 28152
ori $11, $14, 15805
j label15
addu $11, $14, $14
ori $11, $0, 0
sw $11, 0($11)
label15: addu $11, $11, $11
j label16
ori $11, $0, 0
sw $11, 12($11)
subu $11, $14, $11
label16: addu $14, $11, $11
ori $11, $14, 63531
lui $11, 15107
jal label17
ori $11, $0, 16
subu $11, $14, $11
label17: addu $11, $11, $31
jr $11
nop
subu $11, $11, $14
jal label18
ori $11, $0, 16
subu $11, $11, $14
label18: addu $11, $11, $31
jr $11
nop
ori $11, $0, 0
lw $11, 4($11)
j label19
ori $14, $0, 0
sw $11, 0($14)
lui $14, 12471
label19: lui $14, 24977
j label20
ori $11, $11, 21439
ori $11, $0, 0
sw $11, 12($11)
label20: ori $11, $14, 44970
ori $11, $0, 0
lw $14, 8($11)
beq $14, $11, label21
ori $11, $0, 0
lw $14, 0($11)
ori $11, $0, 0
lw $11, 12($11)
label21: addu $11, $11, $11
ori $11, $11, 1015
subu $11, $11, $11
beq $11, $14, label22
ori $14, $0, 0
sw $14, 8($14)
ori $11, $11, 46304
label22: ori $11, $0, 0
lw $11, 0($11)
ori $11, $0, 0
lw $11, 4($11)
jal label23
ori $14, $0, 16
lui $11, 23697
label23: addu $14, $14, $31
jr $14
nop
ori $11, $11, 57809
ori $11, $0, 0
sw $11, 12($11)
addu $11, $11, $11
addu $11, $11, $14
subu $14, $11, $11
subu $11, $11, $11
j label24
ori $11, $11, 22860
addu $14, $11, $11
label24: addu $11, $11, $11
lui $11, 60560
jal label25
ori $11, $0, 16
addu $14, $11, $11
label25: addu $11, $11, $31
jr $11
nop
jal label26
ori $14, $0, 16
subu $14, $11, $11
label26: addu $14, $14, $31
jr $14
nop
subu $11, $11, $11
beq $14, $14, label27
ori $14, $11, 2712
ori $11, $0, 0
sw $14, 4($11)
label27: ori $14, $14, 3430
subu $11, $11, $14
subu $11, $14, $11
subu $11, $11, $14
ori $14, $14, 10963
subu $11, $11, $14
ori $11, $11, 56693
ori $11, $0, 0
sw $14, 4($11)
lui $11, 50961
addu $11, $11, $11
ori $14, $0, 0
lw $14, 8($14)
beq $14, $11, label28
ori $11, $0, 0
lw $11, 0($11)
ori $11, $0, 0
sw $11, 4($11)
label28: ori $11, $0, 0
sw $11, 8($11)
ori $11, $0, 0
sw $11, 8($11)
lui $14, 522
lui $11, 61350
subu $14, $14, $11
ori $11, $0, 0
sw $11, 12($11)
j label29
lui $14, 38118
ori $11, $0, 0
lw $11, 4($11)
label29: lui $11, 33206
beq $11, $11, label30
addu $11, $11, $11
subu $11, $11, $14
label30: ori $11, $14, 39336
lui $14, 37224
jal label31
ori $11, $0, 16
addu $11, $14, $11
label31: addu $11, $11, $31
jr $11
nop
ori $11, $14, 12772
beq $11, $14, label32
ori $14, $11, 20350
ori $11, $0, 0
lw $11, 8($11)
label32: subu $11, $11, $11
j label33
ori $11, $0, 0
sw $11, 0($11)
ori $14, $0, 0
lw $11, 4($14)
label33: subu $14, $14, $11
ori $14, $14, 56688
lui $14, 11088
beq $11, $14, label34
lui $11, 13410
ori $11, $0, 0
lw $11, 0($11)
label34: subu $11, $14, $11
ori $11, $0, 0
sw $11, 0($11)
j label35
ori $14, $0, 0
sw $14, 4($14)
ori $11, $11, 18332
label35: ori $11, $0, 0
lw $11, 4($11)
addu $11, $11, $11
ori $11, $14, 38930
ori $11, $0, 0
sw $11, 4($11)
ori $11, $0, 0
sw $11, 8($11)
jal label36
ori $11, $0, 16
ori $11, $11, 6749
label36: addu $11, $11, $31
jr $11
nop
ori $11, $0, 0
lw $11, 12($11)
subu $14, $11, $14
ori $11, $0, 0
lw $11, 8($11)
subu $11, $14, $11
ori $11, $11, 32189
lui $14, 17000
ori $14, $0, 0
sw $11, 8($14)
ori $11, $0, 0
lw $14, 12($11)
addu $11, $11, $11
addu $14, $14, $11
addu $11, $11, $11
j label37
ori $11, $0, 0
sw $14, 12($11)
subu $11, $11, $11
label37: lui $14, 1126
ori $11, $0, 0
sw $14, 12($11)
addu $11, $11, $11
subu $11, $11, $11
ori $14, $0, 0
sw $11, 8($14)
jal label38
ori $11, $0, 16
addu $11, $11, $11
label38: addu $11, $11, $31
jr $11
nop
ori $14, $0, 0
lw $14, 4($14)
subu $11, $11, $11
j label39
ori $14, $0, 0
lw $11, 4($14)
subu $11, $11, $14
label39: ori $11, $0, 0
lw $11, 8($11)
ori $11, $0, 0
sw $11, 12($11)
addu $11, $14, $14
jal label40
ori $11, $0, 16
subu $11, $14, $11
label40: addu $11, $11, $31
jr $11
nop
jal label41
ori $11, $0, 16
subu $11, $11, $11
label41: addu $11, $11, $31
jr $11
nop
ori $14, $0, 0
sw $14, 8($14)
lui $11, 62208
j label42
subu $11, $14, $14
ori $11, $14, 47313
label42: addu $11, $11, $14
jal label43
ori $14, $0, 16
addu $14, $14, $11
label43: addu $14, $14, $31
jr $14
nop
lui $11, 21861
j label44
ori $11, $0, 0
lw $11, 12($11)
lui $11, 6264
label44: ori $11, $14, 9009
subu $14, $11, $14
subu $14, $14, $11
addu $14, $11, $11
addu $11, $11, $11
ori $11, $0, 0
sw $11, 12($11)
j label45
ori $11, $0, 0
lw $14, 4($11)
lui $11, 21533
label45: lui $11, 44773
subu $11, $11, $14
lui $11, 64264
j label46
subu $14, $11, $11
lui $14, 18915
label46: subu $11, $11, $11
beq $11, $14, label47
ori $14, $11, 44936
ori $11, $11, 61688
label47: subu $11, $14, $11
ori $14, $0, 0
lw $14, 8($14)
ori $14, $0, 0
lw $14, 12($14)
subu $14, $11, $11
subu $14, $11, $14
subu $11, $11, $11
ori $14, $11, 32035
ori $11, $14, 11879
ori $14, $11, 4815
subu $14, $11, $14
beq $11, $11, label48
lui $11, 28898
ori $11, $0, 0
sw $14, 8($11)
label48: subu $11, $11, $11
j label49
lui $11, 60262
lui $14, 11913
label49: ori $14, $0, 0
lw $14, 0($14)
lui $11, 33100
ori $11, $0, 0
sw $14, 12($11)
ori $11, $11, 16006
beq $11, $11, label50
lui $11, 17003
lui $11, 53862
label50: ori $11, $0, 0
sw $11, 12($11)
lui $14, 56893
ori $11, $0, 0
lw $14, 8($11)
j label51
addu $14, $14, $14
ori $11, $11, 24042
label51: addu $14, $11, $11
ori $14, $0, 0
lw $14, 4($14)
addu $14, $11, $11
ori $11, $0, 0
lw $11, 8($11)
beq $11, $11, label52
lui $11, 5870
lui $11, 29746
label52: lui $11, 40080
lui $11, 27996
subu $11, $14, $11
j label53
ori $14, $0, 0
lw $11, 4($14)
addu $11, $11, $11
label53: addu $11, $11, $11
j label54
lui $11, 33980
ori $11, $11, 42972
label54: addu $11, $11, $11
ori $14, $0, 0
sw $14, 0($14)
ori $14, $11, 21546
subu $14, $14, $11
beq $14, $11, label55
ori $14, $14, 8450
ori $11, $11, 10018
label55: ori $14, $0, 0
lw $11, 8($14)
beq $11, $14, label56
lui $11, 61527
ori $14, $11, 40201
label56: subu $11, $11, $14
lui $11, 39808
jal label57
ori $14, $0, 16
ori $11, $11, 50961
label57: addu $14, $14, $31
jr $14
nop
subu $11, $11, $11
jal label58
ori $14, $0, 16
lui $11, 62255
label58: addu $14, $14, $31
jr $14
nop
jal label59
ori $11, $0, 16
subu $11, $11, $11
label59: addu $11, $11, $31
jr $11
nop
lui $11, 54137
ori $11, $0, 0
lw $14, 4($11)
ori $11, $11, 18647
ori $11, $14, 13850
jal label60
ori $11, $0, 16
lui $14, 7503
label60: addu $11, $11, $31
jr $11
nop
addu $11, $14, $14
jal label61
ori $11, $0, 16
addu $14, $14, $14
label61: addu $11, $11, $31
jr $11
nop
ori $14, $0, 0
lw $11, 8($14)
ori $14, $0, 0
lw $11, 4($14)
lui $11, 10684
jal label62
ori $11, $0, 16
ori $11, $11, 13742
label62: addu $11, $11, $31
jr $11
nop
ori $11, $0, 0
sw $11, 0($11)
jal label63
ori $14, $0, 16
lui $11, 10567
label63: addu $14, $14, $31
jr $14
nop
ori $14, $0, 0
lw $14, 0($14)
beq $11, $11, label64
ori $11, $0, 0
sw $11, 0($11)
lui $11, 11486
label64: lui $14, 17868
jal label65
ori $14, $0, 16
ori $11, $14, 21535
label65: addu $14, $14, $31
jr $14
nop
beq $11, $11, label66
ori $11, $11, 56123
ori $11, $0, 0
sw $11, 4($11)
label66: ori $14, $0, 0
sw $11, 4($14)
jal label67
ori $14, $0, 16
lui $11, 55965
label67: addu $14, $14, $31
jr $14
nop
ori $14, $11, 58294
ori $14, $0, 0
sw $11, 12($14)
j label68
subu $14, $14, $11
ori $11, $0, 0
lw $11, 0($11)
label68: ori $14, $0, 0
lw $14, 0($14)
j label69
subu $14, $11, $11
lui $11, 2782
label69: addu $11, $11, $14
lui $11, 14552
ori $11, $0, 0
sw $11, 4($11)
ori $11, $0, 0
lw $11, 8($11)
ori $11, $14, 45661
lui $11, 38876
beq $11, $14, label70
ori $11, $14, 35000
ori $11, $11, 44700
label70: ori $11, $0, 0
sw $11, 12($11)
j label71
lui $11, 45183
lui $11, 64137
label71: lui $11, 6364
j label72
subu $11, $11, $11
lui $11, 40242
label72: lui $11, 27682
ori $11, $0, 0
lw $11, 8($11)
ori $11, $14, 30689
j label73
addu $14, $11, $11
lui $11, 51914
label73: ori $11, $0, 0
lw $11, 0($11)
j label74
ori $11, $0, 0
lw $11, 8($11)
ori $14, $14, 14953
label74: subu $11, $11, $14
jal label75
ori $14, $0, 16
subu $11, $11, $11
label75: addu $14, $14, $31
jr $14
nop
beq $11, $11, label76
ori $14, $11, 56294
ori $14, $0, 0
lw $11, 4($14)
label76: ori $11, $14, 60641
lui $11, 32109
ori $14, $14, 42237
j label77
ori $14, $0, 0
sw $11, 4($14)
ori $11, $0, 0
lw $11, 12($11)
label77: lui $11, 55339
j label78
addu $14, $11, $11
lui $11, 59337
label78: subu $14, $14, $11
lui $11, 8021
addu $11, $11, $14
lui $14, 7291
jal label79
ori $11, $0, 16
subu $11, $14, $14
label79: addu $11, $11, $31
jr $11
nop
j label80
ori $11, $0, 0
lw $14, 8($11)
ori $11, $11, 9377
label80: ori $11, $0, 0
lw $11, 12($11)
j label81
lui $11, 32080
subu $11, $11, $14
label81: ori $11, $0, 0
lw $11, 4($11)
ori $11, $0, 0
sw $14, 0($11)
beq $11, $11, label82
subu $11, $11, $11
ori $14, $0, 0
sw $11, 12($14)
label82: ori $11, $0, 0
sw $14, 4($11)
ori $11, $0, 0
lw $14, 12($11)
lui $14, 15203
lui $11, 14067
jal label83
ori $11, $0, 16
lui $11, 57617
label83: addu $11, $11, $31
jr $11
nop
ori $11, $0, 0
sw $11, 12($11)
jal label84
ori $14, $0, 16
addu $11, $11, $11
label84: addu $14, $14, $31
jr $14
nop
subu $11, $11, $14
ori $14, $0, 0
sw $11, 4($14)
subu $14, $11, $11
ori $11, $11, 48970
jal label85
ori $11, $0, 16
subu $11, $14, $11
label85: addu $11, $11, $31
jr $11
nop
j label86
ori $11, $14, 27976
lui $14, 16930
label86: lui $11, 59519
jal label87
ori $14, $0, 16
lui $14, 54418
label87: addu $14, $14, $31
jr $14
nop
ori $11, $0, 0
lw $14, 12($11)
j label88
ori $11, $11, 11416
lui $14, 955
label88: subu $11, $11, $11
j label89
addu $11, $11, $14
ori $11, $0, 0
sw $11, 12($11)
label89: subu $11, $11, $11
addu $11, $11, $14
ori $14, $0, 0
sw $14, 8($14)
j label90
ori $11, $11, 9012
lui $11, 12835
label90: ori $11, $0, 0
sw $14, 8($11)
jal label91
ori $14, $0, 16
subu $11, $14, $11
label91: addu $14, $14, $31
jr $14
nop
lui $11, 49303
ori $14, $0, 0
lw $14, 8($14)
ori $11, $0, 0
lw $14, 12($11)
ori $14, $14, 19817
beq $14, $11, label92
lui $14, 64782
lui $11, 28661
label92: lui $14, 42925
ori $11, $0, 0
lw $14, 8($11)
lui $11, 52578
j label93
addu $11, $11, $14
addu $14, $11, $14
label93: lui $14, 36444
addu $14, $11, $14
lui $11, 21378
j label94
ori $11, $14, 31969
lui $11, 29955
label94: lui $11, 32907
beq $11, $11, label95
addu $11, $11, $14
ori $14, $0, 0
lw $14, 12($14)
label95: ori $14, $14, 19144
ori $11, $0, 0
lw $11, 8($11)
subu $11, $11, $11
ori $11, $0, 0
sw $14, 12($11)
subu $14, $11, $11
lui $11, 64526
lui $14, 25499
ori $11, $0, 0
sw $11, 8($11)
subu $14, $14, $14
subu $11, $14, $14
addu $11, $14, $11
addu $11, $11, $14
beq $11, $11, label96
lui $14, 61413
ori $14, $0, 0
lw $11, 12($14)
label96: subu $11, $11, $11
jal label97
ori $14, $0, 16
subu $14, $11, $11
label97: addu $14, $14, $31
jr $14
nop
jal label98
ori $11, $0, 16
subu $11, $11, $14
label98: addu $11, $11, $31
jr $11
nop
subu $11, $11, $11
j label99
lui $14, 49434
ori $14, $14, 64812
label99: ori $11, $0, 0
sw $11, 0($11)
j label100
addu $11, $11, $11
subu $14, $14, $11
label100: ori $11, $14, 40033
addu $11, $11, $11
ori $11, $0, 0
sw $11, 8($11)
jal label101
ori $11, $0, 16
lui $14, 38085
label101: addu $11, $11, $31
jr $11
nop
jal label102
ori $11, $0, 16
addu $14, $14, $11
label102: addu $11, $11, $31
jr $11
nop
beq $14, $14, label103
lui $11, 17035
ori $11, $0, 0
lw $14, 0($11)
label103: subu $11, $11, $14
ori $14, $0, 0
sw $11, 4($14)
jal label104
ori $14, $0, 16
ori $14, $11, 21907
label104: addu $14, $14, $31
jr $14
nop
addu $11, $11, $11
addu $11, $11, $14
subu $11, $11, $11
j label105
ori $11, $11, 16117
ori $11, $11, 47164
label105: ori $11, $0, 0
lw $11, 12($11)
ori $11, $0, 0
lw $14, 4($11)
jal label106
ori $11, $0, 16
addu $11, $11, $14
label106: addu $11, $11, $31
jr $11
nop
addu $11, $11, $11
lui $11, 45186
addu $11, $14, $11
lui $11, 53608
lui $11, 29552
lui $11, 17034
ori $14, $14, 32424
ori $14, $0, 0
sw $11, 0($14)
lui $11, 44441
ori $14, $0, 0
lw $14, 12($14)
ori $11, $14, 4503
ori $11, $0, 0
sw $11, 0($11)
addu $14, $14, $11
ori $14, $0, 0
sw $11, 12($14)
ori $11, $14, 19825
lui $14, 22432
addu $11, $11, $14
lui $14, 55295
subu $11, $14, $11
ori $11, $11, 12082
lui $11, 8758
ori $14, $11, 24793
j label107
ori $11, $0, 0
sw $14, 0($11)
ori $11, $0, 0
sw $11, 8($11)
label107: lui $11, 52495
ori $11, $0, 0
sw $14, 8($11)
ori $14, $0, 0
lw $14, 0($14)
subu $11, $14, $11
jal label108
ori $14, $0, 16
subu $14, $14, $11
label108: addu $14, $14, $31
jr $14
nop
ori $11, $0, 0
sw $11, 0($11)
j label109
addu $14, $11, $11
ori $14, $0, 0
sw $11, 12($14)
label109: subu $14, $11, $11
ori $11, $0, 0
sw $11, 4($11)
beq $11, $14, label110
ori $11, $0, 0
sw $11, 0($11)
ori $11, $11, 7704
label110: ori $14, $0, 0
lw $11, 12($14)
jal label111
ori $14, $0, 16
subu $11, $11, $14
label111: addu $14, $14, $31
jr $14
nop
subu $11, $14, $14
addu $14, $11, $14
beq $11, $11, label112
ori $11, $0, 0
lw $11, 4($11)
ori $11, $11, 44908
label112: ori $11, $0, 0
lw $11, 12($11)
ori $11, $14, 3678
j label113
subu $11, $14, $11
ori $11, $0, 0
lw $11, 8($11)
label113: lui $11, 53871
addu $14, $11, $11
ori $11, $11, 56847
lui $14, 26427
addu $11, $14, $11
lui $11, 55114
ori $14, $11, 40212
beq $14, $14, label114
ori $11, $11, 27701
lui $11, 16533
label114: ori $11, $0, 0
lw $14, 8($11)
subu $11, $14, $11
ori $14, $11, 16725
beq $11, $11, label115
ori $14, $11, 1544
ori $14, $11, 21757
label115: ori $11, $14, 16503
subu $14, $11, $11
ori $11, $14, 43245
ori $11, $11, 13953
ori $11, $0, 0
sw $14, 12($11)
beq $11, $11, label116
ori $14, $0, 0
lw $14, 12($14)
addu $14, $14, $11
label116: ori $11, $0, 0
lw $14, 4($11)
ori $11, $11, 30289
ori $11, $0, 0
lw $11, 8($11)
jal label117
ori $11, $0, 16
subu $14, $14, $14
label117: addu $11, $11, $31
jr $11
nop
subu $11, $14, $11
ori $11, $0, 0
sw $14, 0($11)
lui $14, 39846
subu $11, $14, $11
subu $14, $11, $14
subu $14, $11, $14
j label118
subu $11, $11, $11
ori $14, $0, 0
sw $11, 4($14)
label118: ori $14, $11, 17303
subu $11, $11, $14
beq $11, $14, label119
lui $11, 33943
ori $11, $14, 9484
label119: lui $11, 25401
