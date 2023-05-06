\ ******************************************************************************
\
\ NES ELITE GAME SOURCE (BANK 5)
\
\ NES Elite was written by Ian Bell and David Braben and is copyright D. Braben
\ and I. Bell 1992
\
\ The code on this site has been reconstructed from a disassembly of the version
\ released on Ian Bell's personal website at http://www.elitehomepage.org/
\
\ The commentary is copyright Mark Moxon, and any misunderstandings or mistakes
\ in the documentation are entirely my fault
\
\ The terminology and notations used in this commentary are explained at
\ https://www.bbcelite.com/about_site/terminology_used_in_this_commentary.html
\
\ The deep dive articles referred to in this commentary can be found at
\ https://www.bbcelite.com/deep_dives
\
\ ------------------------------------------------------------------------------
\
\ This source file produces the following binary file:
\
\   * bank5.bin
\
\ ******************************************************************************

 INCLUDE "1-source-files/main-sources/elite-build-options.asm"

 _NTSC                  = (_VARIANT = 1)
 _PAL                   = (_VARIANT = 2)

CODE% = &8000
LOAD% = &8000

; Memory locations
ZP               = &0000
RAND             = &0002
RAND_1           = &0002
RAND_2           = &0003
RAND_3           = &0004
T1               = &0006
SC               = &0007
SCH              = &0008
INWK             = &0009
XX1              = &0009
INWK_1           = &000A
INWK_2           = &000B
INWK_3           = &000C
INWK_4           = &000D
INWK_5           = &000E
INWK_6           = &000F
INWK_7           = &0010
INWK_8           = &0011
INWK_9           = &0012
INWK_10          = &0013
INWK_11          = &0014
INWK_12          = &0015
INWK_13          = &0016
INWK_14          = &0017
INWK_15          = &0018
INWK_16          = &0019
INWK_17          = &001A
INWK_18          = &001B
INWK_19          = &001C
INWK_20          = &001D
INWK_21          = &001E
INWK_22          = &001F
INWK_23          = &0020
INWK_24          = &0021
INWK_25          = &0022
INWK_26          = &0023
INWK_27          = &0024
INWK_28          = &0025
INWK_29          = &0026
INWK_30          = &0027
INWK_31          = &0028
INWK_32          = &0029
INWK_33          = &002A
INWK_34          = &002B
INWK_35          = &002C
NEWB             = &002D
P                = &002F
P_1              = &0030
P_2              = &0031
XC               = &0032
YC               = &003B
QQ17             = &003C
K3               = &003D
XX2              = &003D
XX2_1            = &003E
XX2_2            = &003F
XX2_3            = &0040
XX2_4            = &0041
XX2_5            = &0042
XX2_6            = &0043
XX2_7            = &0044
XX2_8            = &0045
XX2_9            = &0046
XX2_10           = &0047
XX2_11           = &0048
XX2_12           = &0049
XX2_13           = &004A
K4               = &004B
K4_1             = &004C
XX16             = &004D
XX16_1           = &004E
XX16_2           = &004F
XX16_3           = &0050
XX16_4           = &0051
XX16_5           = &0052
XX16_6           = &0053
XX16_7           = &0054
XX16_8           = &0055
XX16_9           = &0056
XX16_10          = &0057
XX16_11          = &0058
XX16_12          = &0059
XX16_13          = &005A
XX16_14          = &005B
XX16_15          = &005C
XX16_16          = &005D
XX16_17          = &005E
XX0              = &005F
XX0_1            = &0060
INF              = &0061
XX19             = &0061
INF_1            = &0062
V                = &0063
V_1              = &0064
XX               = &0065
XX_1             = &0066
YY               = &0067
YY_1             = &0068
BETA             = &0069
BET1             = &006A
QQ22             = &006B
QQ22_1           = &006C
ECMA             = &006D
ALP1             = &006E
ALP2             = &006F
ALP2_1           = &0070
X1               = &0071
XX15             = &0071
Y1               = &0072
X2               = &0073
Y2               = &0074
XX15_4           = &0075
XX15_5           = &0076
XX12             = &0077
XX12_1           = &0078
XX12_2           = &0079
XX12_3           = &007A
XX12_4           = &007B
XX12_5           = &007C
K                = &007D
K_1              = &007E
K_2              = &007F
K_3              = &0080
QQ15             = &0082
QQ15_1           = &0083
QQ15_2           = &0084
QQ15_3           = &0085
QQ15_4           = &0086
QQ15_5           = &0087
K5               = &0088
XX18             = &0088
XX18_1           = &0089
XX18_2           = &008A
XX18_3           = &008B
K6               = &008C
K6_1             = &008D
K6_2             = &008E
K6_3             = &008F
K6_4             = &0090
BET2             = &0091
BET2_1           = &0092
DELTA            = &0093
DELT4            = &0094
DELT4_1          = &0095
U                = &0096
Q                = &0097
R                = &0098
S                = &0099
T                = &009A
XSAV             = &009B
YSAV             = &009C
XX17             = &009D
W                = &009E
QQ11             = &009F
ZZ               = &00A0
XX13             = &00A1
MCNT             = &00A2
TYPE             = &00A3
ALPHA            = &00A4
QQ12             = &00A5
TGT              = &00A6
FLAG             = &00A7
CNT              = &00A8
CNT2             = &00A9
STP              = &00AA
XX4              = &00AB
XX20             = &00AC
RAT              = &00AE
RAT2             = &00AF
widget           = &00B0
Yx1M2            = &00B1
Yx2M2            = &00B2
Yx2M1            = &00B3
messXC           = &00B4
newzp            = &00B6
TILE             = &00B8
PATTERNS_HI      = &00B9
T5               = &00BA
T5_1             = &00BB
ADDR1_LO         = &00D4
ADDR1_HI         = &00D5
NAMES_HI         = &00E6
DASHBOARD_SWITCH = &00E9
T6               = &00EB
T6_1             = &00EC
T7               = &00ED
T7_1             = &00EE
PPU_CTRL_COPY    = &00F5
BANK             = &00F7
L00FA            = &00FA
L00FB            = &00FB
XX3              = &0100
XX3_1            = &0101
SPR_00_Y         = &0200
SPR_00_TILE      = &0201
SPR_00_ATTR      = &0202
SPR_00_X         = &0203
SPR_01_Y         = &0204
SPR_01_TILE      = &0205
SPR_01_ATTR      = &0206
SPR_01_X         = &0207
SPR_02_Y         = &0208
SPR_02_TILE      = &0209
SPR_02_ATTR      = &020A
SPR_02_X         = &020B
SPR_03_Y         = &020C
SPR_03_TILE      = &020D
SPR_03_ATTR      = &020E
SPR_03_X         = &020F
SPR_04_Y         = &0210
SPR_04_TILE      = &0211
SPR_04_ATTR      = &0212
SPR_04_X         = &0213
SPR_05_Y         = &0214
SPR_05_TILE      = &0215
SPR_05_ATTR      = &0216
SPR_05_X         = &0217
SPR_06_Y         = &0218
SPR_06_TILE      = &0219
SPR_06_ATTR      = &021A
SPR_06_X         = &021B
SPR_07_Y         = &021C
SPR_07_TILE      = &021D
SPR_07_ATTR      = &021E
SPR_07_X         = &021F
SPR_08_Y         = &0220
SPR_08_TILE      = &0221
SPR_08_ATTR      = &0222
SPR_08_X         = &0223
SPR_09_Y         = &0224
SPR_09_TILE      = &0225
SPR_09_ATTR      = &0226
SPR_09_X         = &0227
SPR_10_Y         = &0228
SPR_10_TILE      = &0229
SPR_10_ATTR      = &022A
SPR_10_X         = &022B
SPR_11_Y         = &022C
SPR_11_TILE      = &022D
SPR_11_ATTR      = &022E
SPR_11_X         = &022F
SPR_12_Y         = &0230
SPR_12_TILE      = &0231
SPR_12_ATTR      = &0232
SPR_12_X         = &0233
SPR_13_Y         = &0234
SPR_13_TILE      = &0235
SPR_13_ATTR      = &0236
SPR_13_X         = &0237
SPR_14_Y         = &0238
SPR_14_TILE      = &0239
SPR_14_ATTR      = &023A
SPR_14_X         = &023B
SPR_15_Y         = &023C
SPR_15_TILE      = &023D
SPR_15_ATTR      = &023E
SPR_15_X         = &023F
SPR_16_Y         = &0240
SPR_16_TILE      = &0241
SPR_16_ATTR      = &0242
SPR_16_X         = &0243
SPR_17_Y         = &0244
SPR_17_TILE      = &0245
SPR_17_ATTR      = &0246
SPR_17_X         = &0247
SPR_18_Y         = &0248
SPR_18_TILE      = &0249
SPR_18_ATTR      = &024A
SPR_18_X         = &024B
SPR_19_Y         = &024C
SPR_19_TILE      = &024D
SPR_19_ATTR      = &024E
SPR_19_X         = &024F
SPR_20_Y         = &0250
SPR_20_TILE      = &0251
SPR_20_ATTR      = &0252
SPR_20_X         = &0253
SPR_21_Y         = &0254
SPR_21_TILE      = &0255
SPR_21_ATTR      = &0256
SPR_21_X         = &0257
SPR_22_Y         = &0258
SPR_22_TILE      = &0259
SPR_22_ATTR      = &025A
SPR_22_X         = &025B
SPR_23_Y         = &025C
SPR_23_TILE      = &025D
SPR_23_ATTR      = &025E
SPR_23_X         = &025F
SPR_24_Y         = &0260
SPR_24_TILE      = &0261
SPR_24_ATTR      = &0262
SPR_24_X         = &0263
SPR_25_Y         = &0264
SPR_25_TILE      = &0265
SPR_25_ATTR      = &0266
SPR_25_X         = &0267
SPR_26_Y         = &0268
SPR_26_TILE      = &0269
SPR_26_ATTR      = &026A
SPR_26_X         = &026B
SPR_27_Y         = &026C
SPR_27_TILE      = &026D
SPR_27_ATTR      = &026E
SPR_27_X         = &026F
SPR_28_Y         = &0270
SPR_28_TILE      = &0271
SPR_28_ATTR      = &0272
SPR_28_X         = &0273
SPR_29_Y         = &0274
SPR_29_TILE      = &0275
SPR_29_ATTR      = &0276
SPR_29_X         = &0277
SPR_30_Y         = &0278
SPR_30_TILE      = &0279
SPR_30_ATTR      = &027A
SPR_30_X         = &027B
SPR_31_Y         = &027C
SPR_31_TILE      = &027D
SPR_31_ATTR      = &027E
SPR_31_X         = &027F
SPR_32_Y         = &0280
SPR_32_TILE      = &0281
SPR_32_ATTR      = &0282
SPR_32_X         = &0283
SPR_33_Y         = &0284
SPR_33_TILE      = &0285
SPR_33_ATTR      = &0286
SPR_33_X         = &0287
SPR_34_Y         = &0288
SPR_34_TILE      = &0289
SPR_34_ATTR      = &028A
SPR_34_X         = &028B
SPR_35_Y         = &028C
SPR_35_TILE      = &028D
SPR_35_ATTR      = &028E
SPR_35_X         = &028F
SPR_36_Y         = &0290
SPR_36_TILE      = &0291
SPR_36_ATTR      = &0292
SPR_36_X         = &0293
SPR_37_Y         = &0294
SPR_37_TILE      = &0295
SPR_37_ATTR      = &0296
SPR_37_X         = &0297
SPR_38_Y         = &0298
SPR_38_TILE      = &0299
SPR_38_ATTR      = &029A
SPR_38_X         = &029B
SPR_39_Y         = &029C
SPR_39_TILE      = &029D
SPR_39_ATTR      = &029E
SPR_39_X         = &029F
SPR_40_Y         = &02A0
SPR_40_TILE      = &02A1
SPR_40_ATTR      = &02A2
SPR_40_X         = &02A3
SPR_41_Y         = &02A4
SPR_41_TILE      = &02A5
SPR_41_ATTR      = &02A6
SPR_41_X         = &02A7
SPR_42_Y         = &02A8
SPR_42_TILE      = &02A9
SPR_42_ATTR      = &02AA
SPR_42_X         = &02AB
SPR_43_Y         = &02AC
SPR_43_TILE      = &02AD
SPR_43_ATTR      = &02AE
SPR_43_X         = &02AF
SPR_44_Y         = &02B0
SPR_44_TILE      = &02B1
SPR_44_ATTR      = &02B2
SPR_44_X         = &02B3
SPR_45_Y         = &02B4
SPR_45_TILE      = &02B5
SPR_45_ATTR      = &02B6
SPR_45_X         = &02B7
SPR_46_Y         = &02B8
SPR_46_TILE      = &02B9
SPR_46_ATTR      = &02BA
SPR_46_X         = &02BB
SPR_47_Y         = &02BC
SPR_47_TILE      = &02BD
SPR_47_ATTR      = &02BE
SPR_47_X         = &02BF
SPR_48_Y         = &02C0
SPR_48_TILE      = &02C1
SPR_48_ATTR      = &02C2
SPR_48_X         = &02C3
SPR_49_Y         = &02C4
SPR_49_TILE      = &02C5
SPR_49_ATTR      = &02C6
SPR_49_X         = &02C7
SPR_50_Y         = &02C8
SPR_50_TILE      = &02C9
SPR_50_ATTR      = &02CA
SPR_50_X         = &02CB
SPR_51_Y         = &02CC
SPR_51_TILE      = &02CD
SPR_51_ATTR      = &02CE
SPR_51_X         = &02CF
SPR_52_Y         = &02D0
SPR_52_TILE      = &02D1
SPR_52_ATTR      = &02D2
SPR_52_X         = &02D3
SPR_53_Y         = &02D4
SPR_53_TILE      = &02D5
SPR_53_ATTR      = &02D6
SPR_53_X         = &02D7
SPR_54_Y         = &02D8
SPR_54_TILE      = &02D9
SPR_54_ATTR      = &02DA
SPR_54_X         = &02DB
SPR_55_Y         = &02DC
SPR_55_TILE      = &02DD
SPR_55_ATTR      = &02DE
SPR_55_X         = &02DF
SPR_56_Y         = &02E0
SPR_56_TILE      = &02E1
SPR_56_ATTR      = &02E2
SPR_56_X         = &02E3
SPR_57_Y         = &02E4
SPR_57_TILE      = &02E5
SPR_57_ATTR      = &02E6
SPR_57_X         = &02E7
SPR_58_Y         = &02E8
SPR_58_TILE      = &02E9
SPR_58_ATTR      = &02EA
SPR_58_X         = &02EB
SPR_59_Y         = &02EC
SPR_59_TILE      = &02ED
SPR_59_ATTR      = &02EE
SPR_59_X         = &02EF
SPR_60_Y         = &02F0
SPR_60_TILE      = &02F1
SPR_60_ATTR      = &02F2
SPR_60_X         = &02F3
SPR_61_Y         = &02F4
SPR_61_TILE      = &02F5
SPR_61_ATTR      = &02F6
SPR_61_X         = &02F7
SPR_62_Y         = &02F8
SPR_62_TILE      = &02F9
SPR_62_ATTR      = &02FA
SPR_62_X         = &02FB
SPR_63_Y         = &02FC
SPR_63_TILE      = &02FD
SPR_63_ATTR      = &02FE
SPR_63_X         = &02FF
FRIN             = &036A
ECMP             = &0389
MJ               = &038A
VIEW             = &038E
EV               = &0392
LAS2             = &0393
TP               = &039E
QQ0              = &039F
QQ1              = &03A0
CASH             = &03A1
QQ14             = &03A5
GCNT             = &03A7
LASER            = &03A8
CRGO             = &03AC
QQ20             = &03AD
BST              = &03BF
BOMB             = &03C0
ENGY             = &03C1
DKCMP            = &03C2
GHYP             = &03C3
ESCP             = &03C4
TRIBBLE          = &03C5
TRIBBLE_1        = &03C6
NOMSL            = &03C8
FIST             = &03C9
AVL              = &03CA
QQ26             = &03DB
TALLY            = &03DC
TALLY_1          = &03DD
QQ21             = &03DF
NOSTM            = &03E5
L03EE            = &03EE
DTW6             = &03F3
DTW2             = &03F4
DTW3             = &03F5
DTW4             = &03F6
DTW5             = &03F7
DTW1             = &03F8
DTW8             = &03F9
XP               = &03FA
YP               = &03FB
LAS              = &0400
MSTG             = &0401
QQ19             = &044D
QQ19_1           = &044E
QQ19_3           = &0450
QQ19_4           = &0450
K2               = &0459
K2_1             = &045A
K2_2             = &045B
K2_3             = &045C
DLY              = &045D
QQ19_2           = &045F
L046C            = &046C
BOXEDGE1         = &046E
BOXEDGE2         = &046F
CONT2_SCAN       = &0475
SWAP             = &047F
XSAV2            = &0481
YSAV2            = &0482
ENERGY           = &0486
QQ24             = &0487
QQ25             = &0488
QQ28             = &0489
QQ29             = &048A
L048B            = &048B
gov              = &048C
tek              = &048D
QQ2              = &048E
QQ3              = &0494
QQ4              = &0495
QQ5              = &0496
QQ8              = &049B
QQ8_1            = &049C
QQ9              = &049D
QQ10             = &049E
QQ18_LO          = &04A4
QQ18_HI          = &04A5
TKN1_LO          = &04A6
TKN1_HI          = &04A7
LANG             = &04A8
CONT1_DOWN       = &04AA
CONT2_DOWN       = &04AB
CONT1_UP         = &04AC
CONT2_UP         = &04AD
CONT1_LEFT       = &04AE
CONT2_LEFT       = &04AF
CONT1_RIGHT      = &04B0
CONT2_RIGHT      = &04B1
CONT1_A          = &04B2
CONT2_A          = &04B3
CONT1_B          = &04B4
CONT2_B          = &04B5
CONT1_START      = &04B6
CONT2_START      = &04B7
CONT1_SELECT     = &04B8
CONT2_SELECT     = &04B9
L04BC            = &04BC
L04BD            = &04BD
SX               = &04C8
SY               = &04DD
SZ               = &04F2
BUFm1            = &0506
BUF              = &0507
BUF_1            = &0508
HANGFLAG         = &0561
MANY             = &0562
SSPR             = &0564
SXL              = &05A5
SYL              = &05BA
SZL              = &05CF
safehouse        = &05E4
Kpercent         = &0600
PPU_CTRL         = &2000
PPU_MASK         = &2001
PPU_STATUS       = &2002
OAM_ADDR         = &2003
OAM_DATA         = &2004
PPU_SCROLL       = &2005
PPU_ADDR         = &2006
PPU_DATA         = &2007
SQ1_ENV          = &4000
SQ1_SWEEP        = &4001
SQ1_LO           = &4002
SQ1_HI           = &4003
SQ2_ENV          = &4004
SQ2_SWEEP        = &4005
SQ2_LO           = &4006
SQ2_HI           = &4007
TRI_CTRL         = &4008
TRI_LO           = &400A
TRI_HI           = &400B
NOI_ENV          = &400C
NOI_RAND         = &400E
NOI_LEN          = &400F
OAM_DMA          = &4014
APU_FLAGS        = &4015
CONTROLLER_1     = &4016
CONTROLLER_2     = &4017
PATTERNS_0       = &6000
PATTERNS_1       = &6800
NAMES_0          = &7000
NAMES_1          = &7400
LC006            = &C006
Spercent         = &C007
RESET_BANK       = &C0AD
SET_BANK         = &C0AE
LC0DF            = &C0DF
log              = &C100
logL             = &C200
antilog          = &C300
antilogODD       = &C400
SNE              = &C500
ACT              = &C520
XX21m2           = &C53E
XX21m1           = &C53F
XX21             = &C540
SEND_TO_PPU1     = &CC2E
COPY_NAMES       = &CD34
BOXEDGES         = &CD6F
UNIV             = &CE7E
UNIV_1           = &CE7F
GINF             = &CE90
sub_CE9E         = &CE9E
sub_CEA5         = &CEA5
NAMES_LOOKUP     = &CED0
PATTERNS_LOOKUP  = &CED2
IRQ              = &CED4
NMI              = &CED5
SET_PALETTE      = &CF2E
RESET_NAMES1     = &D02D
SWITCH_TO_TABLE_0 = &D06D
CONTROLLERS      = &D0F8
FILL_MEMORY      = &D710
SEND_TO_PPU2     = &D986
TWOS             = &D9F7
TWOS2            = &DA01
TWFL             = &DA09
TWFR             = &DA10
ylookupLO        = &DA18
ylookupHI        = &DAF8
LOIN             = &DC0F
PIXEL            = &E4F0
PIXELx2          = &E543
ECBLB2           = &E596
LE909            = &E909
DELAY            = &EBA2
BEEP             = &EBA9
EXNO3            = &EBAD
BOOP             = &EBE5
NOISE            = &EBF2
CHECK_DASHBOARD_A = &EC7D
LDA_XX0_Y        = &EC8D
LDA_EPC_Y        = &ECA0
INC_TALLY        = &ECAE
CB1D4_BANK0      = &ECE2
SETK_K3_XC_YC    = &ECF9
C811E_BANK6      = &ED16
C8021_BANK6      = &ED24
C89D1_BANK6      = &ED50
C8012_BANK6      = &ED6B
CBF41_BANK5      = &ED81
CB9F9_BANK4      = &ED8F
CB96B_BANK4      = &ED9D
CB63D_BANK3      = &EDAB
CB88C_BANK6      = &EDB9
LL9_BANK1        = &EDC7
CBA23_BANK3      = &EDDC
TIDY_BANK1       = &EDEA
CBC83_BANK6      = &EDFF
C9522_BANK0      = &EE0D
STARS_BANK1      = &EE15
SUN_BANK1        = &EE3F
CB2FB_BANK3      = &EE54
CB219_BANK3      = &EE62
CB9C1_BANK4      = &EE78
CA082_BANK6      = &EE8B
CA0F8_BANK6      = &EE99
CB882_BANK4      = &EEA7
CA4A5_BANK6      = &EEB5
CB2EF_BANK0      = &EEC3
CB9E2_BANK3      = &EED3
CB673_BANK3      = &EEE8
CB2BC_BANK3      = &EEF6
CB248_BANK3      = &EF04
CBA17_BANK6      = &EF12
CAFCD_BANK3      = &EF20
CBE52_BANK6      = &EF35
CBED2_BANK6      = &EF43
CB0E1_BANK3      = &EF51
CB18E_BANK3      = &EF6C
PAS1_BANK0       = &EF7A
CBED7_BANK5      = &EF88
CBEEA_BANK5      = &EF96
CB93C_BANK4      = &EFA4
CB8F9_BANK4      = &EFB2
CA2C3_BANK6      = &EFC0
CBA63_BANK6      = &EFCE
CB39D_BANK0      = &EFDC
LL164_BANK6      = &EFF7
CB919_BANK6      = &F005
CA166_BANK6      = &F013
CBBDE_BANK6      = &F021
CBB37_BANK6      = &F02F
CB8FE_BANK6      = &F03D
CB90D_BANK6      = &F04B
CA5AB_BANK6      = &F059
sub_CF06F        = &F06F
BEEP_BANK7       = &F074
DETOK_BANK2      = &F082
DTS_BANK2        = &F09D
PDESC_BANK2      = &F0B8
CAE18_BANK3      = &F0C6
CAC1D_BANK3      = &F0E1
CA730_BANK3      = &F0FC
CA775_BANK3      = &F10A
CAABC_BANK3      = &F118
CA7B7_BANK3      = &F126
CA9D1_BANK3      = &F139
CA972_BANK3      = &F15C
CAC5C_BANK3      = &F171
C8980_BANK0      = &F186
CB459_BANK6      = &F194
MVS5_BANK0       = &F1A2
HALL_BANK1       = &F1BD
CHPR_BANK2       = &F1CB
DASC_BANK2       = &F1E6
TT27_BANK2       = &F201
ex_BANK2         = &F21C
TT27_BANK0       = &F237
BR1_BANK0        = &F245
CBAF3_BANK1      = &F25A
TT66_BANK0       = &F26E
CLIP_BANK1       = &F280
CB341_BANK3      = &F293
SCAN_BANK1       = &F2A8
C8926_BANK0      = &F2BD
sub_CF2CE        = &F2CE
CLYNS            = &F2DE
LF333            = &F333
sub_CF338        = &F338
sub_CF359        = &F359
LF362            = &F362
sub_CF3BC        = &F3BC
sub_CF42A        = &F42A
Ze               = &F42E
sub_CF454        = &F454
NLIN3            = &F46A
NLIN4            = &F473
DORND2           = &F4AC
DORND            = &F4AD
PROJ             = &F4C1
LF52D            = &F52D
LF5AF            = &F5AF
LF5B1            = &F5B1
MU5              = &F65A
MULT3            = &F664
MLS2             = &F6BA
MLS1             = &F6C2
MULTSm2          = &F6C4
MULTS            = &F6C6
MU6              = &F707
SQUA             = &F70C
SQUA2            = &F70E
MU1              = &F713
MLU1             = &F718
MLU2             = &F71D
MULTU            = &F721
MU11             = &F725
FMLTU2           = &F766
FMLTU            = &F770
MLTU2m2          = &F7AB
MLTU2            = &F7AD
MUT2             = &F7D2
MUT1             = &F7D6
MULT1            = &F7DA
MULT12           = &F83C
TAS3             = &F853
MAD              = &F86F
ADD              = &F872
TIS1             = &F8AE
DV42             = &F8D1
DV41             = &F8D4
DVID3B2          = &F962
LL5              = &FA55
LL28             = &FA91
NORM             = &FAF8

 ORG &8000

.pydis_start
 SEI                                          ; 8000: 78          x
 INC LC006                                    ; 8001: EE 06 C0    ...
 JMP Spercent                                 ; 8004: 4C 07 C0    L..

 EQUS "@ 5.0"                                 ; 8007: 40 20 35... @ 5
