import string

def Weight_Convertion(inName, outName):
    inFile = open(inName, 'r', encoding='utf-8')
    outFile = open(outName, 'w', encoding='utf-8')
    lines = inFile.read()
    outlines = lines.replace(" ", "\n")
    outFile.write(outlines)
    inFile.close()
    outFile.close()