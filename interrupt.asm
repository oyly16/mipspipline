    j main
    j interrupt
    j exception

main:
    addi $s0,$0,2
loop:
    beq $a0,$s0,out
    addi $a0,$a0,1
    j loop

interrupt:
    addi $a1,$a1,1
    jr $26

exception:
    addi $a2,$a2,1
    jr $26

out:
    nop#0xffffffff
    addi $a3,$a3,1
    nop
