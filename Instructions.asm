    j main
    j interrupt
    j exception
	
main:	
    lui $a0,0x4000#$a0 is the begin of peripherals
    addi $a1,$0,0#$a1 loop 0~3 to control AN
    addi $a2,$0,0#$a2 is the data to show on digi
    addi $a3,$0,0#$a3 is the decode result writing into 0x40000010
    addi $t4,$0,1
    addi $t5,$0,2
    addi $t6,$0,3#parameter 1,2,3 
    addi $t7,$0,-7#$t7=0xfffffff9
    addi $t8,$0,-1#$t8=0xffffffff

sort:
    lw $a2,20($a0)#save start time
    addi $s1,$0,0#$s1 is the begin of datamemory
    addi $s2,$0,99#s2=N-1
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
    lw $t0,20($a0)
    sub $a2,$t0,$a2#cal a2
    srl $t0,$a2,16
    sw $t0,12($a0)#high in led
    addi $s0,$0,-60000
    sw $s0,0($a0)#set TH
    sw $t8,4($a0)#set TL
    sw $t6,8($a0)#open timer
    j end
swap:   
    sll $t1,$s4,2
    add $t1,$s1,$t1
    lw $t0,0($t1)
    lw $t2,4($t1)
    sw $t2,0($t1)
    sw $t0,4($t1)
    j conti

interrupt:
    lw $t0,8($a0)
    and $t0,$t0,$t7
    sw $t0,8($a0)#TCON &= 0xfffffff9
    #save datas at $sp
    beq $a1,$0,show0
    beq $a1,$t4,show1
    beq $a1,$t5,show2
    beq $a1,$t6,show3

return:
    sw $a3,16($a0)
    bne $a1,$t6,a1plus
    addi $a1,$0,-1
a1plus:
    addi $a1,$a1,1
    #take datas from $sp
    lw $t0,8($a0)
    ori $t0,$t0,2
    sw $t0,8($a0)
    jr $26

show0:
    andi $s5,$a2,0x000f
    jal decode
    addi $a3,$a3,0x0100
    j return

show1:
    andi $s5,$a2,0x00f0
    srl $s5,$s5,4
    jal decode
    addi $a3,$a3,0x0200
    j return

show2:
    andi $s5,$a2,0x0f00
    srl $s5,$s5,8
    jal decode
    addi $a3,$a3,0x0400
    j return

show3:
    andi $s5,$a2,0xf000
    srl $s5,$s5,12
    jal decode
    addi $a3,$a3,0x0800
    j return
    
decode:
    addi $a3,$0,0
    addi $t0,$s5,0
    beq $t0,$0,zero
    addi $t0,$s5,-1
    beq $t0,$0,one
    addi $t0,$s5,-2
    beq $t0,$0,two
    addi $t0,$s5,-3
    beq $t0,$0,three
    addi $t0,$s5,-4
    beq $t0,$0,four
    addi $t0,$s5,-5
    beq $t0,$0,five
    addi $t0,$s5,-6
    beq $t0,$0,six
    addi $t0,$s5,-7
    beq $t0,$0,seven
    addi $t0,$s5,-8
    beq $t0,$0,eight
    addi $t0,$s5,-9
    beq $t0,$0,nine
    addi $t0,$s5,-10
    beq $t0,$0,ten
    addi $t0,$s5,-11
    beq $t0,$0,eleven
    addi $t0,$s5,-12
    beq $t0,$0,twelve
    addi $t0,$s5,-13
    beq $t0,$0,thirteen
    addi $t0,$s5,-14
    beq $t0,$0,fourteen
    addi $t0,$s5,-15
    beq $t0,$0,fifteen

zero:
    addi $a3,$0,0x003f
    jr $ra
one:
    addi $a3,$0,0x0006
    jr $ra
two:
    addi $a3,$0,0x005b
    jr $ra
three:
    addi $a3,$0,0x004f
    jr $ra
four:
    addi $a3,$0,0x0066
    jr $ra
five:
    addi $a3,$0,0x006d
    jr $ra
six:
    addi $a3,$0,0x007d
    jr $ra
seven:
    addi $a3,$0,0x0007
    jr $ra 
eight:
    addi $a3,$0,0x007f
    jr $ra
nine:
    addi $a3,$0,0x006f
    jr $ra
ten:
    addi $a3,$0,0x0077
    jr $ra
eleven:
    addi $a3,$0,0x007c
    jr $ra
twelve:
    addi $a3,$0,0x0039
    jr $ra
thirteen:
    addi $a3,$0,0x005e
    jr $ra
fourteen:
    addi $a3,$0,0x0079
    jr $ra
fifteen:
    addi $a3,$0,0x0071
    jr $ra

exception:
    jr $26

end:
    j end
