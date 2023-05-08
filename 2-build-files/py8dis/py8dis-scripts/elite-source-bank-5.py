from commands import *


load(0x8000, "slices/bank5.bin", "6502")

config.set_lower_case(False)

# Remove all extras
config.set_label_references(False)
config.set_show_autogenerated_labels(False)
config.set_show_all_labels(False)
config.set_inline_comment_column(46)
config.set_subroutine_header("*" * 78)
config.set_indent_string(" ")

entry(0x8000)
string(0x8007, 5)

subroutine(0xBED7, "SetSystemImage")
subroutine(0xBEEA, "GetSystemImage")
subroutine(0xBF41, "subm_BF41")

label(0xBF64, "addrLo")
byte(0xBF64, 4)
hexadecimal(0xBF64, 4)

label(0xBF68, "addrHi")
byte(0xBF68, 4)
hexadecimal(0xBF68, 4)

byte(0xBF6C, 1)

label(0x800C, "imageCount")
label(0x800C + 0x0020, "image0")
byte(0x800C + 0x0020, 0x0458 - 0x0020)
hexadecimal(0x800C + 0x0020, 0x0458 - 0x0020)
label(0x800C + 0x0458, "image1")
byte(0x800C + 0x0458, 0x0847 - 0x0458)
hexadecimal(0x800C + 0x0458, 0x0847 - 0x0458)
label(0x800C + 0x0847, "image2")
byte(0x800C + 0x0847, 0x0E08 - 0x0847)
hexadecimal(0x800C + 0x0847, 0x0E08 - 0x0847)
label(0x800C + 0x0E08, "image3")
byte(0x800C + 0x0E08, 0x12E0 - 0x0E08)
hexadecimal(0x800C + 0x0E08, 0x12E0 - 0x0E08)
label(0x800C + 0x12E0, "image4")
byte(0x800C + 0x12E0, 0x166C - 0x12E0)
hexadecimal(0x800C + 0x12E0, 0x166C - 0x12E0)
label(0x800C + 0x166C, "image5")
byte(0x800C + 0x166C, 0x1A90 - 0x166C)
hexadecimal(0x800C + 0x166C, 0x1A90 - 0x166C)
label(0x800C + 0x1A90, "image6")
byte(0x800C + 0x1A90, 0x1E90 - 0x1A90)
hexadecimal(0x800C + 0x1A90, 0x1E90 - 0x1A90)
label(0x800C + 0x1E90, "image7")
byte(0x800C + 0x1E90, 0x22E8 - 0x1E90)
hexadecimal(0x800C + 0x1E90, 0x22E8 - 0x1E90)
label(0x800C + 0x22E8, "image8")
byte(0x800C + 0x22E8, 0x2611 - 0x22E8)
hexadecimal(0x800C + 0x22E8, 0x2611 - 0x22E8)
label(0x800C + 0x2611, "image9")
byte(0x800C + 0x2611, 0x29D8 - 0x2611)
hexadecimal(0x800C + 0x2611, 0x29D8 - 0x2611)
label(0x800C + 0x29D8, "image10")
byte(0x800C + 0x29D8, 0x2E20 - 0x29D8)
hexadecimal(0x800C + 0x29D8, 0x2E20 - 0x29D8)
label(0x800C + 0x2E20, "image11")
byte(0x800C + 0x2E20, 0x3232 - 0x2E20)
hexadecimal(0x800C + 0x2E20, 0x3232 - 0x2E20)
label(0x800C + 0x3232, "image12")
byte(0x800C + 0x3232, 0x36C5 - 0x3232)
hexadecimal(0x800C + 0x3232, 0x36C5 - 0x3232)
label(0x800C + 0x36C5, "image13")
byte(0x800C + 0x36C5, 0x3B07 - 0x36C5)
hexadecimal(0x800C + 0x36C5, 0x3B07 - 0x36C5)
label(0x800C + 0x3B07, "image14")
byte(0x800C + 0x3B07, 0x3ECB - 0x3B07)
hexadecimal(0x800C + 0x3B07, 0x3ECB - 0x3B07)

exec(open('py8dis-scripts/common-variables.py').read())

go()
