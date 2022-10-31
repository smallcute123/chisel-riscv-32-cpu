from random import *

file = open("fetch.hex","w")

for j in range(100):
    file.write("".join([choice("0123456789ABCDEF") for i in range(2)]) )
    file.write('\n')

file.close()
