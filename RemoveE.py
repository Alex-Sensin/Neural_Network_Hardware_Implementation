import string;

def RemoveE(inName, outName):
    inFile = open(inName, "r", encoding='utf-8')
    outFile = open(outName, "w", encoding='utf-8')
    line = inFile.readline()
    while line:
        pos = line.find("e")
        num = float(line[0:pos-1])
        exp = float(line[pos+1:len(line)])
        out = num * (10 ** exp)
        output = f"{out:.60f}"
        outFile.write(str(output) + '\n')
        line = inFile.readline()
    inFile.close()
    outFile.close()