.L800C
L800E = L800C+2
L800F = L800C+3
 EQUB &0F, &00, &20, &00, &58, &04, &47, &08  ; 800C: 0F 00 20... ..
 EQUB &08, &0E, &E0, &12, &6C, &16, &90, &1A  ; 8014: 08 0E E0... ...
 EQUB &90, &1E, &E8, &22, &11, &26, &D8, &29  ; 801C: 90 1E E8... ...
 EQUB &20, &2E, &32, &32, &C5, &36, &07, &3B  ; 8024: 20 2E 32...  .2
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &07  ; 802C: 0F 0F 0F... ...
 EQUB &21, &02, &00, &22, &02, &33, &12, &0F  ; 8034: 21 02 00... !..
 EQUB &0F, &5F, &04, &40, &22, &80, &D0, &02  ; 803C: 0F 5F 04... ._.
 EQUB &32, &0C, &38, &77, &12, &FE, &03, &E0  ; 8044: 32 0C 38... 2.8
 EQUB &F8, &C0, &20, &0F, &0E, &22, &02, &39  ; 804C: F8 C0 20... ..
 EQUB &07, &02, &0F, &0F, &12, &02, &02, &00  ; 8054: 07 02 0F... ...
 EQUB &02, &00, &22, &80, &40, &05, &FE, &FC  ; 805C: 02 00 22... .."
 EQUB &F2, &23, &E0, &C0, &60, &0F, &0F, &02  ; 8064: F2 23 E0... .#.
 EQUB &21, &02, &0F, &08, &D0, &A0, &44, &21  ; 806C: 21 02 0F... !..
 EQUB &23, &43, &21, &04, &00, &21, &08, &02  ; 8074: 23 43 21... #C!
 EQUB &30, &E0, &33, &0B, &0E, &38, &C1, &04  ; 807C: 30 E0 33... 0.3
 EQUB &80, &00, &21, &38, &F0, &0F, &07, &21  ; 8084: 80 00 21... ..!
 EQUB &1A, &F7, &03, &34, &01, &07, &7F, &17  ; 808C: 1A F7 03... ...
 EQUB &E0, &02, &75, &BE, &FF, &DE, &7F, &FE  ; 8094: E0 02 75... ..u
 EQUB &04, &32, &01, &0B, &57, &BF, &33, &07  ; 809C: 04 32 01... .2.
 EQUB &0B, &3F, &7F, &FD, &FA, &EF, &F9, &E5  ; 80A4: 0B 3F 7F... .?.
 EQUB &78, &E0, &80, &21, &0F, &13, &50, &03  ; 80AC: 78 E0 80... x..
 EQUB &80, &F8, &12, &21, &03, &06, &E0, &FF  ; 80B4: 80 F8 12... ...
 EQUB &6E, &20, &05, &7F, &6F, &32, &15, &02  ; 80BC: 6E 20 05... n .
 EQUB &04, &F5, &7A, &D0, &A8, &33, &01, &0F  ; 80C4: 04 F5 7A... ..z
 EQUB &1E, &7F, &6F, &BE, &78, &95, &33, &2F  ; 80CC: 1E 7F 6F... ..o
 EQUB &17, &22, &00, &B0, &00, &B0, &C0, &80  ; 80D4: 17 22 00... .".
 EQUB &00, &21, &08, &50, &7F, &35, &3B, &17  ; 80DC: 00 21 08... .!.
 EQUB &2B, &51, &02, &40, &00, &FE, &F2, &E0  ; 80E4: 2B 51 02... +Q.
 EQUB &80, &04, &21, &18, &04, &21, &01, &06  ; 80EC: 80 04 21... ..!
 EQUB &37, &0B, &05, &60, &06, &01, &03, &0F  ; 80F4: 37 0B 05... 7..
 EQUB &7D, &BF, &FA, &54, &21, &02, &FD, &FB  ; 80FC: 7D BF FA... }..
 EQUB &FD, &FB, &D6, &83, &32, &17, &2D, &3F  ; 8104: FD FB D6... ...
 EQUB &21, &24, &02, &21, &05, &80, &38, &08  ; 810C: 21 24 02... !$.
 EQUB &25, &0A, &42, &08, &02, &20, &08, &A2  ; 8114: 25 0A 42... %.B
 EQUB &55, &EB, &34, &01, &28, &40, &0A, &45  ; 811C: 55 EB 34... U.4
 EQUB &AF, &5B, &EF, &21, &12, &A5, &5A, &AD  ; 8124: AF 5B EF... .[.
 EQUB &7B, &BE, &D7, &7F, &21, &22, &55, &AA  ; 812C: 7B BE D7... {..
 EQUB &7D, &DB, &FD, &FF, &F7, &A9, &56, &FF  ; 8134: 7D DB FD... }..
 EQUB &BF, &14, &57, &17, &D4, &FE, &FF, &FE  ; 813C: BF 14 57... ..W
 EQUB &14, &55, &21, &2F, &5B, &21, &3F, &6F  ; 8144: 14 55 21... .U!
 EQUB &BE, &7F, &FF, &B5, &EE, &7B, &13, &F7  ; 814C: BE 7F FF... ...
 EQUB &FF, &7D, &12, &DF, &FE, &14, &DF, &17  ; 8154: FF 7D 12... .}.
 EQUB &BF, &1E, &FD, &FF, &22, &FD, &EF, &FA  ; 815C: BF 1E FD... ...
 EQUB &F7, &AF, &14, &BF, &FF, &7F, &AF, &7F  ; 8164: F7 AF 14... ...
 EQUB &F0, &CC, &B8, &77, &12, &FE, &12, &7F  ; 816C: F0 CC B8... ...
 EQUB &E1, &F8, &C0, &20, &00, &DF, &13, &7F  ; 8174: E1 F8 C0... ...
 EQUB &32, &3F, &1F, &7F, &1F, &15, &22, &FD  ; 817C: 32 3F 1F... 2?.
 EQUB &FA, &FD, &F7, &FA, &EF, &22, &FD, &FF  ; 8184: FA FD F7... ...
 EQUB &FD, &FF, &7F, &FF, &BF, &15, &FE, &FC  ; 818C: FD FF 7F... ...
 EQUB &F2, &23, &E0, &C0, &60, &02, &32, &07  ; 8194: F2 23 E0... .#.
 EQUB &04, &04, &12, &EF, &C7, &32, &07, &02  ; 819C: 04 04 12... ...
 EQUB &02, &12, &FB, &71, &21, &21, &03, &12  ; 81A4: 02 12 FB... ...
 EQUB &EF, &E3, &C1, &80, &02, &FD, &12, &BE  ; 81AC: EF E3 C1... ...
 EQUB &32, &0C, &08, &02, &12, &7E, &21, &38  ; 81B4: 32 0C 08... 2..
 EQUB &20, &03, &FF, &FD, &FC, &32, &38, &08  ; 81BC: 20 03 FF...  ..
 EQUB &03, &D0, &A0, &44, &21, &23, &43, &21  ; 81C4: 03 D0 A0... ...
 EQUB &04, &00, &21, &08, &02, &30, &E0, &33  ; 81CC: 04 00 21... ..!
 EQUB &0B, &0E, &38, &C1, &04, &80, &00, &21  ; 81D4: 0B 0E 38... ..8
 EQUB &38, &F0, &0F, &07, &21, &1A, &F7, &03  ; 81DC: 38 F0 0F... 8..
 EQUB &34, &01, &07, &7F, &17, &E0, &02, &75  ; 81E4: 34 01 07... 4..
 EQUB &BE, &FF, &DE, &7F, &FE, &04, &32, &01  ; 81EC: BE FF DE... ...
 EQUB &0B, &57, &BF, &33, &07, &0B, &3F, &7F  ; 81F4: 0B 57 BF... .W.
 EQUB &FD, &FA, &EF, &F9, &E5, &78, &E0, &80  ; 81FC: FD FA EF... ...
 EQUB &21, &0F, &13, &50, &03, &80, &F8, &12  ; 8204: 21 0F 13... !..
 EQUB &21, &03, &06, &E0, &FF, &6E, &20, &05  ; 820C: 21 03 06... !..
 EQUB &7F, &6F, &32, &15, &02, &04, &F5, &7A  ; 8214: 7F 6F 32... .o2
 EQUB &D0, &A8, &33, &01, &0F, &1E, &7F, &6F  ; 821C: D0 A8 33... ..3
 EQUB &BE, &78, &95, &33, &2F, &17, &22, &00  ; 8224: BE 78 95... .x.
 EQUB &B0, &00, &B0, &C0, &80, &00, &21, &08  ; 822C: B0 00 B0... ...
 EQUB &50, &7F, &35, &3B, &17, &2B, &51, &02  ; 8234: 50 7F 35... P.5
 EQUB &40, &00, &FE, &F2, &E0, &80, &04, &21  ; 823C: 40 00 FE... @..
 EQUB &18, &04, &21, &01, &06, &37, &0B, &05  ; 8244: 18 04 21... ..!
 EQUB &60, &06, &01, &03, &0F, &7D, &BF, &FA  ; 824C: 60 06 01... `..
 EQUB &54, &21, &02, &FD, &FB, &FD, &FB, &D6  ; 8254: 54 21 02... T!.
 EQUB &83, &32, &17, &2D, &3F, &0F, &0F, &0F  ; 825C: 83 32 17... .2.
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; 8264: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &02, &32  ; 826C: 0F 0F 0F... ...
 EQUB &0F, &33, &47, &88, &02, &21, &01, &00  ; 8274: 0F 33 47... .3G
 EQUB &21, &0F, &20, &21, &02, &06, &80, &33  ; 827C: 21 0F 20... !.
 EQUB &1E, &07, &3C, &D0, &B0, &02, &80, &21  ; 8284: 1E 07 3C... ..<
 EQUB &06, &00, &21, &0C, &10, &A0, &04, &80  ; 828C: 06 00 21... ..!
 EQUB &40, &20, &80, &04, &80, &40, &20, &80  ; 8294: 40 20 80... @ .
 EQUB &0F, &0F, &0F, &0F, &0F, &05, &34, &01  ; 829C: 0F 0F 0F... ...
 EQUB &03, &0D, &1F, &22, &10, &21, &38, &98  ; 82A4: 03 0D 1F... ...
 EQUB &00, &22, &01, &21, &0E, &02, &22, &08  ; 82AC: 00 22 01... .".
 EQUB &33, &02, &07, &08, &00, &90, &10, &00  ; 82B4: 33 02 07... 3..
 EQUB &39, &04, &02, &05, &08, &02, &93, &14  ; 82BC: 39 04 02... 9..
 EQUB &00, &04, &0A, &10, &30, &70, &21, &29  ; 82C4: 00 04 0A... ...
 EQUB &51, &21, &21, &0A, &21, &04, &8C, &22  ; 82CC: 51 21 21... Q!!
 EQUB &DE, &BF, &21, &3F, &3F, &0A, &10, &33  ; 82D4: DE BF 21... ..!
 EQUB &1C, &3C, &3D, &7E, &56, &0B, &41, &E3  ; 82DC: 1C 3C 3D... .<=
 EQUB &F2, &D0, &88, &0A, &81, &C7, &9F, &92  ; 82E4: F2 D0 88... ...
 EQUB &21, &04, &0A, &22, &02, &21, &04, &80  ; 82EC: 21 04 0A... !..
 EQUB &20, &02, &21, &2C, &5F, &BB, &DC, &BC  ; 82F4: 20 02 21...  .!
 EQUB &FB, &FD, &F7, &32, &04, &03, &05, &20  ; 82FC: FB FD F7... ...
 EQUB &34, &03, &0F, &CC, &1B, &F4, &B1, &47  ; 8304: 34 03 0F... 4..
 EQUB &35, &3A, &03, &09, &00, &0A, &60, &A0  ; 830C: 35 3A 03... 5:.
 EQUB &32, &03, &08, &80, &C0, &00, &C0, &66  ; 8314: 32 03 08... 2..
 EQUB &9F, &C6, &21, &08, &80, &40, &00, &40  ; 831C: 9F C6 21... ..!
 EQUB &21, &26, &91, &21, &02, &06, &80, &00  ; 8324: 21 26 91... !&.
 EQUB &F8, &56, &21, &21, &80, &02, &80, &00  ; 832C: F8 56 21... .V!
 EQUB &C8, &07, &21, &03, &88, &21, &04, &02  ; 8334: C8 07 21... ..!
 EQUB &20, &02, &21, &02, &05, &21, &1F, &E5  ; 833C: 20 02 21...  .!
 EQUB &21, &08, &50, &04, &21, &19, &80, &03  ; 8344: 21 08 50... !.P
 EQUB &33, &01, &06, &38, &80, &E8, &21, &1F  ; 834C: 33 01 06... 3..
 EQUB &10, &00, &32, &01, &04, &30, &00, &40  ; 8354: 10 00 32... ..2
 EQUB &21, &08, &00, &21, &3F, &8A, &41, &00  ; 835C: 21 08 00... !..
 EQUB &21, &21, &80, &21, &01, &00, &21, &22  ; 8364: 21 21 80... !!.
 EQUB &06, &12, &FC, &FB, &FE, &F4, &A8, &40  ; 836C: 06 12 FC... ...
 EQUB &10, &4B, &21, &1C, &AA, &78, &C0, &02  ; 8374: 10 4B 21... .K!
 EQUB &E8, &21, &14, &C0, &80, &34, &02, &05  ; 837C: E8 21 14... .!.
 EQUB &10, &06, &60, &00, &80, &05, &21, &1A  ; 8384: 10 06 60... ..`
 EQUB &87, &21, &1C, &70, &F0, &06, &10, &60  ; 838C: 87 21 1C... .!.
 EQUB &03, &AC, &E2, &10, &00, &60, &21, &06  ; 8394: 03 AC E2... ...
 EQUB &02, &21, &04, &C2, &10, &05, &34, &04  ; 839C: 02 21 04... .!.
 EQUB &0F, &02, &01, &02, &C0, &10, &40, &33  ; 83A4: 0F 02 01... ...
 EQUB &0C, &02, &01, &05, &91, &CF, &DC, &FF  ; 83AC: 0C 02 01... ...
 EQUB &5F, &7D, &21, &28, &02, &81, &DC, &6B  ; 83B4: 5F 7D 21... _}!
 EQUB &21, &12, &75, &20, &80, &90, &6A, &CD  ; 83BC: 21 12 75... !.u
 EQUB &F7, &FF, &AF, &87, &00, &80, &40, &C0  ; 83C4: F7 FF AF... ...
 EQUB &74, &36, &2E, &25, &86, &0A, &85, &2F  ; 83CC: 74 36 2E... t6.
 EQUB &57, &FE, &F0, &E1, &80, &03, &32, &01  ; 83D4: 57 FE F0... W..
 EQUB &0C, &60, &80, &00, &90, &41, &87, &6A  ; 83DC: 0C 60 80... .`.
 EQUB &D0, &E8, &DD, &FF, &02, &21, &01, &02  ; 83E4: D0 E8 DD... ...
 EQUB &80, &00, &91, &4D, &F0, &4C, &30, &60  ; 83EC: 80 00 91... ...
 EQUB &FC, &F7, &AF, &21, &05, &60, &21, &04  ; 83F4: FC F7 AF... ...
 EQUB &10, &20, &74, &A3, &00, &80, &C4, &68  ; 83FC: 10 20 74... . t
 EQUB &54, &21, &2E, &FD, &BF, &FF, &00, &80  ; 8404: 54 21 2E... T!.
 EQUB &03, &88, &21, &14, &AE, &33, &01, &0D  ; 840C: 03 88 21... ..!
 EQUB &1A, &61, &C0, &22, &80, &C1, &00, &33  ; 8414: 1A 61 C0... .a.
 EQUB &01, &08, &21, &40, &00, &80, &C1, &E4  ; 841C: 01 08 21... ..!
 EQUB &36, &1E, &03, &02, &16, &06, &2F, &55  ; 8424: 36 1E 03... 6..
 EQUB &C0, &36, &14, &02, &00, &14, &04, &2E  ; 842C: C0 36 14... .6.
 EQUB &55, &22, &10, &32, &08, &01, &F4, &BA  ; 8434: 55 22 10... U".
 EQUB &93, &F9, &00, &10, &21, &08, &00, &C0  ; 843C: 93 F9 00... ...
 EQUB &30, &21, &03, &A0, &21, &02, &4C, &30  ; 8444: 30 21 03... 0!.
 EQUB &82, &40, &21, &05, &AB, &21, &3D, &00  ; 844C: 82 40 21... .@!
 EQUB &40, &05, &20, &35, &02, &04, &02, &04  ; 8454: 40 05 20... @.
 EQUB &29, &7C, &E8, &D2, &06, &40, &80, &3F  ; 845C: 29 7C E8... )|.
 EQUB &0F, &0F, &0F, &0B, &22, &04, &36, &0E  ; 8464: 0F 0F 0F... ...
 EQUB &1E, &1E, &08, &00, &04, &0F, &01, &20  ; 846C: 1E 1E 08... ...
 EQUB &52, &21, &11, &60, &21, &14, &0F, &06  ; 8474: 52 21 11... R!.
 EQUB &22, &02, &34, &07, &0F, &1F, &1F, &05  ; 847C: 22 02 34... ".4
 EQUB &22, &80, &02, &34, &04, &0C, &0C, &04  ; 8484: 22 80 02... "..
 EQUB &10, &78, &07, &32, &04, &01, &0F, &08  ; 848C: 10 78 07... .x.
 EQUB &21, &08, &08, &21, &08, &00, &22, &04  ; 8494: 21 08 08... !..
 EQUB &34, &06, &0F, &3F, &08, &02, &34, &04  ; 849C: 34 06 0F... 4..
 EQUB &05, &0B, &04, &80, &02, &21, &0C, &70  ; 84A4: 05 0B 04... ...
 EQUB &F0, &24, &10, &0F, &07, &21, &25, &07  ; 84AC: F0 24 10... .$.
 EQUB &FF, &04, &33, &01, &06, &0C, &FF, &00  ; 84B4: FF 04 33... ..3
 EQUB &22, &04, &21, &3C, &C0, &21, &04, &00  ; 84BC: 22 04 21... ".!
 EQUB &FF, &02, &35, &1C, &38, &3C, &2C, &2C  ; 84C4: FF 02 35... ..5
 EQUB &FF, &00, &26, &10, &FF, &00, &50, &05  ; 84CC: FF 00 26... ..&
 EQUB &C0, &30, &00, &86, &10, &05, &21, &05  ; 84D4: C0 30 00... .0.
 EQUB &07, &7F, &BF, &21, &17, &BB, &21, &15  ; 84DC: 07 7F BF... ...
 EQUB &03, &FF, &F0, &C0, &80, &04, &FF, &35  ; 84E4: 03 FF F0... ...
 EQUB &0F, &13, &05, &02, &02, &02, &FF, &43  ; 84EC: 0F 13 05... ...
 EQUB &F3, &51, &04, &FF, &FD, &EA, &54, &04  ; 84F4: F3 51 04... .Q.
 EQUB &36, &18, &08, &04, &07, &05, &04, &06  ; 84FC: 36 18 08... 6..
 EQUB &F0, &35, &3E, &13, &01, &80, &26, &04  ; 8504: F0 35 3E... .5>
 EQUB &80, &40, &02, &40, &0C, &21, &01, &07  ; 850C: 80 40 02... .@.
 EQUB &80, &04, &32, &03, &05, &05, &AE, &C4  ; 8514: 80 04 32... ..2
 EQUB &40, &20, &09, &21, &01, &07, &20, &10  ; 851C: 40 20 09... @ .
 EQUB &21, &07, &08, &40, &21, &0E, &00, &40  ; 8524: 21 07 08... !..
 EQUB &06, &5F, &02, &20, &04, &F0, &21, &06  ; 852C: 06 5F 02... ._.
 EQUB &08, &40, &08, &3F, &80, &00, &32, &01  ; 8534: 08 40 08... .@.
 EQUB &04, &04, &80, &03, &10, &02, &21, &04  ; 853C: 04 04 80... ...
 EQUB &80, &06, &32, &24, &02, &00, &20, &00  ; 8544: 80 06 32... ..2
 EQUB &21, &02, &05, &34, &0C, &14, &1A, &08  ; 854C: 21 02 05... !..
 EQUB &02, &40, &02, &21, &04, &10, &02, &10  ; 8554: 02 40 02... .@.
 EQUB &02, &21, &02, &07, &35, &04, &0D, &09  ; 855C: 02 21 02... .!.
 EQUB &06, &04, &03, &21, &04, &00, &80, &02  ; 8564: 06 04 03... ...
 EQUB &21, &08, &20, &00, &21, &02, &06, &91  ; 856C: 21 08 20... !.
 EQUB &00, &21, &01, &83, &46, &21, &3C, &00  ; 8574: 00 21 01... .!.
 EQUB &21, &08, &08, &21, &01, &05, &40, &04  ; 857C: 21 08 08... !..
 EQUB &36, &02, &06, &0E, &04, &00, &04, &04  ; 8584: 36 02 06... 6..
 EQUB &40, &C0, &4E, &37, &0A, &02, &02, &1A  ; 858C: 40 C0 4E... @.N
 EQUB &2C, &A6, &38, &06, &32, &04, &01, &10  ; 8594: 2C A6 38... ,.8
 EQUB &00, &21, &01, &03, &21, &04, &04, &21  ; 859C: 00 21 01... .!.
 EQUB &11, &00, &80, &21, &04, &07, &32, &08  ; 85A4: 11 00 80... ...
 EQUB &1C, &05, &20, &02, &3C, &07, &06, &03  ; 85AC: 1C 05 20... ..
 EQUB &03, &01, &04, &0E, &04, &80, &04, &0A  ; 85B4: 03 01 04... ...
 EQUB &08, &10, &93, &66, &35, &0F, &1C, &13  ; 85BC: 08 10 93... ...
 EQUB &8F, &0F, &EF, &8F, &21, &0F, &EF, &00  ; 85C4: 8F 0F EF... ...
 EQUB &BA, &D5, &A3, &41, &82, &21, &01, &05  ; 85CC: BA D5 A3... ...
 EQUB &C0, &80, &5B, &20, &00, &40, &21, &02  ; 85D4: C0 80 5B... ..[
 EQUB &03, &DA, &00, &21, &08, &02, &21, &08  ; 85DC: 03 DA 00... ...
 EQUB &03, &21, &2B, &00, &10, &02, &32, &01  ; 85E4: 03 21 2B... .!+
 EQUB &02, &00, &FF, &23, &03, &21, &3F, &C2  ; 85EC: 02 00 FF... ...
 EQUB &21, &04, &00, &FF, &9F, &A3, &21, &15  ; 85F4: 21 04 00... !..
 EQUB &6A, &22, &52, &00, &FF, &26, &EF, &00  ; 85FC: 6A 22 52... j"R
 EQUB &FF, &50, &05, &C0, &30, &00, &86, &10  ; 8604: FF 50 05... .P.
 EQUB &02, &38, &16, &22, &00, &1A, &2F, &1F  ; 860C: 02 38 16... .8.
 EQUB &0B, &15, &03, &81, &4B, &E9, &44, &6A  ; 8614: 0B 15 03... ...
 EQUB &BF, &02, &5D, &A8, &20, &40, &80, &03  ; 861C: BF 02 5D... ..]
 EQUB &21, &2F, &72, &34, &0D, &1A, &0D, &0D  ; 8624: 21 2F 72... !/r
 EQUB &02, &4B, &B1, &88, &AE, &D1, &FD, &02  ; 862C: 02 4B B1... .K.
 EQUB &A8, &42, &21, &15, &AB, &FD, &AA, &02  ; 8634: A8 42 21... .B!
 EQUB &35, &18, &08, &04, &87, &05, &84, &40  ; 863C: 35 18 08... 5..
 EQUB &80, &04, &F0, &35, &3E, &13, &01, &80  ; 8644: 80 04 F0... ...
 EQUB &26, &04, &80, &40, &02, &40, &00, &34  ; 864C: 26 04 80... &..
 EQUB &02, &09, &01, &02, &07, &21, &01, &07  ; 8654: 02 09 01... ...
 EQUB &80, &04, &32, &03, &05, &20, &E8, &03  ; 865C: 80 04 32... ..2
 EQUB &AE, &C4, &40, &20, &00, &C0, &81, &00  ; 8664: AE C4 40... ..@
 EQUB &33, &04, &0A, &1C, &B8, &FC, &21, &01  ; 866C: 33 04 0A... 3..
 EQUB &03, &32, &04, &28, &52, &F8, &33, &24  ; 8674: 03 32 04... .2.
 EQUB &13, &07, &02, &32, &04, &28, &74, &84  ; 867C: 13 07 02... ...
 EQUB &EA, &30, &4A, &21, &0E, &00, &40, &36  ; 8684: EA 30 4A... .0J
 EQUB &03, &28, &22, &40, &14, &3A, &5F, &00  ; 868C: 03 28 22... .("
 EQUB &A8, &21, &21, &00, &21, &01, &00, &8A  ; 8694: A8 21 21... .!!
 EQUB &F3, &21, &06, &00, &40, &93, &32, &0D  ; 869C: F3 21 06... .!.
 EQUB &3A, &30, &4A, &21, &1D, &4F, &00, &94  ; 86A4: 3A 30 4A... :0J
 EQUB &FF, &56, &21, &28, &94, &40, &EA, &3F  ; 86AC: FF 56 21... .V!
 EQUB &0F, &0F, &09, &10, &07, &21, &18, &0F  ; 86B4: 0F 0F 09... ...
 EQUB &04, &21, &08, &07, &21, &08, &0F, &0F  ; 86BC: 04 21 08... .!.
 EQUB &0F, &0F, &0F, &09, &5C, &21, &2C, &E8  ; 86C4: 0F 0F 0F... ...
 EQUB &21, &06, &60, &20, &02, &46, &00, &AE  ; 86CC: 21 06 60... !.`
 EQUB &9E, &48, &21, &38, &0F, &0F, &0F, &0F  ; 86D4: 9E 48 21... .H!
 EQUB &0F, &0B, &80, &F0, &FB, &FE, &04, &80  ; 86DC: 0F 0B 80... ...
 EQUB &10, &80, &50, &06, &80, &C0, &06, &80  ; 86E4: 10 80 50... ..P
 EQUB &40, &0F, &0F, &0F, &0F, &0F, &0F, &06  ; 86EC: 40 0F 0F... @..
 EQUB &FF, &41, &05, &F8, &FE, &41, &05, &88  ; 86F4: FF 41 05... .A.
 EQUB &C0, &23, &80, &00, &40, &02, &40, &00  ; 86FC: C0 23 80... .#.
 EQUB &22, &80, &00, &40, &0F, &0F, &04, &3F  ; 8704: 22 80 00... "..
 EQUB &0F, &0F, &0F, &0F, &04, &AF, &FF, &7F  ; 870C: 0F 0F 0F... ...
 EQUB &21, &3F, &63, &32, &0F, &33, &C8, &00  ; 8714: 21 3F 63... !?c
 EQUB &AA, &77, &21, &1E, &63, &32, &0D, &13  ; 871C: AA 77 21... .w!
 EQUB &00, &8F, &79, &EF, &FF, &FB, &81, &02  ; 8724: 00 8F 79... ..y
 EQUB &89, &02, &A6, &7B, &81, &03, &22, &80  ; 872C: 89 02 A6... ...
 EQUB &03, &80, &02, &22, &80, &03, &A1, &21  ; 8734: 03 80 02... ...
 EQUB &0A, &0E, &10, &C2, &0E, &A6, &0F, &21  ; 873C: 0A 0E 10... ...
 EQUB &23, &98, &0E, &58, &21, &05, &0E, &20  ; 8744: 23 98 0E... #..
 EQUB &21, &03, &E4, &37, &34, &1A, &18, &0A  ; 874C: 21 03 E4... !..
 EQUB &0B, &0F, &0C, &C4, &20, &22, &10, &22  ; 8754: 0B 0F 0C... ...
 EQUB &08, &33, &03, &04, &07, &FF, &7F, &C7  ; 875C: 08 33 03... .3.
 EQUB &21, &0C, &C1, &33, &0C, &3E, &06, &D4  ; 8764: 21 0C C1... !..
 EQUB &7A, &47, &21, &04, &02, &21, &2C, &60  ; 876C: 7A 47 21... zG!
 EQUB &D9, &12, &FE, &21, &07, &5F, &AA, &20  ; 8774: D9 12 FE... ...
 EQUB &00, &80, &D5, &FE, &33, &06, &1B, &0A  ; 877C: 00 80 D5... ...
 EQUB &00, &80, &B0, &FC, &84, &E2, &40, &00  ; 8784: 00 80 B0... ...
 EQUB &21, &15, &80, &32, &13, &05, &85, &E2  ; 878C: 21 15 80... !..
 EQUB &40, &21, &01, &06, &33, &07, &0E, &34  ; 8794: 40 21 01... @!.
 EQUB &C1, &F3, &9F, &F7, &FE, &FC, &E8, &06  ; 879C: C1 F3 9F... ...
 EQUB &80, &61, &41, &21, &1C, &E2, &21, &3F  ; 87A4: 80 61 41... .aA
 EQUB &F7, &5F, &9E, &21, &2D, &03, &37, &03  ; 87AC: F7 5F 9E... ._.
 EQUB &0C, &3A, &4F, &03, &98, &01, &94, &FA  ; 87B4: 0C 3A 4F... .:O
 EQUB &E8, &B0, &4A, &21, &03, &02, &7F, &51  ; 87BC: E8 B0 4A... ..J
 EQUB &21, &3B, &BF, &DF, &FF, &21, &14, &80  ; 87C4: 21 3B BF... !;.
 EQUB &41, &02, &10, &8A, &57, &21, &18, &10  ; 87CC: 41 02 10... A..
 EQUB &30, &20, &40, &21, &01, &02, &21, &18  ; 87D4: 30 20 40... 0 @
 EQUB &00, &30, &20, &40, &21, &01, &02, &21  ; 87DC: 00 30 20... .0
 EQUB &32, &63, &61, &40, &80, &03, &21, &12  ; 87E4: 32 63 61... 2ca
 EQUB &42, &61, &40, &80, &03, &D0, &6C, &98  ; 87EC: 42 61 40... Ba@
 EQUB &43, &40, &80, &00, &21, &01, &80, &44  ; 87F4: 43 40 80... C@.
 EQUB &10, &42, &40, &80, &04, &C0, &B0, &71  ; 87FC: 10 42 40... .B@
 EQUB &21, &3F, &B8, &80, &21, &01, &00, &40  ; 8804: 21 3F B8... !?.
 EQUB &10, &40, &20, &98, &80, &21, &16, &41  ; 880C: 10 40 20... .@
 EQUB &80, &00, &80, &A0, &02, &96, &41, &80  ; 8814: 80 00 80... ...
 EQUB &00, &80, &03, &D0, &9C, &C0, &10, &00  ; 881C: 00 80 03... ...
 EQUB &21, &0C, &79, &E1, &90, &21, &14, &C0  ; 8824: 21 0C 79... !.y
 EQUB &10, &00, &21, &04, &40, &A1, &22, &0C  ; 882C: 10 00 21... ..!
 EQUB &10, &03, &80, &A0, &22, &0C, &10, &03  ; 8834: 10 03 80... ...
 EQUB &80, &00, &FF, &21, &0B, &00, &21, &28  ; 883C: 80 00 FF... ...
 EQUB &10, &21, &01, &02, &FE, &21, &0B, &00  ; 8844: 10 21 01... .!.
 EQUB &21, &28, &10, &21, &01, &02, &3F, &0F  ; 884C: 21 28 10... !(.
 EQUB &0F, &0F, &0F, &0F, &03, &22, &01, &04  ; 8854: 0F 0F 0F... ...
 EQUB &21, &3E, &13, &05, &80, &E0, &9C, &0F  ; 885C: 21 3E 13... !>.
 EQUB &0F, &05, &32, &08, &34, &03, &25, &03  ; 8864: 0F 05 32... ..2
 EQUB &22, &01, &00, &13, &F1, &FC, &13, &48  ; 886C: 22 01 00... "..
 EQUB &F9, &E0, &C0, &00, &22, &C0, &80, &0F  ; 8874: F9 E0 C0... ...
 EQUB &0F, &21, &0C, &7E, &03, &FE, &61, &21  ; 887C: 0F 21 0C... .!.
 EQUB &06, &C0, &21, &0C, &02, &21, &02, &66  ; 8884: 06 C0 21... ..!
 EQUB &C9, &67, &D8, &32, &0C, &3E, &00, &BF  ; 888C: C9 67 D8... .g.
 EQUB &59, &92, &21, &33, &7E, &CB, &02, &A0  ; 8894: 59 92 21... Y.!
 EQUB &59, &7E, &CD, &7B, &8C, &03, &FF, &CC  ; 889C: 59 7E CD... Y~.
 EQUB &B0, &00, &21, &18, &03, &64, &02, &C0  ; 88A4: B0 00 21... ..!
 EQUB &00, &33, &01, &04, &0A, &05, &21, &03  ; 88AC: 00 33 01... .3.
 EQUB &70, &BC, &32, &0A, &04, &02, &80, &40  ; 88B4: 70 BC 32... p.2
 EQUB &00, &21, &0C, &00, &21, &01, &03, &81  ; 88BC: 00 21 0C... .!.
 EQUB &36, &18, &01, &60, &0C, &00, &01, &00  ; 88C4: 36 18 01... 6..
 EQUB &B9, &97, &8D, &21, &25, &DE, &32, &09  ; 88CC: B9 97 8D... ...
 EQUB &3C, &10, &60, &32, &01, &18, &80, &61  ; 88D4: 3C 10 60... <.`
 EQUB &00, &20, &02, &21, &03, &0E, &38, &01  ; 88DC: 00 20 02... . .
 EQUB &02, &06, &04, &0C, &0D, &0A, &04, &06  ; 88E4: 02 06 04... ...
 EQUB &32, &01, &19, &04, &21, &01, &83, &4F  ; 88EC: 32 01 19... 2..
 EQUB &21, &11, &00, &32, &08, &24, &90, &C0  ; 88F4: 21 11 00... !..
 EQUB &E1, &BF, &FE, &8B, &00, &21, &0C, &02  ; 88FC: E1 BF FE... ...
 EQUB &21, &01, &84, &21, &01, &06, &32, &01  ; 8904: 21 01 84... !..
 EQUB &03, &06, &C0, &FC, &08, &21, &04, &00  ; 890C: 03 06 C0... ...
 EQUB &37, &01, &03, &0F, &1F, &1E, &3D, &3C  ; 8914: 37 01 03... 7..
 EQUB &FC, &23, &F8, &9D, &21, &3F, &7E, &21  ; 891C: FC 23 F8... .#.
 EQUB &04, &10, &84, &32, &01, &2F, &5F, &EF  ; 8924: 04 10 84... ...
 EQUB &46, &F8, &57, &8E, &21, &1D, &22, &BF  ; 892C: 46 F8 57... F.W
 EQUB &47, &EB, &21, &06, &C0, &E8, &E5, &EF  ; 8934: 47 EB 21... G.!
 EQUB &BF, &FE, &7D, &34, &07, &0F, &1E, &1F  ; 893C: BF FE 7D... ..}
 EQUB &BF, &7F, &12, &DF, &21, &3F, &12, &FE  ; 8944: BF 7F 12... ...
 EQUB &F8, &C4, &78, &80, &C0, &8E, &32, &0C  ; 894C: F8 C4 78... ..x
 EQUB &08, &03, &7B, &12, &7E, &22, &7F, &FC  ; 8954: 08 03 7B... ..{
 EQUB &7F, &FD, &F6, &E8, &90, &C0, &02, &40  ; 895C: 7F FD F6... ...
 EQUB &3F, &00, &20, &32, &02, &01, &57, &AC  ; 8964: 3F 00 20... ?.
 EQUB &21, &12, &45, &21, &0A, &57, &00, &51  ; 896C: 21 12 45... !.E
 EQUB &AE, &55, &BF, &35, &15, &01, &40, &14  ; 8974: AE 55 BF... .U.
 EQUB &2E, &D5, &7F, &7A, &55, &5F, &21, &2A  ; 897C: 2E D5 7F... ...
 EQUB &00, &4A, &A0, &7C, &AB, &5A, &D0, &00  ; 8984: 00 4A A0... .J.
 EQUB &41, &AB, &21, &1D, &87, &5D, &EA, &21  ; 898C: 41 AB 21... A.!
 EQUB &02, &57, &21, &0A, &D5, &21, &3B, &81  ; 8994: 02 57 21... .W!
 EQUB &40, &B5, &00, &49, &A0, &75, &AE, &50  ; 899C: 40 B5 00... @..
 EQUB &00, &20, &4B, &21, &01, &00, &40, &A9  ; 89A4: 00 20 4B... . K
 EQUB &00, &21, &02, &55, &AA, &5D, &21, &0B  ; 89AC: 00 21 02... .!.
 EQUB &55, &AE, &FD, &A8, &D0, &BA, &54, &A2  ; 89B4: 55 AE FD... U..
 EQUB &D0, &A0, &00, &22, &01, &88, &40, &02  ; 89BC: D0 A0 00... ...
 EQUB &21, &3E, &13, &21, &05, &04, &22, &80  ; 89C4: 21 3E 13... !>.
 EQUB &60, &21, &15, &BF, &21, &05, &AF, &5A  ; 89CC: 60 21 15... `!.
 EQUB &32, &2F, &05, &00, &E8, &45, &FE, &50  ; 89D4: 32 2F 05... 2/.
 EQUB &AA, &D5, &BA, &5D, &21, &02, &D4, &BB  ; 89DC: AA D5 BA... ...
 EQUB &55, &E8, &50, &AA, &51, &BF, &21, &15  ; 89E4: 55 E8 50... U.P
 EQUB &AB, &41, &00, &60, &21, &28, &44, &FA  ; 89EC: AB 41 00... .A.
 EQUB &44, &A8, &40, &8A, &7D, &E8, &54, &21  ; 89F4: 44 A8 40... D.@
 EQUB &03, &83, &35, &02, &03, &03, &01, &01  ; 89FC: 03 83 35... ..5
 EQUB &00, &12, &71, &8E, &FB, &FF, &BF, &FF  ; 8A04: 00 12 71... ..q
 EQUB &B0, &E6, &DF, &21, &3F, &FF, &8F, &C3  ; 8A0C: B0 E6 DF... ...
 EQUB &80, &21, &14, &8E, &FD, &DA, &F1, &FB  ; 8A14: 80 21 14... .!.
 EQUB &D1, &00, &21, &2A, &F5, &BF, &AE, &75  ; 8A1C: D1 00 21... ..!
 EQUB &A8, &75, &32, &17, &2A, &55, &E8, &80  ; 8A24: A8 75 32... .u2
 EQUB &00, &A0, &FA, &43, &92, &00, &21, &09  ; 8A2C: 00 A0 FA... ...
 EQUB &B8, &21, &08, &00, &21, &2C, &7E, &A8  ; 8A34: B8 21 08... .!.
 EQUB &5D, &21, &2B, &00, &21, &08, &D0, &21  ; 8A3C: 5D 21 2B... ]!+
 EQUB &3D, &E3, &00, &50, &A0, &00, &21, &01  ; 8A44: 3D E3 00... =..
 EQUB &02, &32, &22, &3E, &02, &21, &18, &82  ; 8A4C: 02 32 22... .2"
 EQUB &30, &04, &21, &02, &40, &04, &21, &02  ; 8A54: 30 04 21... 0.!
 EQUB &55, &BE, &00, &32, &01, &07, &6E, &85  ; 8A5C: 55 BE 00... U..
 EQUB &21, &2A, &DF, &AA, &21, &01, &9F, &76  ; 8A64: 21 2A DF... !*.
 EQUB &32, &0C, &31, &ED, &D4, &21, &2A, &CF  ; 8A6C: 32 0C 31... 2.1
 EQUB &B0, &60, &21, &0D, &42, &21, &03, &70  ; 8A74: B0 60 21... .`!
 EQUB &BC, &21, &0A, &C4, &A0, &21, &08, &93  ; 8A7C: BC 21 0A... .!.
 EQUB &21, &1A, &D5, &20, &41, &8C, &00, &D2  ; 8A84: 21 1A D5... !..
 EQUB &21, &04, &74, &82, &64, &21, &1B, &B2  ; 8A8C: 21 04 74... !.t
 EQUB &CD, &32, &24, &03, &05, &A0, &40, &E1  ; 8A94: CD 32 24... .2$
 EQUB &36, &03, &18, &43, &2E, &08, &36, &85  ; 8A9C: 36 03 18... 6..
 EQUB &9C, &21, &38, &D0, &83, &C8, &60, &C3  ; 8AA4: 9C 21 38... .!8
 EQUB &10, &86, &80, &46, &21, &08, &00, &91  ; 8AAC: 10 86 80... ...
 EQUB &4C, &00, &39, &06, &05, &62, &06, &04  ; 8AB4: 4C 00 39... L.9
 EQUB &8C, &2D, &0A, &14, &10, &40, &80, &21  ; 8ABC: 8C 2D 0A... .-.
 EQUB &04, &10, &20, &59, &A5, &81, &21, &24  ; 8AC4: 04 10 20... ..
 EQUB &00, &21, &11, &82, &CD, &76, &21, &2F  ; 8ACC: 00 21 11... .!.
 EQUB &74, &89, &A4, &50, &A1, &9E, &50, &21  ; 8AD4: 74 89 A4... t..
 EQUB &29, &10, &21, &19, &B0, &AC, &21, &2B  ; 8ADC: 29 10 21... ).!
 EQUB &DD, &64, &21, &01, &63, &94, &00, &5B  ; 8AE4: DD 64 21... .d!
 EQUB &C0, &32, &28, &02, &45, &A0, &00, &21  ; 8AEC: C0 32 28... .2(
 EQUB &2C, &02, &21, &08, &A0, &C2, &20, &00  ; 8AF4: 2C 02 21... ,.!
 EQUB &10, &C0, &00, &21, &0A, &02, &21, &05  ; 8AFC: 10 C0 00... ...
 EQUB &53, &35, &02, &0D, &15, &26, &2D, &22  ; 8B04: 53 35 02... S5.
 EQUB &52, &21, &3A, &22, &FC, &8D, &62, &4E  ; 8B0C: 52 21 3A... R!:
 EQUB &95, &21, &35, &D0, &45, &BE, &56, &A9  ; 8B14: 95 21 35... .!5
 EQUB &21, &12, &B9, &C6, &AB, &57, &AA, &5B  ; 8B1C: 21 12 B9... !..
 EQUB &65, &AA, &54, &E7, &BC, &56, &BA, &D6  ; 8B24: 65 AA 54... e.T
 EQUB &6C, &21, &09, &A2, &21, &0B, &94, &21  ; 8B2C: 6C 21 09... l!.
 EQUB &09, &A5, &5E, &FD, &DE, &A8, &21, &24  ; 8B34: 09 A5 5E... ..^
 EQUB &82, &57, &AA, &F1, &47, &21, &3B, &86  ; 8B3C: 82 57 AA... .W.
 EQUB &40, &A1, &75, &D3, &94, &88, &50, &80  ; 8B44: 40 A1 75... @.u
 EQUB &A4, &52, &7C, &B9, &90, &A8, &21, &13  ; 8B4C: A4 52 7C... .R|
 EQUB &80, &42, &89, &21, &17, &6E, &21, &38  ; 8B54: 80 42 89... .B.
 EQUB &C0, &68, &B0, &3F, &05, &32, &13, &01  ; 8B5C: C0 68 B0... .h.
 EQUB &06, &32, &13, &01, &05, &50, &AA, &00  ; 8B64: 06 32 13... .2.
 EQUB &21, &02, &04, &50, &AA, &00, &21, &02  ; 8B6C: 21 02 04... !..
 EQUB &04, &21, &2A, &00, &81, &21, &2A, &04  ; 8B74: 04 21 2A... .!*
 EQUB &21, &2A, &00, &81, &21, &2A, &06, &54  ; 8B7C: 21 2A 00... !*.
 EQUB &A0, &06, &54, &A0, &04, &21, &02, &02  ; 8B84: A0 06 54... ..T
 EQUB &21, &15, &04, &21, &02, &02, &21, &15  ; 8B8C: 21 15 04... !..
 EQUB &04, &C0, &02, &40, &04, &C0, &02, &40  ; 8B94: 04 C0 02... ...
 EQUB &04, &50, &07, &50, &0F, &05, &21, &02  ; 8B9C: 04 50 07... .P.
 EQUB &02, &36, &01, &02, &57, &2F, &00, &02  ; 8BA4: 02 36 01... .6.
 EQUB &02, &35, &01, &02, &55, &2F, &05, &AB  ; 8BAC: 02 35 01... .5.
 EQUB &5D, &21, &2F, &5F, &FF, &22, &FE, &21  ; 8BB4: 5D 21 2F... ]!/
 EQUB &05, &AB, &5D, &21, &2F, &5E, &F4, &E8  ; 8BBC: 05 AB 5D... ..]
 EQUB &40, &77, &BF, &12, &C1, &03, &77, &BE  ; 8BC4: 40 77 BF... @w.
 EQUB &F1, &40, &80, &03, &FA, &14, &7F, &32  ; 8BCC: F1 40 80... .@.
 EQUB &1F, &03, &FA, &FF, &5F, &8B, &34, &16  ; 8BD4: 1F 03 FA... ...
 EQUB &0B, &01, &02, &EA, &40, &FA, &50, &A0  ; 8BDC: 0B 01 02... ...
 EQUB &D0, &FA, &FF, &EA, &40, &FA, &50, &A0  ; 8BE4: D0 FA FF... ...
 EQUB &D0, &7A, &FD, &02, &33, &01, &2F, &04  ; 8BEC: D0 7A FD... .z.
 EQUB &00, &40, &A0, &02, &33, &01, &2F, &04  ; 8BF4: 00 40 A0... .@.
 EQUB &00, &40, &A0, &02, &40, &A8, &03, &21  ; 8BFC: 00 40 A0... .@.
 EQUB &2E, &02, &40, &A8, &03, &21, &2E, &06  ; 8C04: 2E 02 40... ..@
 EQUB &10, &98, &06, &10, &90, &21, &05, &BB  ; 8C0C: 10 98 06... ...
 EQUB &57, &B7, &41, &34, &02, &17, &AB, &05  ; 8C14: 57 B7 41... W.A
 EQUB &BB, &56, &B7, &41, &32, &02, &17, &AA  ; 8C1C: BB 56 B7... .V.
 EQUB &FC, &7C, &23, &FC, &22, &FE, &FF, &A0  ; 8C24: FC 7C 23... .|#
 EQUB &74, &E8, &50, &C0, &A0, &C0, &94, &0F  ; 8C2C: 74 E8 50... t.P
 EQUB &01, &21, &07, &04, &30, &21, &3C, &7F  ; 8C34: 01 21 07... .!.
 EQUB &21, &07, &04, &30, &32, &2C, &15, &EB  ; 8C3C: 21 07 04... !..
 EQUB &71, &00, &34, &05, &0E, &04, &2E, &FF  ; 8C44: 71 00 34... q.4
 EQUB &AB, &71, &00, &34, &05, &0E, &04, &2E  ; 8C4C: AB 71 00... .q.
 EQUB &F7, &C0, &02, &50, &80, &00, &80, &E8  ; 8C54: F7 C0 02... ...
 EQUB &40, &02, &50, &80, &00, &80, &E8, &21  ; 8C5C: 40 02 50... @.P
 EQUB &04, &07, &21, &04, &07, &3E, &0C, &0E  ; 8C64: 04 07 21... ..!
 EQUB &06, &07, &07, &0F, &13, &81, &0C, &0A  ; 8C6C: 06 07 07... ...
 EQUB &00, &03, &02, &0F, &21, &01, &00, &3A  ; 8C74: 00 03 02... ...
 EQUB &17, &02, &00, &01, &96, &29, &02, &10  ; 8C7C: 17 02 00... ...
 EQUB &17, &02, &02, &96, &32, &29, &02, &10  ; 8C84: 17 02 02... ...
 EQUB &FF, &AF, &5D, &99, &21, &36, &98, &21  ; 8C8C: FF AF 5D... ..]
 EQUB &27, &D1, &7F, &AA, &5D, &02, &80, &21  ; 8C94: 27 D1 7F... '..
 EQUB &26, &D1, &C1, &FF, &40, &A6, &6D, &CC  ; 8C9C: 26 D1 C1... &..
 EQUB &81, &21, &34, &00, &85, &40, &04, &21  ; 8CA4: 81 21 34... .!4
 EQUB &04, &12, &5D, &A6, &81, &21, &32, &84  ; 8CAC: 04 12 5D... ..]
 EQUB &73, &BF, &6F, &5D, &02, &21, &02, &00  ; 8CB4: 73 BF 6F... s.o
 EQUB &73, &3F, &FD, &AA, &40, &00, &21, &32  ; 8CBC: 73 3F FD... s?.
 EQUB &48, &91, &20, &21, &1D, &AA, &40, &00  ; 8CC4: 48 91 20... H.
 EQUB &21, &32, &48, &91, &20, &D5, &20, &21  ; 8CCC: 21 32 48... !2H
 EQUB &05, &9A, &60, &80, &20, &00, &D5, &20  ; 8CD4: 05 9A 60... ..`
 EQUB &21, &05, &9A, &60, &80, &20, &00, &32  ; 8CDC: 21 05 9A... !..
 EQUB &02, &2B, &D5, &30, &03, &81, &00, &21  ; 8CE4: 02 2B D5... .+.
 EQUB &21, &C0, &04, &80, &FC, &8F, &43, &F5  ; 8CEC: 21 C0 04... !..
 EQUB &21, &3B, &5F, &E7, &60, &33, &38, &02  ; 8CF4: 21 3B 5F... !;_
 EQUB &01, &80, &20, &50, &87, &20, &A5, &32  ; 8CFC: 01 80 20... ..
 EQUB &08, &12, &80, &62, &00, &21, &0C, &00  ; 8D04: 08 12 80... ...
 EQUB &A5, &32, &08, &12, &80, &62, &00, &21  ; 8D0C: A5 32 08... .2.
 EQUB &0C, &00, &33, &0A, &25, &1A, &80, &41  ; 8D14: 0C 00 33... ..3
 EQUB &00, &D2, &00, &33, &0A, &25, &1A, &80  ; 8D1C: 00 D2 00... ...
 EQUB &41, &00, &D2, &00, &46, &68, &72, &DA  ; 8D24: 41 00 D2... A..
 EQUB &21, &21, &56, &83, &21, &0A, &40, &21  ; 8D2C: 21 21 56... !!V
 EQUB &08, &70, &C2, &21, &21, &50, &83, &21  ; 8D34: 08 70 C2... .p.
 EQUB &02, &9C, &E6, &A4, &51, &96, &C0, &58  ; 8D3C: 02 9C E6... ...
 EQUB &21, &23, &9C, &21, &26, &A4, &51, &96  ; 8D44: 21 23 9C... !#.
 EQUB &C0, &58, &21, &23, &C1, &21, &04, &00  ; 8D4C: C0 58 21... .X!
 EQUB &30, &80, &03, &C1, &21, &04, &00, &30  ; 8D54: 30 80 03... 0..
 EQUB &80, &04, &80, &10, &00, &60, &04, &80  ; 8D5C: 80 04 80... ...
 EQUB &10, &00, &60, &03, &38, &02, &05, &09  ; 8D64: 10 00 60... ..`
 EQUB &0B, &03, &02, &05, &0B, &02, &33, &08  ; 8D6C: 0B 03 02... ...
 EQUB &01, &02, &02, &21, &01, &CF, &BF, &7F  ; 8D74: 01 02 02... ...
 EQUB &F8, &E3, &C7, &86, &21, &02, &4D, &AA  ; 8D7C: F8 E3 C7... ...
 EQUB &21, &37, &58, &21, &23, &44, &84, &21  ; 8D84: 21 37 58... !7X
 EQUB &02, &00, &C3, &00, &21, &08, &02, &80  ; 8D8C: 02 00 C3... ...
 EQUB &C0, &00, &C3, &00, &21, &08, &03, &80  ; 8D94: C0 00 C3... ...
 EQUB &00, &21, &36, &5B, &32, &2F, &1E, &04  ; 8D9C: 00 21 36... .!6
 EQUB &33, &22, &19, &07, &04, &44, &00, &21  ; 8DA4: 33 22 19... 3".
 EQUB &02, &00, &C0, &32, &22, &1B, &FE, &44  ; 8DAC: 02 00 C0... ...
 EQUB &00, &21, &02, &00, &80, &20, &21, &11  ; 8DB4: 00 21 02... .!.
 EQUB &AC, &00, &21, &08, &00, &80, &00, &D0  ; 8DBC: AC 00 21... ..!
 EQUB &C0, &80, &00, &21, &08, &00, &80, &00  ; 8DC4: C0 80 00... ...
 EQUB &10, &02, &40, &00, &10, &05, &40, &00  ; 8DCC: 10 02 40... ..@
 EQUB &10, &05, &40, &00, &21, &06, &05, &40  ; 8DD4: 10 05 40... ..@
 EQUB &00, &21, &06, &05, &33, &0A, &04, &04  ; 8DDC: 00 21 06... .!.
 EQUB &05, &21, &0A, &00, &21, &04, &05, &22  ; 8DE4: 05 21 0A... .!.
 EQUB &01, &32, &03, &02, &06, &32, &01, &02  ; 8DEC: 01 32 03... .2.
 EQUB &04, &CA, &32, &2F, &3A, &40, &80, &03  ; 8DF4: 04 CA 32... ..2
 EQUB &40, &21, &0C, &10, &00, &80, &03, &21  ; 8DFC: 40 21 0C... @!.
 EQUB &01, &07, &21, &01, &07, &21, &18, &07  ; 8E04: 01 07 21... ..!
 EQUB &10, &0F, &0F, &0F, &0F, &0F, &0C, &3F  ; 8E0C: 10 0F 0F... ...
 EQUB &0F, &01, &37, &02, &17, &2B, &05, &0A  ; 8E14: 0F 01 37... ..7
 EQUB &57, &3F, &5F, &FE, &FF, &FE, &B5, &FA  ; 8E1C: 57 3F 5F... W?_
 EQUB &DF, &EA, &50, &AE, &F4, &E8, &50, &00  ; 8E24: DF EA 50... ..P
 EQUB &41, &33, &0B, &17, &01, &02, &21, &05  ; 8E2C: 41 33 0B... A3.
 EQUB &00, &40, &A0, &7A, &FE, &7F, &BF, &7F  ; 8E34: 00 40 A0... .@.
 EQUB &AB, &33, &11, &02, &01, &D4, &F8, &EA  ; 8E3C: AB 33 11... .3.
 EQUB &FC, &FE, &7F, &AF, &7F, &09, &21, &05  ; 8E44: FC FE 7F... ...
 EQUB &40, &20, &34, &02, &07, &12, &15, &BE  ; 8E4C: 40 20 34... @ 4
 EQUB &75, &A0, &54, &BA, &FF, &EA, &54, &80  ; 8E54: 75 A0 54... u.T
 EQUB &33, &01, &02, &07, &8A, &45, &80, &21  ; 8E5C: 33 01 02... 3..
 EQUB &05, &BF, &7F, &FE, &FA, &FE, &5C, &F8  ; 8E64: 05 BF 7F... ...
 EQUB &FE, &7D, &68, &39, &15, &3F, &1F, &1F  ; 8E6C: FE 7D 68... .}h
 EQUB &0E, &3B, &00, &05, &02, &80, &22, &C0  ; 8E74: 0E 3B 00... .;.
 EQUB &A0, &32, &15, &2B, &5E, &F5, &7E, &BF  ; 8E7C: A0 32 15... .2.
 EQUB &56, &21, &2F, &7A, &04, &22, &04, &00  ; 8E84: 56 21 2F... V!/
 EQUB &21, &01, &10, &33, &2C, &0E, &14, &BC  ; 8E8C: 21 01 10... !..
 EQUB &73, &21, &27, &43, &80, &00, &80, &10  ; 8E94: 73 21 27... s!'
 EQUB &A0, &00, &D0, &D9, &33, &02, &17, &2F  ; 8E9C: A0 00 D0... ...
 EQUB &23, &1F, &22, &0F, &FE, &22, &F6, &22  ; 8EA4: 23 1F 22... #."
 EQUB &E0, &22, &F0, &E0, &38, &3C, &3F, &3F  ; 8EAC: E0 22 F0... .".
 EQUB &1F, &1E, &0E, &04, &04, &A3, &55, &E2  ; 8EB4: 1F 1E 0E... ...
 EQUB &22, &E0, &E9, &40, &41, &D4, &6A, &BD  ; 8EBC: 22 E0 E9... "..
 EQUB &6B, &21, &3E, &55, &AF, &7F, &03, &21  ; 8EC4: 6B 21 3E... k!>
 EQUB &01, &04, &F0, &5C, &21, &28, &10, &81  ; 8ECC: 01 04 F0... ...
 EQUB &03, &30, &62, &F5, &FF, &21, &2F, &55  ; 8ED4: 03 30 62... .0b
 EQUB &A2, &21, &07, &A5, &50, &EA, &F0, &A0  ; 8EDC: A2 21 07... .!.
 EQUB &50, &E8, &C0, &60, &A0, &60, &C0, &40  ; 8EE4: 50 E8 C0... P..
 EQUB &0F, &22, &01, &02, &FF, &5F, &AB, &5F  ; 8EEC: 0F 22 01... .".
 EQUB &FE, &B5, &EE, &7F, &06, &22, &02, &00  ; 8EF4: FE B5 EE... ...
 EQUB &22, &80, &05, &34, &0B, &05, &00, &01  ; 8EFC: 22 80 05... "..
 EQUB &04, &E4, &78, &C8, &0F, &0E, &21, &2A  ; 8F04: 04 E4 78... ..x
 EQUB &5C, &21, &38, &10, &20, &0F, &80, &40  ; 8F0C: 5C 21 38... \!8
 EQUB &30, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; 8F14: 30 0F 0F... 0..
 EQUB &08, &3F, &21, &01, &00, &21, &11, &04  ; 8F1C: 08 3F 21... .?!
 EQUB &21, &08, &7F, &AF, &34, &17, &2B, &05  ; 8F24: 21 08 7F... !..
 EQUB &0B, &5F, &AB, &FD, &E8, &D4, &FA, &F5  ; 8F2C: 0B 5F AB... ._.
 EQUB &A8, &C0, &A0, &03, &40, &09, &33, &01  ; 8F34: A8 C0 A0... ...
 EQUB &0B, &17, &05, &40, &A0, &7A, &21, &01  ; 8F3C: 0B 17 05... ...
 EQUB &07, &35, &2B, &07, &15, &03, &01, &03  ; 8F44: 07 35 2B... .5+
 EQUB &20, &00, &21, &14, &02, &32, &03, &01  ; 8F4C: 20 00 21...  .!
 EQUB &00, &7F, &21, &38, &5C, &32, &28, &01  ; 8F54: 00 7F 21... ..!
 EQUB &80, &95, &21, &18, &40, &80, &02, &40  ; 8F5C: 80 95 21... ..!
 EQUB &04, &37, &01, &02, &07, &0A, &05, &00  ; 8F64: 04 37 01... .7.
 EQUB &05, &BF, &7F, &FE, &FA, &FE, &5C, &F8  ; 8F6C: 05 BF 7F... ...
 EQUB &FE, &7D, &68, &36, &15, &3F, &1F, &1F  ; 8F74: FE 7D 68... .}h
 EQUB &0E, &3B, &03, &80, &22, &C0, &A0, &02  ; 8F7C: 0E 3B 03... .;.
 EQUB &33, &01, &0A, &01, &03, &21, &05, &03  ; 8F84: 33 01 0A... 3..
 EQUB &36, &01, &07, &07, &03, &02, &18, &20  ; 8F8C: 36 01 07... 6..
 EQUB &00, &8A, &40, &82, &C4, &A2, &07, &10  ; 8F94: 00 8A 40... ..@
 EQUB &33, &02, &17, &2F, &23, &1F, &22, &0F  ; 8F9C: 33 02 17... 3..
 EQUB &FE, &22, &F6, &22, &E0, &22, &F0, &E0  ; 8FA4: FE 22 F6... .".
 EQUB &38, &3C, &3F, &3F, &1F, &1E, &0E, &04  ; 8FAC: 38 3C 3F... 8<?
 EQUB &04, &80, &40, &24, &E0, &22, &40, &34  ; 8FB4: 04 80 40... ..@
 EQUB &2B, &15, &02, &14, &04, &22, &01, &00  ; 8FBC: 2B 15 02... +..
 EQUB &21, &01, &00, &20, &32, &14, &28, &00  ; 8FC4: 21 01 00... !..
 EQUB &A0, &D4, &60, &81, &00, &32, &01, &07  ; 8FCC: A0 D4 60... ..`
 EQUB &20, &40, &22, &80, &50, &AA, &5D, &F8  ; 8FD4: 20 40 22...  @"
 EQUB &21, &05, &00, &21, &02, &05, &60, &A0  ; 8FDC: 21 05 00... !..
 EQUB &60, &C0, &40, &0F, &08, &21, &01, &4A  ; 8FE4: 60 C0 40... `.@
 EQUB &21, &11, &80, &10, &02, &20, &02, &22  ; 8FEC: 21 11 80... !..
 EQUB &02, &21, &2E, &22, &BF, &32, &1D, &17  ; 8FF4: 02 21 2E... .!.
 EQUB &03, &F4, &FA, &77, &F2, &E0, &04, &80  ; 8FFC: 03 F4 FA... ...
 EQUB &0F, &0F, &D5, &A3, &43, &35, &2B, &11  ; 9004: 0F 0F D5... ...
 EQUB &31, &11, &01, &0C, &80, &40, &30, &0F  ; 900C: 31 11 01... 1..
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &08, &3F  ; 9014: 0F 0F 0F... ...
 EQUB &04, &34, &01, &04, &02, &02, &04, &33  ; 901C: 04 34 01... .4.
 EQUB &01, &04, &02, &0F, &0F, &03, &21, &01  ; 9024: 01 04 02... ...
 EQUB &00, &35, &01, &0A, &05, &20, &15, &AF  ; 902C: 00 35 01... .5.
 EQUB &08, &51, &32, &0B, &17, &AF, &FF, &BE  ; 9034: 08 51 32... .Q2
 EQUB &F4, &E8, &08, &FE, &12, &FA, &FF, &BF  ; 903C: F4 E8 08... ...
 EQUB &5F, &85, &09, &80, &40, &80, &54, &EE  ; 9044: 5F 85 09... _..
 EQUB &FD, &FE, &0D, &80, &50, &80, &08, &23  ; 904C: FD FE 0D... ...
 EQUB &01, &32, &23, &0C, &10, &40, &84, &00  ; 9054: 01 32 23... .2#
 EQUB &22, &01, &32, &21, &08, &10, &40, &84  ; 905C: 22 01 32... ".2
 EQUB &02, &81, &C2, &74, &21, &38, &00, &40  ; 9064: 02 81 C2... ...
 EQUB &03, &82, &54, &21, &28, &00, &40, &37  ; 906C: 03 82 54... ..T
 EQUB &01, &0A, &5F, &2B, &05, &00, &15, &AB  ; 9074: 01 0A 5F... .._
 EQUB &08, &7F, &FE, &FD, &F8, &75, &BA, &7F  ; 907C: 08 7F FE... ...
 EQUB &FA, &08, &40, &80, &35, &01, &05, &01  ; 9084: FA 08 40... ..@
 EQUB &A2, &06, &04, &22, &01, &00, &21, &02  ; 908C: A2 06 04... ...
 EQUB &00, &82, &97, &6A, &40, &60, &20, &32  ; 9094: 00 82 97... ...
 EQUB &31, &04, &22, &80, &00, &22, &40, &00  ; 909C: 31 04 22... 1."
 EQUB &20, &00, &FF, &FA, &FD, &7F, &22, &3F  ; 90A4: 20 00 FF...  ..
 EQUB &5F, &EA, &08, &D4, &A0, &00, &80, &40  ; 90AC: 5F EA 08... _..
 EQUB &A9, &D0, &80, &08, &3B, &09, &17, &1E  ; 90B4: A9 D0 80... ...
 EQUB &3C, &28, &28, &0C, &0C, &09, &15, &1A  ; 90BC: 3C 28 28... <((
 EQUB &30, &22, &20, &22, &08, &A5, &D2, &60  ; 90C4: 30 22 20... 0"
 EQUB &00, &21, &01, &00, &32, &08, &0C, &A0  ; 90CC: 00 21 01... .!.
 EQUB &80, &40, &00, &21, &01, &00, &22, &08  ; 90D4: 80 40 00... .@.
 EQUB &7F, &FF, &5F, &21, &2F, &5F, &BF, &32  ; 90DC: 7F FF 5F... .._
 EQUB &07, &06, &08, &FD, &E8, &D0, &23, &E0  ; 90E4: 07 06 08... ...
 EQUB &22, &F0, &08, &3E, &01, &09, &09, &1C  ; 90EC: 22 F0 08... "..
 EQUB &10, &08, &0C, &18, &01, &01, &09, &08  ; 90F4: 10 08 0C... ...
 EQUB &10, &08, &33, &0C, &08, &03, &02, &20  ; 90FC: 10 08 33... ..3
 EQUB &21, &21, &51, &4A, &6A, &04, &20, &51  ; 9104: 21 21 51... !!Q
 EQUB &40, &21, &2A, &5C, &AA, &34, &1D, &1F  ; 910C: 40 21 2A... @!*
 EQUB &1F, &16, &BF, &BE, &07, &80, &00, &80  ; 9114: 1F 16 BF... ...
 EQUB &40, &80, &C1, &AA, &50, &80, &08, &3E  ; 911C: 40 80 C1... @..
 EQUB &06, &26, &03, &16, &0B, &05, &03, &02  ; 9124: 06 26 03... .&.
 EQUB &06, &24, &01, &14, &0A, &04, &35, &03  ; 912C: 06 24 01... .$.
 EQUB &02, &03, &00, &01, &83, &7E, &CE, &B8  ; 9134: 02 03 00... ...
 EQUB &90, &21, &02, &00, &21, &01, &82, &21  ; 913C: 90 21 02... .!.
 EQUB &2C, &CA, &A8, &90, &8F, &9D, &21, &0A  ; 9144: 2C CA A8... ,..
 EQUB &05, &22, &80, &06, &5A, &AF, &32, &15  ; 914C: 05 22 80... .".
 EQUB &0F, &5F, &AF, &32, &17, &3F, &08, &3F  ; 9154: 0F 5F AF... ._.
 EQUB &98, &50, &98, &21, &32, &A6, &E4, &C8  ; 915C: 98 50 98... .P.
 EQUB &80, &21, &18, &10, &34, &18, &12, &26  ; 9164: 80 21 18... .!.
 EQUB &24, &48, &00, &4C, &3A, &0A, &24, &45  ; 916C: 24 48 00... $H.
 EQUB &04, &0C, &0C, &08, &48, &0A, &24, &41  ; 9174: 04 0C 0C... ...
 EQUB &00, &33, &0C, &04, &08, &7F, &FF, &FB  ; 917C: 00 33 0C... .3.
 EQUB &FF, &DC, &6C, &CE, &AE, &00, &80, &00  ; 9184: FF DC 6C... ..l
 EQUB &21, &24, &48, &60, &CA, &AE, &00, &A0  ; 918C: 21 24 48... !$H
 EQUB &54, &A0, &0C, &3E, &01, &05, &05, &0A  ; 9194: 54 A0 0C... T..
 EQUB &17, &07, &25, &54, &01, &05, &05, &0A  ; 919C: 17 07 25... ..%
 EQUB &15, &04, &21, &21, &50, &C0, &22, &40  ; 91A4: 15 04 21... ..!
 EQUB &80, &A0, &7D, &21, &28, &00, &40, &00  ; 91AC: 80 A0 7D... ..}
 EQUB &40, &00, &A0, &6D, &21, &28, &03, &33  ; 91B4: 40 00 A0... @..
 EQUB &08, &0C, &06, &48, &05, &32, &08, &06  ; 91BC: 08 0C 06... ...
 EQUB &48, &02, &36, &1B, &07, &17, &3E, &1F  ; 91C4: 48 02 36... H.6
 EQUB &14, &03, &35, &01, &13, &2E, &17, &14  ; 91CC: 14 03 35... ..5
 EQUB &02, &90, &80, &21, &02, &80, &33, &04  ; 91D4: 02 90 80... ...
 EQUB &08, &18, &00, &90, &80, &21, &02, &80  ; 91DC: 08 18 00... ...
 EQUB &35, &04, &08, &18, &00, &09, &22, &10  ; 91E4: 35 04 08... 5..
 EQUB &00, &20, &00, &40, &00, &21, &09, &22  ; 91EC: 00 20 00... . .
 EQUB &10, &00, &20, &00, &40, &00, &21, &24  ; 91F4: 10 00 20... ..
 EQUB &42, &21, &04, &80, &04, &21, &24, &42  ; 91FC: 42 21 04... B!.
 EQUB &21, &04, &80, &06, &22, &04, &33, &0C  ; 9204: 21 04 80... !..
 EQUB &08, &28, &20, &02, &21, &04, &00, &21  ; 920C: 08 28 20... .(
 EQUB &04, &00, &21, &28, &20, &21, &36, &BE  ; 9214: 04 00 21... ..!
 EQUB &6B, &5B, &8F, &85, &47, &34, &03, &24  ; 921C: 6B 5B 8F... k[.
 EQUB &9E, &29, &10, &8E, &80, &44, &21, &01  ; 9224: 9E 29 10... .).
 EQUB &03, &80, &00, &A0, &C0, &D8, &21, &07  ; 922C: 03 80 00... ...
 EQUB &9F, &7C, &CF, &33, &39, &2F, &07, &50  ; 9234: 9F 7C CF... .|.
 EQUB &08, &21, &3D, &E7, &FA, &DF, &F3, &7F  ; 923C: 08 21 3D... .!=
 EQUB &93, &FE, &08, &CE, &FF, &73, &FF, &21  ; 9244: 93 FE 08... ...
 EQUB &3F, &FF, &CF, &FC, &08, &7E, &14, &21  ; 924C: 3F FF CF... ?..
 EQUB &3F, &12, &09, &C0, &FE, &FF, &F9, &FF  ; 9254: 3F 12 09... ?..
 EQUB &FE, &FB, &0A, &70, &E7, &FF, &F9, &7E  ; 925C: FE FB 0A... ...
 EQUB &D2, &40, &07, &40, &03, &81, &21, &22  ; 9264: D2 40 07... .@.
 EQUB &97, &F9, &21, &03, &83, &63, &36, &3D  ; 926C: 97 F9 21... ..!
 EQUB &0D, &19, &10, &08, &01, &83, &62, &37  ; 9274: 0D 19 10... ...
 EQUB &24, &09, &11, &10, &08, &88, &24, &00  ; 927C: 24 09 11... $..
 EQUB &42, &48, &21, &2D, &85, &21, &12, &8B  ; 9284: 42 48 21... BH!
 EQUB &21, &25, &00, &42, &34, &08, &25, &85  ; 928C: 21 25 00... !%.
 EQUB &12, &05, &40, &A0, &F5, &9F, &71, &92  ; 9294: 12 05 40... ..@
 EQUB &82, &00, &40, &A0, &D5, &05, &21, &04  ; 929C: 82 00 40... ..@
 EQUB &A8, &7D, &BF, &F7, &DD, &6B, &32, &22  ; 92A4: A8 7D BF... .}.
 EQUB &04, &A0, &4D, &06, &88, &D6, &CF, &FF  ; 92AC: 04 A0 4D... ..M
 EQUB &FB, &AA, &A0, &00, &88, &52, &05, &10  ; 92B4: FB AA A0... ...
 EQUB &21, &3D, &AA, &9F, &FC, &D7, &92, &80  ; 92BC: 21 3D AA... !=.
 EQUB &10, &21, &2D, &AA, &02, &35, &02, &0A  ; 92C4: 10 21 2D... .!-
 EQUB &0E, &5D, &2A, &80, &ED, &E8, &62, &48  ; 92CC: 0E 5D 2A... .]*
 EQUB &21, &02, &55, &21, &2A, &80, &03, &80  ; 92D4: 21 02 55... !.U
 EQUB &21, &11, &55, &EA, &40, &CE, &79, &21  ; 92DC: 21 11 55... !.U
 EQUB &2E, &8A, &21, &11, &45, &AA, &40, &3F  ; 92E4: 2E 8A 21... ..!
 EQUB &F0, &78, &21, &3C, &7C, &FE, &13, &03  ; 92EC: F0 78 21... .x!
 EQUB &10, &02, &21, &02, &87, &03, &21, &01  ; 92F4: 10 02 21... ..!
 EQUB &03, &20, &02, &80, &C0, &80, &21, &01  ; 92FC: 03 20 02... . .
 EQUB &0F, &80, &02, &E3, &43, &31, &03, &25  ; 9304: 0F 80 02... ...
 EQUB &06, &08, &FD, &FE, &FF, &22, &F0, &22  ; 930C: 06 08 FD... ...
 EQUB &F8, &FD, &82, &C0, &22, &E0, &70, &30  ; 9314: F8 FD 82... ...
 EQUB &21, &38, &9C, &06, &40, &0F, &01, &20  ; 931C: 21 38 9C... !8.
 EQUB &06, &21, &01, &80, &24, &0C, &22, &08  ; 9324: 06 21 01... .!.
 EQUB &22, &18, &40, &20, &10, &05, &FB, &17  ; 932C: 22 18 40... ".@
 EQUB &EC, &FE, &F6, &7B, &21, &3B, &9D, &CF  ; 9334: EC FE F6... ...
 EQUB &E6, &05, &22, &80, &C0, &00, &20, &06  ; 933C: E6 05 22... .."
 EQUB &33, &01, &03, &01, &05, &C0, &E0, &C0  ; 9344: 33 01 03... 3..
 EQUB &80, &04, &21, &18, &23, &10, &30, &23  ; 934C: 80 04 21... ..!
 EQUB &20, &04, &80, &22, &40, &20, &16, &F9  ; 9354: 20 04 80...  ..
 EQUB &F8, &18, &C0, &60, &70, &B0, &B8, &D8  ; 935C: F8 18 C0... ...
 EQUB &EC, &7C, &07, &21, &02, &0A, &21, &08  ; 9364: EC 7C 07... .|.
 EQUB &05, &20, &00, &48, &23, &40, &02, &22  ; 936C: 05 20 00... . .
 EQUB &10, &21, &08, &05, &FA, &FB, &F9, &FD  ; 9374: 10 21 08... .!.
 EQUB &15, &22, &7F, &FF, &21, &3F, &7F, &21  ; 937C: 15 22 7F... .".
 EQUB &3F, &9F, &22, &76, &BB, &FB, &FD, &FF  ; 9384: 3F 9F 22... ?."
 EQUB &FE, &FF, &04, &22, &80, &22, &C0, &07  ; 938C: FE FF 04... ...
 EQUB &40, &02, &40, &E0, &40, &21, &02, &08  ; 9394: 40 02 40... @.@
 EQUB &22, &10, &03, &34, &04, &02, &02, &01  ; 939C: 22 10 03... "..
 EQUB &00, &FF, &F7, &E7, &67, &22, &F3, &BB  ; 93A4: 00 FF F7... ...
 EQUB &B9, &9F, &8F, &CF, &C7, &22, &E7, &22  ; 93AC: B9 9F 8F... ...
 EQUB &C7, &12, &7F, &21, &3F, &DF, &13, &22  ; 93B4: C7 12 7F... ...
 EQUB &60, &F0, &B0, &22, &F8, &22, &FC, &E0  ; 93BC: 60 F0 B0... `..
 EQUB &40, &05, &21, &01, &08, &33, &18, &08  ; 93C4: 40 05 21... @.!
 EQUB &0C, &07, &22, &40, &22, &60, &22, &70  ; 93CC: 0C 07 22... .."
 EQUB &D9, &22, &CF, &E5, &F6, &22, &FE, &FC  ; 93D4: D9 22 CF... .".
 EQUB &47, &67, &7F, &FF, &BF, &22, &3F, &21  ; 93DC: 47 67 7F... Gg.
 EQUB &1F, &18, &FC, &22, &FE, &22, &F7, &FB  ; 93E4: 1F 18 FC... ...
 EQUB &FF, &FD, &05, &84, &80, &C0, &00, &21  ; 93EC: FF FD 05... ...
 EQUB &08, &08, &80, &02, &22, &10, &21, &08  ; 93F4: 08 08 80... ...
 EQUB &22, &78, &22, &7C, &22, &7E, &22, &7F  ; 93FC: 22 78 22... "x"
 EQUB &3F, &CC, &E4, &F2, &FB, &FD, &FC, &DE  ; 9404: 3F CC E4... ?..
 EQUB &BF, &02, &10, &21, &38, &10, &80, &85  ; 940C: BF 02 10... ...
 EQUB &42, &02, &33, &01, &02, &01, &00, &20  ; 9414: 42 02 33... B.3
 EQUB &70, &00, &80, &40, &A0, &41, &83, &21  ; 941C: 70 00 80... p..
 EQUB &01, &06, &81, &02, &21, &01, &03, &80  ; 9424: 01 06 81... ...
 EQUB &C0, &80, &00, &50, &A0, &40, &25, &01  ; 942C: C0 80 00... ...
 EQUB &18, &32, &37, &2F, &7F, &15, &65, &A0  ; 9434: 18 32 37... .27
 EQUB &90, &D0, &E8, &EC, &F4, &F2, &20, &04  ; 943C: 90 D0 E8... ...
 EQUB &40, &E0, &40, &0E, &20, &70, &05, &21  ; 9444: 40 E0 40... @.@
 EQUB &01, &83, &31, &01, &24, &03, &22, &07  ; 944C: 01 83 31... ..1
 EQUB &87, &21, &07, &19, &FE, &16, &5A, &21  ; 9454: 87 21 07... .!.
 EQUB &2D, &DD, &FE, &DE, &EF, &F7, &FB, &03  ; 945C: 2D DD FE... -..
 EQUB &22, &80, &22, &40, &A0, &20, &70, &20  ; 9464: 22 80 22... "."
 EQUB &05, &20, &21, &05, &06, &80, &D0, &80  ; 946C: 05 20 21... . !
 EQUB &00, &80, &03, &31, &07, &24, &0F, &23  ; 9474: 00 80 03... ...
 EQUB &1F, &1F, &11, &F9, &CC, &C2, &D9, &F9  ; 947C: 1F 1F 11... ...
 EQUB &FE, &FF, &DF, &B0, &D0, &C8, &68, &74  ; 9484: FE FF DF... ...
 EQUB &B4, &9A, &CA, &06, &32, &02, &07, &09  ; 948C: B4 9A CA... ...
 EQUB &33, &08, &1C, &08, &04, &31, &1F, &25  ; 9494: 33 08 1C... 3..
 EQUB &3F, &22, &7F, &18, &FD, &7C, &22, &3E  ; 949C: 3F 22 7F... ?".
 EQUB &22, &9F, &22, &DF, &13, &7F, &FD, &FC  ; 94A4: 22 9F 22... "."
 EQUB &22, &F8, &DD, &BD, &DE, &CE, &22, &E7  ; 94AC: 22 F8 DD... "..
 EQUB &73, &32, &39, &02, &00, &22, &80, &22  ; 94B4: 73 32 39... s29
 EQUB &40, &22, &A0, &03, &21, &01, &02, &40  ; 94BC: 40 22 A0... @".
 EQUB &A0, &00, &40, &A0, &50, &A2, &47, &21  ; 94C4: A0 00 40... ..@
 EQUB &02, &00, &28, &7F, &13, &FB, &22, &FD  ; 94CC: 02 00 28... ..(
 EQUB &FE, &12, &BF, &12, &24, &7F, &23, &FC  ; 94D4: FE 12 BF... ...
 EQUB &FD, &FC, &FE, &FA, &FB, &32, &1D, &04  ; 94DC: FD FC FE... ...
 EQUB &86, &F2, &7B, &BD, &B9, &21, &18, &D1  ; 94E4: 86 F2 7B... ..{
 EQUB &D0, &68, &E8, &22, &74, &F8, &BA, &50  ; 94EC: D0 68 E8... .h.
 EQUB &A0, &40, &03, &32, &01, &03, &07, &80  ; 94F4: A0 40 03... .@.
 EQUB &27, &7F, &21, &3F, &16, &CF, &FF, &23  ; 94FC: 27 7F 21... '.!
 EQUB &3F, &32, &1F, &0F, &87, &83, &C3, &22  ; 9504: 3F 32 1F... ?2.
 EQUB &F9, &22, &F0, &F8, &FC, &F2, &FB, &21  ; 950C: F9 22 F0... .".
 EQUB &3C, &9C, &8E, &34, &07, &27, &23, &31  ; 9514: 3C 9C 8E... <..
 EQUB &98, &DE, &5D, &4D, &CE, &EE, &EF, &97  ; 951C: 98 DE 5D... ..]
 EQUB &32, &3F, &01, &02, &22, &80, &44, &40  ; 9524: 32 3F 01... 2?.
 EQUB &A0, &33, &08, &1C, &08, &05, &22, &3F  ; 952C: A0 33 08... .3.
 EQUB &BF, &25, &3F, &FF, &C7, &12, &C1, &12  ; 9534: BF 25 3F... .%?
 EQUB &C0, &3F, &00, &80, &C0, &80, &0F, &0F  ; 953C: C0 3F 00... .?.
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &04, &37  ; 9544: 0F 0F 0F... ...
 EQUB &02, &01, &00, &0F, &1F, &3F, &3F, &7E  ; 954C: 02 01 00... ...
 EQUB &04, &10, &22, &38, &7C, &04, &80, &22  ; 9554: 04 10 22... .."
 EQUB &C0, &60, &0F, &0F, &0F, &0F, &0F, &0F  ; 955C: C0 60 0F... .`.
 EQUB &0E, &7C, &78, &FE, &12, &FB, &22, &F7  ; 9564: 0E 7C 78... .|x
 EQUB &22, &78, &FE, &12, &FB, &22, &F7, &10  ; 956C: 22 78 FE... "x.
 EQUB &00, &21, &08, &84, &C4, &E2, &F0, &F9  ; 9574: 00 21 08... .!.
 EQUB &20, &10, &02, &20, &90, &C8, &E4, &0F  ; 957C: 20 10 02...  ..
 EQUB &0F, &0F, &0F, &0F, &0F, &06, &22, &F7  ; 9584: 0F 0F 0F... ...
 EQUB &12, &23, &7F, &21, &3F, &22, &F7, &12  ; 958C: 12 23 7F... .#.
 EQUB &22, &7F, &79, &21, &38, &80, &03, &32  ; 9594: 22 7F 79... ".y
 EQUB &08, &18, &9E, &9F, &86, &35, &03, &01  ; 959C: 08 18 9E... ...
 EQUB &00, &08, &18, &9E, &9F, &00, &22, &80  ; 95A4: 00 08 18... ...
 EQUB &22, &40, &20, &10, &80, &03, &22, &80  ; 95AC: 22 40 20... "@
 EQUB &40, &20, &10, &0F, &01, &3F, &0F, &0F  ; 95B4: 40 20 10... @ .
 EQUB &0F, &0F, &04, &3E, &3D, &1C, &1E, &1E  ; 95BC: 0F 0F 04... ...
 EQUB &0E, &0E, &0C, &0C, &3A, &1B, &19, &1D  ; 95C4: 0E 0E 0C... ...
 EQUB &0E, &0E, &22, &0C, &BF, &9F, &98, &30  ; 95CC: 0E 0E 22... .."
 EQUB &24, &F0, &BF, &32, &1F, &18, &B0, &30  ; 95D4: 24 F0 BF... $..
 EQUB &70, &30, &90, &22, &88, &C4, &34, &04  ; 95DC: 70 30 90... p0.
 EQUB &02, &00, &01, &02, &40, &A0, &30, &22  ; 95E4: 02 00 01... ...
 EQUB &18, &32, &0C, &06, &0F, &0F, &0F, &0F  ; 95EC: 18 32 0C... .2.
 EQUB &0F, &05, &36, &0C, &0E, &1E, &9E, &0F  ; 95F4: 0F 05 36... ..6
 EQUB &0F, &22, &47, &31, &0C, &23, &06, &23  ; 95FC: 0F 22 47... ."G
 EQUB &83, &81, &22, &F0, &70, &22, &78, &23  ; 9604: 83 81 22... .."
 EQUB &F8, &90, &80, &22, &40, &60, &E0, &22  ; 960C: F8 90 80... ...
 EQUB &C4, &02, &80, &C0, &20, &03, &34, &02  ; 9614: C4 02 80... ...
 EQUB &03, &01, &01, &00, &22, &40, &E0, &22  ; 961C: 03 01 01... ...
 EQUB &80, &22, &40, &20, &00, &22, &10, &02  ; 9624: 80 22 40... ."@
 EQUB &C0, &00, &A0, &80, &10, &50, &0F, &0F  ; 962C: C0 00 A0... ...
 EQUB &0F, &0F, &04, &38, &27, &33, &33, &1B  ; 9634: 0F 0F 04... ...
 EQUB &09, &01, &01, &03, &C1, &22, &C3, &E1  ; 963C: 09 01 01... ...
 EQUB &F0, &78, &7C, &21, &3C, &B8, &98, &22  ; 9644: F0 78 7C... .x|
 EQUB &80, &23, &C0, &E0, &22, &06, &21, &0F  ; 964C: 80 23 C0... .#.
 EQUB &8F, &87, &32, &03, &01, &09, &C0, &60  ; 9654: 8F 87 32... ..2
 EQUB &70, &F8, &D8, &DC, &CE, &67, &23, &08  ; 965C: 70 F8 D8... p..
 EQUB &22, &0C, &3A, &06, &02, &03, &28, &28  ; 9664: 22 0C 3A... ".:
 EQUB &38, &34, &04, &02, &02, &81, &0F, &0F  ; 966C: 38 34 04... 84.
 EQUB &0F, &0F, &04, &3F, &23, &10, &34, &18  ; 9674: 0F 0F 04... ...
 EQUB &38, &10, &2C, &7E, &0D, &22, &10, &30  ; 967C: 38 10 2C... 8.,
 EQUB &0F, &0F, &02, &3D, &04, &0C, &04, &04  ; 9684: 0F 0F 02... ...
 EQUB &0E, &1E, &1E, &0C, &3E, &02, &3C, &02  ; 968C: 0E 1E 1E... ...
 EQUB &3C, &7E, &22, &7F, &00, &22, &40, &20  ; 9694: 3C 7E 22... <~"
 EQUB &22, &08, &33, &16, &3F, &00, &23, &38  ; 969C: 22 08 33... ".3
 EQUB &10, &00, &22, &10, &0F, &0E, &22, &20  ; 96A4: 10 00 22... .."
 EQUB &70, &00, &21, &1C, &22, &7E, &BE, &E0  ; 96AC: 70 00 21... p.!
 EQUB &22, &7C, &35, &3E, &1E, &04, &18, &18  ; 96B4: 22 7C 35... "|5
 EQUB &10, &02, &39, &01, &1E, &3F, &01, &1E  ; 96BC: 10 02 39... ..9
 EQUB &1E, &0C, &02, &30, &23, &38, &34, &05  ; 96C4: 1E 0C 02... ...
 EQUB &1D, &3C, &3D, &06, &22, &80, &0F, &01  ; 96CC: 1D 3C 3D... .<=
 EQUB &70, &88, &70, &22, &F0, &60, &21, &01  ; 96D4: 70 88 70... p.p
 EQUB &20, &33, &18, &08, &08, &88, &98, &22  ; 96DC: 20 33 18...  3.
 EQUB &9C, &21, &1C, &08, &3C, &0E, &1F, &00  ; 96E4: 9C 21 1C... .!.
 EQUB &03, &03, &01, &03, &00, &3D, &1C, &9C  ; 96EC: 03 03 01... ...
 EQUB &1C, &22, &9C, &21, &1C, &84, &03, &C0  ; 96F4: 1C 22 9C... .".
 EQUB &22, &E0, &60, &0A, &22, &04, &37, &0E  ; 96FC: 22 E0 60... ".`
 EQUB &1E, &1E, &10, &0C, &01, &23, &64, &63  ; 9704: 1E 1E 10... ...
 EQUB &22, &67, &47, &70, &22, &BC, &20, &21  ; 970C: 22 67 47... "gG
 EQUB &18, &98, &90, &98, &10, &08, &33, &1F  ; 9714: 18 98 90... ...
 EQUB &06, &03, &05, &31, &18, &25, &3C, &22  ; 971C: 06 03 05... ...
 EQUB &1C, &40, &C0, &22, &C8, &C0, &22, &C8  ; 9724: 1C 40 C0... .@.
 EQUB &59, &03, &22, &18, &03, &33, &0C, &0E  ; 972C: 59 03 22... Y."
 EQUB &2E, &6C, &68, &23, &2C, &71, &E7, &CC  ; 9734: 2E 6C 68... .lh
 EQUB &D9, &9B, &23, &B6, &D8, &10, &21, &18  ; 973C: D9 9B 23... ..#
 EQUB &80, &21, &3C, &7C, &60, &40, &08, &34  ; 9744: 80 21 3C... .!<
 EQUB &03, &01, &03, &03, &04, &84, &88, &C4  ; 974C: 03 01 03... ...
 EQUB &C8, &21, &04, &03, &59, &5D, &32, &0D  ; 9754: C8 21 04... .!.
 EQUB &01, &05, &90, &21, &13, &B7, &02, &10  ; 975C: 01 05 90... ...
 EQUB &00, &6C, &EC, &94, &21, &01, &04, &21  ; 9764: 00 6C EC... .l.
 EQUB &36, &00, &7D, &FD, &21, &0D, &03, &40  ; 976C: 36 00 7D... 6.}
 EQUB &00, &E0, &E8, &F8, &0F, &0F, &05, &21  ; 9774: 00 E0 E8... ...
 EQUB &18, &00, &21, &38, &00, &21, &08, &0F  ; 977C: 18 00 21... ..!
 EQUB &0C, &3F, &03, &30, &10, &00, &40, &8C  ; 9784: 0C 3F 03... .?.
 EQUB &0B, &22, &10, &00, &20, &21, &18, &0F  ; 978C: 0B 22 10... .".
 EQUB &0F, &03, &21, &06, &00, &35, &0A, &04  ; 9794: 0F 03 21... ..!
 EQUB &0D, &0D, &02, &DC, &8C, &4E, &8C, &42  ; 979C: 0D 0D 02... ...
 EQUB &8D, &22, &9E, &40, &00, &A0, &C8, &60  ; 97A4: 8D 22 9E... .".
 EQUB &44, &21, &2C, &4E, &21, &38, &50, &58  ; 97AC: 44 21 2C... D!,
 EQUB &50, &20, &00, &22, &20, &0F, &0F, &01  ; 97B4: 50 20 00... P .
 EQUB &20, &00, &32, &22, &31, &F9, &70, &5D  ; 97BC: 20 00 32...  .2
 EQUB &BB, &21, &13, &CF, &E4, &40, &22, &20  ; 97C4: BB 21 13... .!.
 EQUB &21, &08, &20, &00, &5E, &21, &25, &4E  ; 97CC: 21 08 20... !.
 EQUB &5E, &35, &26, &2E, &16, &2C, &08, &50  ; 97D4: 5E 35 26... ^5&
 EQUB &58, &21, &1D, &58, &E5, &C9, &59, &0F  ; 97DC: 58 21 1D... X!.
 EQUB &09, &60, &00, &60, &68, &48, &10, &20  ; 97E4: 09 60 00... .`.
 EQUB &36, &01, &26, &10, &1C, &1C, &0C, &88  ; 97EC: 36 01 26... 6.&
 EQUB &22, &BA, &08, &73, &3E, &26, &03, &01  ; 97F4: 22 BA 08... "..
 EQUB &05, &03, &04, &0F, &48, &29, &28, &A9  ; 97FC: 05 03 04... ...
 EQUB &29, &21, &A1, &21, &18, &80, &00, &C0  ; 9804: 29 21 A1... )!.
 EQUB &20, &40, &60, &80, &20, &0A, &22, &04  ; 980C: 20 40 60...  @`
 EQUB &23, &0D, &34, &02, &22, &55, &13, &54  ; 9814: 23 0D 34... #.4
 EQUB &22, &53, &21, &32, &E8, &21, &1A, &92  ; 981C: 22 53 21... "S!
 EQUB &21, &1A, &94, &54, &48, &54, &21, &08  ; 9824: 21 1A 94... !..
 EQUB &08, &A6, &CB, &04, &44, &32, &01, &24  ; 982C: 08 A6 CB... ...
 EQUB &48, &22, &58, &22, &48, &21, &28, &A0  ; 9834: 48 22 58... H"X
 EQUB &80, &22, &40, &58, &50, &40, &21, &18  ; 983C: 80 22 40... ."@
 EQUB &88, &03, &22, &18, &03, &38, &0A, &08  ; 9844: 88 03 22... .."
 EQUB &0C, &2A, &26, &0A, &00, &0A, &C2, &5A  ; 984C: 0C 2A 26... .*&
 EQUB &B7, &8E, &F4, &5B, &35, &19, &0D, &34  ; 9854: B7 8E F4... ...
 EQUB &E8, &14, &58, &92, &B8, &A2, &80, &00  ; 985C: E8 14 58... ..X
 EQUB &22, &01, &00, &21, &01, &03, &84, &21  ; 9864: 22 01 00... "..
 EQUB &02, &84, &CD, &CC, &03, &21, &08, &D4  ; 986C: 02 84 CD... ...
 EQUB &8A, &94, &21, &02, &03, &8D, &83, &D2  ; 9874: 8A 94 21... ..!
 EQUB &9E, &21, &0D, &04, &21, &02, &B6, &58  ; 987C: 9E 21 0D... .!.
 EQUB &BF, &00, &10, &00, &21, &0A, &43, &E2  ; 9884: BF 00 10... ...
 EQUB &9E, &21, &07, &03, &5D, &00, &A2, &7B  ; 988C: 9E 21 07... .!.
 EQUB &21, &32, &03, &80, &00, &88, &C0, &E8  ; 9894: 21 32 03... !2.
 EQUB &21, &18, &0F, &0F, &04, &21, &18, &00  ; 989C: 21 18 0F... !..
 EQUB &21, &38, &00, &21, &08, &0F, &0C, &3F  ; 98A4: 21 38 00... !8.
 EQUB &22, &CF, &C7, &22, &87, &83, &21, &01  ; 98AC: 22 CF C7... "..
 EQUB &00, &22, &CF, &C7, &22, &87, &83, &21  ; 98B4: 00 22 CF... .".
 EQUB &01, &00, &17, &BF, &17, &BF, &13, &22  ; 98BC: 01 00 17... ...
 EQUB &EF, &22, &CF, &87, &13, &22, &EF, &22  ; 98C4: EF 22 CF... .".
 EQUB &CF, &87, &1F, &1F, &1F, &1F, &14, &F1  ; 98CC: CF 87 1F... ...
 EQUB &E0, &F1, &E0, &23, &C0, &E0, &F1, &E0  ; 98D4: E0 F1 E0... ...
 EQUB &F1, &E0, &23, &C0, &E0, &0F, &01, &BF  ; 98DC: F1 E0 23... ..#
 EQUB &35, &1F, &17, &03, &03, &01, &02, &BF  ; 98E4: 35 1F 17... 5..
 EQUB &35, &1F, &17, &03, &03, &01, &02, &87  ; 98EC: 35 1F 17... 5..
 EQUB &23, &07, &87, &CF, &8F, &21, &07, &87  ; 98F4: 23 07 87... #..
 EQUB &23, &07, &87, &CF, &8E, &21, &07, &18  ; 98FC: 23 07 87... #..
 EQUB &7F, &12, &F7, &12, &F2, &CF, &1B, &FE  ; 9904: 7F 12 F7... ...
 EQUB &FF, &87, &FF, &B0, &19, &FB, &13, &FD  ; 990C: FF 87 FF... ...
 EQUB &B7, &14, &FE, &DE, &CE, &8E, &87, &13  ; 9914: B7 14 FE... ...
 EQUB &FE, &DE, &CE, &8E, &87, &C0, &80, &06  ; 991C: FE DE CE... ...
 EQUB &C0, &80, &0F, &05, &80, &CC, &0F, &01  ; 9924: C0 80 0F... ...
 EQUB &22, &07, &21, &02, &05, &22, &07, &21  ; 992C: 22 07 21... ".!
 EQUB &02, &05, &13, &23, &7F, &22, &3F, &12  ; 9934: 02 05 13... ...
 EQUB &D3, &7F, &21, &27, &7C, &32, &1B, &02  ; 993C: D3 7F 21... ..!
 EQUB &18, &FB, &21, &2F, &FF, &D2, &BA, &E7  ; 9944: 18 FB 21... ..!
 EQUB &9C, &21, &01, &FF, &24, &FE, &12, &FB  ; 994C: 9C 21 01... .!.
 EQUB &5F, &E2, &BE, &FA, &40, &21, &13, &4C  ; 9954: 5F E2 BE... _..
 EQUB &A1, &31, &07, &23, &03, &32, &02, &06  ; 995C: A1 31 07... .1.
 EQUB &22, &8C, &36, &05, &03, &02, &03, &00  ; 9964: 22 8C 36... ".6
 EQUB &06, &8C, &84, &80, &C0, &40, &05, &80  ; 996C: 06 8C 84... ...
 EQUB &C0, &40, &0D, &F7, &5E, &A8, &41, &21  ; 9974: C0 40 0D... .@.
 EQUB &02, &80, &0C, &C0, &B8, &50, &0F, &04  ; 997C: 02 80 0C... ...
 EQUB &22, &3F, &22, &1F, &24, &0F, &32, &08  ; 9984: 22 3F 22... "?"
 EQUB &25, &22, &10, &34, &0E, &04, &02, &08  ; 998C: 25 22 10... %".
 EQUB &3F, &18, &21, &14, &E1, &00, &F0, &21  ; 9994: 3F 18 21... ?.!
 EQUB &06, &88, &32, &23, &08, &FB, &F9, &F1  ; 999C: 06 88 32... ..2
 EQUB &22, &E0, &22, &C0, &E0, &21, &0A, &A9  ; 99A4: 22 E0 22... "."
 EQUB &21, &11, &60, &A0, &02, &20, &88, &07  ; 99AC: 21 11 60... !.`
 EQUB &88, &0F, &0F, &01, &35, &04, &1E, &2E  ; 99B4: 88 0F 0F... ...
 EQUB &1C, &3B, &54, &00, &80, &0A, &21, &38  ; 99BC: 1C 3B 54... .;T
 EQUB &FC, &D7, &21, &02, &0F, &03, &32, &1F  ; 99C4: FC D7 21... ..!
 EQUB &17, &24, &03, &22, &02, &32, &1E, &14  ; 99CC: 17 24 03... .$.
 EQUB &03, &21, &01, &00, &21, &02, &13, &22  ; 99D4: 03 21 01... .!.
 EQUB &E7, &13, &81, &06, &90, &E0, &C0, &80  ; 99DC: E7 13 81... ...
 EQUB &02, &24, &80, &06, &80, &0F, &0F, &01  ; 99E4: 02 24 80... .$.
 EQUB &21, &19, &07, &21, &05, &04, &10, &21  ; 99EC: 21 19 07... !..
 EQUB &24, &00, &21, &05, &05, &32, &01, &0B  ; 99F4: 24 00 21... $.!
 EQUB &5F, &00, &21, &28, &10, &02, &32, &01  ; 99FC: 5F 00 21... _.!
 EQUB &0B, &5F, &05, &40, &EB, &FF, &05, &40  ; 9A04: 0B 5F 05... ._.
 EQUB &EB, &77, &05, &7F, &12, &05, &7F, &FF  ; 9A0C: EB 77 05... .w.
 EQUB &9C, &6D, &48, &03, &FF, &EF, &FF, &21  ; 9A14: 9C 6D 48... .mH
 EQUB &25, &48, &03, &E7, &83, &C6, &04, &60  ; 9A1C: 25 48 03... %H.
 EQUB &13, &04, &60, &22, &DF, &7F, &05, &C0  ; 9A24: 13 04 60... ..`
 EQUB &12, &05, &C0, &FF, &FE, &06, &E0, &F0  ; 9A2C: 12 05 C0... ...
 EQUB &21, &14, &00, &22, &02, &00, &21, &02  ; 9A34: 21 14 00... !..
 EQUB &60, &30, &3E, &2F, &07, &6F, &0F, &1F  ; 9A3C: 60 30 3E... `0>
 EQUB &CF, &17, &4F, &2F, &07, &6F, &0D, &1F  ; 9A44: CF 17 4F... ..O
 EQUB &CF, &21, &15, &48, &DF, &EF, &BF, &15  ; 9A4C: CF 21 15... .!.
 EQUB &DE, &EF, &BD, &22, &FE, &FD, &FF, &FB  ; 9A54: DE EF BD... ...
 EQUB &18, &67, &F7, &FF, &F7, &E7, &F7, &F9  ; 9A5C: 18 67 F7... .g.
 EQUB &EF, &19, &E3, &F4, &4E, &F8, &9F, &F4  ; 9A64: EF 19 E3... ...
 EQUB &BF, &E7, &FF, &C7, &FF, &F7, &13, &00  ; 9A6C: BF E7 FF... ...
 EQUB &81, &00, &80, &00, &A2, &21, &01, &D3  ; 9A74: 81 00 80... ...
 EQUB &18, &F7, &21, &3F, &6B, &33, &1F, &39  ; 9A7C: 18 F7 21... ..!
 EQUB &0F, &BB, &F1, &18, &B7, &BF, &BB, &DE  ; 9A84: 0F BB F1... ...
 EQUB &FF, &22, &DF, &8F, &F0, &F8, &FC, &15  ; 9A8C: FF 22 DF... .".
 EQUB &70, &F8, &FC, &12, &EF, &E7, &D7, &3F  ; 9A94: 70 F8 FC... p..
 EQUB &40, &10, &80, &20, &02, &40, &0F, &0F  ; 9A9C: 40 10 80... @..
 EQUB &0F, &01, &21, &18, &5E, &21, &3C, &06  ; 9AA4: 0F 01 21... ..!
 EQUB &80, &03, &40, &02, &90, &21, &02, &05  ; 9AAC: 80 03 40... ..@
 EQUB &80, &0A, &C0, &0F, &0F, &0F, &0F, &0F  ; 9AB4: 80 0A C0... ...
 EQUB &0D, &21, &18, &0F, &48, &00, &80, &05  ; 9ABC: 0D 21 18... .!.
 EQUB &21, &03, &00, &21, &02, &00, &21, &01  ; 9AC4: 21 03 00... !..
 EQUB &03, &21, &0E, &79, &21, &35, &4D, &21  ; 9ACC: 03 21 0E... .!.
 EQUB &3D, &65, &97, &21, &02, &00, &E0, &FF  ; 9AD4: 3D 65 97... =e.
 EQUB &CF, &F3, &BC, &21, &33, &CF, &03, &F0  ; 9ADC: CF F3 BC... ...
 EQUB &78, &F0, &76, &A7, &0F, &0F, &0A, &33  ; 9AE4: 78 F0 76... x.v
 EQUB &0B, &08, &00, &24, &03, &32, &07, &3F  ; 9AEC: 0B 08 00... ...
 EQUB &F1, &7F, &FF, &22, &FE, &FC, &F8, &CF  ; 9AF4: F1 7F FF... ...
 EQUB &DF, &9F, &22, &3F, &7F, &12, &80, &C0  ; 9AFC: DF 9F 22... .."
 EQUB &E0, &F0, &F8, &FC, &F8, &E6, &07, &21  ; 9B04: E0 F0 F8... ...
 EQUB &04, &06, &32, &24, &09, &06, &80, &09  ; 9B0C: 04 06 32... ..2
 EQUB &23, &07, &35, &05, &0B, &0B, &0F, &0D  ; 9B14: 23 07 35... #.5
 EQUB &F9, &F1, &60, &67, &21, &0D, &82, &81  ; 9B1C: F9 F1 60... ..`
 EQUB &21, &07, &FF, &FC, &21, &01, &A7, &21  ; 9B24: 21 07 FF... !..
 EQUB &1F, &7F, &FD, &FA, &9F, &7F, &FB, &EA  ; 9B2C: 1F 7F FD... ...
 EQUB &B1, &61, &80, &C1, &03, &22, &80, &40  ; 9B34: B1 61 80... .a.
 EQUB &80, &00, &21, &08, &48, &21, &01, &90  ; 9B3C: 80 00 21... ..!
 EQUB &21, &04, &20, &02, &20, &00, &80, &0D  ; 9B44: 21 04 20... !.
 EQUB &32, &0C, &18, &10, &05, &21, &1F, &5B  ; 9B4C: 32 0C 18... 2..
 EQUB &E8, &05, &D1, &80, &06, &20, &0F, &08  ; 9B54: E8 05 D1... ...
 EQUB &3F, &21, &04, &02, &21, &04, &02, &21  ; 9B5C: 3F 21 04... ?!.
 EQUB &08, &0F, &0F, &0F, &01, &21, &37, &A1  ; 9B64: 08 0F 0F... ...
 EQUB &5B, &06, &40, &22, &80, &00, &21, &09  ; 9B6C: 5B 06 40... [.@
 EQUB &00, &21, &04, &03, &80, &10, &00, &20  ; 9B74: 00 21 04... .!.
 EQUB &00, &21, &08, &40, &21, &03, &07, &21  ; 9B7C: 00 21 08... .!.
 EQUB &38, &0F, &0F, &0A, &20, &88, &00, &20  ; 9B84: 38 0F 0F... 8..
 EQUB &82, &00, &21, &04, &05, &40, &0F, &0F  ; 9B8C: 82 00 21... ..!
 EQUB &05, &32, &36, &18, &0F, &01, &21, &08  ; 9B94: 05 32 36... .26
 EQUB &00, &20, &21, &01, &00, &83, &38, &0C  ; 9B9C: 00 20 21... . !
 EQUB &3B, &0D, &FF, &16, &2E, &59, &27, &F1  ; 9BA4: 3B 0D FF... ;..
 EQUB &86, &CA, &B2, &C2, &92, &68, &FD, &C0  ; 9BAC: 86 CA B2... ...
 EQUB &21, &1C, &58, &32, &33, &2C, &5B, &8D  ; 9BB4: 21 1C 58... !.X
 EQUB &21, &37, &02, &E0, &98, &B8, &F2, &B7  ; 9BBC: 21 37 02... !7.
 EQUB &45, &07, &80, &0F, &02, &21, &04, &00  ; 9BC4: 45 07 80... E..
 EQUB &3B, &03, &0D, &80, &02, &01, &8D, &35  ; 9BCC: 3B 03 0D... ;..
 EQUB &D5, &3F, &C0, &11, &4C, &00, &74, &77  ; 9BD4: D5 3F C0... .?.
 EQUB &FF, &21, &15, &FC, &75, &21, &34, &71  ; 9BDC: FF 21 15... .!.
 EQUB &D9, &68, &9F, &C1, &FA, &7C, &B8, &78  ; 9BE4: D9 68 9F... .h.
 EQUB &83, &DC, &33, &1F, &3F, &0F, &78, &FF  ; 9BEC: 83 DC 33... ..3
 EQUB &EA, &C0, &E0, &F0, &F8, &FC, &21, &3A  ; 9BF4: EA C0 E0... ...
 EQUB &46, &21, &19, &05, &21, &01, &00, &20  ; 9BFC: 46 21 19... F!.
 EQUB &04, &21, &11, &00, &21, &08, &80, &40  ; 9C04: 04 21 11... .!.
 EQUB &21, &08, &00, &80, &21, &12, &00, &21  ; 9C0C: 21 08 00... !..
 EQUB &08, &00, &21, &02, &41, &30, &37, &18  ; 9C14: 08 00 21... ..!
 EQUB &08, &44, &01, &01, &28, &09, &A8, &4A  ; 9C1C: 08 44 01... .D.
 EQUB &A4, &21, &04, &00, &33, &12, &39, &12  ; 9C24: A4 21 04... .!.
 EQUB &A3, &80, &C2, &35, &0D, &1E, &3A, &50  ; 9C2C: A3 80 C2... ...
 EQUB &03, &FE, &5D, &EE, &B1, &82, &21, &05  ; 9C34: 03 FE 5D... ..]
 EQUB &6A, &B2, &C4, &21, &15, &4F, &9A, &7B  ; 9C3C: 6A B2 C4... j..
 EQUB &21, &3E, &00, &84, &80, &22, &40, &A0  ; 9C44: 21 3E 00... !>.
 EQUB &60, &C0, &21, &1C, &00, &21, &09, &10  ; 9C4C: 60 C0 21... `.!
 EQUB &00, &21, &01, &00, &34, &04, &01, &00  ; 9C54: 00 21 01... .!.
 EQUB &08, &00, &42, &00, &10, &80, &02, &48  ; 9C5C: 08 00 42... ..B
 EQUB &03, &10, &00, &92, &46, &32, &2C, &18  ; 9C64: 03 10 00... ...
 EQUB &04, &20, &32, &24, &17, &EB, &04, &21  ; 9C6C: 04 20 32... . 2
 EQUB &2E, &7F, &FF, &E0, &04, &CD, &B5, &C2  ; 9C74: 2E 7F FF... ...
 EQUB &05, &80, &00, &21, &04, &06, &21, &02  ; 9C7C: 05 80 00... ...
 EQUB &10, &05, &3F, &0F, &03, &80, &21, &04  ; 9C84: 10 05 3F... ..?
 EQUB &52, &20, &00, &48, &02, &80, &21, &04  ; 9C8C: 52 20 00... R .
 EQUB &52, &20, &00, &48, &04, &21, &12, &6C  ; 9C94: 52 20 00... R .
 EQUB &8A, &65, &04, &21, &12, &6C, &8A, &65  ; 9C9C: 8A 65 04... .e.
 EQUB &21, &04, &00, &41, &32, &16, &2C, &9A  ; 9CA4: 21 04 00... !..
 EQUB &E4, &7B, &21, &04, &00, &41, &32, &16  ; 9CAC: E4 7B 21... .{!
 EQUB &2C, &9A, &E4, &7B, &21, &02, &48, &80  ; 9CB4: 2C 9A E4... ,..
 EQUB &21, &13, &A7, &4B, &DF, &BF, &21, &02  ; 9CBC: 21 13 A7... !..
 EQUB &48, &80, &21, &13, &A7, &4A, &DB, &B1  ; 9CC4: 48 80 21... H.!
 EQUB &00, &49, &82, &4C, &B9, &E9, &D6, &8B  ; 9CCC: 00 49 82... .I.
 EQUB &00, &49, &82, &4C, &B9, &E9, &56, &8B  ; 9CD4: 00 49 82... .I.
 EQUB &33, &04, &08, &24, &C1, &80, &03, &33  ; 9CDC: 33 04 08... 3..
 EQUB &04, &08, &24, &C1, &80, &03, &84, &00  ; 9CE4: 04 08 24... ..$
 EQUB &48, &90, &80, &20, &00, &21, &04, &84  ; 9CEC: 48 90 80... H..
 EQUB &00, &48, &90, &80, &20, &00, &21, &04  ; 9CF4: 00 48 90... .H.
 EQUB &0F, &01, &3E, &04, &03, &29, &05, &07  ; 9CFC: 0F 01 3E... ..>
 EQUB &15, &03, &0A, &04, &03, &29, &05, &07  ; 9D04: 15 03 0A... ...
 EQUB &15, &32, &03, &0A, &9B, &FA, &AF, &7D  ; 9D0C: 15 32 03... .2.
 EQUB &FF, &76, &DD, &EF, &9B, &FA, &AB, &55  ; 9D14: FF 76 DD... .v.
 EQUB &8E, &52, &D5, &AD, &D7, &BF, &F9, &E7  ; 9D1C: 8E 52 D5... .R.
 EQUB &DF, &67, &FF, &6F, &D7, &BE, &D9, &65  ; 9D24: DF 67 FF... .g.
 EQUB &DF, &65, &BB, &6F, &FB, &CD, &DC, &7B  ; 9D2C: DF 65 BB... .e.
 EQUB &A7, &6F, &7E, &F7, &6B, &CD, &88, &7B  ; 9D34: A7 6F 7E... .o~
 EQUB &A5, &6B, &56, &D5, &53, &21, &37, &EF  ; 9D3C: A5 6B 56... .kV
 EQUB &DD, &BA, &E6, &EE, &DD, &51, &21, &34  ; 9D44: DD BA E6... ...
 EQUB &EA, &55, &AA, &C7, &EF, &DA, &23, &80  ; 9D4C: EA 55 AA... .U.
 EQUB &32, &38, &27, &BF, &7C, &21, &39, &80  ; 9D54: 32 38 27... 28'
 EQUB &A0, &C0, &58, &E7, &7F, &EC, &B9, &00  ; 9D5C: A0 C0 58... ..X
 EQUB &10, &20, &C4, &90, &20, &42, &B4, &00  ; 9D64: 10 20 C4... . .
 EQUB &10, &20, &C4, &90, &20, &42, &B4, &0F  ; 9D6C: 10 20 C4... . .
 EQUB &01, &34, &07, &03, &03, &01, &04, &21  ; 9D74: 01 34 07... .4.
 EQUB &05, &00, &32, &02, &01, &04, &FF, &FB  ; 9D7C: 05 00 32... ..2
 EQUB &BF, &12, &EF, &7F, &21, &07, &83, &CB  ; 9D84: BF 12 EF... ...
 EQUB &21, &24, &30, &10, &C8, &40, &21, &06  ; 9D8C: 21 24 30... !$0
 EQUB &BA, &FF, &97, &FF, &F7, &12, &FE, &B2  ; 9D94: BA FF 97... ...
 EQUB &21, &27, &94, &5C, &33, &01, &0A, &01  ; 9D9C: 21 27 94... !'.
 EQUB &42, &FF, &FD, &F7, &F5, &DB, &BF, &12  ; 9DA4: 42 FF FD... B..
 EQUB &8B, &85, &21, &16, &55, &32, &1B, &2C  ; 9DAC: 8B 85 21... ..!
 EQUB &88, &00, &7A, &FA, &F4, &E5, &C8, &D9  ; 9DB4: 88 00 7A... ..z
 EQUB &99, &21, &33, &4D, &75, &4B, &9B, &32  ; 9DBC: 99 21 33... .!3
 EQUB &36, &2F, &75, &ED, &F2, &E5, &EF, &4F  ; 9DC4: 36 2F 75... 6/u
 EQUB &DF, &BF, &7F, &FF, &F2, &65, &EE, &44  ; 9DCC: DF BF 7F... ...
 EQUB &DA, &A8, &51, &C3, &68, &D0, &F0, &E5  ; 9DD4: DA A8 51... ..Q
 EQUB &DE, &A6, &FC, &F9, &21, &28, &50, &70  ; 9DDC: DE A6 FC... ...
 EQUB &A5, &5E, &A6, &5C, &89, &0F, &0F, &0F  ; 9DE4: A5 5E A6... .^.
 EQUB &03, &32, &3F, &03, &06, &32, &3E, &02  ; 9DEC: 03 32 3F... .2?
 EQUB &06, &3F, &FF, &FE, &34, &1C, &05, &01  ; 9DF4: 06 3F FF... .?.
 EQUB &01, &03, &37, &05, &1F, &02, &06, &0C  ; 9DFC: 01 03 37... ..7
 EQUB &08, &18, &76, &65, &E3, &EF, &CF, &4F  ; 9E04: 08 18 76... ..v
 EQUB &8F, &21, &1F, &8A, &9C, &21, &38, &78  ; 9E0C: 8F 21 1F... .!.
 EQUB &30, &21, &34, &68, &62, &13, &FC, &FB  ; 9E14: 30 21 34... 0!4
 EQUB &EF, &9F, &EF, &86, &37, &19, &23, &44  ; 9E1C: EF 9F EF... ...
 EQUB &1A, &29, &93, &29, &70, &B2, &6F, &EF  ; 9E24: 1A 29 93... .).
 EQUB &DB, &7F, &FE, &FF, &30, &B2, &4F, &AD  ; 9E2C: DB 7F FE... ...
 EQUB &5B, &6F, &D4, &21, &03, &0F, &0F, &0F  ; 9E34: 5B 6F D4... [o.
 EQUB &0F, &22, &01, &32, &03, &07, &08, &30  ; 9E3C: 0F 22 01... .".
 EQUB &20, &60, &22, &C0, &80, &02, &35, &3F  ; 9E44: 20 60 22...  `"
 EQUB &0B, &07, &07, &03, &03, &35, &07, &0B  ; 9E4C: 0B 07 07... ...
 EQUB &06, &00, &01, &03, &DF, &7F, &FF, &BF  ; 9E54: 06 00 01... ...
 EQUB &FE, &03, &D4, &60, &80, &20, &21, &06  ; 9E5C: FE 03 D4... ...
 EQUB &03, &FE, &FF, &FC, &E0, &04, &33, &06  ; 9E64: 03 FE FF... ...
 EQUB &0B, &14, &A0, &0F, &0F, &0F, &0F, &34  ; 9E6C: 0B 14 A0... ...
 EQUB &06, &0C, &1C, &18, &30, &70, &60, &C0  ; 9E74: 06 0C 1C... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0E, &22  ; 9E7C: 0F 0F 0F... ...
 EQUB &01, &36, &03, &07, &0E, &0E, &1C, &38  ; 9E84: 01 36 03... .6.
 EQUB &08, &C0, &80, &04, &22, &01, &0C, &22  ; 9E8C: 08 C0 80... ...
 EQUB &E0, &22, &C0, &0F, &0F, &0F, &03, &3F  ; 9E94: E0 22 C0... .".
 EQUB &44, &10, &80, &32, &28, &02, &40, &08  ; 9E9C: 44 10 80... D..
 EQUB &20, &08, &10, &02, &20, &40, &E0, &7A  ; 9EA4: 20 08 10...  ..
 EQUB &FD, &FF, &02, &40, &20, &02, &40, &80  ; 9EAC: FD FF 02... ...
 EQUB &07, &32, &04, &21, &02, &21, &02, &00  ; 9EB4: 07 32 04... .2.
 EQUB &32, &08, &01, &05, &20, &06, &10, &02  ; 9EBC: 32 08 01... 2..
 EQUB &21, &04, &02, &21, &01, &04, &40, &05  ; 9EC4: 21 04 02... !..
 EQUB &23, &02, &82, &22, &7F, &33, &3F, &1F  ; 9ECC: 23 02 82... #..
 EQUB &06, &03, &D8, &BC, &F8, &E0, &50, &07  ; 9ED4: 06 03 D8... ...
 EQUB &21, &04, &00, &10, &04, &40, &00, &21  ; 9EDC: 21 04 00... !..
 EQUB &01, &0A, &21, &02, &0D, &21, &07, &00  ; 9EE4: 01 0A 21... ..!
 EQUB &22, &02, &36, &07, &1F, &1F, &3F, &FF  ; 9EEC: 22 02 36... ".6
 EQUB &3F, &03, &22, &C0, &E0, &F0, &E1, &05  ; 9EF4: 3F 03 22... ?."
 EQUB &21, &0C, &86, &C0, &03, &21, &03, &00  ; 9EFC: 21 0C 86... !..
 EQUB &80, &50, &88, &02, &20, &33, &08, &1F  ; 9F04: 80 50 88... .P.
 EQUB &07, &06, &80, &C0, &E0, &00, &21, &02  ; 9F0C: 07 06 80... ...
 EQUB &02, &21, &01, &02, &32, &01, &08, &02  ; 9F14: 02 21 01... .!.
 EQUB &40, &00, &50, &03, &22, &1F, &21, &06  ; 9F1C: 40 00 50... @.P
 EQUB &00, &34, &01, &02, &07, &0B, &C0, &84  ; 9F24: 00 34 01... .4.
 EQUB &21, &2E, &54, &21, &19, &00, &40, &21  ; 9F2C: 21 2E 54... !.T
 EQUB &08, &20, &32, &18, &0D, &C7, &E7, &FB  ; 9F34: 08 20 32... . 2
 EQUB &FD, &6F, &34, &14, &0B, &02, &0F, &85  ; 9F3C: FD 6F 34... .o4
 EQUB &C2, &E1, &70, &02, &A0, &10, &80, &C0  ; 9F44: C2 E1 70... ..p
 EQUB &70, &30, &0D, &23, &02, &08, &22, &07  ; 9F4C: 70 30 0D... p0.
 EQUB &33, &04, &01, &08, &03, &B0, &64, &80  ; 9F54: 33 04 01... 3..
 EQUB &21, &03, &04, &21, &22, &03, &80, &00  ; 9F5C: 21 03 04... !..
 EQUB &20, &00, &EC, &F0, &50, &20, &32, &08  ; 9F64: 20 00 EC...  ..
 EQUB &04, &02, &33, &0C, &04, &02, &0F, &0F  ; 9F6C: 04 02 33... ..3
 EQUB &0F, &0F, &0F, &05, &80, &20, &21, &08  ; 9F74: 0F 0F 0F... ...
 EQUB &A0, &20, &0F, &0F, &0F, &0B, &3F, &E0  ; 9F7C: A0 20 0F... . .
 EQUB &40, &21, &02, &80, &00, &10, &32, &04  ; 9F84: 40 21 02... @!.
 EQUB &01, &00, &40, &00, &10, &00, &80, &21  ; 9F8C: 01 00 40... ..@
 EQUB &01, &02, &31, &09, &23, &01, &32, &25  ; 9F94: 01 02 31... ..1
 EQUB &01, &00, &89, &74, &DA, &B5, &21, &1F  ; 9F9C: 01 00 89... ...
 EQUB &85, &21, &22, &51, &00, &C8, &B2, &44  ; 9FA4: 85 21 22... .!"
 EQUB &B2, &F4, &A8, &7D, &44, &03, &20, &00  ; 9FAC: B2 F4 A8... ...
 EQUB &A0, &00, &53, &21, &21, &8A, &35, &27  ; 9FB4: A0 00 53... ..S
 EQUB &0A, &15, &4A, &01, &80, &02, &21, &24  ; 9FBC: 0A 15 4A... ..J
 EQUB &50, &20, &82, &21, &08, &40, &04, &20  ; 9FC4: 50 20 82... P .
 EQUB &06, &21, &11, &02, &21, &08, &42, &00  ; 9FCC: 06 21 11... .!.
 EQUB &21, &02, &42, &02, &3B, &22, &02, &FA  ; 9FD4: 21 02 42... !.B
 EQUB &37, &5A, &24, &49, &13, &80, &09, &27  ; 9FDC: 37 5A 24... 7Z$
 EQUB &43, &A6, &5F, &AC, &F0, &02, &41, &00  ; 9FE4: 43 A6 5F... C._
 EQUB &80, &04, &80, &34, &24, &01, &00, &08  ; 9FEC: 80 04 80... ...
 EQUB &00, &10, &80, &21, &04, &42, &10, &00  ; 9FF4: 00 10 80... ...
 EQUB &21, &01, &40, &32, &08, &02, &03, &10  ; 9FFC: 21 01 40... !.@
 EQUB &21, &01, &02, &10, &21, &02, &00, &40  ; A004: 21 01 02... !..
 EQUB &21, &04, &03, &59, &00, &21, &02, &47  ; A00C: 21 04 03... !..
 EQUB &33, &3A, &27, &2F, &5F, &FF, &5F, &20  ; A014: 33 3A 27... 3:'
 EQUB &21, &02, &E0, &21, &24, &A0, &D0, &E8  ; A01C: 21 02 E0... !..
 EQUB &D1, &40, &21, &08, &80, &02, &21, &0C  ; A024: D1 40 21... .@!
 EQUB &86, &C0, &03, &21, &03, &00, &80, &50  ; A02C: 86 C0 03... ...
 EQUB &88, &20, &00, &20, &33, &08, &1F, &07  ; A034: 88 20 00... . .
 EQUB &02, &20, &03, &80, &C0, &E0, &00, &38  ; A03C: 02 20 03... . .
 EQUB &01, &02, &01, &80, &05, &01, &0A, &01  ; A044: 01 02 01... ...
 EQUB &00, &50, &21, &22, &50, &80, &41, &3E  ; A04C: 00 50 21... .P!
 EQUB &24, &01, &2F, &27, &3A, &04, &09, &02  ; A054: 24 01 2F... $./
 EQUB &07, &0B, &80, &04, &2E, &54, &21, &19  ; A05C: 07 0B 80... ...
 EQUB &00, &40, &21, &08, &20, &32, &18, &0D  ; A064: 00 40 21... .@!
 EQUB &C7, &E7, &FB, &FD, &6F, &34, &14, &0B  ; A06C: C7 E7 FB... ...
 EQUB &02, &0F, &85, &C2, &E1, &70, &02, &A0  ; A074: 02 0F 85... ...
 EQUB &10, &80, &C0, &70, &30, &08, &21, &0A  ; A07C: 10 80 C0... ...
 EQUB &00, &10, &00, &42, &00, &21, &07, &03  ; A084: 00 10 00... ...
 EQUB &40, &02, &20, &02, &22, &07, &33, &04  ; A08C: 40 02 20... @.
 EQUB &01, &08, &03, &B0, &64, &80, &21, &03  ; A094: 01 08 03... ...
 EQUB &04, &21, &22, &03, &80, &00, &20, &00  ; A09C: 04 21 22... .!"
 EQUB &EC, &F0, &50, &20, &32, &08, &04, &02  ; A0A4: EC F0 50... ..P
 EQUB &33, &0C, &04, &02, &0D, &21, &02, &03  ; A0AC: 33 0C 04... 3..
 EQUB &10, &02, &80, &0F, &0F, &0F, &0C, &20  ; A0B4: 10 02 80... ...
 EQUB &84, &10, &88, &20, &21, &08, &70, &0F  ; A0BC: 84 10 88... ...
 EQUB &0F, &0F, &0B, &3F, &0F, &0F, &0F, &0F  ; A0C4: 0F 0F 0B... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; A0CC: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; A0D4: 0F 0F 0F... ...
 EQUB &09, &33, &01, &07, &0E, &05, &33, &01  ; A0DC: 09 33 01... .3.
 EQUB &06, &0C, &03, &32, &07, &3F, &F3, &79  ; A0E4: 06 0C 03... ...
 EQUB &21, &3F, &03, &32, &06, &32, &E1, &30  ; A0EC: 21 3F 03... !?.
 EQUB &21, &1A, &02, &7F, &FC, &FF, &7F, &AF  ; A0F4: 21 1A 02... !..
 EQUB &77, &02, &71, &F8, &46, &33, &29, &07  ; A0FC: 77 02 71... w.q
 EQUB &02, &02, &DE, &B7, &E0, &78, &12, &02  ; A104: 02 02 DE... ...
 EQUB &21, &06, &20, &80, &60, &F4, &21, &39  ; A10C: 21 06 20... !.
 EQUB &03, &E0, &7C, &32, &3F, &1E, &FF, &03  ; A114: 03 E0 7C... ..|
 EQUB &A0, &34, &14, &0B, &06, &03, &0F, &0F  ; A11C: A0 34 14... .4.
 EQUB &04, &36, &01, &03, &06, &0D, &18, &34  ; A124: 04 36 01... .6.
 EQUB &02, &34, &01, &02, &04, &08, &10, &20  ; A12C: 02 34 01... .4.
 EQUB &21, &3F, &7B, &D1, &AB, &E6, &FF, &BF  ; A134: 21 3F 7B... !?{
 EQUB &F6, &21, &3A, &51, &00, &21, &21, &84  ; A13C: F6 21 3A... .!:
 EQUB &6E, &21, &1E, &42, &3F, &DF, &E7, &F2  ; A144: 6E 21 1E... n!.
 EQUB &36, &38, &18, &04, &02, &90, &04, &82  ; A14C: 36 38 18... 68.
 EQUB &20, &10, &04, &EB, &F4, &FD, &F0, &7A  ; A154: 20 10 04...  ..
 EQUB &32, &3D, &1E, &8F, &48, &A4, &30, &60  ; A15C: 32 3D 1E... 2=.
 EQUB &30, &33, &1C, &08, &04, &FF, &EF, &5F  ; A164: 30 33 1C... 03.
 EQUB &EC, &7F, &21, &3F, &8F, &CF, &F3, &37  ; A16C: EC 7F 21... ..!
 EQUB &29, &1E, &44, &23, &19, &06, &03, &FE  ; A174: 29 1E 44... ).D
 EQUB &7F, &DB, &EF, &6F, &B2, &70, &F9, &D4  ; A17C: 7F DB EF... ...
 EQUB &6F, &5B, &AD, &4F, &B2, &30, &89, &0F  ; A184: 6F 5B AD... o[.
 EQUB &04, &35, &01, &03, &07, &07, &0A, &03  ; A18C: 04 35 01... .5.
 EQUB &35, &01, &02, &04, &05, &0A, &78, &F8  ; A194: 35 01 02... 5..
 EQUB &FB, &FE, &B7, &FB, &FF, &EF, &40, &C8  ; A19C: FB FE B7... ...
 EQUB &B0, &70, &A4, &CB, &83, &AD, &4F, &9B  ; A1A4: B0 70 A4... .p.
 EQUB &77, &FC, &12, &FA, &EF, &33, &01, &0A  ; A1AC: 77 FC 12... w..
 EQUB &01, &5C, &FC, &21, &27, &F2, &EF, &DD  ; A1B4: 01 5C FC... .\.
 EQUB &FF, &FB, &FD, &7F, &FD, &DF, &F7, &88  ; A1BC: FF FB FD... ...
 EQUB &6C, &21, &3B, &5D, &21, &1E, &85, &8B  ; A1C4: 6C 21 3B... l!;
 EQUB &D5, &32, &11, &0F, &AE, &DF, &F7, &FB  ; A1CC: D5 32 11... .2.
 EQUB &7F, &DF, &32, &11, &0B, &00, &83, &40  ; A1D4: 7F DF 32... ..2
 EQUB &71, &48, &DA, &F3, &FB, &FD, &5F, &FF  ; A1DC: 71 48 DA... qH.
 EQUB &ED, &F2, &B9, &21, &11, &A8, &F8, &54  ; A1E4: ED F2 B9... ...
 EQUB &FE, &6D, &F2, &21, &39, &FC, &A6, &DE  ; A1EC: FE 6D F2... .m.
 EQUB &E5, &F0, &D0, &68, &B4, &5C, &A6, &5E  ; A1F4: E5 F0 D0... ...
 EQUB &A5, &70, &50, &21, &28, &B4, &0F, &01  ; A1FC: A5 70 50... .pP
 EQUB &3E, &03, &15, &07, &05, &29, &03, &04  ; A204: 3E 03 15... >..
 EQUB &48, &03, &15, &07, &05, &29, &03, &21  ; A20C: 48 03 15... H..
 EQUB &04, &48, &DD, &77, &FF, &7D, &AF, &FA  ; A214: 04 48 DD... .H.
 EQUB &9B, &65, &D5, &53, &8E, &55, &AB, &FA  ; A21C: 9B 65 D5... .e.
 EQUB &9B, &65, &12, &DF, &EF, &F9, &BF, &D7  ; A224: 9B 65 12... .e.
 EQUB &7B, &BB, &FD, &DF, &6D, &D9, &BE, &D7  ; A22C: 7B BB FD... {..
 EQUB &7B, &FE, &6F, &BF, &7F, &DD, &CD, &FB  ; A234: 7B FE 6F... {.o
 EQUB &BF, &D6, &6B, &BD, &7F, &89, &CD, &6B  ; A23C: BF D6 6B... ..k
 EQUB &B1, &EF, &E7, &BA, &DD, &EF, &B7, &53  ; A244: B1 EF E7... ...
 EQUB &BB, &EE, &C7, &AA, &55, &EA, &B4, &51  ; A24C: BB EE C7... ...
 EQUB &BB, &FC, &FF, &E7, &21, &38, &9C, &8A  ; A254: BB FC FF... ...
 EQUB &E4, &71, &6C, &21, &3F, &E7, &21, &18  ; A25C: E4 71 6C... .ql
 EQUB &9C, &8A, &E4, &71, &42, &20, &90, &C4  ; A264: 9C 8A E4... ...
 EQUB &20, &10, &80, &21, &04, &42, &20, &90  ; A26C: 20 10 80...  ..
 EQUB &C4, &20, &10, &80, &21, &04, &0F, &02  ; A274: C4 20 10... . .
 EQUB &20, &52, &21, &04, &80, &02, &21, &08  ; A27C: 20 52 21...  R!
 EQUB &00, &20, &52, &21, &04, &80, &02, &21  ; A284: 00 20 52... . R
 EQUB &08, &8A, &6C, &21, &12, &05, &8A, &6C  ; A28C: 08 8A 6C... ..l
 EQUB &21, &12, &05, &E4, &9A, &32, &2C, &16  ; A294: 21 12 05... !..
 EQUB &41, &00, &21, &04, &00, &E4, &9A, &32  ; A29C: 41 00 21... A.!
 EQUB &2C, &16, &41, &00, &21, &04, &00, &DF  ; A2A4: 2C 16 41... ,.A
 EQUB &4B, &A7, &21, &13, &80, &48, &21, &02  ; A2AC: 4B A7 21... K.!
 EQUB &20, &DB, &4A, &A7, &21, &13, &80, &48  ; A2B4: 20 DB 4A...  .J
 EQUB &21, &02, &20, &DF, &E9, &B9, &4C, &82  ; A2BC: 21 02 20... !.
 EQUB &49, &00, &21, &02, &5E, &E9, &B9, &4C  ; A2C4: 49 00 21... I.!
 EQUB &82, &49, &00, &21, &02, &EA, &A7, &83  ; A2CC: 82 49 00... .I.
 EQUB &C1, &34, &24, &08, &04, &08, &EA, &A7  ; A2D4: C1 34 24... .4$
 EQUB &83, &C1, &34, &24, &08, &04, &08, &40  ; A2DC: 83 C1 34... ..4
 EQUB &20, &80, &90, &48, &00, &84, &00, &40  ; A2E4: 20 80 90...  ..
 EQUB &20, &80, &90, &48, &00, &84, &00, &3F  ; A2EC: 20 80 90...  ..
 EQUB &02, &36, &08, &01, &04, &00, &02, &08  ; A2F4: 02 36 08... .6.
 EQUB &02, &21, &04, &02, &80, &0F, &02, &21  ; A2FC: 02 21 04... .!.
 EQUB &01, &09, &40, &80, &21, &24, &42, &EF  ; A304: 01 09 40... ..@
 EQUB &F8, &E1, &05, &21, &08, &50, &B0, &08  ; A30C: F8 E1 05... ...
 EQUB &21, &01, &06, &21, &04, &03, &10, &05  ; A314: 21 01 06... !..
 EQUB &21, &02, &00, &32, &01, &04, &10, &02  ; A31C: 21 02 00... !..
 EQUB &21, &08, &40, &10, &00, &40, &0B, &78  ; A324: 21 08 40... !.@
 EQUB &7C, &33, &3F, &19, &07, &02, &10, &B8  ; A32C: 7C 33 3F... |3?
 EQUB &5C, &8C, &F8, &B0, &08, &21, &08, &08  ; A334: 5C 8C F8... \..
 EQUB &20, &0F, &0A, &21, &01, &0A, &20, &03  ; A33C: 20 0F 0A...  ..
 EQUB &21, &04, &0D, &21, &08, &00, &10, &03  ; A344: 21 04 0D... !..
 EQUB &21, &02, &08, &31, &08, &23, &07, &24  ; A34C: 21 02 08... !..
 EQUB &10, &21, &3A, &13, &04, &20, &23, &C0  ; A354: 10 21 3A... .!:
 EQUB &21, &08, &02, &21, &02, &00, &20, &02  ; A35C: 21 08 02... !..
 EQUB &32, &0E, &04, &07, &21, &02, &0A, &10  ; A364: 32 0E 04... 2..
 EQUB &02, &20, &08, &22, &07, &21, &0F, &80  ; A36C: 02 20 08... . .
 EQUB &34, &01, &03, &00, &0B, &12, &21, &1E  ; A374: 34 01 03... 4..
 EQUB &60, &F3, &FE, &21, &3D, &D0, &22, &C0  ; A37C: 60 F3 FE... `..
 EQUB &40, &00, &A2, &C8, &00, &30, &03, &21  ; A384: 40 00 A2... @..
 EQUB &1C, &05, &32, &01, &04, &06, &83, &06  ; A38C: 1C 05 32... ..2
 EQUB &80, &0F, &21, &01, &0F, &0F, &0F, &0F  ; A394: 80 0F 21... ..!
 EQUB &0F, &0F, &0F, &0E, &3F, &20, &82, &00  ; A39C: 0F 0F 0F... ...
 EQUB &20, &21, &04, &10, &21, &02, &00, &10  ; A3A4: 20 21 04...  !.
 EQUB &00, &40, &10, &32, &01, &24, &00, &40  ; A3AC: 00 40 10... .@.
 EQUB &00, &20, &80, &21, &08, &02, &44, &21  ; A3B4: 00 20 80... . .
 EQUB &01, &02, &21, &04, &00, &21, &01, &84  ; A3BC: 01 02 21... ..!
 EQUB &10, &02, &31, &21, &23, &01, &41, &32  ; A3C4: 10 02 31... ..1
 EQUB &01, &08, &F0, &A1, &77, &DB, &AD, &10  ; A3CC: 01 08 F0... ...
 EQUB &47, &5A, &40, &80, &E4, &21, &18, &C8  ; A3D4: 47 5A 40... GZ@
 EQUB &F5, &AE, &4C, &00, &20, &04, &21, &24  ; A3DC: F5 AE 4C... ..L
 EQUB &02, &21, &14, &00, &48, &03, &21, &04  ; A3E4: 02 21 14... .!.
 EQUB &00, &20, &81, &21, &04, &02, &21, &04  ; A3EC: 00 20 81... . .
 EQUB &00, &80, &00, &10, &21, &01, &40, &21  ; A3F4: 00 80 00... ...
 EQUB &01, &84, &20, &00, &40, &21, &12, &00  ; A3FC: 01 84 20... ..
 EQUB &21, &08, &00, &21, &04, &40, &00, &40  ; A404: 21 08 00... !..
 EQUB &00, &80, &00, &21, &08, &00, &20, &A5  ; A40C: 00 80 00... ...
 EQUB &21, &3B, &5C, &33, &26, &0B, &03, &02  ; A414: 21 3B 5C... !;\
 EQUB &46, &21, &23, &52, &87, &4C, &F0, &02  ; A41C: 46 21 23... F!#
 EQUB &40, &00, &82, &04, &21, &02, &00, &40  ; A424: 40 00 82... @..
 EQUB &05, &21, &01, &10, &03, &40, &05, &10  ; A42C: 05 21 01... .!.
 EQUB &00, &24, &10, &06, &41, &06, &21, &08  ; A434: 00 24 10... .$.
 EQUB &06, &21, &01, &00, &21, &04, &40, &00  ; A43C: 06 21 01... .!.
 EQUB &10, &03, &21, &01, &00, &21, &08, &00  ; A444: 10 03 21... ..!
 EQUB &21, &08, &02, &40, &21, &01, &00, &80  ; A44C: 21 08 02... !..
 EQUB &21, &08, &02, &20, &00, &21, &08, &00  ; A454: 21 08 02... !..
 EQUB &42, &00, &50, &00, &10, &34, &04, &0C  ; A45C: 42 00 50... B.P
 EQUB &83, &03, &02, &32, &29, &3B, &D5, &7C  ; A464: 83 03 02... ...
 EQUB &12, &80, &21, &04, &00, &10, &40, &60  ; A46C: 12 80 21... ..!
 EQUB &81, &80, &02, &10, &80, &02, &21, &04  ; A474: 81 80 02... ...
 EQUB &00, &21, &04, &80, &21, &24, &00, &82  ; A47C: 00 21 04... .!.
 EQUB &20, &21, &04, &80, &03, &3A, &08, &01  ; A484: 20 21 04...  !.
 EQUB &20, &04, &90, &02, &20, &09, &40, &02  ; A48C: 20 04 90...  ..
 EQUB &02, &20, &21, &08, &07, &8B, &37, &1F  ; A494: 02 20 21... . !
 EQUB &37, &98, &01, &03, &00, &0B, &12, &21  ; A49C: 37 98 01... 7..
 EQUB &1E, &60, &F3, &FE, &21, &3D, &D0, &A0  ; A4A4: 1E 60 F3... .`.
 EQUB &F8, &4C, &00, &A2, &C8, &00, &30, &10  ; A4AC: F8 4C 00... .L.
 EQUB &21, &22, &00, &21, &1C, &05, &32, &01  ; A4B4: 21 22 00... !".
 EQUB &04, &06, &83, &06, &80, &0F, &21, &01  ; A4BC: 04 06 83... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0E  ; A4C4: 0F 0F 0F... ...
 EQUB &3F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; A4CC: 3F 0F 0F... ?..
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; A4D4: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F  ; A4DC: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0D, &3F  ; A4E4: 0F 0F 0F... ...
 EQUB &0F, &0F, &0F, &09, &21, &31, &DC, &06  ; A4EC: 0F 0F 0F... ...
 EQUB &21, &31, &84, &00, &80, &F0, &7B, &A5  ; A4F4: 21 31 84... !1.
 EQUB &00, &55, &21, &0F, &00, &22, &80, &72  ; A4FC: 00 55 21... .U!
 EQUB &A5, &00, &55, &21, &0E, &03, &47, &E6  ; A504: A5 00 55... ..U
 EQUB &5C, &21, &3F, &F4, &03, &46, &C4, &50  ; A50C: 5C 21 3F... \!?
 EQUB &21, &3D, &80, &02, &E1, &9F, &34, &0C  ; A514: 21 3D 80... !=.
 EQUB &01, &C2, &2F, &02, &20, &21, &08, &06  ; A51C: 01 C2 2F... ../
 EQUB &B0, &FF, &5D, &21, &37, &FF, &CF, &02  ; A524: B0 FF 5D... ..]
 EQUB &B0, &4D, &02, &21, &15, &04, &E3, &13  ; A52C: B0 4D 02... .M.
 EQUB &F8, &05, &A5, &7F, &F8, &00, &32, &02  ; A534: F8 05 A5... ...
 EQUB &1B, &FE, &E8, &80, &F4, &02, &33, &02  ; A53C: 1B FE E8... ...
 EQUB &11, &26, &E8, &80, &F4, &00, &21, &03  ; A544: 11 26 E8... .&.
 EQUB &7C, &32, &04, &08, &03, &35, &03, &02  ; A54C: 7C 32 04... |2.
 EQUB &38, &04, &08, &04, &78, &B0, &20, &02  ; A554: 38 04 08... 8..
 EQUB &34, &02, &0F, &9C, &28, &90, &20, &02  ; A55C: 34 02 0F... 4..
 EQUB &36, &02, &0B, &94, &01, &17, &02, &C1  ; A564: 36 02 0B... 6..
 EQUB &60, &21, &09, &00, &34, &0C, &01, &17  ; A56C: 60 21 09... `!.
 EQUB &02, &C1, &60, &21, &09, &00, &21, &0C  ; A574: 02 C1 60... ..`
 EQUB &7E, &12, &5F, &21, &2B, &7F, &00, &21  ; A57C: 7E 12 5F... ~._
 EQUB &15, &50, &FA, &FF, &54, &21, &2A, &7F  ; A584: 15 50 FA... .P.
 EQUB &00, &21, &15, &15, &FD, &A8, &FF, &57  ; A58C: 00 21 15... .!.
 EQUB &21, &0A, &57, &21, &03, &BF, &FD, &A8  ; A594: 21 0A 57... !.W
 EQUB &14, &40, &F5, &02, &40, &45, &E8, &FF  ; A59C: 14 40 F5... .@.
 EQUB &40, &F5, &02, &22, &40, &FD, &A0, &00  ; A5A4: 40 F5 02... @..
 EQUB &20, &03, &40, &5D, &A0, &00, &20, &04  ; A5AC: 20 03 40...  .@
 EQUB &32, &08, &1F, &30, &40, &04, &32, &08  ; A5B4: 32 08 1F... 2..
 EQUB &17, &20, &40, &03, &32, &07, &18, &00  ; A5BC: 17 20 40... . @
 EQUB &40, &04, &32, &03, &18, &00, &40, &04  ; A5C4: 40 04 32... @.2
 EQUB &C8, &60, &06, &C8, &60, &06, &21, &1E  ; A5CC: C8 60 06... .`.
 EQUB &63, &03, &21, &04, &20, &00, &21, &18  ; A5D4: 63 03 21... c.!
 EQUB &62, &03, &21, &04, &20, &03, &C0, &21  ; A5DC: 62 03 21... b.!
 EQUB &08, &02, &C0, &03, &C0, &21, &08, &02  ; A5E4: 08 02 C0... ...
 EQUB &C0, &00, &A0, &07, &A0, &07, &33, &03  ; A5EC: C0 00 A0... ...
 EQUB &2F, &02, &10, &04, &33, &03, &2C, &02  ; A5F4: 2F 02 10... /..
 EQUB &10, &04, &20, &F4, &06, &20, &D4, &08  ; A5FC: 10 04 20... ..
 EQUB &32, &02, &04, &20, &05, &32, &02, &04  ; A604: 32 02 04... 2..
 EQUB &20, &06, &20, &07, &20, &05, &40, &00  ; A60C: 20 06 20...  .
 EQUB &21, &08, &05, &40, &00, &21, &08, &04  ; A614: 21 08 05... !..
 EQUB &3F, &02, &80, &C0, &E0, &70, &B8, &5C  ; A61C: 3F 02 80... ?..
 EQUB &0F, &0F, &01, &21, &02, &0F, &09, &AE  ; A624: 0F 0F 01... ...
 EQUB &D7, &6B, &35, &34, &1B, &0D, &06, &03  ; A62C: D7 6B 35... .k5
 EQUB &00, &80, &C0, &E0, &70, &B8, &5C, &AE  ; A634: 00 80 C0... ...
 EQUB &0F, &03, &21, &04, &00, &21, &08, &30  ; A63C: 0F 03 21... ..!
 EQUB &10, &E0, &0C, &20, &0B, &21, &01, &04  ; A644: 10 E0 0C... ...
 EQUB &40, &02, &D7, &7B, &36, &3D, &1E, &1F  ; A64C: 40 02 D7... @..
 EQUB &0F, &47, &0B, &00, &80, &C0, &70, &21  ; A654: 0F 47 0B... .G.
 EQUB &38, &9C, &DE, &EF, &00, &33, &05, &02  ; A65C: 38 9C DE... 8..
 EQUB &1C, &10, &40, &02, &40, &80, &05, &20  ; A664: 1C 10 40... ..@
 EQUB &0F, &0F, &06, &20, &00, &80, &00, &F3  ; A66C: 0F 0F 06... ...
 EQUB &7D, &36, &3E, &1B, &0D, &06, &03, &01  ; A674: 7D 36 3E... }6>
 EQUB &80, &C0, &E0, &70, &B8, &DC, &6E, &B7  ; A67C: 80 C0 E0... ...
 EQUB &00, &21, &08, &20, &08, &35, &01, &05  ; A684: 00 21 08... .!.
 EQUB &80, &02, &02, &05, &22, &80, &40, &08  ; A68C: 80 02 02... ...
 EQUB &21, &08, &07, &20, &0F, &DB, &6D, &35  ; A694: 21 08 07... !..
 EQUB &32, &0D, &06, &03, &01, &00, &80, &E0  ; A69C: 32 0D 06... 2..
 EQUB &F0, &78, &BC, &6F, &B7, &CB, &00, &25  ; A6A4: F0 78 BC... .x.
 EQUB &01, &81, &C3, &C0, &22, &20, &70, &22  ; A6AC: 01 81 C3... ...
 EQUB &90, &98, &A8, &21, &02, &03, &40, &0D  ; A6B4: 90 98 A8... ...
 EQUB &40, &05, &20, &0E, &21, &08, &75, &35  ; A6BC: 40 05 20... @.
 EQUB &1B, &0D, &07, &03, &01, &02, &FF, &7F  ; A6C4: 1B 0D 07... ...
 EQUB &BF, &4F, &B0, &CF, &70, &21, &3E, &A8  ; A6CC: BF 4F B0... .O.
 EQUB &AC, &A4, &64, &E4, &C4, &33, &0C, &18  ; A6D4: AC A4 64... ..d
 EQUB &08, &0F, &0E, &40, &00, &32, &1C, &08  ; A6DC: 08 0F 0E... ...
 EQUB &00, &40, &0C, &32, &0F, &01, &06, &F8  ; A6E4: 00 40 0C... .@.
 EQUB &E0, &0A, &21, &08, &03, &3F, &02, &80  ; A6EC: E0 0A 21... ..!
 EQUB &C0, &60, &30, &98, &4C, &0F, &09, &21  ; A6F4: C0 60 30... .`0
 EQUB &01, &00, &22, &01, &35, &04, &02, &02  ; A6FC: 01 00 22... .."
 EQUB &04, &22, &02, &10, &02, &21, &12, &00  ; A704: 04 22 02... .".
 EQUB &35, &08, &01, &04, &20, &08, &80, &00  ; A70C: 35 08 01... 5..
 EQUB &21, &01, &10, &00, &40, &02, &21, &02  ; A714: 21 01 10... !..
 EQUB &02, &A6, &5B, &36, &2D, &17, &0B, &05  ; A71C: 02 A6 5B... ..[
 EQUB &02, &01, &00, &80, &C0, &60, &B0, &D8  ; A724: 02 01 00... ...
 EQUB &6C, &B6, &0E, &37, &02, &01, &12, &0E  ; A72C: 6C B6 0E... l..
 EQUB &18, &4C, &32, &C8, &60, &00, &21, &08  ; A734: 18 4C 32... .L2
 EQUB &00, &20, &03, &21, &04, &80, &00, &40  ; A73C: 00 20 03... . .
 EQUB &03, &21, &02, &02, &32, &08, &01, &02  ; A744: 03 21 02... .!.
 EQUB &10, &32, &01, &08, &02, &80, &40, &20  ; A74C: 10 32 01... .2.
 EQUB &33, &08, &06, &01, &00, &5B, &89, &40  ; A754: 33 08 06... 3..
 EQUB &20, &21, &08, &46, &A2, &21, &11, &00  ; A75C: 20 21 08...  !.
 EQUB &80, &60, &99, &44, &21, &21, &90, &74  ; A764: 80 60 99... .`.
 EQUB &21, &12, &8A, &75, &20, &E8, &A0, &80  ; A76C: 21 12 8A... !..
 EQUB &00, &80, &00, &21, &04, &02, &21, &08  ; A774: 00 80 00... ...
 EQUB &03, &40, &20, &30, &00, &21, &18, &00  ; A77C: 03 40 20... .@
 EQUB &21, &0C, &10, &02, &80, &00, &21, &01  ; A784: 21 0C 10... !..
 EQUB &00, &21, &02, &20, &00, &90, &00, &4A  ; A78C: 00 21 02... .!.
 EQUB &03, &21, &01, &80, &00, &36, &04, &01  ; A794: 03 21 01... .!.
 EQUB &40, &04, &00, &01, &04, &21, &01, &10  ; A79C: 40 04 00... @..
 EQUB &21, &04, &BD, &DE, &47, &34, &0B, &05  ; A7A4: 21 04 BD... !..
 EQUB &02, &01, &20, &00, &80, &44, &A0, &D0  ; A7AC: 02 01 20... ..
 EQUB &E8, &75, &BB, &00, &80, &02, &21, &08  ; A7B4: E8 75 BB... .u.
 EQUB &02, &80, &10, &3E, &06, &08, &06, &03  ; A7BC: 02 80 10... ...
 EQUB &06, &01, &21, &00, &01, &00, &04, &80  ; A7C4: 06 01 21... ..!
 EQUB &12, &C0, &38, &08, &01, &40, &04, &00  ; A7CC: 12 C0 38... ..8
 EQUB &02, &00, &08, &00, &40, &00, &21, &11  ; A7D4: 02 00 08... ...
 EQUB &80, &03, &21, &01, &03, &10, &09, &21  ; A7DC: 80 03 21... ..!
 EQUB &08, &02, &5D, &35, &2E, &13, &1D, &0E  ; A7E4: 08 02 5D... ..]
 EQUB &05, &02, &C0, &C2, &60, &B0, &DA, &54  ; A7EC: 05 02 C0... ...
 EQUB &BA, &4D, &21, &03, &00, &22, &01, &32  ; A7F4: BA 4D 21... .M!
 EQUB &08, &02, &46, &BD, &60, &84, &B0, &A0  ; A7FC: 08 02 46... ..F
 EQUB &50, &D9, &D0, &E8, &20, &00, &10, &00  ; A804: 50 D9 D0... P..
 EQUB &21, &08, &00, &20, &03, &20, &32, &04  ; A80C: 21 08 00... !..
 EQUB &01, &80, &02, &21, &04, &00, &32, &08  ; A814: 01 80 02... ...
 EQUB &02, &20, &00, &40, &21, &09, &02, &21  ; A81C: 02 20 00... . .
 EQUB &08, &08, &20, &02, &21, &08, &00, &35  ; A824: 08 08 20... ..
 EQUB &36, &3A, &1D, &0B, &01, &02, &21, &04  ; A82C: 36 3A 1D... 6:.
 EQUB &E3, &FF, &DF, &76, &BF, &CF, &F0, &5E  ; A834: E3 FF DF... ...
 EQUB &ED, &E8, &64, &A4, &64, &C4, &32, &08  ; A83C: ED E8 64... ..d
 EQUB &1C, &40, &00, &41, &10, &34, &04, &01  ; A844: 1C 40 00... .@.
 EQUB &00, &02, &02, &21, &02, &40, &21, &11  ; A84C: 00 02 02... ...
 EQUB &84, &20, &21, &08, &20, &21, &04, &90  ; A854: 84 20 21... . !
 EQUB &00, &20, &00, &80, &00, &21, &08, &40  ; A85C: 00 20 00... . .
 EQUB &06, &21, &08, &00, &21, &08, &07, &21  ; A864: 06 21 08... .!.
 EQUB &02, &00, &36, &24, &01, &08, &00, &13  ; A86C: 02 00 36... ..6
 EQUB &02, &02, &20, &21, &04, &00, &20, &F0  ; A874: 02 02 20... ..
 EQUB &21, &11, &02, &44, &00, &20, &02, &21  ; A87C: 21 11 02... !..
 EQUB &01, &00, &21, &02, &00, &33, &01, &08  ; A884: 01 00 21... ..!
 EQUB &22, &3F, &FF, &7F, &36, &3F, &1F, &0F  ; A88C: 22 3F FF... "?.
 EQUB &07, &03, &01, &84, &50, &21, &02, &00  ; A894: 07 03 01... ...
 EQUB &33, &02, &01, &02, &81, &18, &91, &00  ; A89C: 33 02 01... 3..
 EQUB &20, &10, &34, &0C, &06, &A3, &01, &15  ; A8A4: 20 10 34...  .4
 EQUB &FD, &FF, &7F, &21, &11, &88, &46, &33  ; A8AC: FD FF 7F... ...
 EQUB &1A, &2F, &15, &BF, &5B, &13, &EF, &FA  ; A8B4: 1A 2F 15... ./.
 EQUB &EE, &EB, &BC, &21, &23, &8C, &77, &AB  ; A8BC: EE EB BC... ...
 EQUB &7A, &AE, &CB, &BC, &40, &80, &40, &22  ; A8C4: 7A AE CB... z..
 EQUB &80, &40, &00, &80, &40, &80, &40, &22  ; A8CC: 80 40 00... .@.
 EQUB &80, &40, &00, &80, &0F, &0F, &0F, &06  ; A8D4: 80 40 00... .@.
 EQUB &80, &C0, &E0, &F0, &58, &40, &20, &10  ; A8DC: 80 C0 E0... ...
 EQUB &88, &44, &E2, &F1, &58, &7F, &36, &3F  ; A8E4: 88 44 E2... .D.
 EQUB &0F, &06, &05, &02, &01, &00, &4B, &35  ; A8EC: 0F 06 05... ...
 EQUB &25, &0B, &06, &05, &02, &81, &40, &BF  ; A8F4: 25 0B 06... %..
 EQUB &EB, &A6, &D1, &DC, &A8, &21, &14, &80  ; A8FC: EB A6 D1... ...
 EQUB &BF, &EB, &21, &26, &D1, &DC, &A8, &21  ; A904: BF EB 21... ..!
 EQUB &14, &80, &52, &A8, &CC, &80, &50, &03  ; A90C: 14 80 52... ..R
 EQUB &52, &A8, &CC, &80, &50, &0F, &0F, &0F  ; A914: 52 A8 CC... R..
 EQUB &09, &21, &02, &07, &21, &02, &04, &21  ; A91C: 09 21 02... .!.
 EQUB &24, &10, &05, &20, &21, &24, &10, &05  ; A924: 24 10 05... $..
 EQUB &20, &08, &20, &07, &20, &07, &20, &0F  ; A92C: 20 08 20...  .
 EQUB &0F, &0F, &06, &10, &00, &21, &08, &0F  ; A934: 0F 0F 06... ...
 EQUB &02, &33, &04, &01, &00, &23, &04, &20  ; A93C: 02 33 04... .3.
 EQUB &00, &36, &04, &01, &00, &04, &00, &04  ; A944: 00 36 04... .6.
 EQUB &20, &00, &21, &08, &00, &20, &02, &10  ; A94C: 20 00 21...  .!
 EQUB &02, &21, &08, &00, &20, &02, &10, &0F  ; A954: 02 21 08... .!.
 EQUB &0E, &33, &04, &02, &01, &0F, &01, &80  ; A95C: 0E 33 04... .3.
 EQUB &40, &3F, &08, &80, &0F, &21, &04, &00  ; A964: 40 3F 08... @?.
 EQUB &21, &02, &02, &21, &01, &09, &21, &01  ; A96C: 21 02 02... !..
 EQUB &07, &81, &88, &22, &80, &10, &80, &00  ; A974: 07 81 88... ...
 EQUB &40, &00, &88, &00, &80, &10, &80, &00  ; A97C: 40 00 88... @..
 EQUB &40, &0F, &0F, &0F, &0C, &20, &10, &33  ; A984: 40 0F 0F... @..
 EQUB &0C, &02, &01, &0F, &01, &80, &40, &30  ; A98C: 0C 02 01... ...
 EQUB &0F, &04, &21, &02, &05, &22, &40, &21  ; A994: 0F 04 21... ..!
 EQUB &02, &23, &20, &10, &00, &80, &07, &80  ; A99C: 02 23 20... .#
 EQUB &0A, &10, &21, &04, &20, &21, &09, &04  ; A9A4: 0A 10 21... ..!
 EQUB &10, &21, &04, &20, &21, &09, &0F, &0F  ; A9AC: 10 21 04... .!.
 EQUB &0F, &0B, &33, &08, &04, &02, &0F, &01  ; A9B4: 0F 0B 33... ..3
 EQUB &80, &40, &30, &32, &0F, &01, &08, &22  ; A9BC: 80 40 30... .@0
 EQUB &10, &23, &18, &21, &38, &F0, &E0, &0F  ; A9C4: 10 23 18... .#.
 EQUB &01, &20, &84, &10, &05, &20, &84, &10  ; A9CC: 01 20 84... . .
 EQUB &0F, &0F, &0F, &0F, &0A, &80, &10, &80  ; A9D4: 0F 0F 0F... ...
 EQUB &05, &80, &10, &80, &0F, &0F, &06, &3F  ; A9DC: 05 80 10... ...
 EQUB &00, &40, &00, &10, &00, &21, &04, &0B  ; A9E4: 00 40 00... .@.
 EQUB &21, &02, &0F, &21, &02, &0F, &21, &02  ; A9EC: 21 02 0F... !..
 EQUB &08, &21, &08, &06, &80, &0F, &0D, &10  ; A9F4: 08 21 08... .!.
 EQUB &60, &0F, &0A, &21, &02, &10, &02, &21  ; A9FC: 60 0F 0A... `..
 EQUB &04, &00, &80, &06, &21, &08, &04, &40  ; AA04: 04 00 80... ...
 EQUB &32, &01, &0A, &BF, &7F, &02, &32, &05  ; AA0C: 32 01 0A... 2..
 EQUB &0E, &57, &13, &21, &01, &82, &57, &EF  ; AA14: 0E 57 13... .W.
 EQUB &7F, &FF, &F4, &E8, &00, &A0, &D0, &A0  ; AA1C: 7F FF F4... ...
 EQUB &40, &80, &20, &0F, &02, &21, &01, &02  ; AA24: 40 80 20... @.
 EQUB &10, &07, &39, &01, &03, &01, &22, &00  ; AA2C: 10 07 39... ..9
 EQUB &3F, &5F, &1E, &14, &A8, &40, &02, &FD  ; AA34: 3F 5F 1E... ?_.
 EQUB &E8, &80, &00, &21, &18, &80, &02, &40  ; AA3C: E8 80 00... ...
 EQUB &0F, &0F, &03, &21, &02, &0F, &0F, &05  ; AA44: 0F 0F 03... ...
 EQUB &32, &01, &0A, &06, &50, &EA, &05, &32  ; AA4C: 32 01 0A... 2..
 EQUB &11, &01, &43, &06, &80, &21, &01, &02  ; AA54: 11 01 43... ..C
 EQUB &22, &01, &33, &03, &06, &2C, &84, &02  ; AA5C: 22 01 33... ".3
 EQUB &22, &80, &21, &01, &03, &21, &02, &00  ; AA64: 22 80 21... ".!
 EQUB &32, &04, &08, &04, &50, &00, &21, &18  ; AA6C: 32 04 08... 2..
 EQUB &30, &40, &03, &57, &21, &0A, &00, &60  ; AA74: 30 40 03... 0@.
 EQUB &C0, &03, &F0, &C0, &33, &06, &1C, &24  ; AA7C: C0 03 F0... ...
 EQUB &03, &33, &02, &0C, &14, &05, &21, &03  ; AA84: 03 33 02... .3.
 EQUB &03, &21, &08, &03, &21, &14, &20, &09  ; AA8C: 03 21 08... .!.
 EQUB &10, &00, &32, &05, &23, &04, &21, &01  ; AA94: 10 00 32... ..2
 EQUB &82, &41, &8A, &21, &01, &03, &33, &04  ; AA9C: 82 41 8A... .A.
 EQUB &08, &04, &C1, &F0, &04, &20, &21, &08  ; AAA4: 08 04 C1... ...
 EQUB &A2, &F5, &03, &21, &28, &10, &21, &01  ; AAAC: A2 F5 03... ...
 EQUB &80, &E8, &04, &34, &02, &15, &2E, &07  ; AAB4: 80 E8 04... ...
 EQUB &06, &A8, &47, &04, &21, &02, &81, &21  ; AABC: 06 A8 47... ..G
 EQUB &22, &8D, &3F, &00, &A0, &00, &40, &21  ; AAC4: 22 8D 3F... ".?
 EQUB &01, &04, &21, &01, &40, &21, &04, &02  ; AACC: 01 04 21... ..!
 EQUB &40, &00, &20, &07, &20, &0F, &07, &21  ; AAD4: 40 00 20... @.
 EQUB &01, &00, &21, &05, &20, &21, &02, &02  ; AADC: 01 00 21... ..!
 EQUB &20, &32, &08, &04, &02, &21, &02, &20  ; AAE4: 20 32 08...  2.
 EQUB &00, &40, &21, &01, &40, &21, &04, &80  ; AAEC: 00 40 21... .@!
 EQUB &10, &00, &40, &0F, &09, &10, &60, &0F  ; AAF4: 10 00 40... ..@
 EQUB &02, &21, &04, &06, &20, &00, &80, &00  ; AAFC: 02 21 04... .!.
 EQUB &20, &00, &80, &02, &80, &04, &21, &08  ; AB04: 20 00 80...  ..
 EQUB &04, &40, &32, &01, &0A, &BF, &7F, &02  ; AB0C: 04 40 32... .@2
 EQUB &32, &05, &0E, &57, &13, &21, &01, &82  ; AB14: 32 05 0E... 2..
 EQUB &57, &EF, &7F, &FF, &F4, &E8, &00, &A0  ; AB1C: 57 EF 7F... W..
 EQUB &D0, &A0, &40, &80, &20, &0F, &03, &20  ; AB24: D0 A0 40... ..@
 EQUB &02, &80, &06, &39, &01, &03, &01, &22  ; AB2C: 02 80 06... ...
 EQUB &00, &3F, &5F, &1E, &14, &A8, &40, &02  ; AB34: 00 3F 5F... .?_
 EQUB &FD, &E8, &80, &00, &21, &18, &80, &02  ; AB3C: FD E8 80... ...
 EQUB &40, &0F, &0F, &01, &20, &05, &21, &08  ; AB44: 40 0F 0F... @..
 EQUB &0F, &0F, &01, &32, &01, &0A, &06, &50  ; AB4C: 0F 0F 01... ...
 EQUB &EA, &05, &10, &21, &02, &40, &05, &80  ; AB54: EA 05 10... ...
 EQUB &40, &A2, &22, &01, &34, &02, &12, &04  ; AB5C: 40 A2 22... @."
 EQUB &19, &52, &69, &22, &80, &40, &50, &E2  ; AB64: 19 52 69... .Ri
 EQUB &47, &8A, &35, &05, &02, &00, &0A, &17  ; AB6C: 47 8A 35... G.5
 EQUB &B5, &4A, &35, &01, &12, &50, &08, &24  ; AB74: B5 4A 35... .J5
 EQUB &4C, &B9, &D2, &E5, &88, &57, &21, &0A  ; AB7C: 4C B9 D2... L..
 EQUB &20, &90, &21, &3A, &E0, &48, &80, &F0  ; AB84: 20 90 21...  .!
 EQUB &C3, &38, &09, &22, &5A, &24, &89, &02  ; AB8C: C3 38 09... .8.
 EQUB &0D, &12, &AA, &D4, &21, &24, &20, &00  ; AB94: 0D 12 AA... ...
 EQUB &10, &C4, &8D, &00, &32, &06, &15, &63  ; AB9C: 10 C4 8D... ...
 EQUB &00, &84, &AA, &54, &EA, &44, &88, &00  ; ABA4: 00 84 AA... ...
 EQUB &32, &11, &02, &40, &BB, &7F, &EE, &D7  ; ABAC: 32 11 02... 2..
 EQUB &21, &3A, &D4, &AB, &88, &52, &B5, &EE  ; ABB4: 21 3A D4... !:.
 EQUB &75, &BE, &55, &AA, &5C, &AA, &FF, &DB  ; ABBC: 75 BE 55... u.U
 EQUB &B6, &DB, &33, &26, &0D, &15, &A8, &55  ; ABC4: B6 DB 33... ..3
 EQUB &BE, &DB, &B7, &5D, &32, &0A, &17, &AB  ; ABCC: BE DB B7... ...
 EQUB &7F, &D7, &AB, &EE, &43, &21, &14, &41  ; ABD4: 7F D7 AB... ...
 EQUB &A8, &C5, &21, &1F, &FD, &EA, &D1, &33  ; ABDC: A8 C5 21... ..!
 EQUB &38, &01, &2A, &45, &C2, &ED, &F3, &56  ; ABE4: 38 01 2A... 8.*
 EQUB &B8, &21, &17, &AA, &F5, &21, &3F, &ED  ; ABEC: B8 21 17... .!.
 EQUB &76, &DD, &52, &3F, &08, &48, &21, &01  ; ABF4: 76 DD 52... v.R
 EQUB &44, &02, &80, &20, &08, &21, &02, &10  ; ABFC: 44 02 80... D..
 EQUB &06, &21, &02, &04, &21, &02, &10, &80  ; AC04: 06 21 02... .!.
 EQUB &21, &08, &04, &21, &02, &10, &80, &21  ; AC0C: 21 08 04... !..
 EQUB &08, &06, &32, &01, &26, &06, &32, &01  ; AC14: 08 06 32... ..2
 EQUB &26, &04, &40, &00, &21, &01, &05, &40  ; AC1C: 26 04 40... &.@
 EQUB &00, &21, &01, &0F, &0A, &21, &02, &00  ; AC24: 00 21 01... .!.
 EQUB &36, &02, &08, &01, &04, &00, &01, &0A  ; AC2C: 36 02 08... 6..
 EQUB &40, &0A, &33, &01, &03, &05, &05, &36  ; AC34: 40 0A 33... @.3
 EQUB &01, &03, &05, &00, &11, &22, &45, &AF  ; AC3C: 01 03 05... ...
 EQUB &D7, &FF, &6B, &00, &32, &11, &22, &45  ; AC44: D7 FF 6B... ..k
 EQUB &AF, &57, &FA, &6B, &21, &21, &56, &BD  ; AC4C: AF 57 FA... .W.
 EQUB &FF, &FD, &FF, &EF, &FF, &21, &21, &56  ; AC54: FF FD FF... ...
 EQUB &BD, &F7, &A9, &21, &16, &AD, &FA, &54  ; AC5C: BD F7 A9... ...
 EQUB &FA, &55, &EF, &FD, &FF, &EF, &9F, &54  ; AC64: FA 55 EF... .U.
 EQUB &FA, &55, &EF, &DD, &AF, &34, &06, &0C  ; AC6C: FA 55 EF... .U.
 EQUB &40, &04, &51, &A0, &E1, &F2, &12, &40  ; AC74: 40 04 51... @.Q
 EQUB &21, &04, &51, &A0, &61, &F2, &BF, &57  ; AC7C: 21 04 51... !.Q
 EQUB &00, &21, &08, &00, &20, &40, &80, &84  ; AC84: 00 21 08... .!.
 EQUB &21, &28, &00, &21, &08, &00, &20, &40  ; AC8C: 21 28 00... !(.
 EQUB &80, &84, &21, &28, &07, &20, &07, &20  ; AC94: 80 84 21... ..!
 EQUB &0F, &01, &3B, &06, &0B, &17, &07, &2B  ; AC9C: 0F 01 3B... ..;
 EQUB &1F, &37, &7F, &06, &8B, &16, &85, &AB  ; ACA4: 1F 37 7F... .7.
 EQUB &21, &18, &A2, &CE, &13, &BF, &FE, &F5  ; ACAC: 21 18 A2... !..
 EQUB &40, &80, &BF, &F5, &AB, &21, &14, &A0  ; ACB4: 40 80 BF... @..
 EQUB &03, &12, &FA, &F1, &A8, &03, &6D, &F0  ; ACBC: 03 12 FA... ...
 EQUB &40, &05, &FE, &7D, &A8, &10, &80, &00  ; ACC4: 40 05 FE... @..
 EQUB &32, &0B, &17, &70, &06, &21, &01, &FF  ; ACCC: 32 0B 17... 2..
 EQUB &5E, &21, &2F, &5F, &BF, &7D, &DF, &FF  ; ACD4: 5E 21 2F... ^!/
 EQUB &37, &0B, &06, &03, &03, &07, &1D, &0A  ; ACDC: 37 0B 06... 7..
 EQUB &55, &50, &E0, &D5, &EB, &7D, &FA, &FC  ; ACE4: 55 50 E0... UP.
 EQUB &F0, &50, &E0, &D5, &EB, &7D, &EA, &BC  ; ACEC: F0 50 E0... .P.
 EQUB &F0, &00, &80, &48, &80, &44, &02, &21  ; ACF4: F0 00 80... ...
 EQUB &22, &00, &80, &48, &80, &44, &02, &21  ; ACFC: 22 00 80... "..
 EQUB &22, &0F, &01, &22, &7F, &FF, &FE, &FC  ; AD04: 22 0F 01... "..
 EQUB &FE, &DD, &7F, &57, &6D, &DA, &F8, &C8  ; AD0C: FE DD 7F... ...
 EQUB &94, &80, &45, &C0, &A0, &E1, &EB, &57  ; AD14: 94 80 45... ..E
 EQUB &BF, &12, &02, &80, &40, &32, &02, &04  ; AD1C: BF 12 02... ...
 EQUB &91, &EA, &32, &02, &17, &7F, &FF, &E7  ; AD24: 91 EA 32... ..2
 EQUB &7F, &12, &02, &21, &0A, &51, &82, &21  ; AD2C: 7F 12 02... ...
 EQUB &25, &5F, &EA, &BF, &FF, &FD, &FA, &F7  ; AD34: 25 5F EA... %_.
 EQUB &BF, &FF, &FD, &32, &02, &17, &FD, &5A  ; AD3C: BF FF FD... ...
 EQUB &F7, &AA, &57, &21, &0D, &3F, &FF, &A8  ; AD44: F7 AA 57... ..W
 EQUB &40, &F0, &E7, &DF, &7F, &12, &A8, &40  ; AD4C: 40 F0 E7... @..
 EQUB &F0, &A7, &DA, &75, &AF, &40, &8B, &21  ; AD54: F0 A7 DA... ...
 EQUB &16, &FF, &FD, &F8, &D0, &61, &40, &8B  ; AD5C: 16 FF FD... ...
 EQUB &21, &16, &FB, &5D, &21, &38, &D0, &61  ; AD64: 21 16 FB... !..
 EQUB &21, &12, &20, &C1, &A9, &40, &34, &01  ; AD6C: 21 12 20... !.
 EQUB &28, &50, &12, &20, &C1, &A9, &40, &32  ; AD74: 28 50 12... (P.
 EQUB &01, &28, &50, &0F, &01, &FF, &7F, &AF  ; AD7C: 01 28 50... .(P
 EQUB &7F, &12, &22, &7F, &FF, &7A, &AF, &7E  ; AD84: 7F 12 22... .."
 EQUB &F4, &DA, &7F, &6F, &17, &7F, &47, &BA  ; AD8C: F4 DA 7F... ...
 EQUB &D0, &81, &21, &1A, &F7, &DF, &7D, &13  ; AD94: D0 81 21... ..!
 EQUB &F5, &DB, &13, &40, &32, &02, &2F, &75  ; AD9C: F5 DB 13... ...
 EQUB &DB, &FD, &AB, &21, &05, &FF, &EE, &7D  ; ADA4: DB FD AB... ...
 EQUB &F7, &12, &FE, &F5, &21, &3F, &EE, &7D  ; ADAC: F7 12 FE... ...
 EQUB &D7, &7A, &D4, &A0, &00, &F7, &8F, &DE  ; ADB4: D7 7A D4... .z.
 EQUB &FD, &12, &AF, &21, &15, &77, &8D, &D6  ; ADBC: FD 12 AF... ...
 EQUB &4D, &A6, &21, &01, &02, &83, &57, &BF  ; ADC4: 4D A6 21... M.!
 EQUB &FF, &FE, &EC, &FC, &B0, &83, &56, &BB  ; ADCC: FF FE EC... ...
 EQUB &D5, &82, &32, &04, &0C, &10, &A0, &E2  ; ADD4: D5 82 32... ..2
 EQUB &B4, &E8, &40, &21, &05, &02, &A0, &E2  ; ADDC: B4 E8 40... ..@
 EQUB &B4, &E8, &40, &21, &05, &0F, &03, &7D  ; ADE4: B4 E8 40... ..@
 EQUB &33, &3F, &2F, &06, &04, &5D, &33, &0B  ; ADEC: 33 3F 2F... 3?/
 EQUB &25, &02, &04, &22, &FD, &E0, &40, &04  ; ADF4: 25 02 04... %..
 EQUB &E8, &55, &E0, &40, &04, &AF, &E3, &80  ; ADFC: E8 55 E0... .U.
 EQUB &06, &21, &02, &80, &05, &A8, &F5, &8F  ; AE04: 06 21 02... .!.
 EQUB &06, &40, &8A, &05, &32, &0F, &38, &C0  ; AE0C: 06 40 8A... .@.
 EQUB &05, &32, &03, &08, &40, &05, &E0, &40  ; AE14: 05 32 03... .2.
 EQUB &06, &20, &40, &0F, &0F, &0F, &0F, &0F  ; AE1C: 06 20 40... . @
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &01, &3F  ; AE24: 0F 0F 0F... ...
 EQUB &06, &22, &01, &0F, &09, &23, &08, &00  ; AE2C: 06 22 01... .".
 EQUB &21, &04, &0F, &0C, &34, &01, &02, &02  ; AE34: 21 04 0F... !..
 EQUB &08, &0F, &0F, &0A, &10, &00, &22, &10  ; AE3C: 08 0F 0F... ...
 EQUB &06, &22, &01, &09, &25, &08, &0F, &32  ; AE44: 06 22 01... .".
 EQUB &02, &01, &0F, &02, &26, &10, &00, &32  ; AE4C: 02 01 0F... ...
 EQUB &18, &01, &06, &20, &00, &22, &80, &20  ; AE54: 18 01 06... ...
 EQUB &02, &40, &02, &21, &04, &00, &22, &02  ; AE5C: 02 40 02... .@.
 EQUB &02, &34, &01, &05, &5F, &0B, &5F, &BF  ; AE64: 02 34 01... .4.
 EQUB &FF, &BF, &FF, &80, &D4, &F9, &EF, &FF  ; AE6C: FF BF FF... ...
 EQUB &FA, &FF, &FE, &06, &40, &10, &0A, &36  ; AE74: FA FF FE... ...
 EQUB &08, &0E, &08, &0A, &08, &0C, &03, &D0  ; AE7C: 08 0E 08... ...
 EQUB &00, &A0, &00, &50, &22, &40, &02, &10  ; AE84: 00 A0 00... ...
 EQUB &32, &04, &28, &00, &B3, &32, &11, &3B  ; AE8C: 32 04 28... 2.(
 EQUB &10, &D0, &10, &00, &21, &08, &13, &21  ; AE94: 10 D0 10... ...
 EQUB &06, &00, &21, &02, &02, &22, &FE, &FF  ; AE9C: 06 00 21... ..!
 EQUB &21, &01, &C1, &02, &23, &80, &21, &15  ; AEA4: 21 01 C1... !..
 EQUB &0D, &35, &08, &0D, &08, &00, &18, &10  ; AEAC: 0D 35 08... .5.
 EQUB &00, &20, &00, &80, &06, &20, &00, &22  ; AEB4: 00 20 00... . .
 EQUB &40, &04, &22, &04, &0F, &0F, &08, &22  ; AEBC: 40 04 22... @."
 EQUB &20, &0F, &0F, &0F, &0F, &0F, &0B, &3F  ; AEC4: 20 0F 0F...  ..
 EQUB &06, &22, &01, &02, &10, &04, &21, &02  ; AECC: 06 22 01... .".
 EQUB &06, &A0, &40, &05, &10, &02, &23, &08  ; AED4: 06 A0 40... ..@
 EQUB &00, &21, &04, &0F, &0C, &34, &01, &02  ; AEDC: 00 21 04... .!.
 EQUB &02, &08, &02, &21, &02, &03, &21, &01  ; AEE4: 02 08 02... ...
 EQUB &00, &20, &00, &32, &02, &15, &05, &21  ; AEEC: 00 20 00... . .
 EQUB &02, &A0, &03, &80, &00, &20, &02, &21  ; AEF4: 02 A0 03... ...
 EQUB &08, &06, &21, &08, &05, &10, &00, &22  ; AEFC: 08 06 21... ..!
 EQUB &10, &06, &22, &01, &09, &37, &0A, &08  ; AF04: 10 06 22... .."
 EQUB &09, &08, &08, &02, &03, &00, &80, &21  ; AF0C: 09 08 08... ...
 EQUB &2E, &7F, &32, &14, &0B, &BF, &FF, &02  ; AF14: 2E 7F 32... ..2
 EQUB &80, &E0, &40, &A2, &F1, &F8, &00, &32  ; AF1C: 80 E0 40... ..@
 EQUB &02, &01, &04, &21, &02, &02, &40, &00  ; AF24: 02 01 04... ...
 EQUB &21, &14, &BA, &02, &22, &10, &50, &23  ; AF2C: 21 14 BA... !..
 EQUB &10, &00, &32, &18, &01, &06, &20, &00  ; AF34: 10 00 32... ..2
 EQUB &22, &80, &20, &02, &40, &02, &21, &05  ; AF3C: 22 80 20... ".
 EQUB &00, &22, &02, &00, &32, &01, &12, &FA  ; AF44: 00 22 02... .".
 EQUB &A0, &F4, &A0, &43, &21, &0F, &5F, &21  ; AF4C: A0 F4 A0... ...
 EQUB &1F, &7C, &33, &2A, &07, &11, &C1, &F5  ; AF54: 1F 7C 33... .|3
 EQUB &22, &F9, &02, &36, &15, &1E, &0C, &1A  ; AF5C: 22 F9 02... "..
 EQUB &9D, &0F, &00, &20, &54, &80, &32, &02  ; AF64: 9D 0F 00... ...
 EQUB &15, &40, &A0, &00, &31, &08, &23, &16  ; AF6C: 15 40 A0... .@.
 EQUB &BF, &32, &16, &17, &03, &80, &00, &80  ; AF74: BF 32 16... .2.
 EQUB &00, &42, &22, &40, &02, &22, &20, &30  ; AF7C: 00 42 22... .B"
 EQUB &21, &38, &A8, &3D, &2A, &28, &28, &78  ; AF84: 21 38 A8... !8.
 EQUB &28, &00, &08, &3F, &3F, &7F, &06, &00  ; AF8C: 28 00 08... (..
 EQUB &02, &02, &FD, &FC, &FF, &21, &01, &C1  ; AF94: 02 02 FD... ...
 EQUB &02, &80, &21, &15, &9F, &21, &0A, &05  ; AF9C: 02 80 21... ..!
 EQUB &21, &0A, &84, &D0, &05, &96, &21, &17  ; AFA4: 21 0A 84... !..
 EQUB &B6, &00, &21, &18, &10, &00, &20, &22  ; AFAC: B6 00 21... ..!
 EQUB &80, &21, &05, &05, &20, &00, &22, &40  ; AFB4: 80 21 05... .!.
 EQUB &04, &22, &04, &0F, &0F, &08, &22, &20  ; AFBC: 04 22 04... .".
 EQUB &0F, &0F, &0F, &0F, &0F, &0B, &3F, &00  ; AFC4: 0F 0F 0F... ...
 EQUB &C0, &E8, &F6, &EB, &F3, &EA, &D2, &00  ; AFCC: C0 E8 F6... ...
 EQUB &C0, &68, &32, &36, &29, &72, &AA, &52  ; AFD4: C0 68 32... .h2
 EQUB &05, &23, &80, &05, &80, &0F, &0F, &04  ; AFDC: 05 23 80... .#.
 EQUB &23, &06, &35, &0E, &03, &07, &03, &01  ; AFE4: 23 06 35... #.5
 EQUB &23, &02, &3A, &0A, &03, &05, &02, &01  ; AFEC: 23 02 3A... #.:
 EQUB &2F, &17, &2F, &17, &0A, &00, &85, &A0  ; AFF4: 2F 17 2F... /./
 EQUB &35, &2D, &16, &2D, &16, &0A, &00, &85  ; AFFC: 35 2D 16... 5-.
 EQUB &A0, &14, &FD, &21, &3F, &E6, &B9, &33  ; B004: A0 14 FD... ...
 EQUB &01, &02, &01, &AB, &D5, &21, &3F, &86  ; B00C: 01 02 01... ...
 EQUB &A9, &A0, &C0, &A0, &40, &80, &40, &80  ; B014: A9 A0 C0... ...
 EQUB &00, &A0, &C0, &A0, &40, &80, &40, &80  ; B01C: 00 A0 C0... ...
 EQUB &00, &A2, &45, &21, &0D, &B2, &32, &0C  ; B024: 00 A2 45... ..E
 EQUB &04, &48, &88, &A0, &44, &21, &09, &A2  ; B02C: 04 48 88... .H.
 EQUB &32, &08, &04, &48, &23, &80, &07, &80  ; B034: 32 08 04... 2..
 EQUB &0F, &0F, &0F, &09, &78, &20, &10, &35  ; B03C: 0F 0F 0F... ...
 EQUB &18, &0C, &18, &08, &09, &48, &20, &10  ; B044: 18 0C 18... ...
 EQUB &36, &08, &04, &08, &00, &01, &14, &68  ; B04C: 36 08 04... 6..
 EQUB &B0, &70, &F1, &73, &F2, &72, &21, &14  ; B054: B0 70 F1... .p.
 EQUB &68, &B0, &70, &D1, &72, &D0, &40, &02  ; B05C: 68 B0 70... h.p
 EQUB &21, &3C, &C3, &AF, &9F, &AF, &9F, &02  ; B064: 21 3C C3... !<.
 EQUB &21, &3C, &C3, &21, &2F, &9A, &AD, &98  ; B06C: 21 3C C3... !<.
 EQUB &C8, &90, &D0, &B0, &D0, &F0, &80, &D8  ; B074: C8 90 D0... ...
 EQUB &C0, &90, &50, &A0, &40, &60, &80, &D8  ; B07C: C0 90 50... ..P
 EQUB &0F, &02, &21, &02, &00, &3A, &04, &06  ; B084: 0F 02 21... ..!
 EQUB &01, &00, &02, &00, &02, &00, &04, &02  ; B08C: 01 00 02... ...
 EQUB &02, &21, &02, &C0, &30, &70, &B8, &78  ; B094: 02 21 02... .!.
 EQUB &10, &E0, &10, &C0, &30, &70, &A8, &48  ; B09C: 10 E0 10... ...
 EQUB &10, &60, &10, &0F, &01, &3E, &08, &0D  ; B0A4: 10 60 10... .`.
 EQUB &08, &0D, &0E, &0D, &18, &07, &00, &05  ; B0AC: 08 0D 0E... ...
 EQUB &00, &05, &06, &05, &32, &08, &07, &F2  ; B0B4: 00 05 06... ...
 EQUB &73, &F1, &23, &F0, &00, &22, &D0, &42  ; B0BC: 73 F1 23... s.#
 EQUB &D1, &80, &D0, &80, &02, &9F, &5F, &65  ; B0C4: D1 80 D0... ...
 EQUB &9E, &C1, &62, &21, &22, &66, &10, &58  ; B0CC: 9E C1 62... ..b
 EQUB &21, &25, &9C, &C1, &21, &22, &00, &21  ; B0D4: 21 25 9C... !%.
 EQUB &26, &EC, &D8, &EE, &D4, &E4, &C6, &AC  ; B0DC: 26 EC D8... &..
 EQUB &00, &64, &32, &18, &28, &50, &E0, &42  ; B0E4: 00 64 32... .d2
 EQUB &A4, &0F, &02, &22, &01, &06, &21, &01  ; B0EC: A4 0F 02... ...
 EQUB &07, &20, &40, &20, &60, &E0, &03, &20  ; B0F4: 07 20 40... . @
 EQUB &40, &20, &40, &C0, &03, &3F, &0F, &01  ; B0FC: 40 20 40... @ @
 EQUB &21, &3A, &20, &06, &21, &12, &20, &06  ; B104: 21 3A 20... !:
 EQUB &B8, &21, &08, &06, &98, &21, &08, &06  ; B10C: B8 21 08... .!.
 EQUB &32, &36, &3E, &40, &6E, &04, &34, &14  ; B114: 32 36 3E... 26>
 EQUB &18, &40, &2A, &0A, &F8, &D4, &04, &21  ; B11C: 18 40 2A... .@*
 EQUB &02, &00, &E9, &54, &0B, &21, &19, &7F  ; B124: 02 00 E9... ...
 EQUB &21, &35, &4F, &21, &1B, &00, &21, &01  ; B12C: 21 35 4F... !5O
 EQUB &03, &23, &01, &03, &E6, &21, &3C, &F0  ; B134: 03 23 01... .#.
 EQUB &BC, &69, &00, &60, &A0, &20, &60, &20  ; B13C: BC 69 00... .i.
 EQUB &22, &60, &00, &60, &A0, &20, &60, &21  ; B144: 22 60 00... "`.
 EQUB &24, &60, &40, &0C, &20, &21, &04, &00  ; B14C: 24 60 40... $`@
 EQUB &80, &03, &35, &1F, &27, &2C, &38, &18  ; B154: 80 03 35... ..5
 EQUB &03, &10, &34, &27, &04, &08, &08, &03  ; B15C: 03 10 34... ..4
 EQUB &D0, &21, &08, &50, &A8, &70, &03, &D0  ; B164: D0 21 08... .!.
 EQUB &21, &08, &50, &A8, &70, &5E, &7A, &32  ; B16C: 21 08 50... !.P
 EQUB &22, &26, &4A, &66, &4E, &56, &46, &37  ; B174: 22 26 4A... "&J
 EQUB &1A, &22, &26, &0A, &26, &4C, &16, &F8  ; B17C: 1A 22 26... ."&
 EQUB &EA, &C6, &E6, &C6, &AC, &02, &30, &6A  ; B184: EA C6 E6... ...
 EQUB &C3, &62, &C6, &AC, &0A, &CE, &21, &03  ; B18C: C3 62 C6... .b.
 EQUB &99, &21, &03, &20, &32, &0C, &01, &C0  ; B194: 99 21 03... .!.
 EQUB &08, &FE, &DC, &E6, &30, &C2, &21, &18  ; B19C: 08 FE DC... ...
 EQUB &83, &20, &08, &21, &08, &00, &86, &00  ; B1A4: 83 20 08... . .
 EQUB &21, &01, &C0, &0A, &21, &02, &30, &00  ; B1AC: 21 01 C0... !..
 EQUB &21, &06, &80, &21, &19, &C0, &3E, &04  ; B1B4: 21 06 80... !..
 EQUB &18, &19, &38, &3D, &38, &3D, &3A, &3D  ; B1BC: 18 19 38... ..8
 EQUB &08, &09, &08, &0D, &A8, &33, &1D, &2A  ; B1C4: 08 09 08... ...
 EQUB &3D, &F8, &78, &F8, &78, &24, &F8, &D8  ; B1CC: 3D F8 78... =.x
 EQUB &6A, &C8, &6E, &C8, &AB, &C8, &89, &4E  ; B1D4: 6A C8 6E... j.n
 EQUB &5E, &21, &0C, &05, &4C, &5A, &21, &0C  ; B1DC: 5E 21 0C... ^!.
 EQUB &40, &00, &30, &00, &CC, &09, &21, &06  ; B1E4: 40 00 30... @.0
 EQUB &00, &21, &03, &20, &21, &05, &00, &C0  ; B1EC: 00 21 03... .!.
 EQUB &08, &32, &02, &18, &00, &83, &21, &18  ; B1F4: 08 32 02... .2.
 EQUB &00, &21, &06, &60, &08, &21, &04, &63  ; B1FC: 00 21 06... .!.
 EQUB &00, &21, &2C, &00, &61, &21, &0C, &C1  ; B204: 00 21 2C... .!,
 EQUB &08, &60, &02, &60, &21, &08, &80, &10  ; B20C: 08 60 02... .`.
 EQUB &44, &08, &30, &00, &21, &33, &00, &21  ; B214: 44 08 30... D.0
 EQUB &0C, &00, &33, &06, &01, &1A, &07, &DA  ; B21C: 0C 00 33... ..3
 EQUB &20, &00, &21, &38, &00, &CC, &00, &99  ; B224: 20 00 21...  .!
 EQUB &F0, &07, &C6, &02, &21, &01, &03, &80  ; B22C: F0 07 C6... ...
 EQUB &09, &37, &31, &06, &90, &03, &60, &0C  ; B234: 09 37 31... .71
 EQUB &01, &3F, &12, &FB, &C1, &80, &02, &10  ; B23C: 01 3F 12... .?.
 EQUB &FF, &FB, &E0, &C0, &04, &F8, &F0, &E0  ; B244: FF FB E0... ...
 EQUB &05, &22, &3F, &7F, &13, &22, &7F, &15  ; B24C: 05 22 3F... ."?
 EQUB &FE, &FD, &DA, &13, &FB, &D1, &A1, &22  ; B254: FE FD DA... ...
 EQUB &01, &FF, &80, &03, &23, &80, &FE, &08  ; B25C: 01 FF 80... ...
 EQUB &20, &30, &50, &00, &10, &50, &20, &0C  ; B264: 20 30 50...  0P
 EQUB &22, &02, &22, &04, &7F, &21, &15, &02  ; B26C: 22 02 22... "."
 EQUB &34, &08, &1D, &02, &02, &A0, &40, &02  ; B274: 34 08 1D... 4..
 EQUB &20, &80, &C0, &10, &08, &23, &80, &C0  ; B27C: 20 80 C0...  ..
 EQUB &22, &40, &22, &60, &08, &70, &D0, &C0  ; B284: 22 40 22... "@"
 EQUB &A8, &84, &D2, &E9, &C2, &07, &80, &22  ; B28C: A8 84 D2... ...
 EQUB &04, &32, &0C, &08, &23, &18, &20, &38  ; B294: 04 32 0C... .2.
 EQUB &0A, &12, &0A, &08, &09, &01, &00, &02  ; B29C: 0A 12 0A... ...
 EQUB &48, &A8, &8C, &21, &24, &00, &40, &C0  ; B2A4: 48 A8 8C... H..
 EQUB &09, &22, &20, &36, &01, &03, &03, &07  ; B2AC: 09 22 20... ."
 EQUB &0F, &1F, &00, &7F, &C1, &83, &FE, &F8  ; B2B4: 0F 1F 00... ...
 EQUB &F0, &F8, &E1, &C2, &C4, &89, &34, &12  ; B2BC: F0 F8 E1... ...
 EQUB &28, &40, &28, &40, &00, &83, &21, &01  ; B2C4: 28 40 28... (@(
 EQUB &06, &87, &FF, &FD, &7C, &5E, &A3, &00  ; B2CC: 06 87 FF... ...
 EQUB &20, &21, &22, &E7, &C7, &CF, &9F, &BF  ; B2D4: 20 21 22...  !"
 EQUB &00, &21, &0C, &22, &5E, &21, &2F, &87  ; B2DC: 00 21 0C... .!.
 EQUB &D3, &C8, &00, &10, &37, &33, &01, &03  ; B2E4: D3 C8 00... ...
 EQUB &07, &8F, &3F, &3F, &7F, &16, &F0, &F8  ; B2EC: 07 8F 3F... ..?
 EQUB &F0, &F8, &FC, &F8, &FC, &F8, &90, &C6  ; B2F4: F0 F8 FC... ...
 EQUB &36, &04, &11, &C2, &04, &10, &07, &C1  ; B2FC: 36 04 11... 6..
 EQUB &61, &82, &33, &07, &0C, &1F, &12, &C0  ; B304: 61 82 33... a.3
 EQUB &87, &9F, &1D, &22, &44, &20, &21, &22  ; B30C: 87 9F 1D... ...
 EQUB &91, &98, &8C, &C3, &12, &34, &1F, &07  ; B314: 91 98 8C... ...
 EQUB &00, &38, &02, &13, &FE, &7E, &21, &1F  ; B31C: 00 38 02... .8.
 EQUB &DF, &21, &1F, &BC, &21, &3C, &78, &7C  ; B324: DF 21 1F... .!.
 EQUB &F8, &F4, &F8, &F0, &1B, &23, &FE, &13  ; B32C: F8 F4 F8... ...
 EQUB &33, &1F, &0F, &07, &00, &8F, &1A, &FC  ; B334: 33 1F 0F... 3..
 EQUB &12, &F0, &E1, &CF, &88, &10, &70, &FE  ; B33C: 12 F0 E1... ...
 EQUB &FC, &78, &C0, &22, &01, &21, &03, &00  ; B344: FC 78 C0... .x.
 EQUB &21, &05, &42, &81, &80, &02, &40, &30  ; B34C: 21 05 42... !.B
 EQUB &21, &03, &80, &40, &00, &33, &03, &0F  ; B354: 21 03 80... !..
 EQUB &3F, &16, &FE, &FF, &F3, &F7, &13, &E0  ; B35C: 3F 16 FE... ?..
 EQUB &21, &06, &80, &13, &FD, &F6, &21, &38  ; B364: 21 06 80... !..
 EQUB &02, &FE, &F8, &FE, &80, &00, &21, &07  ; B36C: 02 FE F8... ...
 EQUB &02, &60, &C3, &32, &06, &0C, &78, &C0  ; B374: 02 60 C3... .`.
 EQUB &21, &03, &00, &87, &33, &06, &0C, &18  ; B37C: 21 03 00... !..
 EQUB &70, &C0, &32, &03, &07, &80, &00, &33  ; B384: 70 C0 32... p.2
 EQUB &07, &1F, &3F, &13, &7F, &17, &3F, &F1  ; B38C: 07 1F 3F... ..?
 EQUB &C0, &32, &04, &3E, &7F, &13, &00, &33  ; B394: C0 32 04... .2.
 EQUB &04, &1F, &3F, &13, &BF, &33, &07, &0F  ; B39C: 04 1F 3F... ..?
 EQUB &1F, &12, &C1, &22, &80, &12, &FA, &FC  ; B3A4: 1F 12 C1... ...
 EQUB &F6, &E8, &40, &60, &AA, &50, &A0, &02  ; B3AC: F6 E8 40... ..@
 EQUB &38, &01, &02, &25, &02, &02, &03, &07  ; B3B4: 38 01 02... 8..
 EQUB &2F, &5F, &FF, &FE, &00, &7F, &13, &22  ; B3BC: 2F 5F FF... /_.
 EQUB &7F, &FF, &21, &01, &19, &F7, &23, &70  ; B3C4: 7F FF 21... ..!
 EQUB &F0, &F8, &9F, &21, &06, &08, &23, &01  ; B3CC: F0 F8 9F... ...
 EQUB &00, &22, &02, &40, &31, &2A, &23, &3F  ; B3D4: 00 22 02... .".
 EQUB &33, &0E, &07, &07, &5F, &BF, &19, &FC  ; B3DC: 33 0E 07... 3..
 EQUB &F8, &F0, &E0, &80, &FF, &22, &7F, &5F  ; B3E4: F8 F0 E0... ...
 EQUB &47, &40, &22, &60, &F3, &C1, &22, &80  ; B3EC: 47 40 22... G@"
 EQUB &04, &D8, &78, &7C, &7E, &7F, &BF, &9F  ; B3F4: 04 D8 78... ..x
 EQUB &FF, &05, &80, &C0, &E0, &22, &04, &32  ; B3FC: FF 05 80... ...
 EQUB &0C, &08, &23, &18, &30, &35, &0F, &07  ; B404: 0C 08 23... ..#
 EQUB &0F, &0F, &0B, &23, &03, &FC, &F8, &EC  ; B40C: 0F 0F 0B... ...
 EQUB &22, &E4, &E0, &22, &C0, &08, &22, &20  ; B414: 22 E4 E0... "..
 EQUB &22, &21, &34, &06, &02, &04, &0C, &00  ; B41C: 22 21 34... "!4
 EQUB &7F, &A3, &86, &F9, &36, &07, &0E, &05  ; B424: 7F A3 86... ...
 EQUB &99, &33, &27, &4F, &DF, &13, &F0, &F8  ; B42C: 99 33 27... .3'
 EQUB &EC, &D6, &EB, &F5, &FE, &FF, &22, &30  ; B434: EC D6 EB... ...
 EQUB &02, &21, &03, &83, &E0, &F0, &33, &01  ; B43C: 02 21 03... .!.
 EQUB &31, &13, &DA, &BE, &32, &34, &2C, &5C  ; B444: 31 13 DA... 1..
 EQUB &80, &8B, &D9, &FD, &22, &F8, &FC, &FF  ; B44C: 80 8B D9... ...
 EQUB &00, &21, &18, &CC, &FE, &FD, &FB, &76  ; B454: 00 21 18... .!.
 EQUB &DC, &32, &1C, &3C, &7D, &F9, &9B, &21  ; B45C: DC 32 1C... .2.
 EQUB &32, &62, &E2, &3A, &0E, &05, &0E, &05  ; B464: 32 62 E2... 2b.
 EQUB &02, &07, &02, &07, &7F, &3F, &C7, &9F  ; B46C: 02 07 02... ...
 EQUB &13, &F8, &15, &F8, &00, &21, &03, &FC  ; B474: 13 F8 15... ...
 EQUB &FB, &EF, &BF, &7F, &FF, &7F, &21, &3F  ; B47C: FB EF BF... ...
 EQUB &7C, &22, &F8, &24, &F0, &F8, &14, &23  ; B484: 7C 22 F8... |".
 EQUB &7F, &33, &3F, &1F, &0F, &FE, &F8, &14  ; B48C: 7F 33 3F... .3?
 EQUB &C6, &84, &32, &0D, &1B, &FB, &E6, &E0  ; B494: C6 84 32... ..2
 EQUB &FC, &22, &C3, &87, &83, &34, &07, &0B  ; B49C: FC 22 C3... .".
 EQUB &07, &0F, &05, &34, &01, &03, &07, &07  ; B4A4: 07 0F 05... ...
 EQUB &5F, &7F, &12, &FD, &C0, &C8, &9F, &EF  ; B4AC: 5F 7F 12... _..
 EQUB &D7, &8B, &DF, &70, &02, &22, &F0, &E0  ; B4B4: D7 8B DF... ...
 EQUB &C0, &81, &36, &07, &0F, &3E, &03, &00  ; B4BC: C0 81 36... ..6
 EQUB &38, &EF, &DF, &BF, &7F, &FF, &BF, &32  ; B4C4: 38 EF DF... 8..
 EQUB &07, &0F, &12, &FE, &FF, &FE, &12, &BF  ; B4CC: 07 0F 12... ...
 EQUB &6F, &E7, &C7, &CF, &16, &FC, &22, &F0  ; B4D4: 6F E7 C7... o..
 EQUB &22, &07, &03, &32, &03, &3F, &FF, &98  ; B4DC: 22 07 03... "..
 EQUB &21, &08, &02, &7E, &DF, &12, &03, &32  ; B4E4: 21 08 02... !..
 EQUB &07, &1F, &13, &7D, &F7, &21, &03, &1F  ; B4EC: 07 1F 13... ...
 EQUB &15, &FE, &12, &FE, &F0, &E1, &83, &32  ; B4F4: 15 FE 12... ...
 EQUB &1F, &3F, &E8, &A0, &E0, &22, &C0, &80  ; B4FC: 1F 3F E8... .?.
 EQUB &02, &3F, &07, &10, &07, &10, &0F, &0F  ; B504: 02 3F 07... .?.
 EQUB &0F, &0F, &0F, &0F, &0F, &08, &20, &30  ; B50C: 0F 0F 0F... ...
 EQUB &24, &70, &02, &20, &30, &50, &00, &10  ; B514: 24 70 02... $p.
 EQUB &50, &0F, &0F, &07, &34, &08, &0C, &07  ; B51C: 50 0F 0F... P..
 EQUB &07, &04, &34, &08, &0C, &02, &02, &04  ; B524: 07 04 34... ..4
 EQUB &20, &80, &C0, &50, &04, &20, &80, &C0  ; B52C: 20 80 C0...  ..
 EQUB &10, &0F, &04, &23, &40, &22, &60, &03  ; B534: 10 0F 04... ...
 EQUB &23, &40, &22, &60, &0F, &01, &50, &22  ; B53C: 23 40 22... #@"
 EQUB &70, &35, &38, &1C, &1E, &0F, &03, &22  ; B544: 70 35 38... p58
 EQUB &50, &40, &35, &28, &04, &12, &09, &02  ; B54C: 50 40 35... P@5
 EQUB &07, &80, &07, &80, &22, &04, &32, &0C  ; B554: 07 80 07... ...
 EQUB &08, &23, &18, &30, &22, &04, &32, &0C  ; B55C: 08 23 18... .#.
 EQUB &08, &23, &18, &20, &35, &0E, &06, &0E  ; B564: 08 23 18... .#.
 EQUB &0E, &0B, &23, &03, &38, &0A, &02, &0A  ; B56C: 0E 0B 23... ..#
 EQUB &08, &09, &01, &00, &02, &C8, &E8, &EC  ; B574: 08 09 01... ...
 EQUB &E4, &44, &22, &C0, &80, &48, &A8, &8C  ; B57C: E4 44 22... .D"
 EQUB &21, &24, &00, &40, &C0, &0F, &02, &24  ; B584: 21 24 00... !$.
 EQUB &20, &04, &22, &20, &0F, &07, &3E, &01  ; B58C: 20 04 22...  ."
 EQUB &03, &07, &0F, &1E, &38, &70, &38, &01  ; B594: 03 07 0F... ...
 EQUB &02, &04, &09, &12, &28, &40, &21, &28  ; B59C: 02 04 09... ...
 EQUB &C0, &22, &80, &05, &40, &00, &83, &21  ; B5A4: C0 22 80... .".
 EQUB &01, &04, &22, &30, &04, &40, &E0, &02  ; B5AC: 01 04 22... .."
 EQUB &87, &FF, &F8, &00, &40, &A0, &22, &01  ; B5B4: 87 FF F8... ...
 EQUB &21, &03, &07, &32, &02, &04, &04, &3F  ; B5BC: 21 03 07... !..
 EQUB &22, &80, &22, &C0, &22, &E0, &F0, &F8  ; B5C4: 22 80 22... "."
 EQUB &02, &22, &40, &20, &80, &D0, &C8, &0A  ; B5CC: 02 22 40... ."@
 EQUB &21, &03, &03, &32, &01, &03, &0C, &60  ; B5D4: 21 03 03... !..
 EQUB &C0, &80, &0F, &02, &34, &1F, &07, &07  ; B5DC: C0 80 0F... ...
 EQUB &1F, &FE, &FC, &F0, &F8, &10, &35, &06  ; B5E4: 1F FE FC... ...
 EQUB &04, &11, &C2, &04, &10, &00, &C1, &E1  ; B5EC: 04 11 C2... ...
 EQUB &83, &33, &07, &0C, &18, &02, &C1, &61  ; B5F4: 83 33 07... .3.
 EQUB &82, &33, &07, &0C, &18, &02, &C0, &23  ; B5FC: 82 33 07... .3.
 EQUB &80, &04, &C0, &23, &80, &0F, &05, &22  ; B604: 80 04 C0... ...
 EQUB &7C, &36, &3C, &3E, &1F, &1F, &0F, &03  ; B60C: 7C 36 3C... |6<
 EQUB &22, &44, &20, &35, &22, &11, &18, &0C  ; B614: 22 44 20... "D
 EQUB &03, &05, &F8, &12, &05, &21, &38, &08  ; B61C: 03 05 F8... ...
 EQUB &C0, &FC, &06, &C0, &21, &1C, &0F, &0A  ; B624: C0 FC 06... ...
 EQUB &32, &03, &1F, &7E, &FE, &F8, &22, &F0  ; B62C: 32 03 1F... 2..
 EQUB &0F, &0F, &21, &0F, &FE, &0F, &05, &34  ; B634: 0F 0F 21... ..!
 EQUB &01, &0F, &0F, &1F, &04, &37, &01, &0F  ; B63C: 01 0F 0F... ...
 EQUB &08, &10, &3F, &07, &0F, &7F, &FF, &23  ; B644: 08 10 3F... ..?
 EQUB &FE, &30, &32, &06, &0C, &78, &C0, &02  ; B64C: FE 30 32... .02
 EQUB &21, &02, &12, &9F, &34, &0F, &07, &07  ; B654: 21 02 12... !..
 EQUB &0F, &7F, &00, &33, &05, &02, &01, &03  ; B65C: 0F 7F 00... ...
 EQUB &40, &F0, &14, &FC, &22, &F0, &30, &21  ; B664: 40 F0 14... @..
 EQUB &03, &80, &40, &03, &30, &07, &21, &03  ; B66C: 03 80 40... ..@
 EQUB &E0, &C0, &80, &04, &21, &03, &06, &21  ; B674: E0 C0 80... ...
 EQUB &07, &FF, &33, &01, &07, &0F, &03, &21  ; B67C: 07 FF 33... ..3
 EQUB &06, &80, &03, &33, &01, &07, &3F, &12  ; B684: 06 80 03... ...
 EQUB &FC, &C0, &80, &33, &01, &06, &38, &04  ; B68C: FC C0 80... ...
 EQUB &21, &03, &15, &02, &21, &02, &80, &00  ; B694: 21 03 15... !..
 EQUB &21, &07, &02, &7F, &17, &60, &C3, &32  ; B69C: 21 07 02... !..
 EQUB &06, &0C, &78, &C0, &21, &03, &00, &17  ; B6A4: 06 0C 78... ..x
 EQUB &FE, &87, &33, &06, &0C, &18, &70, &C0  ; B6AC: FE 87 33... ..3
 EQUB &32, &03, &06, &12, &FE, &F0, &E0, &80  ; B6B4: 32 03 06... 2..
 EQUB &02, &80, &00, &21, &06, &10, &20, &80  ; B6BC: 02 80 00... ...
 EQUB &02, &E0, &80, &06, &63, &8F, &33, &1F  ; B6C4: 02 E0 80... ...
 EQUB &3F, &3F, &7F, &12, &3F, &23, &1F, &22  ; B6CC: 3F 3F 7F... ??.
 EQUB &0F, &33, &05, &03, &01, &FE, &F4, &A0  ; B6D4: 0F 33 05... .3.
 EQUB &FD, &E8, &40, &A8, &40, &80, &0F, &04  ; B6DC: FD E8 40... ..@
 EQUB &21, &08, &0C, &21, &02, &0F, &04, &21  ; B6E4: 21 08 0C... !..
 EQUB &04, &0F, &04, &21, &08, &00, &21, &02  ; B6EC: 04 0F 04... ...
 EQUB &20, &0A, &21, &04, &05, &21, &01, &08  ; B6F4: 20 0A 21...  .!
 EQUB &C0, &E0, &0A, &21, &02, &02, &40, &0A  ; B6FC: C0 E0 0A... ...
 EQUB &21, &01, &03, &21, &04, &06, &80, &04  ; B704: 21 01 03... !..
 EQUB &37, &0A, &25, &03, &09, &04, &02, &01  ; B70C: 37 0A 25... 7.%
 EQUB &03, &80, &C0, &E0, &70, &21, &38, &9C  ; B714: 03 80 C0... ...
 EQUB &70, &35, &38, &1C, &0A, &05, &02, &07  ; B71C: 70 35 38... p58
 EQUB &80, &00, &20, &0F, &0B, &40, &B0, &78  ; B724: 80 00 20... ..
 EQUB &FC, &FE, &7F, &08, &4E, &36, &27, &13  ; B72C: FC FE 7F... ...
 EQUB &09, &04, &02, &01, &03, &80, &C0, &A0  ; B734: 09 04 02... ...
 EQUB &50, &21, &28, &84, &0C, &20, &05, &22  ; B73C: 50 21 28... P!(
 EQUB &01, &23, &03, &21, &01, &00, &70, &F8  ; B744: 01 23 03... .#.
 EQUB &EA, &D0, &F8, &B0, &40, &36, &3F, &1F  ; B74C: EA D0 F8... ...
 EQUB &0F, &07, &03, &01, &02, &80, &C0, &E0  ; B754: 0F 07 03... ...
 EQUB &F0, &F8, &7C, &BE, &57, &08, &40, &21  ; B75C: F0 F8 7C... ..|
 EQUB &01, &10, &0E, &21, &01, &0F, &02, &22  ; B764: 01 10 0E... ...
 EQUB &01, &05, &C0, &E0, &F0, &F8, &5C, &37  ; B76C: 01 05 C0... ...
 EQUB &2A, &0A, &01, &00, &04, &02, &01, &02  ; B774: 2A 0A 01... *..
 EQUB &80, &40, &20, &10, &21, &08, &00, &80  ; B77C: 80 40 20... .@
 EQUB &0F, &05, &40, &02, &10, &80, &06, &21  ; B784: 0F 05 40... ..@
 EQUB &04, &09, &33, &15, &08, &04, &06, &80  ; B78C: 04 09 33... ..3
 EQUB &0F, &0F, &3F, &38, &0F, &07, &0A, &15  ; B794: 0F 0F 3F... ..?
 EQUB &00, &0A, &0C, &06, &E9, &4A, &5F, &32  ; B79C: 00 0A 0C... ...
 EQUB &02, &17, &BA, &57, &BF, &74, &A8, &D4  ; B7A4: 02 17 BA... ...
 EQUB &FA, &90, &00, &40, &EA, &40, &02, &88  ; B7AC: FA 90 00... ...
 EQUB &00, &10, &00, &20, &10, &80, &03, &80  ; B7B4: 00 10 00... ...
 EQUB &10, &00, &21, &08, &00, &21, &02, &02  ; B7BC: 10 00 21... ..!
 EQUB &40, &02, &10, &82, &20, &21, &06, &10  ; B7C4: 40 02 10... @..
 EQUB &21, &01, &00, &80, &44, &10, &80, &21  ; B7CC: 21 01 00... !..
 EQUB &08, &20, &00, &48, &00, &32, &03, &01  ; B7D4: 08 20 00... . .
 EQUB &03, &80, &02, &F5, &7E, &95, &20, &21  ; B7DC: 03 80 02... ...
 EQUB &08, &02, &44, &50, &80, &32, &01, &04  ; B7E4: 08 02 44... ..D
 EQUB &10, &00, &21, &04, &80, &41, &80, &03  ; B7EC: 10 00 21... ..!
 EQUB &84, &03, &21, &02, &40, &00, &21, &04  ; B7F4: 84 03 21... ..!
 EQUB &40, &00, &21, &04, &05, &21, &01, &04  ; B7FC: 40 00 21... @.!
 EQUB &21, &01, &03, &C0, &E0, &00, &20, &34  ; B804: 21 01 03... !..
 EQUB &02, &08, &00, &02, &02, &21, &08, &07  ; B80C: 02 08 00... ...
 EQUB &10, &82, &20, &21, &04, &10, &21, &01  ; B814: 10 82 20... ..
 EQUB &00, &80, &20, &02, &40, &02, &20, &02  ; B81C: 00 80 20... ..
 EQUB &20, &02, &20, &00, &80, &00, &37, &0A  ; B824: 20 02 20...  .
 EQUB &25, &03, &09, &04, &02, &01, &03, &80  ; B82C: 25 03 09... %..
 EQUB &C0, &E0, &70, &21, &38, &9C, &70, &35  ; B834: C0 E0 70... ..p
 EQUB &38, &1C, &0A, &05, &02, &07, &80, &00  ; B83C: 38 1C 0A... 8..
 EQUB &20, &10, &80, &02, &21, &08, &80, &10  ; B844: 20 10 80...  ..
 EQUB &02, &21, &02, &02, &21, &04, &40, &05  ; B84C: 02 21 02... .!.
 EQUB &10, &06, &40, &B0, &78, &FC, &FE, &7F  ; B854: 10 06 40... ..@
 EQUB &08, &4E, &36, &27, &13, &09, &04, &02  ; B85C: 08 4E 36... .N6
 EQUB &01, &03, &80, &C0, &A0, &50, &21, &28  ; B864: 01 03 80... ...
 EQUB &84, &08, &21, &04, &00, &21, &09, &00  ; B86C: 84 08 21... ..!
 EQUB &52, &03, &21, &08, &02, &34, &03, &01  ; B874: 52 03 21... R.!
 EQUB &82, &01, &42, &00, &AC, &F6, &55, &FE  ; B87C: 82 01 42... ..B
 EQUB &A4, &4D, &B8, &36, &3F, &1F, &0F, &07  ; B884: A4 4D B8... .M.
 EQUB &03, &01, &02, &80, &C0, &E0, &F0, &F8  ; B88C: 03 01 02... ...
 EQUB &7C, &BE, &57, &08, &40, &21, &01, &10  ; B894: 7C BE 57... |.W
 EQUB &0D, &80, &21, &02, &20, &00, &40, &00  ; B89C: 0D 80 21... ..!
 EQUB &10, &00, &21, &03, &81, &00, &20, &00  ; B8A4: 10 00 21... ..!
 EQUB &48, &00, &10, &E1, &30, &84, &22, &01  ; B8AC: 48 00 10... H..
 EQUB &05, &C0, &E0, &F0, &F8, &5C, &37, &2A  ; B8B4: 05 C0 E0... ...
 EQUB &0A, &01, &00, &04, &02, &01, &02, &80  ; B8BC: 0A 01 00... ...
 EQUB &40, &20, &10, &21, &08, &00, &80, &0F  ; B8C4: 40 20 10... @ .
 EQUB &03, &80, &02, &10, &C0, &00, &44, &00  ; B8CC: 03 80 02... ...
 EQUB &80, &02, &21, &22, &0B, &33, &15, &08  ; B8D4: 80 02 21... ..!
 EQUB &04, &06, &80, &0F, &0F, &3F, &0F, &0F  ; B8DC: 04 06 80... ...
 EQUB &0F, &0F, &0F, &40, &0F, &0D, &34, &12  ; B8E4: 0F 0F 0F... ...
 EQUB &05, &22, &04, &0C, &40, &10, &80, &00  ; B8EC: 05 22 04... .".
 EQUB &20, &0F, &0F, &04, &44, &0F, &0F, &07  ; B8F4: 20 0F 0F...  ..
 EQUB &33, &01, &0F, &3B, &05, &32, &01, &0B  ; B8FC: 33 01 0F... 3..
 EQUB &20, &04, &21, &3F, &FE, &12, &04, &21  ; B904: 20 04 21...  .!
 EQUB &3C, &F8, &FC, &FE, &04, &FC, &FF, &32  ; B90C: 3C F8 FC... <..
 EQUB &3F, &1F, &04, &FC, &33, &37, &19, &0C  ; B914: 3F 1F 04... ?..
 EQUB &05, &80, &F0, &FC, &05, &80, &F0, &FC  ; B91C: 05 80 F0... ...
 EQUB &0F, &09, &10, &21, &02, &20, &21, &04  ; B924: 0F 09 10... ...
 EQUB &0C, &20, &08, &3E, &01, &03, &07, &0F  ; B92C: 0C 20 08... . .
 EQUB &1F, &3F, &3F, &00, &01, &03, &07, &0F  ; B934: 1F 3F 3F... .??
 EQUB &1F, &37, &21, &23, &75, &DA, &FC, &F6  ; B93C: 1F 37 21... .7!
 EQUB &FB, &FD, &FE, &FF, &40, &80, &40, &20  ; B944: FB FD FE... ...
 EQUB &90, &C8, &E4, &F2, &12, &7F, &32, &3F  ; B94C: 90 C8 E4... ...
 EQUB &1F, &8F, &C7, &63, &7F, &36, &3F, &1F  ; B954: 1F 8F C7... ...
 EQUB &0F, &07, &03, &01, &00, &8F, &C7, &E3  ; B95C: 0F 07 03... ...
 EQUB &F5, &FA, &FD, &12, &21, &06, &83, &C1  ; B964: F5 FA FD... ...
 EQUB &E0, &F0, &F8, &FC, &22, &FE, &14, &7F  ; B96C: E0 F0 F8... ...
 EQUB &FF, &DF, &7E, &21, &3F, &9F, &CF, &67  ; B974: FF DF 7E... ..~
 EQUB &33, &33, &19, &0C, &0B, &40, &0F, &07  ; B97C: 33 33 19... 33.
 EQUB &22, &01, &23, &03, &21, &07, &02, &21  ; B984: 22 01 23... ".#
 EQUB &01, &00, &21, &02, &02, &21, &06, &7F  ; B98C: 01 00 21... ..!
 EQUB &FF, &BF, &4F, &87, &32, &03, &01, &80  ; B994: FF BF 4F... ..O
 EQUB &51, &88, &33, &04, &02, &01, &03, &3F  ; B99C: 51 88 33... Q.3
 EQUB &18, &F9, &FC, &7E, &32, &3F, &1F, &8F  ; B9A4: 18 F9 FC... ...
 EQUB &47, &21, &23, &B1, &D8, &EC, &F6, &FB  ; B9AC: 47 21 23... G!#
 EQUB &FD, &FE, &FF, &00, &80, &40, &20, &90  ; B9B4: FD FE FF... ...
 EQUB &E8, &F4, &FA, &12, &7F, &21, &3B, &5F  ; B9BC: E8 F4 FA... ...
 EQUB &AE, &D7, &7B, &7F, &36, &3F, &1F, &0B  ; B9C4: AE D7 7B... ..{
 EQUB &07, &02, &01, &20, &16, &77, &BB, &21  ; B9CC: 07 02 01... ...
 EQUB &06, &A3, &D1, &EA, &F7, &FB, &75, &BA  ; B9D4: 06 A3 D1... ...
 EQUB &08, &20, &80, &00, &20, &00, &20, &21  ; B9DC: 08 20 80... . .
 EQUB &04, &0F, &02, &32, &07, &01, &06, &32  ; B9E4: 04 0F 02... ...
 EQUB &07, &01, &06, &C0, &E0, &F0, &F8, &7C  ; B9EC: 07 01 06... ...
 EQUB &7E, &22, &7F, &00, &80, &C0, &E0, &70  ; B9F4: 7E 22 7F... ~".
 EQUB &78, &37, &3C, &1E, &7F, &3F, &1F, &0F  ; B9FC: 78 37 3C... x7<
 EQUB &07, &83, &41, &A8, &35, &11, &08, &04  ; BA04: 07 83 41... ..A
 EQUB &02, &01, &03, &13, &EF, &FF, &FB, &FD  ; BA0C: 02 01 03... ...
 EQUB &FE, &FD, &FF, &7F, &32, &2F, &1F, &8B  ; BA14: FE FD FF... ...
 EQUB &45, &21, &22, &BF, &FE, &EF, &BF, &FF  ; BA1C: 45 21 22... E!"
 EQUB &EF, &F7, &FB, &00, &88, &C4, &A2, &F1  ; BA24: EF F7 FB... ...
 EQUB &E8, &F5, &FA, &D5, &E8, &F4, &F8, &FC  ; BA2C: E8 F5 FA... ...
 EQUB &FE, &DF, &FF, &55, &32, &28, &14, &88  ; BA34: FE DF FF... ...
 EQUB &44, &EA, &55, &BA, &08, &21, &11, &00  ; BA3C: 44 EA 55... D.U
 EQUB &35, &01, &08, &01, &00, &02, &0F, &01  ; BA44: 35 01 08... 5..
 EQUB &80, &02, &36, &01, &06, &0E, &0F, &07  ; BA4C: 80 02 36... ..6
 EQUB &07, &03, &35, &04, &08, &0C, &06, &05  ; BA54: 07 03 35... ..5
 EQUB &FF, &FE, &34, &3C, &1A, &0D, &06, &A3  ; BA5C: FF FE 34... ..4
 EQUB &D5, &AF, &37, &16, &0C, &02, &05, &06  ; BA64: D5 AF 37... ..7
 EQUB &03, &01, &F5, &FE, &7F, &32, &3B, &1D  ; BA6C: 03 01 F5... ...
 EQUB &8E, &D7, &FB, &E0, &F0, &78, &32, &38  ; BA74: 8E D7 FB... ...
 EQUB &18, &88, &D4, &FA, &7F, &BF, &DF, &EF  ; BA7C: 18 88 D4... ...
 EQUB &F7, &FF, &7F, &FF, &33, &11, &0A, &05  ; BA84: F7 FF 7F... ...
 EQUB &82, &41, &21, &28, &57, &21, &3F, &7D  ; BA8C: 82 41 21... .A!
 EQUB &BE, &CF, &E7, &F3, &F9, &FC, &FE, &7D  ; BA94: BE CF E7... ...
 EQUB &BE, &4F, &A7, &53, &E9, &7C, &BA, &F7  ; BA9C: BE 4F A7... .O.
 EQUB &FB, &7D, &AA, &51, &E8, &D0, &62, &D7  ; BAA4: FB 7D AA... .}.
 EQUB &FB, &7D, &AA, &51, &E8, &D0, &62, &0F  ; BAAC: FB 7D AA... .}.
 EQUB &0F, &02, &31, &07, &23, &03, &22, &01  ; BAB4: 0F 02 31... ..1
 EQUB &02, &36, &06, &01, &01, &02, &00, &01  ; BABC: 02 36 06... .6.
 EQUB &02, &EA, &F7, &FB, &13, &F7, &7B, &80  ; BAC4: 02 EA F7... ...
 EQUB &40, &A0, &D1, &68, &7D, &B6, &7B, &FD  ; BACC: 40 A0 D1... @..
 EQUB &76, &FB, &FD, &FE, &13, &34, &3D, &16  ; BAD4: 76 FB FD... v..
 EQUB &0B, &15, &AA, &7D, &FF, &7F, &12, &7F  ; BADC: 0B 15 AA... ...
 EQUB &BB, &9D, &4E, &A6, &D3, &21, &1F, &AF  ; BAE4: BB 9D 4E... ..N
 EQUB &5F, &AB, &9D, &4A, &A6, &53, &7F, &BB  ; BAEC: 5F AB 9D... _..
 EQUB &DD, &AA, &44, &A2, &02, &5F, &BB, &DD  ; BAF4: DD AA 44... ..D
 EQUB &AA, &44, &A2, &02, &10, &80, &44, &A0  ; BAFC: AA 44 A2... .D.
 EQUB &10, &21, &08, &00, &82, &10, &80, &44  ; BB04: 10 21 08... .!.
 EQUB &A0, &10, &21, &08, &00, &82, &3F, &00  ; BB0C: A0 10 21... ..!
 EQUB &10, &04, &21, &01, &02, &33, &04, &0E  ; BB14: 10 04 21... ..!
 EQUB &04, &04, &21, &04, &03, &10, &03, &21  ; BB1C: 04 04 21... ..!
 EQUB &02, &0E, &C0, &21, &04, &02, &10, &06  ; BB24: 02 0E C0... ...
 EQUB &80, &21, &04, &0F, &0F, &06, &36, &03  ; BB2C: 80 21 04... .!.
 EQUB &06, &0C, &1C, &38, &38, &22, &70, &0F  ; BB34: 06 0C 1C... ...
 EQUB &08, &21, &0E, &05, &21, &08, &C0, &21  ; BB3C: 08 21 0E... .!.
 EQUB &01, &0F, &09, &78, &FC, &24, &F8, &FB  ; BB44: 01 0F 09... ...
 EQUB &FE, &03, &32, &01, &0F, &78, &C0, &02  ; BB4C: FE 03 32... ..2
 EQUB &32, &03, &3E, &F0, &04, &78, &C0, &0F  ; BB54: 32 03 3E... 2.>
 EQUB &06, &21, &03, &04, &37, &07, &38, &C0  ; BB5C: 06 21 03... .!.
 EQUB &02, &00, &03, &1E, &F0, &80, &03, &78  ; BB64: 02 00 03... ...
 EQUB &FC, &7D, &35, &3E, &1F, &0F, &07, &01  ; BB6C: FC 7D 35... .}5
 EQUB &05, &C0, &A0, &C0, &0F, &09, &21, &07  ; BB74: 05 C0 A0... ...
 EQUB &07, &E0, &0F, &08, &74, &0F, &0F, &0F  ; BB7C: 07 E0 0F... ...
 EQUB &01, &21, &08, &08, &20, &00, &21, &28  ; BB84: 01 21 08... .!.
 EQUB &00, &20, &00, &21, &08, &0F, &0F, &0C  ; BB8C: 00 20 00... . .
 EQUB &20, &02, &21, &04, &0F, &20, &0A, &21  ; BB94: 20 02 21...  .!
 EQUB &01, &06, &21, &18, &40, &04, &80, &03  ; BB9C: 01 06 21... ..!
 EQUB &40, &07, &3F, &80, &21, &01, &00, &21  ; BBA4: 40 07 3F... @.?
 EQUB &08, &00, &80, &10, &00, &21, &04, &00  ; BBAC: 08 00 80... ...
 EQUB &21, &04, &80, &21, &04, &00, &21, &08  ; BBB4: 21 04 80... !..
 EQUB &02, &40, &00, &21, &04, &02, &21, &02  ; BBBC: 02 40 00... .@.
 EQUB &30, &10, &02, &21, &01, &10, &04, &20  ; BBC4: 30 10 02... 0..
 EQUB &00, &21, &04, &03, &20, &40, &03, &21  ; BBCC: 00 21 04... .!.
 EQUB &02, &04, &10, &06, &81, &00, &10, &02  ; BBD4: 02 04 10... ...
 EQUB &80, &21, &02, &0F, &0B, &36, &01, &03  ; BBDC: 80 21 02... .!.
 EQUB &0A, &16, &75, &3E, &6C, &80, &0F, &06  ; BBE4: 0A 16 75... ..u
 EQUB &32, &01, &11, &05, &32, &17, &38, &80  ; BBEC: 32 01 11... 2..
 EQUB &0F, &09, &D7, &72, &E4, &F4, &F7, &F5  ; BBF4: 0F 09 D7... ...
 EQUB &E5, &4F, &03, &80, &32, &07, &3C, &E0  ; BBFC: E5 4F 03... .O.
 EQUB &02, &32, &07, &1C, &E0, &80, &03, &B0  ; BC04: 02 32 07... .2.
 EQUB &80, &21, &02, &05, &21, &08, &60, &0C  ; BC0C: 80 21 02... .!.
 EQUB &32, &01, &05, &03, &32, &01, &0F, &7C  ; BC14: 32 01 05... 2..
 EQUB &60, &85, &00, &32, &07, &3C, &E0, &00  ; BC1C: 60 85 00... `..
 EQUB &21, &04, &60, &00, &74, &C7, &36, &3E  ; BC24: 21 04 60... !.`
 EQUB &1D, &0C, &05, &03, &02, &C0, &A0, &C0  ; BC2C: 1D 0C 05... ...
 EQUB &80, &C8, &30, &59, &BE, &0F, &09, &21  ; BC34: 80 C8 30... ..0
 EQUB &03, &07, &90, &0F, &21, &01, &03, &21  ; BC3C: 03 07 90... ...
 EQUB &08, &03, &8B, &21, &3F, &07, &C0, &0F  ; BC44: 08 03 8B... ...
 EQUB &0D, &21, &04, &08, &21, &08, &08, &20  ; BC4C: 0D 21 04... .!.
 EQUB &00, &21, &28, &00, &21, &22, &00, &21  ; BC54: 00 21 28... .!(
 EQUB &08, &05, &80, &02, &21, &04, &07, &21  ; BC5C: 08 05 80... ...
 EQUB &02, &0F, &0A, &20, &02, &21, &04, &00  ; BC64: 02 0F 0A... ...
 EQUB &32, &0A, &1D, &05, &32, &0C, &21, &80  ; BC6C: 32 0A 1D... 2..
 EQUB &02, &21, &08, &00, &20, &02, &80, &00  ; BC74: 02 21 08... .!.
 EQUB &33, &11, &08, &14, &BE, &20, &80, &21  ; BC7C: 33 11 08... 3..
 EQUB &01, &00, &10, &00, &80, &02, &21, &18  ; BC84: 01 00 10... ...
 EQUB &40, &04, &80, &00, &32, &05, &2B, &40  ; BC8C: 40 04 80... @..
 EQUB &00, &32, &01, &07, &00, &40, &C0, &D0  ; BC94: 00 32 01... .2.
 EQUB &3F, &0F, &0F, &0F, &05, &80, &07, &80  ; BC9C: 3F 0F 0F... ?..
 EQUB &0F, &0F, &0D, &20, &07, &20, &05, &21  ; BCA4: 0F 0F 0D... ...
 EQUB &04, &07, &21, &04, &05, &10, &07, &10  ; BCAC: 04 07 21... ..!
 EQUB &0C, &10, &07, &10, &80, &06, &21, &04  ; BCB4: 0C 10 07... ...
 EQUB &80, &06, &21, &04, &0F, &0F, &0F, &0F  ; BCBC: 80 06 21... ..!
 EQUB &06, &20, &07, &20, &05, &80, &02, &21  ; BCC4: 06 20 07... . .
 EQUB &02, &02, &20, &00, &80, &02, &21, &02  ; BCCC: 02 02 20... ..
 EQUB &02, &20, &05, &21, &04, &00, &40, &05  ; BCD4: 02 20 05... . .
 EQUB &21, &04, &00, &40, &02, &80, &04, &10  ; BCDC: 21 04 00... !..
 EQUB &21, &04, &00, &80, &04, &10, &21, &04  ; BCE4: 21 04 00... !..
 EQUB &0F, &0F, &0F, &06, &21, &01, &00, &21  ; BCEC: 0F 0F 0F... ...
 EQUB &04, &00, &21, &02, &03, &21, &01, &00  ; BCF4: 04 00 21... ..!
 EQUB &21, &04, &00, &21, &02, &00, &21, &04  ; BCFC: 21 04 00... !..
 EQUB &00, &10, &21, &01, &00, &84, &21, &11  ; BD04: 00 10 21... ..!
 EQUB &00, &21, &04, &00, &10, &21, &01, &00  ; BD0C: 00 21 04... .!.
 EQUB &84, &34, &11, &02, &40, &08, &A1, &54  ; BD14: 84 34 11... .4.
 EQUB &AA, &74, &F8, &21, &02, &40, &21, &08  ; BD1C: AA 74 F8... .t.
 EQUB &A1, &54, &AA, &74, &F8, &21, &08, &20  ; BD24: A1 54 AA... .T.
 EQUB &21, &04, &02, &36, &01, &0F, &30, &08  ; BD2C: 21 04 02... !..
 EQUB &20, &04, &02, &32, &01, &0F, &30, &40  ; BD34: 20 04 02...  ..
 EQUB &02, &34, &03, &1E, &F0, &07, &7F, &40  ; BD3C: 02 34 03... .4.
 EQUB &02, &34, &03, &1E, &F0, &07, &7F, &03  ; BD44: 02 34 03... .4.
 EQUB &C0, &00, &F0, &F8, &FC, &03, &C0, &00  ; BD4C: C0 00 F0... ...
 EQUB &F0, &F8, &FC, &3F, &0F, &07, &32, &01  ; BD54: F0 F8 FC... ...
 EQUB &03, &06, &36, &01, &03, &15, &0A, &17  ; BD5C: 03 06 36... ..6
 EQUB &3D, &6F, &12, &BD, &34, &15, &0A, &17  ; BD64: 3D 6F 12... =o.
 EQUB &3D, &6F, &12, &BD, &40, &AA, &55, &EB  ; BD6C: 3D 6F 12... =o.
 EQUB &BE, &FF, &F7, &FF, &40, &AA, &55, &EB  ; BD74: BE FF F7... ...
 EQUB &BE, &FF, &F7, &FF, &F8, &F7, &7F, &15  ; BD7C: BE FF F7... ...
 EQUB &F8, &D7, &7F, &FF, &7B, &FF, &AE, &55  ; BD84: F8 D7 7F... ...
 EQUB &21, &07, &FF, &7E, &15, &21, &07, &FF  ; BD8C: 21 07 FF... !..
 EQUB &7E, &FF, &F7, &BE, &EB, &55, &DF, &17  ; BD94: 7E FF F7... ~..
 EQUB &DF, &FB, &FF, &DF, &FE, &F5, &A8, &00  ; BD9C: DF FB FF... ...
 EQUB &EE, &12, &25, &80, &AE, &FF, &EF, &00  ; BDA4: EE 12 25... ..%
 EQUB &A2, &00, &21, &2A, &02, &C0, &FF, &35  ; BDAC: A2 00 21... ..!
 EQUB &3F, &1F, &0F, &07, &07, &00, &C0, &FF  ; BDB4: 3F 1F 0F... ?..
 EQUB &21, &3F, &9B, &21, &0D, &80, &00, &32  ; BDBC: 21 3F 9B... !?.
 EQUB &0F, &3F, &FB, &15, &32, &0E, &3F, &FB  ; BDC4: 0F 3F FB... .?.
 EQUB &FF, &BD, &57, &8A, &00, &17, &FE, &12  ; BDCC: FF BD 57... ..W
 EQUB &F7, &BF, &EE, &55, &88, &21, &02, &12  ; BDD4: F7 BF EE... ...
 EQUB &EF, &13, &F8, &00, &7F, &FF, &ED, &FF  ; BDDC: EF 13 F8... ...
 EQUB &DA, &75, &A8, &00, &13, &FE, &04, &A8  ; BDE4: DA 75 A8... .u.
 EQUB &02, &21, &02, &02, &50, &00, &FF, &FE  ; BDEC: 02 21 02... .!.
 EQUB &E0, &05, &A0, &21, &02, &20, &02, &20  ; BDF4: E0 05 A0... ...
 EQUB &00, &21, &22, &FF, &21, &07, &07, &21  ; BDFC: 00 21 22... .!"
 EQUB &06, &03, &80, &00, &23, &80, &06, &21  ; BE04: 06 03 80... ...
 EQUB &0A, &00, &21, &02, &00, &21, &08, &00  ; BE0C: 0A 00 21... ..!
 EQUB &21, &22, &00, &22, &07, &21, &04, &05  ; BE14: 21 22 00... !".
 EQUB &80, &00, &84, &21, &01, &00, &21, &01  ; BE1C: 80 00 84... ...
 EQUB &80, &21, &01, &FF, &8F, &07, &88, &00  ; BE24: 80 21 01... .!.
 EQUB &40, &00, &40, &00, &40, &F8, &C0, &06  ; BE2C: 40 00 40... @.@
 EQUB &21, &08, &40, &03, &40, &0D, &21, &02  ; BE34: 21 08 40... !.@
 EQUB &00, &10, &21, &01, &09, &54, &00, &54  ; BE3C: 00 10 21... ..!
 EQUB &00, &40, &21, &0A, &40, &21, &0A, &03  ; BE44: 00 40 21... .@!
 EQUB &32, &09, &12, &04, &21, &0A, &03, &80  ; BE4C: 32 09 12... 2..
 EQUB &00, &80, &08, &21, &01, &80, &00, &21  ; BE54: 00 80 08... ...
 EQUB &13, &0C, &21, &2A, &00, &21, &22, &00  ; BE5C: 13 0C 21... ..!
 EQUB &21, &0A, &00, &21, &2A, &09, &80, &00  ; BE64: 21 0A 00... !..
 EQUB &80, &03, &21, &04, &20, &0B, &21, &02  ; BE6C: 80 03 21... ..!
 EQUB &10, &80, &00, &21, &02, &09, &21, &04  ; BE74: 10 80 00... ...
 EQUB &20, &00, &21, &02, &10, &40, &09, &32  ; BE7C: 20 00 21...  .!
 EQUB &01, &04, &20, &80, &00, &21, &15, &00  ; BE84: 01 04 20... ..
 EQUB &21, &05, &3F, &43, &00, &63, &00, &70  ; BE8C: 21 05 3F... !.?
 EQUB &00, &79, &00, &72, &00, &69, &00, &67  ; BE94: 00 79 00... .y.
 EQUB &00, &68, &00, &74, &00, &20, &00, &28  ; BE9C: 00 68 00... .h.
 EQUB &00, &43, &00, &29, &00, &20, &00, &44  ; BEA4: 00 43 00... .C.
 EQUB &00, &2E, &00, &42, &00, &72, &00, &61  ; BEAC: 00 2E 00... ...
 EQUB &00, &62, &00, &65, &00, &6E, &00, &2C  ; BEB4: 00 62 00... .b.
 EQUB &00, &20, &00, &49, &00, &2E, &00, &42  ; BEBC: 00 20 00... . .
 EQUB &00, &65, &00, &6C, &00, &6C, &00, &20  ; BEC4: 00 65 00... .e.
 EQUB &00, &31, &00, &39, &00, &39, &00, &31  ; BECC: 00 31 00... .1.
 EQUB &00, &2E, &00                           ; BED4: 00 2E 00    ...

 JSR sub_CBEEA                                ; BED7: 20 EA BE     ..
 LDA #4                                       ; BEDA: A9 04       ..
 STA PPU_ADDR                                 ; BEDC: 8D 06 20    ..
 LDA #&50 ; 'P'                               ; BEDF: A9 50       .P
 STA PPU_ADDR                                 ; BEE1: 8D 06 20    ..
 JSR LF5AF                                    ; BEE4: 20 AF F5     ..
 JMP LF5B1                                    ; BEE7: 4C B1 F5    L..

.sub_CBEEA
 LDA #0                                       ; BEEA: A9 00       ..
 STA SCH                                      ; BEEC: 85 08       ..
 LDA L046C                                    ; BEEE: AD 6C 04    .l.
 ASL A                                        ; BEF1: 0A          .
 ROL SCH                                      ; BEF2: 26 08       &.
 ASL A                                        ; BEF4: 0A          .
 ROL SCH                                      ; BEF5: 26 08       &.
 ASL A                                        ; BEF7: 0A          .
 ROL SCH                                      ; BEF8: 26 08       &.
 STA SC                                       ; BEFA: 85 07       ..
 STA T5                                       ; BEFC: 85 BA       ..
 LDA SCH                                      ; BEFE: A5 08       ..
 ADC #&68 ; 'h'                               ; BF00: 69 68       ih
 STA T5_1                                     ; BF02: 85 BB       ..
 LDA SCH                                      ; BF04: A5 08       ..
 ADC #&60 ; '`'                               ; BF06: 69 60       i`
 STA SCH                                      ; BF08: 85 08       ..
 LDA QQ15_1                                   ; BF0A: A5 83       ..
 EOR QQ15_4                                   ; BF0C: 45 86       E.
 EOR QQ15_3                                   ; BF0E: 45 85       E.
 AND #&0F                                     ; BF10: 29 0F       ).
 TAX                                          ; BF12: AA          .
 CPX L800C                                    ; BF13: EC 0C 80    ...
 BCC CBF1C                                    ; BF16: 90 04       ..
 LDX L800C                                    ; BF18: AE 0C 80    ...
 DEX                                          ; BF1B: CA          .
.CBF1C
 TXA                                          ; BF1C: 8A          .
 ORA #&C0                                     ; BF1D: 09 C0       ..
 STA L048B                                    ; BF1F: 8D 8B 04    ...
 TXA                                          ; BF22: 8A          .
 ASL A                                        ; BF23: 0A          .
 TAX                                          ; BF24: AA          .
 LDA L800E,X                                  ; BF25: BD 0E 80    ...
 ADC #&0C                                     ; BF28: 69 0C       i.
 STA V                                        ; BF2A: 85 63       .c
 LDA L800F,X                                  ; BF2C: BD 0F 80    ...
 ADC #&80                                     ; BF2F: 69 80       i.
 STA V_1                                      ; BF31: 85 64       .d
 JSR LF52D                                    ; BF33: 20 2D F5     -.
 LDA T5                                       ; BF36: A5 BA       ..
 STA SC                                       ; BF38: 85 07       ..
 LDA T5_1                                     ; BF3A: A5 BB       ..
 STA SCH                                      ; BF3C: 85 08       ..
 JMP LF52D                                    ; BF3E: 4C 2D F5    L-.

 LDA #5                                       ; BF41: A9 05       ..
 JSR LE909                                    ; BF43: 20 09 E9     ..
 JSR LF362                                    ; BF46: 20 62 F3     b.
 LDX LANG                                     ; BF49: AE A8 04    ...
 LDA LBF64,X                                  ; BF4C: BD 64 BF    .d.
 STA L00FA                                    ; BF4F: 85 FA       ..
 LDA LBF68,X                                  ; BF51: BD 68 BF    .h.
 STA L00FB                                    ; BF54: 85 FB       ..
 LDA #0                                       ; BF56: A9 00       ..
 STA L04BC                                    ; BF58: 8D BC 04    ...
 STA L04BD                                    ; BF5B: 8D BD 04    ...
 LDX #&80                                     ; BF5E: A2 80       ..
 STX L03EE                                    ; BF60: 8E EE 03    ...
 RTS                                          ; BF63: 60          `

.LBF64
 EQUB &B0, &02, &53, &B0                      ; BF64: B0 02 53... ..S
.LBF68
 EQUB &E5, &E6, &E6, &E5, &FF, &FF, &FF, &FF  ; BF68: E5 E6 E6... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF70: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF78: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF80: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF88: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF90: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BF98: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFA0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFA8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFB0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFB8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFC0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFC8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFD0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFD8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFE0: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFE8: FF FF FF... ...
 EQUB &FF, &FF, &FF, &FF, &FF, &FF, &FF, &FF  ; BFF0: FF FF FF... ...
 EQUB &FF, &FF,   7, &C0,   0, &C0,   7, &C0  ; BFF8: FF FF 07... ...
.pydis_end

\ ******************************************************************************
\
\ Save bank5.bin
\
\ ******************************************************************************

 PRINT "S.bank5.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "3-assembled-output/bank5.bin", CODE%, P%, LOAD%
