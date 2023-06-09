from commands import *


load(0x8000, "slices/bank3.bin", "6502")

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
string(0x800C, 0x8053 - 0x800C)

byte(0x8053, 0x8100 - 0x8053)
hexadecimal(0x8053, 0x8100 - 0x8053)

label(0x8100, "iconBar0")
byte(0x8100, 0x8400 - 0x8100)
hexadecimal(0x8100, 0x8400 - 0x8100)

label(0x8400, "iconBar1")
byte(0x8400, 0x8800 - 0x8400)
hexadecimal(0x8400, 0x8800 - 0x8400)

label(0x8800, "iconBar2")
byte(0x8800, 0x8C00 - 0x8800)
hexadecimal(0x8800, 0x8C00 - 0x8800)

label(0x8C00, "iconBar3")
byte(0x8C00, 0x9000 - 0x8C00)
hexadecimal(0x8C00, 0x9000 - 0x8C00)

label(0x9000, "iconBar5")
byte(0x9000, 0x9500 - 0x9000)
hexadecimal(0x9000, 0x9500 - 0x9000)

byte(0x9500, 0x95CE - 0x9500)
hexadecimal(0x9500, 0x95CE - 0x9500)

byte(0x95CE, 0x963F - 0x95CE)
hexadecimal(0x95CE, 0x963F - 0x95CE)

byte(0x963F, 0x9760 - 0x963F)
hexadecimal(0x963F, 0x9760 - 0x963F)

byte(0x9760, 0x9FA1 - 0x9760)
hexadecimal(0x9760, 0x9FA1 - 0x9760)

byte(0x9FA1, 0xA493 - 0x9FA1)
hexadecimal(0x9FA1, 0xA493 - 0x9FA1)

byte(0xA493, 0xA4D3 - 0xA493)
hexadecimal(0xA493, 0xA4D3 - 0xA493)

byte(0xA4D3, 0xA71B - 0xA4D3)
hexadecimal(0xA4D3, 0xA71B - 0xA4D3)

byte(0xA71B, 0xA730 - 0xA71B)
hexadecimal(0xA71B, 0xA730 - 0xA71B)

byte(0xB3DF, 0xB53F - 0xB3DF)
hexadecimal(0xB3DF, 0xB53F - 0xB3DF)

byte(0xB53F, 0xB57F - 0xB53F)
hexadecimal(0xB53F, 0xB57F - 0xB53F)

byte(0xB6A8, 0xB6C7 - 0xB6A8)
hexadecimal(0xB6A8, 0xB6C7 - 0xB6A8)

byte(0xB6C8, 0xB9AA - 0xB6C8)
hexadecimal(0xB6C8, 0xB9AA - 0xB6C8)

byte(0xB9AA, 0xB9BA - 0xB9AA)
hexadecimal(0xB9AA, 0xB9BA - 0xB9AA)

byte(0xB9BA, 0xB9CA - 0xB9BA)
hexadecimal(0xB9BA, 0xB9CA - 0xB9BA)

byte(0xB9CA, 0xB9DA - 0xB9CA)
hexadecimal(0xB9CA, 0xB9DA - 0xB9CA)

entry(0xA730)
entry(0xA775)
entry(0xA7B6)
entry(0xA7B7)
entry(0xA9D1)
entry(0xAABC)
entry(0xABE7)
entry(0xAC1D)
entry(0xAD43)
entry(0xAFC3)
entry(0xAFC8)
entry(0xAFCD)
entry(0xB0E1)
entry(0xB18E)
entry(0xB219)
entry(0xB2BC)
entry(0xB2FB)
entry(0xB341)
entry(0xB5F6)
entry(0xB63D)
entry(0xB673)
entry(0xB9E2)
entry(0xBA11)
entry(0xBA23)

label(0xB9AA, "LB9AA")
label(0xB9BA, "LB9BA")
label(0xB9CA, "LB9CA")

subroutine(0xA7B7, "subm_A7B7")
subroutine(0xA909, "subm_A909")
subroutine(0xA95D, "subm_A95D")
subroutine(0xA972, "subm_A972")
subroutine(0xA9D1, "subm_A9D1")
subroutine(0xAABC, "DrawTitleScreen")
subroutine(0xABE7, "subm_ABE7")
subroutine(0xAC1D, "subm_AC1D")
subroutine(0xAC86, "subm_AC86")
subroutine(0xACEB, "subm_ACEB")
subroutine(0xAD2A, "subm_AD2A")
subroutine(0xADBC, "subm_AE18_ADBC")
subroutine(0xADE0, "subm_AE18_ADE0")
subroutine(0xAE18, "subm_AE18")
subroutine(0xAF2E, "subm_AF2E")
subroutine(0xAF5B, "subm_AF5B")
subroutine(0xAF96, "subm_AF96")
subroutine(0xAFC3, "subm_AFCD_AFC3")
subroutine(0xAFC8, "subm_AFCD_AFC8")
subroutine(0xAFCD, "subm_AFCD")
subroutine(0xB0E1, "subm_B0E1")
subroutine(0xB18E, "subm_B18E")
subroutine(0xB219, "subm_B219")
subroutine(0xB2A9, "subm_B2A9")
subroutine(0xB2BC, "subm_B2BC")
subroutine(0xB2FB, "subm_B2FB")
subroutine(0xB341, "ClearTiles")
subroutine(0xB57F, "subm_B57F")
subroutine(0xB5F6, "subm_B5F6")
subroutine(0xB5F9, "subm_B5F9")
subroutine(0xB63D, "subm_B63D")
subroutine(0xB673, "subm_B673")
subroutine(0xB9E2, "subm_B9E2")
subroutine(0xBA11, "subm_BA23_BA11")
subroutine(0xBA23, "subm_BA23")

exec(open('py8dis-scripts/common-variables.py').read())

go()
