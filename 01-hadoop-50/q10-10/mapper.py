import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        columna1 = ""
        columna2 = ""
        
        line = line.strip()
        splits = line.split("\t")
        
        if len(splits) != 1: 
            columna1 = splits[0].rjust(4)
            columna2 = splits[1].split(",")
            
        for letra in columna2:  
            print(letra + '\t' + columna1)
        
