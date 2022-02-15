import Weight_Convertion
import RemoveE
import DecimalToBinary
import BinaryFraction

def Convert():
    inFile = ['weight1.txt', 'weight2.txt', 'bias1.txt', 'bias2.txt']
    f1 = ['Tempw1.txt','Tempw2.txt','Tempb1.txt','Tempb2.txt']
    f2 = ['Weight1_out.txt', 'Weight2_out.txt', 'Bias1_out.txt', 'Bias2_out.txt']

    count = 0

    while (count < len(inFile)):
        Weight_Convertion.Weight_Convertion(inFile[count], f1[count])
        RemoveE.RemoveE(f1[count],f2[count])
        DecimalToBinary.DecimalToBinary(f2[count],f1[count])
        BinaryFraction.BinaryFraction(f1[count], f2[count])
        count += 1

    # # Testing files
    # inFile = 'weight1.txt'
    # f1 = 'text1.txt'
    # f2 = 'text2.txt'
    # f3 = 'text3.txt'
    # f4 = 'text4.txt'

    # Weight_Convertion.Weight_Convertion(inFile, f1)
    # RemoveE.RemoveE(f1,f2)
    # DecimalToBinary.DecimalToBinary(f2,f3)
    # BinaryFraction.BinaryFraction(f3, f4)

Convert()



