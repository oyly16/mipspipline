.data
	in_buff: .space 4096

.text
sort:
    	#lw $s0,20($a0)#$s0 is the begin time of sort
    	addi $s1,$0,0#$s1 is the begin of datamemory
    	#la $s1,in_buff
	addi $t0,$0,20
	sw $t0,0($s1)
	addi $t0,$0,16
	sw $t0,4($s1)
	addi $t0,$0,19
	sw $t0,8($s1)
	addi $t0,$0,6
	sw $t0,12($s1)
	addi $t0,$0,2
	sw $t0,16($s1)#store N numbers
	addi $s2,$0,4#s2=N-1
	addi $s3,$0,1
loop1:  
    	bgt $s3,$s2,exit1
	addi $s4,$s3,-1
loop2:  
    	blt $s4,$0,exit2
	sll $t0,$s4,2
	add $t0,$s1,$t0
	lw $t1,0($t0)
	lw $t2,4($t0)
	blt $t2,$t1,swap
conti:  
    	addi $s4,$s4,-1
	j loop2
exit2:  
    	addi $s3,$s3,1
	j loop1
exit1:  
    	j end
swap:   
    	sll $t1,$s4,2
	add $t1,$s1,$t1
	lw $t0,0($t1)
	lw $t2,4($t1)
	sw $t2,0($t1)
	sw $t0,4($t1)
	j conti
end:
	nop
	 
	

	
	
