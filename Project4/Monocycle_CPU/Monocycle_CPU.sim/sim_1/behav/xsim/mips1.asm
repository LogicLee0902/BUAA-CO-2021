ori $0, $0, 1
addu $0, $0, $0
lui $0, 234
sw $0, ($0)
lui $s0, 2
lw $s0, ($0)
subu $t1,$s0, $t2