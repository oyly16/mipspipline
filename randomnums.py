import random


random.seed(1)
for i in range(100):
    #print('RAM_data['+str(i)+']<=32\'d'+str(random.randint(0,200))+';')
    print('addi $t0,$0,'+str(random.randint(0,200)))
    print('sw $t0,'+str(i*4)+'($s1)')