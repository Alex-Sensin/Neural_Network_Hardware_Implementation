import string
import math
from decimal import Decimal

# Offset is set to 31

def BinaryFraction(inName, outName):
    inFile = open(inName, "r", encoding='utf-8')
    outFile = open(outName, "w", encoding='utf-8')
    # temp = open('temp.txt', 'w')
    # tempMag = open('tempMag.txt', 'w')

    line = inFile.readline()

    while line:
        sign = 0
        line.replace('\n', "")

        if (line[0] == '-'):
            sign = 1
            line.replace("-", "")
        if (line[0] == '+'):
            line.replace("+", "")
        line.replace("-","")
        
        period = line.find('.')
        start = line.find(str(1))
        # end = line.rfind(1) - 1

        if (start == -1):
            stringExp = "000000"
        elif (abs(start - period) > 31):
            stringExp = "000000"
        else:
            exp = -1 * (start - period)
            stringExp = format(exp + 31, '06b')

        out = Decimal(line) * Decimal(10 ** (start - period))
        # mag, null = math.modf(out)

        stringMag = str(out)[str(out).find(".")+1: str(out).find(".")+1+7]
        # temp.write(str(out) + '\n')
        # tempMag.write(stringMag + '\n')

        if (stringMag == "0"):
            stringMag = "0000000"

        while (len(stringMag) < 7):
            stringMag += "0"



        stringSign = str(sign)

        Output = stringSign + stringExp + stringMag + "\n"
        outFile.write(Output)
        line = inFile.readline()

    inFile.close()
    outFile.close()

def BinaryFraction2(inName, outName):
    inFile = open(inName, "r", encoding='utf-8')
    outFile = open(outName, "w", encoding='utf-8')
    temp = open('temp.txt', 'w')
    tempMag = open('tempMag.txt', 'w')

    line = inFile.readline()
    newLine = ""
    while line:
        sign = 0
        line.replace('\n', "")

        if (line[0] == '-'):
            sign = 1
            line.replace("-", "")
        if (line[0] == '+'):
            line.replace("+", "")
        line.replace("-","")
        
        period = line.find('.')
        start = line.find(str(1))
        # end = line.rfind(1) - 1

        if (start == -1):
            stringExp = "000000"
        elif (abs(start - period) > 31):
            stringExp = "000000"
        else:
            exp = -1 * (start - period)
            stringExp = format(exp + 31, '06b')

        out = Decimal(line) * Decimal(10 ** (start - period))
        # mag, null = math.modf(out)
        stringOut = str(out.normalize())
        stringOut.replace("E-1590", "000000")

        stringMag = stringOut[stringOut.find(".")+1: stringOut.find(".")+1+7]


        if (stringMag == "0"):
            stringMag = "0000000"
        elif (stringMag == '0E-1590'):
            stringMag = "0000000"

        while (len(stringMag) < 7):
            stringMag += "0"

        stringMag.replace("E-1590","00000")
        temp.write(stringOut + '\n')
        tempMag.write(stringMag + '\n')



        stringSign = str(sign)

        Output = stringSign + stringExp + stringMag + "\n"
        newLine += Output
        line = inFile.readline()


    outLine = newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine + newLine
    # outLine = outLine.replace("\n", "")
    outFile.write(outLine)
    inFile.close()
    outFile.close()