
ori $s0, 200
ori $s1, 200
#subu $s0, $s0, $s1
beq $s0, $0, bbb
ori $s2, 300
ori $s3, 100
bbb:
ori $s3, 400
