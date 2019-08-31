with open('ptest.txt') as f:
    for i,line in enumerate(f.readlines()):
        print('8\'d'+str(i)+': Instruction<=32\'h'+line.strip()+';')
