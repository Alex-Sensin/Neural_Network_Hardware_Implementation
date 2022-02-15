import math
import BinaryFraction

def Decode():
    inFile = open("Inputs.txt", "r", encoding='utf-8')
    lineCount = 0
    line = inFile.readline()

    while (lineCount < 10):
        tempFile = open("inputTemp.txt", "w+", encoding='utf-8')
        tempFile.truncate()
        line.replace("\n","")
        figure = int(line[0])
        element = 0
        while (element < len(line)):
            whole_b = ""
            if (line[element] == ","):
                end = line.find(",", element+1)
                if (end != -1):
                    value = int(line[element+1: end])
                decimalValue = value / 255.0

                frac, whole = math.modf(decimalValue)
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

                tempFile.write(whole_b + "." + frac_b + "\n")

            element += 1
        tempFile.close()
        saveFile = "Inputs" + str(figure) + ".txt"
        BinaryFraction.BinaryFraction2('inputTemp.txt', saveFile)
        lineCount += 1
        line = inFile.readline()



