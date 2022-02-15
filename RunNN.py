import ConvertWeight
import DecodeInputs
import os

ConvertWeight.Convert()
DecodeInputs.Decode()

os.system("vsim -do Hardware.do -c")
