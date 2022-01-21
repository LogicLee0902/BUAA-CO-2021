ori $s0, 100
ori $s1, 4
ori $s2,0x12345678
addu $t0, $s0, $s1
subu $t1, $s0, $s1
sw $s2, 0
