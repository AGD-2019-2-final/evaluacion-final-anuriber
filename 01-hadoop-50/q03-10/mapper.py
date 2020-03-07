import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        columna1 = ""
        columna2 = ""
        
        line = line.strip()
        splits = line.split(",")
        #print(len(splits))
        #print(splits[1])
        if len(splits) != 1: # Transactions have more columns than users
            columna1 = splits[0]
            columna2 = splits[1] 
        print(columna2 + '\t' + columna1)
