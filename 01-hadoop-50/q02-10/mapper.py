import sys
#
# >>> Escriba el codigo del mapper a partir de este punto <<<
#
if __name__ == "__main__":
    for line in sys.stdin:
        purpose = ""
        amount = ""
        
        line = line.strip()
        splits = line.split(",")
        ##print(len(splits))
        ##print(splits[1])
        if len(splits) != 20: # Transactions have more columns than users
            purpose = splits[3]
            amount = splits[4] 
        print(purpose + '\t' + amount)
