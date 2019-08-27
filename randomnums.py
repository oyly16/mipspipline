import random

for i in range(10):
    print('addi $a0,$0,'+str(random.randint(0,20)))
    print('sw $a0,0($a1)')
    print('addi,$a1,$a1,4')