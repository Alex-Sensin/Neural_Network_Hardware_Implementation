import string
import math

# inFile = open("outTest2.txt", "r", encoding='utf-8')
# outFile = open("outTest3.txt", "w", encoding='utf-8')

def DecimalToBinary(inName, outName):
    inFile = open(inName, "r+", encoding='utf-8')
    outFile = open(outName, "w+", encoding='utf-8')
    line = inFile.readline()

    while (line):
        # Whole part
        pos = line.find(".")
        whole_b = ""

        frac, whole = math.modf(float(line.replace('\n', "")))
        whole = int(whole)

        if (whole == 0):
            if (line[0] == "-"):
                whole_b = str(0) + "-"
            else:
                whole_b = str(0)
        else:
            while (whole > 0):
                whole_b += str(whole % 2)
                whole //= 2
        
        whole_b = whole_b[ : :-1]
        
        # whole_b.replace(".0", "")

        # Fraction Part
        frac = abs(frac)
        frac_b = ""
        count = 100

        while (count > 0):
            frac *= 2
            null, bit = math.modf(frac)
            if(int(bit) == 1):
                frac -= bit
                frac_b += '1'
            else:
                frac_b += '0'

            count -= 1

        outFile.write(whole_b + "." + frac_b + "\n")
        line = inFile.readline()

    inFile.close()
    outFile.close()

    
    
