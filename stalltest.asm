.data	
	in_buff: .space 4096
.text
	la $a0,in_buff
	addi $a1,$0,3
	sw $a1,0($a0)
	lw $a2,0($a0)
	addi $a3,$a2,1#load-use
	beq $a3,$a2,branch1#R and beq
	addi $t0,$t0,1
branch1:
	lw $a3,0($a0)
	beq $a3,$a2,branch2#lw and beq
	addi $t1,$t1,1
branch2:
	jal jump1
jump1:	
	bne $a1,$ra,branch3#jal and beq
	addi $t2,$t2,1
	beq $a1,$a2,branch4
	addi $t3,$t3,1
	sw $a1,0($a0)
	lw $a2,0($a0)
	jr $a2#lw and jr
branch3:
	addi $a1,$ra,0
	jr $a1#R and jr
branch4:
	jal jump2
	addi $t4,$t4,1
loop:	
	j loop
jump2:	
	jr $ra#jal and jr


