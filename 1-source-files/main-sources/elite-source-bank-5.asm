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

\ ******************************************************************************
\
\ Configuration variables
\
\ ******************************************************************************

 S% = &C007             \ The game's main entry point in bank 7

 PPU_CTRL   = &2000     \ NES PPU registers
 PPU_MASK   = &2001
 PPU_STATUS = &2002
 OAM_ADDR   = &2003
 OAM_DATA   = &2004
 PPU_SCROLL = &2005
 PPU_ADDR   = &2006
 PPU_DATA   = &2007
 OAM_DMA    = &4014

\ ******************************************************************************
\
\       Name: ZP
\       Type: Workspace
\    Address: &0000 to &00B0
\   Category: Workspaces
\    Summary: Lots of important variables are stored in the zero page workspace
\             as it is quicker and more space-efficient to access memory here
\
\ ******************************************************************************

 ORG &0000

.ZP

 SKIP 0                 \ The start of the zero page workspace

 SKIP 2                 \ These bytes appear to be unused

.RAND

 SKIP 4                 \ Four 8-bit seeds for the random number generation
                        \ system implemented in the DORND routine

.T1

 SKIP 1                 \ Temporary storage, used in a number of places

.SC

 SKIP 1                 \ Screen address (low byte)
                        \
                        \ Elite draws on-screen by poking bytes directly into
                        \ screen memory, and SC(1 0) is typically set to the
                        \ address of the character block containing the pixel

.SCH

 SKIP 1                 \ Screen address (high byte)

.XX1

 SKIP 0                 \ This is an alias for INWK that is used in the main
                        \ ship-drawing routine at LL9

.INWK

 SKIP 33                \ The zero-page internal workspace for the current ship
                        \ data block
                        \
                        \ As operations on zero page locations are faster and
                        \ have smaller opcodes than operations on the rest of
                        \ the addressable memory, Elite tends to store oft-used
                        \ data here. A lot of the routines in Elite need to
                        \ access and manipulate ship data, so to make this an
                        \ efficient exercise, the ship data is first copied from
                        \ the ship data blocks at K% into INWK (or, when new
                        \ ships are spawned, from the blueprints at XX21). See
                        \ the deep dive on "Ship data blocks" for details of
                        \ what each of the bytes in the INWK data block
                        \ represents

.L002A

 SKIP 1                 \ ???

.L002B

 SKIP 1                 \ ???

.L002C

 SKIP 1                 \ ???

.NEWB

 SKIP 1                 \ The ship's "new byte flags" (or NEWB flags)
                        \
                        \ Contains details about the ship's type and associated
                        \ behaviour, such as whether they are a trader, a bounty
                        \ hunter, a pirate, currently hostile, in the process of
                        \ docking, inside the hold having been scooped, and so
                        \ on. The default values for each ship type are taken
                        \ from the table at E%, and you can find out more detail
                        \ in the deep dive on "Advanced tactics with the NEWB
                        \ flags"

.L002E

 SKIP 1                 \ ???

.P

 SKIP 3                 \ Temporary storage, used in a number of places

.XC

 SKIP 1                 \ The x-coordinate of the text cursor (i.e. the text
                        \ column), which can be from 0 to 32
                        \
                        \ A value of 0 denotes the leftmost column and 32 the
                        \ rightmost column, but because the top part of the
                        \ screen (the space view) has a white border that
                        \ clashes with columns 0 and 32, text is only shown
                        \ in columns 1-31

.hiddenColour

 SKIP 1                 \ ???

.visibleColour

 SKIP 1                 \ ???

.paletteColour1

 SKIP 1                 \ ???

.paletteColour2

 SKIP 1                 \ ???

.L0037

 SKIP 1                 \ ???

.nmiTimer

 SKIP 1                 \ ???

.nmiTimerLo

 SKIP 1                 \ ???

.nmiTimerHi

 SKIP 1                 \ ???

.YC

 SKIP 1                 \ The y-coordinate of the text cursor (i.e. the text
                        \ row), which can be from 0 to 23
                        \
                        \ The screen actually has 31 character rows if you
                        \ include the dashboard, but the text printing routines
                        \ only work on the top part (the space view), so the
                        \ text cursor only goes up to a maximum of 23, the row
                        \ just before the screen splits
                        \
                        \ A value of 0 denotes the top row, but because the
                        \ top part of the screen has a white border that clashes
                        \ with row 0, text is always shown at row 1 or greater

.QQ17

 SKIP 1                 \ Contains a number of flags that affect how text tokens
                        \ are printed, particularly capitalisation:
                        \
                        \   * If all bits are set (255) then text printing is
                        \     disabled
                        \
                        \   * Bit 7: 0 = ALL CAPS
                        \            1 = Sentence Case, bit 6 determines the
                        \                case of the next letter to print
                        \
                        \   * Bit 6: 0 = print the next letter in upper case
                        \            1 = print the next letter in lower case
                        \
                        \   * Bits 0-5: If any of bits 0-5 are set, print in
                        \               lower case
                        \
                        \ So:
                        \
                        \   * QQ17 = 0 means case is set to ALL CAPS
                        \
                        \   * QQ17 = %10000000 means Sentence Case, currently
                        \            printing upper case
                        \
                        \   * QQ17 = %11000000 means Sentence Case, currently
                        \            printing lower case
                        \
                        \   * QQ17 = %11111111 means printing is disabled

.K3

 SKIP 0                 \ Temporary storage, used in a number of places

.XX2

 SKIP 14                \ Temporary storage, used to store the visibility of the
                        \ ship's faces during the ship-drawing routine at LL9

.K4

 SKIP 2                 \ Temporary storage, used in a number of places

.XX16

 SKIP 18                \ Temporary storage for a block of values, used in a
                        \ number of places

.XX0

 SKIP 2                 \ Temporary storage, used to store the address of a ship
                        \ blueprint. For example, it is used when we add a new
                        \ ship to the local bubble in routine NWSHP, and it
                        \ contains the address of the current ship's blueprint
                        \ as we loop through all the nearby ships in the main
                        \ flight loop

.XX19

 SKIP 0                 \ Instead of pointing XX19 to the ship heap address in
                        \ INWK(34 33), like the other versions of Elite, the NES
                        \ version points XX19 to the ship blueprint address in
                        \ INF(1 0)

.INF

 SKIP 2                 \ Temporary storage, typically used for storing the
                        \ address of a ship's data block, so it can be copied
                        \ to and from the internal workspace at INWK

.V

 SKIP 2                 \ Temporary storage, typically used for storing an
                        \ address pointer

.XX

 SKIP 2                 \ Temporary storage, typically used for storing a 16-bit
                        \ x-coordinate

.YY

 SKIP 2                 \ Temporary storage, typically used for storing a 16-bit
                        \ y-coordinate

.BETA

 SKIP 1                 \ The current pitch angle beta, which is reduced from
                        \ JSTY to a sign-magnitude value between -8 and +8
                        \
                        \ This describes how fast we are pitching our ship, and
                        \ determines how fast the universe pitches around us
                        \
                        \ The sign bit is also stored in BET2, while the
                        \ opposite sign is stored in BET2+1

.BET1

 SKIP 1                 \ The magnitude of the pitch angle beta, i.e. |beta|,
                        \ which is a positive value between 0 and 8

.QQ22

 SKIP 2                 \ The two hyperspace countdown counters
                        \
                        \ Before a hyperspace jump, both QQ22 and QQ22+1 are
                        \ set to 15
                        \
                        \ QQ22 is an internal counter that counts down by 1
                        \ each time TT102 is called, which happens every
                        \ iteration of the main game loop. When it reaches
                        \ zero, the on-screen counter in QQ22+1 gets
                        \ decremented, and QQ22 gets set to 5 and the countdown
                        \ continues (so the first tick of the hyperspace counter
                        \ takes 15 iterations to happen, but subsequent ticks
                        \ take 5 iterations each)
                        \
                        \ QQ22+1 contains the number that's shown on-screen
                        \ during the countdown. It counts down from 15 to 1, and
                        \ when it hits 0, the hyperspace engines kick in

.ECMA

 SKIP 1                 \ The E.C.M. countdown timer, which determines whether
                        \ an E.C.M. system is currently operating:
                        \
                        \   * 0 = E.C.M. is off
                        \
                        \   * Non-zero = E.C.M. is on and is counting down
                        \
                        \ The counter starts at 32 when an E.C.M. is activated,
                        \ either by us or by an opponent, and it decreases by 1
                        \ in each iteration of the main flight loop until it
                        \ reaches zero, at which point the E.C.M. switches off.
                        \ Only one E.C.M. can be active at any one time, so
                        \ there is only one counter

.ALP1

 SKIP 1                 \ Magnitude of the roll angle alpha, i.e. |alpha|,
                        \ which is a positive value between 0 and 31

.ALP2

 SKIP 2                 \ Bit 7 of ALP2 = sign of the roll angle in ALPHA
                        \
                        \ Bit 7 of ALP2+1 = opposite sign to ALP2 and ALPHA

.XX15

 SKIP 0                 \ Temporary storage, typically used for storing screen
                        \ coordinates in line-drawing routines
                        \
                        \ There are six bytes of storage, from XX15 TO XX15+5.
                        \ The first four bytes have the following aliases:
                        \
                        \   X1 = XX15
                        \   Y1 = XX15+1
                        \   X2 = XX15+2
                        \   Y2 = XX15+3
                        \
                        \ These are typically used for describing lines in terms
                        \ of screen coordinates, i.e. (X1, Y1) to (X2, Y2)
                        \
                        \ The last two bytes of XX15 do not have aliases

.X1

 SKIP 1                 \ Temporary storage, typically used for x-coordinates in
                        \ line-drawing routines

.Y1

 SKIP 1                 \ Temporary storage, typically used for y-coordinates in
                        \ line-drawing routines

.X2

 SKIP 1                 \ Temporary storage, typically used for x-coordinates in
                        \ line-drawing routines

.Y2

 SKIP 1                 \ Temporary storage, typically used for y-coordinates in
                        \ line-drawing routines

 SKIP 2                 \ The last two bytes of the XX15 block

.XX12

 SKIP 6                 \ Temporary storage for a block of values, used in a
                        \ number of places

.K

 SKIP 4                 \ Temporary storage, used in a number of places

.L0081

 SKIP 1                 \ ???

.QQ15

 SKIP 6                 \ The three 16-bit seeds for the selected system, i.e.
                        \ the one in the crosshairs in the Short-range Chart
                        \
                        \ See the deep dives on "Galaxy and system seeds" and
                        \ "Twisting the system seeds" for more details

.K5

 SKIP 0                 \ Temporary storage used to store segment coordinates
                        \ across successive calls to BLINE, the ball line
                        \ routine

.XX18

 SKIP 4                 \ Temporary storage used to store coordinates in the
                        \ LL9 ship-drawing routine

.K6

 SKIP 5                 \ Temporary storage, typically used for storing
                        \ coordinates during vector calculations

.BET2

 SKIP 2                 \ Bit 7 of BET2 = sign of the pitch angle in BETA
                        \
                        \ Bit 7 of BET2+1 = opposite sign to BET2 and BETA

.DELTA

 SKIP 1                 \ Our current speed, in the range 1-40

.DELT4

 SKIP 2                 \ Our current speed * 64 as a 16-bit value
                        \
                        \ This is stored as DELT4(1 0), so the high byte in
                        \ DELT4+1 therefore contains our current speed / 4

.U

 SKIP 1                 \ Temporary storage, used in a number of places

.Q

 SKIP 1                 \ Temporary storage, used in a number of places

.R

 SKIP 1                 \ Temporary storage, used in a number of places

.S

 SKIP 1                 \ Temporary storage, used in a number of places

.T

 SKIP 1                 \ Temporary storage, used in a number of places

.XSAV

 SKIP 1                 \ Temporary storage for saving the value of the X
                        \ register, used in a number of places

.YSAV

 SKIP 1                 \ Temporary storage for saving the value of the Y
                        \ register, used in a number of places

.XX17

 SKIP 1                 \ Temporary storage, used in BPRNT to store the number
                        \ of characters to print, and as the edge counter in the
                        \ main ship-drawing routine

.QQ11

 SKIP 1                 \ The number of the current view:
                        \
                        \   0   = Space view
                        \   1   = Title screen
                        \         Get commander name ("@", save/load commander)
                        \         In-system jump just arrived ("J")
                        \
                        \ This value is typically set by calling routine TT66

.QQ11a

 SKIP 1

.ZZ

 SKIP 1                 \ Temporary storage, typically used for distance values

.XX13

 SKIP 1                 \ Temporary storage, typically used in the line-drawing
                        \ routines

.MCNT

 SKIP 1                 \ The main loop counter
                        \
                        \ This counter determines how often certain actions are
                        \ performed within the main loop. See the deep dive on
                        \ "Scheduling tasks with the main loop counter" for more
                        \ details

.TYPE

 SKIP 1                 \ The current ship type
                        \
                        \ This is where we store the current ship type for when
                        \ we are iterating through the ships in the local bubble
                        \ as part of the main flight loop. See the table at XX21
                        \ for information about ship types

.ALPHA

 SKIP 1                 \ The current roll angle alpha, which is reduced from
                        \ JSTX to a sign-magnitude value between -31 and +31
                        \
                        \ This describes how fast we are rolling our ship, and
                        \ determines how fast the universe rolls around us
                        \
                        \ The sign bit is also stored in ALP2, while the
                        \ opposite sign is stored in ALP2+1

.QQ12

 SKIP 1                 \ Our "docked" status
                        \
                        \   * 0 = we are not docked
                        \
                        \   * &FF = we are docked

.TGT

 SKIP 1                 \ Temporary storage, typically used as a target value
                        \ for counters when drawing explosion clouds and partial
                        \ circles

.FLAG

 SKIP 1                 \ A flag that's used to define whether this is the first
                        \ call to the ball line routine in BLINE, so it knows
                        \ whether to wait for the second call before storing
                        \ segment data in the ball line heap

.CNT

 SKIP 1                 \ Temporary storage, typically used for storing the
                        \ number of iterations required when looping

.CNT2

 SKIP 1                 \ Temporary storage, used in the planet-drawing routine
                        \ to store the segment number where the arc of a partial
                        \ circle should start

.STP

 SKIP 1                 \ The step size for drawing circles
                        \
                        \ Circles in Elite are split up into 64 points, and the
                        \ step size determines how many points to skip with each
                        \ straight-line segment, so the smaller the step size,
                        \ the smoother the circle. The values used are:
                        \
                        \   * 2 for big planets and the circles on the charts
                        \   * 4 for medium planets and the launch tunnel
                        \   * 8 for small planets and the hyperspace tunnel
                        \
                        \ As the step size increases we move from smoother
                        \ circles at the top to more polygonal at the bottom.
                        \ See the CIRCLE2 routine for more details

.XX4

 SKIP 1                 \ Temporary storage, used in a number of places

.XX20

 SKIP 1                 \ Temporary storage, used in a number of places

.XX14

 SKIP 1                 \ This byte appears to be unused

.RAT

 SKIP 1                 \ Used to store different signs depending on the current
                        \ space view, for use in calculating stardust movement

.RAT2

 SKIP 1                 \ Temporary storage, used to store the pitch and roll
                        \ signs when moving objects and stardust

.widget

 SKIP 1                 \ Temporary storage, used to store the original argument
                        \ in A in the logarithmic FMLTU and LL28 routines

.Yx1M2

 SKIP 1                 \ ???

.Yx2M2

 SKIP 1                 \ ???

.Yx2M1

 SKIP 1                 \ This is used to store the number of pixel rows in the
                        \ space view, which is also the y-coordinate of the
                        \ bottom pixel row of the space view

.messXC

 SKIP 1                 \ Temporary storage, used to store the text column
                        \ of the in-flight message in MESS, so it can be erased
                        \ from the screen at the correct time

.L00B5

 SKIP 1                 \ ???

.newzp

 SKIP 1                 \ This is used by the STARS2 routine for storing the
                        \ stardust particle's delta_x value

.L00B7

 SKIP 1                 \ ???

.tileNumber

 SKIP 1                 \ ???

.pattBufferHi

 SKIP 1                 \ ???

.SC2

 SKIP 2                 \ ???

.L00BC

 SKIP 1                 \ ???

.L00BD

 SKIP 1                 \ ???

.L00BE

 SKIP 1                 \ ???

.L00BF

 SKIP 1                 \ ???

.drawingPhase

 SKIP 1                 \ ???

.tileNumber0

 SKIP 2                 \ ???

.tileNumber1

 SKIP 2                 \ ???

.tileNumber2

 SKIP 2                 \ ???

.tileNumber3

 SKIP 2                 \ ???

.L00C9

 SKIP 1                 \ ???

.L00CA

 SKIP 1                 \ ???

.L00CB

 SKIP 1                 \ ???

.L00CC

 SKIP 1                 \ ???

.L00CD

 SKIP 1                 \ ???

.L00CE

 SKIP 1                 \ ???

.L00CF

 SKIP 1                 \ ???

.tempVar

 SKIP 2                 \ ???

.L00D2

 SKIP 1                 \ ???

.L00D3

 SKIP 1                 \ ???

.addr1

 SKIP 2                 \ ???

.L00D6

 SKIP 1                 \ ???

.L00D7

 SKIP 1                 \ ???

.L00D8

 SKIP 1                 \ ???

.L00D9

 SKIP 1                 \ ???

.L00DA

 SKIP 1                 \ ???

.L00DB

 SKIP 11                \ ???

.nameBufferHi

 SKIP 1                 \ ???

.L00E7

 SKIP 1                 \ ???

.L00E8

 SKIP 1                 \ ???

.setupPPUForIconBar

 SKIP 1                 \ ???

.showUserInterface

 SKIP 1                 \ ???

.addr4

 SKIP 2                 \ ???

.addr5

 SKIP 2                 \ ???

.L00EF

 SKIP 1                 \ ???

.L00F0

 SKIP 1                 \ ???

.addr6

 SKIP 2                 \ ???

.palettePhase

 SKIP 1                 \ ???

.otherPhase

 SKIP 1                 \ ???

.ppuCtrlCopy

 SKIP 1                 \ ???

.L00F6

 SKIP 1                 \ ???

.currentBank

 SKIP 1                 \ ???

.runningSetBank

 SKIP 1                 \ ???

.L00F9

 SKIP 1                 \ ???

.addr2

 SKIP 2                 \ ???

.L00FC

 SKIP 1                 \ ???

.L00FD

 SKIP 1                 \ ???

.L00FE

 SKIP 1                 \ ???

.L00FF

 SKIP 1                 \ ???

 PRINT "Zero page variables from ", ~ZP, " to ", ~P%

\ ******************************************************************************
\
\       Name: XX3
\       Type: Workspace
\    Address: &0100 to the top of the descending stack
\   Category: Workspaces
\    Summary: Temporary storage space for complex calculations
\
\ ------------------------------------------------------------------------------
\
\ Used as heap space for storing temporary data during calculations. Shared with
\ the descending 6502 stack, which works down from &01FF.
\
\ ******************************************************************************

 ORG &0100

.XX3

 SKIP 0                 \ Temporary storage, typically used for storing tables
                        \ of values such as screen coordinates or ship data

\ ******************************************************************************
\
\       Name: WP
\       Type: Workspace
\    Address: &0300 to &05FF
\   Category: Workspaces
\    Summary: Ship slots, variables
\
\ ******************************************************************************

L03EE             = &03EE
pictureTile       = &046C
systemFlag        = &048B
language          = &04A8
L04BC             = &04BC
L04BD             = &04BD
pattBuffer0       = &6000
pattBuffer1       = &6800
LE5B0_EN          = &E5B0
LE602_DE          = &E602
LE653_FR          = &E653
subm_E909         = &E909
subm_F362         = &F362
UnpackToRAM       = &F52D
UnpackToPPU       = &F5AF

\ ******************************************************************************
\
\       Name: K%
\       Type: Workspace
\    Address: &0600 to &07FF
\   Category: Workspaces
\    Summary: Ship data blocks
\  Deep dive: Ship data blocks
\             The local bubble of universe
\
\ ------------------------------------------------------------------------------
\
\ Contains ship data for all the ships, planets, suns and space stations in our
\ local bubble of universe.
\
\ See the deep dive on "Ship data blocks" for details on ship data blocks, and
\ the deep dive on "The local bubble of universe" for details of how Elite
\ stores the local universe in K%, FRIN and UNIV.
\
\ ******************************************************************************

 ORG &0600

.K%

 SKIP 0                 \ Ship data blocks and ship line heap

\ ******************************************************************************
\
\ ELITE BANK 5
\
\ Produces the binary file bank5.bin.
\
\ ******************************************************************************

 CODE% = &8000
 LOAD% = &8000

 ORG CODE%

\ ******************************************************************************
\
\       Name: ResetMMC1
\       Type: Variable
\   Category: Start and end
\    Summary: The MMC1 mapper reset routine at the start of the ROM bank
\
\ ------------------------------------------------------------------------------
\
\ When the NES is switched on, it is hardwired to perform a JMP (&FFFC). At this
\ point, there is no guarantee as to which ROM banks are mapped to &8000 and
\ &C000, so to ensure that the game starts up correctly, we put the same code
\ in each ROM at the following locations:
\
\   * We put &C000 in address &FFFC in every ROM bank, so the NES always jumps
\     to &C000 when it starts up via the JMP (&FFFC), irrespective of which
\     ROM bank is mapped to &C000.
\
\   * We put the same RESET routine at the start of every ROM bank, so the same
\     routine gets run, whichever ROM bank is mapped to &C000.
\
\ This RESET routine is therefore called when the NES starts up, whatever the
\ bank configuration ends up being. It then switches ROM bank 7 to &C000 and
\ jumps into bank 7 at the game's entry point S%, which starts the game.
\
\ ******************************************************************************

.ResetMMC1

 SEI                    \ Disable interrupts

 INC &C006              \ Reset the MMC1 mapper, which we can do by writing a
                        \ value with bit 7 set into any address in ROM space
                        \ (i.e. any address from &8000 to &FFFF)
                        \
                        \ The INC instruction does this in a more efficient
                        \ manner than an LDA/STA pair, as it:
                        \
                        \   * Fetches the contents of address &C006, which
                        \     contains the high byte of the JMP destination
                        \     below, i.e. the high byte of S%, which is &C0
                        \
                        \   * Adds 1, to give &C1
                        \
                        \   * Writes the value &C1 back to address &C006
                        \
                        \ &C006 is in the ROM space and &C1 has bit 7 set, so
                        \ the INC does all that is required to reset the mapper,
                        \ in fewer cycles and bytes than an LDA/STA pair
                        \
                        \ Resetting MMC1 maps bank 7 to &C000 and enables the
                        \ bank at &8000 to be switched, so this instruction
                        \ ensures that bank 7 is present

 JMP S%                 \ Jump to S% in bank 7 to start the game

\ ******************************************************************************
\
\       Name: Interrupts
\       Type: Subroutine
\   Category: Text
\    Summary: The IRQ and NMI handler while the MMC1 mapper reset routine is
\             still running
\
\ ******************************************************************************

.Interrupts

 RTI                    \ Return from the IRQ interrupt without doing anything
                        \
                        \ This ensures that while the system is starting up and
                        \ the ROM banks are in an unknown configuration, any IRQ
                        \ interrupts that go via the vector at &FFFE and any NMI
                        \ interrupts that go via the vector at &FFFA will end up
                        \ here and be dealt with
                        \
                        \ Once bank 7 is switched into &C000 by the ResetMMC1
                        \ routine, the vector is overwritten with the last two
                        \ bytes of bank 7, which point to the IRQ routine

\ ******************************************************************************
\
\       Name: Version number
\       Type: Variable
\   Category: Text
\    Summary: The game's version number
\
\ ******************************************************************************

 EQUS " 5.0"

\ ******************************************************************************
\
\       Name: SETUP_PPU_FOR_ICON_BAR
\       Type: Macro
\   Category: Screen mode
\    Summary: If the PPU has started drawing the icon bar, configure the PPU to
\             use nametable 0 and pattern table 0
\
\ ******************************************************************************

MACRO SETUP_PPU_FOR_ICON_BAR

 LDA setupPPUForIconBar \ If bit 7 of setupPPUForIconBar and bit 6 of PPU_STATUS
 BPL skip               \ are set, then call SetPPUTablesTo0 to:
 LDA PPU_STATUS         \
 ASL A                  \   * Zero setupPPUForIconBar to disable this process
 BPL skip               \     until both conditions are met once again
 JSR SetPPUTablesTo0    \
                        \   * Clear bits 0 and 4 of PPU_CTRL and PPU_CTRL_COPY,
                        \     to set the base nametable address to &2000 (for
                        \     nametable 0) or &2800 (which is a mirror of &2000)
                        \
                        \   * Clear the C flag
 
.skip

ENDMACRO

\ ******************************************************************************
\
\       Name: imageCount
\       Type: Variable
\   Category: Drawing images
\    Summary: The number of images in the imageOffset table
\
\ ******************************************************************************

.imageCount

 EQUW 15

\ ******************************************************************************
\
\       Name: imageOffset
\       Type: Variable
\   Category: Drawing images
\    Summary: Offset to the data for each of the 15 images
\
\ ******************************************************************************

.imageOffset

 EQUW image0 - imageCount
 EQUW image1 - imageCount
 EQUW image2 - imageCount
 EQUW image3 - imageCount
 EQUW image4 - imageCount
 EQUW image5 - imageCount
 EQUW image6 - imageCount
 EQUW image7 - imageCount
 EQUW image8 - imageCount
 EQUW image9 - imageCount
 EQUW image10 - imageCount
 EQUW image11 - imageCount
 EQUW image12 - imageCount
 EQUW image13 - imageCount
 EQUW image14 - imageCount

\ ******************************************************************************
\
\       Name: image0
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 0
\
\ ******************************************************************************

.image0

 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &07
 EQUB &21, &02, &00, &22, &02, &33, &12, &0F
 EQUB &0F, &5F, &04, &40, &22, &80, &D0, &02
 EQUB &32, &0C, &38, &77, &12, &FE, &03, &E0
 EQUB &F8, &C0, &20, &0F, &0E, &22, &02, &39
 EQUB &07, &02, &0F, &0F, &12, &02, &02, &00
 EQUB &02, &00, &22, &80, &40, &05, &FE, &FC
 EQUB &F2, &23, &E0, &C0, &60, &0F, &0F, &02
 EQUB &21, &02, &0F, &08, &D0, &A0, &44, &21
 EQUB &23, &43, &21, &04, &00, &21, &08, &02
 EQUB &30, &E0, &33, &0B, &0E, &38, &C1, &04
 EQUB &80, &00, &21, &38, &F0, &0F, &07, &21
 EQUB &1A, &F7, &03, &34, &01, &07, &7F, &17
 EQUB &E0, &02, &75, &BE, &FF, &DE, &7F, &FE
 EQUB &04, &32, &01, &0B, &57, &BF, &33, &07
 EQUB &0B, &3F, &7F, &FD, &FA, &EF, &F9, &E5
 EQUB &78, &E0, &80, &21, &0F, &13, &50, &03
 EQUB &80, &F8, &12, &21, &03, &06, &E0, &FF
 EQUB &6E, &20, &05, &7F, &6F, &32, &15, &02
 EQUB &04, &F5, &7A, &D0, &A8, &33, &01, &0F
 EQUB &1E, &7F, &6F, &BE, &78, &95, &33, &2F
 EQUB &17, &22, &00, &B0, &00, &B0, &C0, &80
 EQUB &00, &21, &08, &50, &7F, &35, &3B, &17
 EQUB &2B, &51, &02, &40, &00, &FE, &F2, &E0
 EQUB &80, &04, &21, &18, &04, &21, &01, &06
 EQUB &37, &0B, &05, &60, &06, &01, &03, &0F
 EQUB &7D, &BF, &FA, &54, &21, &02, &FD, &FB
 EQUB &FD, &FB, &D6, &83, &32, &17, &2D, &3F
 EQUB &21, &24, &02, &21, &05, &80, &38, &08
 EQUB &25, &0A, &42, &08, &02, &20, &08, &A2
 EQUB &55, &EB, &34, &01, &28, &40, &0A, &45
 EQUB &AF, &5B, &EF, &21, &12, &A5, &5A, &AD
 EQUB &7B, &BE, &D7, &7F, &21, &22, &55, &AA
 EQUB &7D, &DB, &FD, &FF, &F7, &A9, &56, &FF
 EQUB &BF, &14, &57, &17, &D4, &FE, &FF, &FE
 EQUB &14, &55, &21, &2F, &5B, &21, &3F, &6F
 EQUB &BE, &7F, &FF, &B5, &EE, &7B, &13, &F7
 EQUB &FF, &7D, &12, &DF, &FE, &14, &DF, &17
 EQUB &BF, &1E, &FD, &FF, &22, &FD, &EF, &FA
 EQUB &F7, &AF, &14, &BF, &FF, &7F, &AF, &7F
 EQUB &F0, &CC, &B8, &77, &12, &FE, &12, &7F
 EQUB &E1, &F8, &C0, &20, &00, &DF, &13, &7F
 EQUB &32, &3F, &1F, &7F, &1F, &15, &22, &FD
 EQUB &FA, &FD, &F7, &FA, &EF, &22, &FD, &FF
 EQUB &FD, &FF, &7F, &FF, &BF, &15, &FE, &FC
 EQUB &F2, &23, &E0, &C0, &60, &02, &32, &07
 EQUB &04, &04, &12, &EF, &C7, &32, &07, &02
 EQUB &02, &12, &FB, &71, &21, &21, &03, &12
 EQUB &EF, &E3, &C1, &80, &02, &FD, &12, &BE
 EQUB &32, &0C, &08, &02, &12, &7E, &21, &38
 EQUB &20, &03, &FF, &FD, &FC, &32, &38, &08
 EQUB &03, &D0, &A0, &44, &21, &23, &43, &21
 EQUB &04, &00, &21, &08, &02, &30, &E0, &33
 EQUB &0B, &0E, &38, &C1, &04, &80, &00, &21
 EQUB &38, &F0, &0F, &07, &21, &1A, &F7, &03
 EQUB &34, &01, &07, &7F, &17, &E0, &02, &75
 EQUB &BE, &FF, &DE, &7F, &FE, &04, &32, &01
 EQUB &0B, &57, &BF, &33, &07, &0B, &3F, &7F
 EQUB &FD, &FA, &EF, &F9, &E5, &78, &E0, &80
 EQUB &21, &0F, &13, &50, &03, &80, &F8, &12
 EQUB &21, &03, &06, &E0, &FF, &6E, &20, &05
 EQUB &7F, &6F, &32, &15, &02, &04, &F5, &7A
 EQUB &D0, &A8, &33, &01, &0F, &1E, &7F, &6F
 EQUB &BE, &78, &95, &33, &2F, &17, &22, &00
 EQUB &B0, &00, &B0, &C0, &80, &00, &21, &08
 EQUB &50, &7F, &35, &3B, &17, &2B, &51, &02
 EQUB &40, &00, &FE, &F2, &E0, &80, &04, &21
 EQUB &18, &04, &21, &01, &06, &37, &0B, &05
 EQUB &60, &06, &01, &03, &0F, &7D, &BF, &FA
 EQUB &54, &21, &02, &FD, &FB, &FD, &FB, &D6
 EQUB &83, &32, &17, &2D, &3F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &02, &32
 EQUB &0F, &33, &47, &88, &02, &21, &01, &00
 EQUB &21, &0F, &20, &21, &02, &06, &80, &33
 EQUB &1E, &07, &3C, &D0, &B0, &02, &80, &21
 EQUB &06, &00, &21, &0C, &10, &A0, &04, &80
 EQUB &40, &20, &80, &04, &80, &40, &20, &80
 EQUB &0F, &0F, &0F, &0F, &0F, &05, &34, &01
 EQUB &03, &0D, &1F, &22, &10, &21, &38, &98
 EQUB &00, &22, &01, &21, &0E, &02, &22, &08
 EQUB &33, &02, &07, &08, &00, &90, &10, &00
 EQUB &39, &04, &02, &05, &08, &02, &93, &14
 EQUB &00, &04, &0A, &10, &30, &70, &21, &29
 EQUB &51, &21, &21, &0A, &21, &04, &8C, &22
 EQUB &DE, &BF, &21, &3F, &3F, &0A, &10, &33
 EQUB &1C, &3C, &3D, &7E, &56, &0B, &41, &E3
 EQUB &F2, &D0, &88, &0A, &81, &C7, &9F, &92
 EQUB &21, &04, &0A, &22, &02, &21, &04, &80
 EQUB &20, &02, &21, &2C, &5F, &BB, &DC, &BC
 EQUB &FB, &FD, &F7, &32, &04, &03, &05, &20
 EQUB &34, &03, &0F, &CC, &1B, &F4, &B1, &47
 EQUB &35, &3A, &03, &09, &00, &0A, &60, &A0
 EQUB &32, &03, &08, &80, &C0, &00, &C0, &66
 EQUB &9F, &C6, &21, &08, &80, &40, &00, &40
 EQUB &21, &26, &91, &21, &02, &06, &80, &00
 EQUB &F8, &56, &21, &21, &80, &02, &80, &00
 EQUB &C8, &07, &21, &03, &88, &21, &04, &02
 EQUB &20, &02, &21, &02, &05, &21, &1F, &E5
 EQUB &21, &08, &50, &04, &21, &19, &80, &03
 EQUB &33, &01, &06, &38, &80, &E8, &21, &1F
 EQUB &10, &00, &32, &01, &04, &30, &00, &40
 EQUB &21, &08, &00, &21, &3F, &8A, &41, &00
 EQUB &21, &21, &80, &21, &01, &00, &21, &22
 EQUB &06, &12, &FC, &FB, &FE, &F4, &A8, &40
 EQUB &10, &4B, &21, &1C, &AA, &78, &C0, &02
 EQUB &E8, &21, &14, &C0, &80, &34, &02, &05
 EQUB &10, &06, &60, &00, &80, &05, &21, &1A
 EQUB &87, &21, &1C, &70, &F0, &06, &10, &60
 EQUB &03, &AC, &E2, &10, &00, &60, &21, &06
 EQUB &02, &21, &04, &C2, &10, &05, &34, &04
 EQUB &0F, &02, &01, &02, &C0, &10, &40, &33
 EQUB &0C, &02, &01, &05, &91, &CF, &DC, &FF
 EQUB &5F, &7D, &21, &28, &02, &81, &DC, &6B
 EQUB &21, &12, &75, &20, &80, &90, &6A, &CD
 EQUB &F7, &FF, &AF, &87, &00, &80, &40, &C0
 EQUB &74, &36, &2E, &25, &86, &0A, &85, &2F
 EQUB &57, &FE, &F0, &E1, &80, &03, &32, &01
 EQUB &0C, &60, &80, &00, &90, &41, &87, &6A
 EQUB &D0, &E8, &DD, &FF, &02, &21, &01, &02
 EQUB &80, &00, &91, &4D, &F0, &4C, &30, &60
 EQUB &FC, &F7, &AF, &21, &05, &60, &21, &04
 EQUB &10, &20, &74, &A3, &00, &80, &C4, &68
 EQUB &54, &21, &2E, &FD, &BF, &FF, &00, &80
 EQUB &03, &88, &21, &14, &AE, &33, &01, &0D
 EQUB &1A, &61, &C0, &22, &80, &C1, &00, &33
 EQUB &01, &08, &21, &40, &00, &80, &C1, &E4
 EQUB &36, &1E, &03, &02, &16, &06, &2F, &55
 EQUB &C0, &36, &14, &02, &00, &14, &04, &2E
 EQUB &55, &22, &10, &32, &08, &01, &F4, &BA
 EQUB &93, &F9, &00, &10, &21, &08, &00, &C0
 EQUB &30, &21, &03, &A0, &21, &02, &4C, &30
 EQUB &82, &40, &21, &05, &AB, &21, &3D, &00
 EQUB &40, &05, &20, &35, &02, &04, &02, &04
 EQUB &29, &7C, &E8, &D2, &06, &40, &80, &3F

\ ******************************************************************************
\
\       Name: image1
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 1
\
\ ******************************************************************************

.image1

 EQUB &0F, &0F, &0F, &0B, &22, &04, &36, &0E
 EQUB &1E, &1E, &08, &00, &04, &0F, &01, &20
 EQUB &52, &21, &11, &60, &21, &14, &0F, &06
 EQUB &22, &02, &34, &07, &0F, &1F, &1F, &05
 EQUB &22, &80, &02, &34, &04, &0C, &0C, &04
 EQUB &10, &78, &07, &32, &04, &01, &0F, &08
 EQUB &21, &08, &08, &21, &08, &00, &22, &04
 EQUB &34, &06, &0F, &3F, &08, &02, &34, &04
 EQUB &05, &0B, &04, &80, &02, &21, &0C, &70
 EQUB &F0, &24, &10, &0F, &07, &21, &25, &07
 EQUB &FF, &04, &33, &01, &06, &0C, &FF, &00
 EQUB &22, &04, &21, &3C, &C0, &21, &04, &00
 EQUB &FF, &02, &35, &1C, &38, &3C, &2C, &2C
 EQUB &FF, &00, &26, &10, &FF, &00, &50, &05
 EQUB &C0, &30, &00, &86, &10, &05, &21, &05
 EQUB &07, &7F, &BF, &21, &17, &BB, &21, &15
 EQUB &03, &FF, &F0, &C0, &80, &04, &FF, &35
 EQUB &0F, &13, &05, &02, &02, &02, &FF, &43
 EQUB &F3, &51, &04, &FF, &FD, &EA, &54, &04
 EQUB &36, &18, &08, &04, &07, &05, &04, &06
 EQUB &F0, &35, &3E, &13, &01, &80, &26, &04
 EQUB &80, &40, &02, &40, &0C, &21, &01, &07
 EQUB &80, &04, &32, &03, &05, &05, &AE, &C4
 EQUB &40, &20, &09, &21, &01, &07, &20, &10
 EQUB &21, &07, &08, &40, &21, &0E, &00, &40
 EQUB &06, &5F, &02, &20, &04, &F0, &21, &06
 EQUB &08, &40, &08, &3F, &80, &00, &32, &01
 EQUB &04, &04, &80, &03, &10, &02, &21, &04
 EQUB &80, &06, &32, &24, &02, &00, &20, &00
 EQUB &21, &02, &05, &34, &0C, &14, &1A, &08
 EQUB &02, &40, &02, &21, &04, &10, &02, &10
 EQUB &02, &21, &02, &07, &35, &04, &0D, &09
 EQUB &06, &04, &03, &21, &04, &00, &80, &02
 EQUB &21, &08, &20, &00, &21, &02, &06, &91
 EQUB &00, &21, &01, &83, &46, &21, &3C, &00
 EQUB &21, &08, &08, &21, &01, &05, &40, &04
 EQUB &36, &02, &06, &0E, &04, &00, &04, &04
 EQUB &40, &C0, &4E, &37, &0A, &02, &02, &1A
 EQUB &2C, &A6, &38, &06, &32, &04, &01, &10
 EQUB &00, &21, &01, &03, &21, &04, &04, &21
 EQUB &11, &00, &80, &21, &04, &07, &32, &08
 EQUB &1C, &05, &20, &02, &3C, &07, &06, &03
 EQUB &03, &01, &04, &0E, &04, &80, &04, &0A
 EQUB &08, &10, &93, &66, &35, &0F, &1C, &13
 EQUB &8F, &0F, &EF, &8F, &21, &0F, &EF, &00
 EQUB &BA, &D5, &A3, &41, &82, &21, &01, &05
 EQUB &C0, &80, &5B, &20, &00, &40, &21, &02
 EQUB &03, &DA, &00, &21, &08, &02, &21, &08
 EQUB &03, &21, &2B, &00, &10, &02, &32, &01
 EQUB &02, &00, &FF, &23, &03, &21, &3F, &C2
 EQUB &21, &04, &00, &FF, &9F, &A3, &21, &15
 EQUB &6A, &22, &52, &00, &FF, &26, &EF, &00
 EQUB &FF, &50, &05, &C0, &30, &00, &86, &10
 EQUB &02, &38, &16, &22, &00, &1A, &2F, &1F
 EQUB &0B, &15, &03, &81, &4B, &E9, &44, &6A
 EQUB &BF, &02, &5D, &A8, &20, &40, &80, &03
 EQUB &21, &2F, &72, &34, &0D, &1A, &0D, &0D
 EQUB &02, &4B, &B1, &88, &AE, &D1, &FD, &02
 EQUB &A8, &42, &21, &15, &AB, &FD, &AA, &02
 EQUB &35, &18, &08, &04, &87, &05, &84, &40
 EQUB &80, &04, &F0, &35, &3E, &13, &01, &80
 EQUB &26, &04, &80, &40, &02, &40, &00, &34
 EQUB &02, &09, &01, &02, &07, &21, &01, &07
 EQUB &80, &04, &32, &03, &05, &20, &E8, &03
 EQUB &AE, &C4, &40, &20, &00, &C0, &81, &00
 EQUB &33, &04, &0A, &1C, &B8, &FC, &21, &01
 EQUB &03, &32, &04, &28, &52, &F8, &33, &24
 EQUB &13, &07, &02, &32, &04, &28, &74, &84
 EQUB &EA, &30, &4A, &21, &0E, &00, &40, &36
 EQUB &03, &28, &22, &40, &14, &3A, &5F, &00
 EQUB &A8, &21, &21, &00, &21, &01, &00, &8A
 EQUB &F3, &21, &06, &00, &40, &93, &32, &0D
 EQUB &3A, &30, &4A, &21, &1D, &4F, &00, &94
 EQUB &FF, &56, &21, &28, &94, &40, &EA, &3F
 EQUB &0F, &0F, &09, &10, &07, &21, &18, &0F
 EQUB &04, &21, &08, &07, &21, &08, &0F, &0F
 EQUB &0F, &0F, &0F, &09, &5C, &21, &2C, &E8
 EQUB &21, &06, &60, &20, &02, &46, &00, &AE
 EQUB &9E, &48, &21, &38, &0F, &0F, &0F, &0F
 EQUB &0F, &0B, &80, &F0, &FB, &FE, &04, &80
 EQUB &10, &80, &50, &06, &80, &C0, &06, &80
 EQUB &40, &0F, &0F, &0F, &0F, &0F, &0F, &06
 EQUB &FF, &41, &05, &F8, &FE, &41, &05, &88
 EQUB &C0, &23, &80, &00, &40, &02, &40, &00
 EQUB &22, &80, &00, &40, &0F, &0F, &04, &3F
 EQUB &0F, &0F, &0F, &0F, &04, &AF, &FF, &7F
 EQUB &21, &3F, &63, &32, &0F, &33, &C8, &00
 EQUB &AA, &77, &21, &1E, &63, &32, &0D, &13
 EQUB &00, &8F, &79, &EF, &FF, &FB, &81, &02
 EQUB &89, &02, &A6, &7B, &81, &03, &22, &80
 EQUB &03, &80, &02, &22, &80, &03, &A1, &21
 EQUB &0A, &0E, &10, &C2, &0E, &A6, &0F, &21
 EQUB &23, &98, &0E, &58, &21, &05, &0E, &20
 EQUB &21, &03, &E4, &37, &34, &1A, &18, &0A
 EQUB &0B, &0F, &0C, &C4, &20, &22, &10, &22
 EQUB &08, &33, &03, &04, &07, &FF, &7F, &C7
 EQUB &21, &0C, &C1, &33, &0C, &3E, &06, &D4
 EQUB &7A, &47, &21, &04, &02, &21, &2C, &60
 EQUB &D9, &12, &FE, &21, &07, &5F, &AA, &20
 EQUB &00, &80, &D5, &FE, &33, &06, &1B, &0A
 EQUB &00, &80, &B0, &FC, &84, &E2, &40, &00
 EQUB &21, &15, &80, &32, &13, &05, &85, &E2
 EQUB &40, &21, &01, &06, &33, &07, &0E, &34
 EQUB &C1, &F3, &9F, &F7, &FE, &FC, &E8, &06
 EQUB &80, &61, &41, &21, &1C, &E2, &21, &3F
 EQUB &F7, &5F, &9E, &21, &2D, &03, &37, &03
 EQUB &0C, &3A, &4F, &03, &98, &01, &94, &FA
 EQUB &E8, &B0, &4A, &21, &03, &02, &7F, &51
 EQUB &21, &3B, &BF, &DF, &FF, &21, &14, &80
 EQUB &41, &02, &10, &8A, &57, &21, &18, &10
 EQUB &30, &20, &40, &21, &01, &02, &21, &18
 EQUB &00, &30, &20, &40, &21, &01, &02, &21
 EQUB &32, &63, &61, &40, &80, &03, &21, &12
 EQUB &42, &61, &40, &80, &03, &D0, &6C, &98
 EQUB &43, &40, &80, &00, &21, &01, &80, &44
 EQUB &10, &42, &40, &80, &04, &C0, &B0, &71
 EQUB &21, &3F, &B8, &80, &21, &01, &00, &40
 EQUB &10, &40, &20, &98, &80, &21, &16, &41
 EQUB &80, &00, &80, &A0, &02, &96, &41, &80
 EQUB &00, &80, &03, &D0, &9C, &C0, &10, &00
 EQUB &21, &0C, &79, &E1, &90, &21, &14, &C0
 EQUB &10, &00, &21, &04, &40, &A1, &22, &0C
 EQUB &10, &03, &80, &A0, &22, &0C, &10, &03
 EQUB &80, &00, &FF, &21, &0B, &00, &21, &28
 EQUB &10, &21, &01, &02, &FE, &21, &0B, &00
 EQUB &21, &28, &10, &21, &01, &02, &3F

\ ******************************************************************************
\
\       Name: image2
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 2
\
\ ******************************************************************************

.image2

 EQUB &0F, &0F, &0F, &0F, &0F, &03, &22, &01
 EQUB &04, &21, &3E, &13, &05, &80, &E0, &9C
 EQUB &0F, &0F, &05, &32, &08, &34, &03, &25
 EQUB &03, &22, &01, &00, &13, &F1, &FC, &13
 EQUB &48, &F9, &E0, &C0, &00, &22, &C0, &80
 EQUB &0F, &0F, &21, &0C, &7E, &03, &FE, &61
 EQUB &21, &06, &C0, &21, &0C, &02, &21, &02
 EQUB &66, &C9, &67, &D8, &32, &0C, &3E, &00
 EQUB &BF, &59, &92, &21, &33, &7E, &CB, &02
 EQUB &A0, &59, &7E, &CD, &7B, &8C, &03, &FF
 EQUB &CC, &B0, &00, &21, &18, &03, &64, &02
 EQUB &C0, &00, &33, &01, &04, &0A, &05, &21
 EQUB &03, &70, &BC, &32, &0A, &04, &02, &80
 EQUB &40, &00, &21, &0C, &00, &21, &01, &03
 EQUB &81, &36, &18, &01, &60, &0C, &00, &01
 EQUB &00, &B9, &97, &8D, &21, &25, &DE, &32
 EQUB &09, &3C, &10, &60, &32, &01, &18, &80
 EQUB &61, &00, &20, &02, &21, &03, &0E, &38
 EQUB &01, &02, &06, &04, &0C, &0D, &0A, &04
 EQUB &06, &32, &01, &19, &04, &21, &01, &83
 EQUB &4F, &21, &11, &00, &32, &08, &24, &90
 EQUB &C0, &E1, &BF, &FE, &8B, &00, &21, &0C
 EQUB &02, &21, &01, &84, &21, &01, &06, &32
 EQUB &01, &03, &06, &C0, &FC, &08, &21, &04
 EQUB &00, &37, &01, &03, &0F, &1F, &1E, &3D
 EQUB &3C, &FC, &23, &F8, &9D, &21, &3F, &7E
 EQUB &21, &04, &10, &84, &32, &01, &2F, &5F
 EQUB &EF, &46, &F8, &57, &8E, &21, &1D, &22
 EQUB &BF, &47, &EB, &21, &06, &C0, &E8, &E5
 EQUB &EF, &BF, &FE, &7D, &34, &07, &0F, &1E
 EQUB &1F, &BF, &7F, &12, &DF, &21, &3F, &12
 EQUB &FE, &F8, &C4, &78, &80, &C0, &8E, &32
 EQUB &0C, &08, &03, &7B, &12, &7E, &22, &7F
 EQUB &FC, &7F, &FD, &F6, &E8, &90, &C0, &02
 EQUB &40, &3F, &00, &20, &32, &02, &01, &57
 EQUB &AC, &21, &12, &45, &21, &0A, &57, &00
 EQUB &51, &AE, &55, &BF, &35, &15, &01, &40
 EQUB &14, &2E, &D5, &7F, &7A, &55, &5F, &21
 EQUB &2A, &00, &4A, &A0, &7C, &AB, &5A, &D0
 EQUB &00, &41, &AB, &21, &1D, &87, &5D, &EA
 EQUB &21, &02, &57, &21, &0A, &D5, &21, &3B
 EQUB &81, &40, &B5, &00, &49, &A0, &75, &AE
 EQUB &50, &00, &20, &4B, &21, &01, &00, &40
 EQUB &A9, &00, &21, &02, &55, &AA, &5D, &21
 EQUB &0B, &55, &AE, &FD, &A8, &D0, &BA, &54
 EQUB &A2, &D0, &A0, &00, &22, &01, &88, &40
 EQUB &02, &21, &3E, &13, &21, &05, &04, &22
 EQUB &80, &60, &21, &15, &BF, &21, &05, &AF
 EQUB &5A, &32, &2F, &05, &00, &E8, &45, &FE
 EQUB &50, &AA, &D5, &BA, &5D, &21, &02, &D4
 EQUB &BB, &55, &E8, &50, &AA, &51, &BF, &21
 EQUB &15, &AB, &41, &00, &60, &21, &28, &44
 EQUB &FA, &44, &A8, &40, &8A, &7D, &E8, &54
 EQUB &21, &03, &83, &35, &02, &03, &03, &01
 EQUB &01, &00, &12, &71, &8E, &FB, &FF, &BF
 EQUB &FF, &B0, &E6, &DF, &21, &3F, &FF, &8F
 EQUB &C3, &80, &21, &14, &8E, &FD, &DA, &F1
 EQUB &FB, &D1, &00, &21, &2A, &F5, &BF, &AE
 EQUB &75, &A8, &75, &32, &17, &2A, &55, &E8
 EQUB &80, &00, &A0, &FA, &43, &92, &00, &21
 EQUB &09, &B8, &21, &08, &00, &21, &2C, &7E
 EQUB &A8, &5D, &21, &2B, &00, &21, &08, &D0
 EQUB &21, &3D, &E3, &00, &50, &A0, &00, &21
 EQUB &01, &02, &32, &22, &3E, &02, &21, &18
 EQUB &82, &30, &04, &21, &02, &40, &04, &21
 EQUB &02, &55, &BE, &00, &32, &01, &07, &6E
 EQUB &85, &21, &2A, &DF, &AA, &21, &01, &9F
 EQUB &76, &32, &0C, &31, &ED, &D4, &21, &2A
 EQUB &CF, &B0, &60, &21, &0D, &42, &21, &03
 EQUB &70, &BC, &21, &0A, &C4, &A0, &21, &08
 EQUB &93, &21, &1A, &D5, &20, &41, &8C, &00
 EQUB &D2, &21, &04, &74, &82, &64, &21, &1B
 EQUB &B2, &CD, &32, &24, &03, &05, &A0, &40
 EQUB &E1, &36, &03, &18, &43, &2E, &08, &36
 EQUB &85, &9C, &21, &38, &D0, &83, &C8, &60
 EQUB &C3, &10, &86, &80, &46, &21, &08, &00
 EQUB &91, &4C, &00, &39, &06, &05, &62, &06
 EQUB &04, &8C, &2D, &0A, &14, &10, &40, &80
 EQUB &21, &04, &10, &20, &59, &A5, &81, &21
 EQUB &24, &00, &21, &11, &82, &CD, &76, &21
 EQUB &2F, &74, &89, &A4, &50, &A1, &9E, &50
 EQUB &21, &29, &10, &21, &19, &B0, &AC, &21
 EQUB &2B, &DD, &64, &21, &01, &63, &94, &00
 EQUB &5B, &C0, &32, &28, &02, &45, &A0, &00
 EQUB &21, &2C, &02, &21, &08, &A0, &C2, &20
 EQUB &00, &10, &C0, &00, &21, &0A, &02, &21
 EQUB &05, &53, &35, &02, &0D, &15, &26, &2D
 EQUB &22, &52, &21, &3A, &22, &FC, &8D, &62
 EQUB &4E, &95, &21, &35, &D0, &45, &BE, &56
 EQUB &A9, &21, &12, &B9, &C6, &AB, &57, &AA
 EQUB &5B, &65, &AA, &54, &E7, &BC, &56, &BA
 EQUB &D6, &6C, &21, &09, &A2, &21, &0B, &94
 EQUB &21, &09, &A5, &5E, &FD, &DE, &A8, &21
 EQUB &24, &82, &57, &AA, &F1, &47, &21, &3B
 EQUB &86, &40, &A1, &75, &D3, &94, &88, &50
 EQUB &80, &A4, &52, &7C, &B9, &90, &A8, &21
 EQUB &13, &80, &42, &89, &21, &17, &6E, &21
 EQUB &38, &C0, &68, &B0, &3F, &05, &32, &13
 EQUB &01, &06, &32, &13, &01, &05, &50, &AA
 EQUB &00, &21, &02, &04, &50, &AA, &00, &21
 EQUB &02, &04, &21, &2A, &00, &81, &21, &2A
 EQUB &04, &21, &2A, &00, &81, &21, &2A, &06
 EQUB &54, &A0, &06, &54, &A0, &04, &21, &02
 EQUB &02, &21, &15, &04, &21, &02, &02, &21
 EQUB &15, &04, &C0, &02, &40, &04, &C0, &02
 EQUB &40, &04, &50, &07, &50, &0F, &05, &21
 EQUB &02, &02, &36, &01, &02, &57, &2F, &00
 EQUB &02, &02, &35, &01, &02, &55, &2F, &05
 EQUB &AB, &5D, &21, &2F, &5F, &FF, &22, &FE
 EQUB &21, &05, &AB, &5D, &21, &2F, &5E, &F4
 EQUB &E8, &40, &77, &BF, &12, &C1, &03, &77
 EQUB &BE, &F1, &40, &80, &03, &FA, &14, &7F
 EQUB &32, &1F, &03, &FA, &FF, &5F, &8B, &34
 EQUB &16, &0B, &01, &02, &EA, &40, &FA, &50
 EQUB &A0, &D0, &FA, &FF, &EA, &40, &FA, &50
 EQUB &A0, &D0, &7A, &FD, &02, &33, &01, &2F
 EQUB &04, &00, &40, &A0, &02, &33, &01, &2F
 EQUB &04, &00, &40, &A0, &02, &40, &A8, &03
 EQUB &21, &2E, &02, &40, &A8, &03, &21, &2E
 EQUB &06, &10, &98, &06, &10, &90, &21, &05
 EQUB &BB, &57, &B7, &41, &34, &02, &17, &AB
 EQUB &05, &BB, &56, &B7, &41, &32, &02, &17
 EQUB &AA, &FC, &7C, &23, &FC, &22, &FE, &FF
 EQUB &A0, &74, &E8, &50, &C0, &A0, &C0, &94
 EQUB &0F, &01, &21, &07, &04, &30, &21, &3C
 EQUB &7F, &21, &07, &04, &30, &32, &2C, &15
 EQUB &EB, &71, &00, &34, &05, &0E, &04, &2E
 EQUB &FF, &AB, &71, &00, &34, &05, &0E, &04
 EQUB &2E, &F7, &C0, &02, &50, &80, &00, &80
 EQUB &E8, &40, &02, &50, &80, &00, &80, &E8
 EQUB &21, &04, &07, &21, &04, &07, &3E, &0C
 EQUB &0E, &06, &07, &07, &0F, &13, &81, &0C
 EQUB &0A, &00, &03, &02, &0F, &21, &01, &00
 EQUB &3A, &17, &02, &00, &01, &96, &29, &02
 EQUB &10, &17, &02, &02, &96, &32, &29, &02
 EQUB &10, &FF, &AF, &5D, &99, &21, &36, &98
 EQUB &21, &27, &D1, &7F, &AA, &5D, &02, &80
 EQUB &21, &26, &D1, &C1, &FF, &40, &A6, &6D
 EQUB &CC, &81, &21, &34, &00, &85, &40, &04
 EQUB &21, &04, &12, &5D, &A6, &81, &21, &32
 EQUB &84, &73, &BF, &6F, &5D, &02, &21, &02
 EQUB &00, &73, &3F, &FD, &AA, &40, &00, &21
 EQUB &32, &48, &91, &20, &21, &1D, &AA, &40
 EQUB &00, &21, &32, &48, &91, &20, &D5, &20
 EQUB &21, &05, &9A, &60, &80, &20, &00, &D5
 EQUB &20, &21, &05, &9A, &60, &80, &20, &00
 EQUB &32, &02, &2B, &D5, &30, &03, &81, &00
 EQUB &21, &21, &C0, &04, &80, &FC, &8F, &43
 EQUB &F5, &21, &3B, &5F, &E7, &60, &33, &38
 EQUB &02, &01, &80, &20, &50, &87, &20, &A5
 EQUB &32, &08, &12, &80, &62, &00, &21, &0C
 EQUB &00, &A5, &32, &08, &12, &80, &62, &00
 EQUB &21, &0C, &00, &33, &0A, &25, &1A, &80
 EQUB &41, &00, &D2, &00, &33, &0A, &25, &1A
 EQUB &80, &41, &00, &D2, &00, &46, &68, &72
 EQUB &DA, &21, &21, &56, &83, &21, &0A, &40
 EQUB &21, &08, &70, &C2, &21, &21, &50, &83
 EQUB &21, &02, &9C, &E6, &A4, &51, &96, &C0
 EQUB &58, &21, &23, &9C, &21, &26, &A4, &51
 EQUB &96, &C0, &58, &21, &23, &C1, &21, &04
 EQUB &00, &30, &80, &03, &C1, &21, &04, &00
 EQUB &30, &80, &04, &80, &10, &00, &60, &04
 EQUB &80, &10, &00, &60, &03, &38, &02, &05
 EQUB &09, &0B, &03, &02, &05, &0B, &02, &33
 EQUB &08, &01, &02, &02, &21, &01, &CF, &BF
 EQUB &7F, &F8, &E3, &C7, &86, &21, &02, &4D
 EQUB &AA, &21, &37, &58, &21, &23, &44, &84
 EQUB &21, &02, &00, &C3, &00, &21, &08, &02
 EQUB &80, &C0, &00, &C3, &00, &21, &08, &03
 EQUB &80, &00, &21, &36, &5B, &32, &2F, &1E
 EQUB &04, &33, &22, &19, &07, &04, &44, &00
 EQUB &21, &02, &00, &C0, &32, &22, &1B, &FE
 EQUB &44, &00, &21, &02, &00, &80, &20, &21
 EQUB &11, &AC, &00, &21, &08, &00, &80, &00
 EQUB &D0, &C0, &80, &00, &21, &08, &00, &80
 EQUB &00, &10, &02, &40, &00, &10, &05, &40
 EQUB &00, &10, &05, &40, &00, &21, &06, &05
 EQUB &40, &00, &21, &06, &05, &33, &0A, &04
 EQUB &04, &05, &21, &0A, &00, &21, &04, &05
 EQUB &22, &01, &32, &03, &02, &06, &32, &01
 EQUB &02, &04, &CA, &32, &2F, &3A, &40, &80
 EQUB &03, &40, &21, &0C, &10, &00, &80, &03
 EQUB &21, &01, &07, &21, &01, &07, &21, &18
 EQUB &07, &10, &0F, &0F, &0F, &0F, &0F, &0C
 EQUB &3F

\ ******************************************************************************
\
\       Name: image3
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 3
\
\ ******************************************************************************

.image3

 EQUB &0F, &01, &37, &02, &17, &2B, &05, &0A
 EQUB &57, &3F, &5F, &FE, &FF, &FE, &B5, &FA
 EQUB &DF, &EA, &50, &AE, &F4, &E8, &50, &00
 EQUB &41, &33, &0B, &17, &01, &02, &21, &05
 EQUB &00, &40, &A0, &7A, &FE, &7F, &BF, &7F
 EQUB &AB, &33, &11, &02, &01, &D4, &F8, &EA
 EQUB &FC, &FE, &7F, &AF, &7F, &09, &21, &05
 EQUB &40, &20, &34, &02, &07, &12, &15, &BE
 EQUB &75, &A0, &54, &BA, &FF, &EA, &54, &80
 EQUB &33, &01, &02, &07, &8A, &45, &80, &21
 EQUB &05, &BF, &7F, &FE, &FA, &FE, &5C, &F8
 EQUB &FE, &7D, &68, &39, &15, &3F, &1F, &1F
 EQUB &0E, &3B, &00, &05, &02, &80, &22, &C0
 EQUB &A0, &32, &15, &2B, &5E, &F5, &7E, &BF
 EQUB &56, &21, &2F, &7A, &04, &22, &04, &00
 EQUB &21, &01, &10, &33, &2C, &0E, &14, &BC
 EQUB &73, &21, &27, &43, &80, &00, &80, &10
 EQUB &A0, &00, &D0, &D9, &33, &02, &17, &2F
 EQUB &23, &1F, &22, &0F, &FE, &22, &F6, &22
 EQUB &E0, &22, &F0, &E0, &38, &3C, &3F, &3F
 EQUB &1F, &1E, &0E, &04, &04, &A3, &55, &E2
 EQUB &22, &E0, &E9, &40, &41, &D4, &6A, &BD
 EQUB &6B, &21, &3E, &55, &AF, &7F, &03, &21
 EQUB &01, &04, &F0, &5C, &21, &28, &10, &81
 EQUB &03, &30, &62, &F5, &FF, &21, &2F, &55
 EQUB &A2, &21, &07, &A5, &50, &EA, &F0, &A0
 EQUB &50, &E8, &C0, &60, &A0, &60, &C0, &40
 EQUB &0F, &22, &01, &02, &FF, &5F, &AB, &5F
 EQUB &FE, &B5, &EE, &7F, &06, &22, &02, &00
 EQUB &22, &80, &05, &34, &0B, &05, &00, &01
 EQUB &04, &E4, &78, &C8, &0F, &0E, &21, &2A
 EQUB &5C, &21, &38, &10, &20, &0F, &80, &40
 EQUB &30, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &08, &3F, &21, &01, &00, &21, &11, &04
 EQUB &21, &08, &7F, &AF, &34, &17, &2B, &05
 EQUB &0B, &5F, &AB, &FD, &E8, &D4, &FA, &F5
 EQUB &A8, &C0, &A0, &03, &40, &09, &33, &01
 EQUB &0B, &17, &05, &40, &A0, &7A, &21, &01
 EQUB &07, &35, &2B, &07, &15, &03, &01, &03
 EQUB &20, &00, &21, &14, &02, &32, &03, &01
 EQUB &00, &7F, &21, &38, &5C, &32, &28, &01
 EQUB &80, &95, &21, &18, &40, &80, &02, &40
 EQUB &04, &37, &01, &02, &07, &0A, &05, &00
 EQUB &05, &BF, &7F, &FE, &FA, &FE, &5C, &F8
 EQUB &FE, &7D, &68, &36, &15, &3F, &1F, &1F
 EQUB &0E, &3B, &03, &80, &22, &C0, &A0, &02
 EQUB &33, &01, &0A, &01, &03, &21, &05, &03
 EQUB &36, &01, &07, &07, &03, &02, &18, &20
 EQUB &00, &8A, &40, &82, &C4, &A2, &07, &10
 EQUB &33, &02, &17, &2F, &23, &1F, &22, &0F
 EQUB &FE, &22, &F6, &22, &E0, &22, &F0, &E0
 EQUB &38, &3C, &3F, &3F, &1F, &1E, &0E, &04
 EQUB &04, &80, &40, &24, &E0, &22, &40, &34
 EQUB &2B, &15, &02, &14, &04, &22, &01, &00
 EQUB &21, &01, &00, &20, &32, &14, &28, &00
 EQUB &A0, &D4, &60, &81, &00, &32, &01, &07
 EQUB &20, &40, &22, &80, &50, &AA, &5D, &F8
 EQUB &21, &05, &00, &21, &02, &05, &60, &A0
 EQUB &60, &C0, &40, &0F, &08, &21, &01, &4A
 EQUB &21, &11, &80, &10, &02, &20, &02, &22
 EQUB &02, &21, &2E, &22, &BF, &32, &1D, &17
 EQUB &03, &F4, &FA, &77, &F2, &E0, &04, &80
 EQUB &0F, &0F, &D5, &A3, &43, &35, &2B, &11
 EQUB &31, &11, &01, &0C, &80, &40, &30, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &08, &3F
 EQUB &04, &34, &01, &04, &02, &02, &04, &33
 EQUB &01, &04, &02, &0F, &0F, &03, &21, &01
 EQUB &00, &35, &01, &0A, &05, &20, &15, &AF
 EQUB &08, &51, &32, &0B, &17, &AF, &FF, &BE
 EQUB &F4, &E8, &08, &FE, &12, &FA, &FF, &BF
 EQUB &5F, &85, &09, &80, &40, &80, &54, &EE
 EQUB &FD, &FE, &0D, &80, &50, &80, &08, &23
 EQUB &01, &32, &23, &0C, &10, &40, &84, &00
 EQUB &22, &01, &32, &21, &08, &10, &40, &84
 EQUB &02, &81, &C2, &74, &21, &38, &00, &40
 EQUB &03, &82, &54, &21, &28, &00, &40, &37
 EQUB &01, &0A, &5F, &2B, &05, &00, &15, &AB
 EQUB &08, &7F, &FE, &FD, &F8, &75, &BA, &7F
 EQUB &FA, &08, &40, &80, &35, &01, &05, &01
 EQUB &A2, &06, &04, &22, &01, &00, &21, &02
 EQUB &00, &82, &97, &6A, &40, &60, &20, &32
 EQUB &31, &04, &22, &80, &00, &22, &40, &00
 EQUB &20, &00, &FF, &FA, &FD, &7F, &22, &3F
 EQUB &5F, &EA, &08, &D4, &A0, &00, &80, &40
 EQUB &A9, &D0, &80, &08, &3B, &09, &17, &1E
 EQUB &3C, &28, &28, &0C, &0C, &09, &15, &1A
 EQUB &30, &22, &20, &22, &08, &A5, &D2, &60
 EQUB &00, &21, &01, &00, &32, &08, &0C, &A0
 EQUB &80, &40, &00, &21, &01, &00, &22, &08
 EQUB &7F, &FF, &5F, &21, &2F, &5F, &BF, &32
 EQUB &07, &06, &08, &FD, &E8, &D0, &23, &E0
 EQUB &22, &F0, &08, &3E, &01, &09, &09, &1C
 EQUB &10, &08, &0C, &18, &01, &01, &09, &08
 EQUB &10, &08, &33, &0C, &08, &03, &02, &20
 EQUB &21, &21, &51, &4A, &6A, &04, &20, &51
 EQUB &40, &21, &2A, &5C, &AA, &34, &1D, &1F
 EQUB &1F, &16, &BF, &BE, &07, &80, &00, &80
 EQUB &40, &80, &C1, &AA, &50, &80, &08, &3E
 EQUB &06, &26, &03, &16, &0B, &05, &03, &02
 EQUB &06, &24, &01, &14, &0A, &04, &35, &03
 EQUB &02, &03, &00, &01, &83, &7E, &CE, &B8
 EQUB &90, &21, &02, &00, &21, &01, &82, &21
 EQUB &2C, &CA, &A8, &90, &8F, &9D, &21, &0A
 EQUB &05, &22, &80, &06, &5A, &AF, &32, &15
 EQUB &0F, &5F, &AF, &32, &17, &3F, &08, &3F
 EQUB &98, &50, &98, &21, &32, &A6, &E4, &C8
 EQUB &80, &21, &18, &10, &34, &18, &12, &26
 EQUB &24, &48, &00, &4C, &3A, &0A, &24, &45
 EQUB &04, &0C, &0C, &08, &48, &0A, &24, &41
 EQUB &00, &33, &0C, &04, &08, &7F, &FF, &FB
 EQUB &FF, &DC, &6C, &CE, &AE, &00, &80, &00
 EQUB &21, &24, &48, &60, &CA, &AE, &00, &A0
 EQUB &54, &A0, &0C, &3E, &01, &05, &05, &0A
 EQUB &17, &07, &25, &54, &01, &05, &05, &0A
 EQUB &15, &04, &21, &21, &50, &C0, &22, &40
 EQUB &80, &A0, &7D, &21, &28, &00, &40, &00
 EQUB &40, &00, &A0, &6D, &21, &28, &03, &33
 EQUB &08, &0C, &06, &48, &05, &32, &08, &06
 EQUB &48, &02, &36, &1B, &07, &17, &3E, &1F
 EQUB &14, &03, &35, &01, &13, &2E, &17, &14
 EQUB &02, &90, &80, &21, &02, &80, &33, &04
 EQUB &08, &18, &00, &90, &80, &21, &02, &80
 EQUB &35, &04, &08, &18, &00, &09, &22, &10
 EQUB &00, &20, &00, &40, &00, &21, &09, &22
 EQUB &10, &00, &20, &00, &40, &00, &21, &24
 EQUB &42, &21, &04, &80, &04, &21, &24, &42
 EQUB &21, &04, &80, &06, &22, &04, &33, &0C
 EQUB &08, &28, &20, &02, &21, &04, &00, &21
 EQUB &04, &00, &21, &28, &20, &21, &36, &BE
 EQUB &6B, &5B, &8F, &85, &47, &34, &03, &24
 EQUB &9E, &29, &10, &8E, &80, &44, &21, &01
 EQUB &03, &80, &00, &A0, &C0, &D8, &21, &07
 EQUB &9F, &7C, &CF, &33, &39, &2F, &07, &50
 EQUB &08, &21, &3D, &E7, &FA, &DF, &F3, &7F
 EQUB &93, &FE, &08, &CE, &FF, &73, &FF, &21
 EQUB &3F, &FF, &CF, &FC, &08, &7E, &14, &21
 EQUB &3F, &12, &09, &C0, &FE, &FF, &F9, &FF
 EQUB &FE, &FB, &0A, &70, &E7, &FF, &F9, &7E
 EQUB &D2, &40, &07, &40, &03, &81, &21, &22
 EQUB &97, &F9, &21, &03, &83, &63, &36, &3D
 EQUB &0D, &19, &10, &08, &01, &83, &62, &37
 EQUB &24, &09, &11, &10, &08, &88, &24, &00
 EQUB &42, &48, &21, &2D, &85, &21, &12, &8B
 EQUB &21, &25, &00, &42, &34, &08, &25, &85
 EQUB &12, &05, &40, &A0, &F5, &9F, &71, &92
 EQUB &82, &00, &40, &A0, &D5, &05, &21, &04
 EQUB &A8, &7D, &BF, &F7, &DD, &6B, &32, &22
 EQUB &04, &A0, &4D, &06, &88, &D6, &CF, &FF
 EQUB &FB, &AA, &A0, &00, &88, &52, &05, &10
 EQUB &21, &3D, &AA, &9F, &FC, &D7, &92, &80
 EQUB &10, &21, &2D, &AA, &02, &35, &02, &0A
 EQUB &0E, &5D, &2A, &80, &ED, &E8, &62, &48
 EQUB &21, &02, &55, &21, &2A, &80, &03, &80
 EQUB &21, &11, &55, &EA, &40, &CE, &79, &21
 EQUB &2E, &8A, &21, &11, &45, &AA, &40, &3F

\ ******************************************************************************
\
\       Name: image4
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 4
\
\ ******************************************************************************

.image4

 EQUB &F0, &78, &21, &3C, &7C, &FE, &13, &03
 EQUB &10, &02, &21, &02, &87, &03, &21, &01
 EQUB &03, &20, &02, &80, &C0, &80, &21, &01
 EQUB &0F, &80, &02, &E3, &43, &31, &03, &25
 EQUB &06, &08, &FD, &FE, &FF, &22, &F0, &22
 EQUB &F8, &FD, &82, &C0, &22, &E0, &70, &30
 EQUB &21, &38, &9C, &06, &40, &0F, &01, &20
 EQUB &06, &21, &01, &80, &24, &0C, &22, &08
 EQUB &22, &18, &40, &20, &10, &05, &FB, &17
 EQUB &EC, &FE, &F6, &7B, &21, &3B, &9D, &CF
 EQUB &E6, &05, &22, &80, &C0, &00, &20, &06
 EQUB &33, &01, &03, &01, &05, &C0, &E0, &C0
 EQUB &80, &04, &21, &18, &23, &10, &30, &23
 EQUB &20, &04, &80, &22, &40, &20, &16, &F9
 EQUB &F8, &18, &C0, &60, &70, &B0, &B8, &D8
 EQUB &EC, &7C, &07, &21, &02, &0A, &21, &08
 EQUB &05, &20, &00, &48, &23, &40, &02, &22
 EQUB &10, &21, &08, &05, &FA, &FB, &F9, &FD
 EQUB &15, &22, &7F, &FF, &21, &3F, &7F, &21
 EQUB &3F, &9F, &22, &76, &BB, &FB, &FD, &FF
 EQUB &FE, &FF, &04, &22, &80, &22, &C0, &07
 EQUB &40, &02, &40, &E0, &40, &21, &02, &08
 EQUB &22, &10, &03, &34, &04, &02, &02, &01
 EQUB &00, &FF, &F7, &E7, &67, &22, &F3, &BB
 EQUB &B9, &9F, &8F, &CF, &C7, &22, &E7, &22
 EQUB &C7, &12, &7F, &21, &3F, &DF, &13, &22
 EQUB &60, &F0, &B0, &22, &F8, &22, &FC, &E0
 EQUB &40, &05, &21, &01, &08, &33, &18, &08
 EQUB &0C, &07, &22, &40, &22, &60, &22, &70
 EQUB &D9, &22, &CF, &E5, &F6, &22, &FE, &FC
 EQUB &47, &67, &7F, &FF, &BF, &22, &3F, &21
 EQUB &1F, &18, &FC, &22, &FE, &22, &F7, &FB
 EQUB &FF, &FD, &05, &84, &80, &C0, &00, &21
 EQUB &08, &08, &80, &02, &22, &10, &21, &08
 EQUB &22, &78, &22, &7C, &22, &7E, &22, &7F
 EQUB &3F, &CC, &E4, &F2, &FB, &FD, &FC, &DE
 EQUB &BF, &02, &10, &21, &38, &10, &80, &85
 EQUB &42, &02, &33, &01, &02, &01, &00, &20
 EQUB &70, &00, &80, &40, &A0, &41, &83, &21
 EQUB &01, &06, &81, &02, &21, &01, &03, &80
 EQUB &C0, &80, &00, &50, &A0, &40, &25, &01
 EQUB &18, &32, &37, &2F, &7F, &15, &65, &A0
 EQUB &90, &D0, &E8, &EC, &F4, &F2, &20, &04
 EQUB &40, &E0, &40, &0E, &20, &70, &05, &21
 EQUB &01, &83, &31, &01, &24, &03, &22, &07
 EQUB &87, &21, &07, &19, &FE, &16, &5A, &21
 EQUB &2D, &DD, &FE, &DE, &EF, &F7, &FB, &03
 EQUB &22, &80, &22, &40, &A0, &20, &70, &20
 EQUB &05, &20, &21, &05, &06, &80, &D0, &80
 EQUB &00, &80, &03, &31, &07, &24, &0F, &23
 EQUB &1F, &1F, &11, &F9, &CC, &C2, &D9, &F9
 EQUB &FE, &FF, &DF, &B0, &D0, &C8, &68, &74
 EQUB &B4, &9A, &CA, &06, &32, &02, &07, &09
 EQUB &33, &08, &1C, &08, &04, &31, &1F, &25
 EQUB &3F, &22, &7F, &18, &FD, &7C, &22, &3E
 EQUB &22, &9F, &22, &DF, &13, &7F, &FD, &FC
 EQUB &22, &F8, &DD, &BD, &DE, &CE, &22, &E7
 EQUB &73, &32, &39, &02, &00, &22, &80, &22
 EQUB &40, &22, &A0, &03, &21, &01, &02, &40
 EQUB &A0, &00, &40, &A0, &50, &A2, &47, &21
 EQUB &02, &00, &28, &7F, &13, &FB, &22, &FD
 EQUB &FE, &12, &BF, &12, &24, &7F, &23, &FC
 EQUB &FD, &FC, &FE, &FA, &FB, &32, &1D, &04
 EQUB &86, &F2, &7B, &BD, &B9, &21, &18, &D1
 EQUB &D0, &68, &E8, &22, &74, &F8, &BA, &50
 EQUB &A0, &40, &03, &32, &01, &03, &07, &80
 EQUB &27, &7F, &21, &3F, &16, &CF, &FF, &23
 EQUB &3F, &32, &1F, &0F, &87, &83, &C3, &22
 EQUB &F9, &22, &F0, &F8, &FC, &F2, &FB, &21
 EQUB &3C, &9C, &8E, &34, &07, &27, &23, &31
 EQUB &98, &DE, &5D, &4D, &CE, &EE, &EF, &97
 EQUB &32, &3F, &01, &02, &22, &80, &44, &40
 EQUB &A0, &33, &08, &1C, &08, &05, &22, &3F
 EQUB &BF, &25, &3F, &FF, &C7, &12, &C1, &12
 EQUB &C0, &3F, &00, &80, &C0, &80, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &04, &37
 EQUB &02, &01, &00, &0F, &1F, &3F, &3F, &7E
 EQUB &04, &10, &22, &38, &7C, &04, &80, &22
 EQUB &C0, &60, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0E, &7C, &78, &FE, &12, &FB, &22, &F7
 EQUB &22, &78, &FE, &12, &FB, &22, &F7, &10
 EQUB &00, &21, &08, &84, &C4, &E2, &F0, &F9
 EQUB &20, &10, &02, &20, &90, &C8, &E4, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &06, &22, &F7
 EQUB &12, &23, &7F, &21, &3F, &22, &F7, &12
 EQUB &22, &7F, &79, &21, &38, &80, &03, &32
 EQUB &08, &18, &9E, &9F, &86, &35, &03, &01
 EQUB &00, &08, &18, &9E, &9F, &00, &22, &80
 EQUB &22, &40, &20, &10, &80, &03, &22, &80
 EQUB &40, &20, &10, &0F, &01, &3F, &0F, &0F
 EQUB &0F, &0F, &04, &3E, &3D, &1C, &1E, &1E
 EQUB &0E, &0E, &0C, &0C, &3A, &1B, &19, &1D
 EQUB &0E, &0E, &22, &0C, &BF, &9F, &98, &30
 EQUB &24, &F0, &BF, &32, &1F, &18, &B0, &30
 EQUB &70, &30, &90, &22, &88, &C4, &34, &04
 EQUB &02, &00, &01, &02, &40, &A0, &30, &22
 EQUB &18, &32, &0C, &06, &0F, &0F, &0F, &0F
 EQUB &0F, &05, &36, &0C, &0E, &1E, &9E, &0F
 EQUB &0F, &22, &47, &31, &0C, &23, &06, &23
 EQUB &83, &81, &22, &F0, &70, &22, &78, &23
 EQUB &F8, &90, &80, &22, &40, &60, &E0, &22
 EQUB &C4, &02, &80, &C0, &20, &03, &34, &02
 EQUB &03, &01, &01, &00, &22, &40, &E0, &22
 EQUB &80, &22, &40, &20, &00, &22, &10, &02
 EQUB &C0, &00, &A0, &80, &10, &50, &0F, &0F
 EQUB &0F, &0F, &04, &38, &27, &33, &33, &1B
 EQUB &09, &01, &01, &03, &C1, &22, &C3, &E1
 EQUB &F0, &78, &7C, &21, &3C, &B8, &98, &22
 EQUB &80, &23, &C0, &E0, &22, &06, &21, &0F
 EQUB &8F, &87, &32, &03, &01, &09, &C0, &60
 EQUB &70, &F8, &D8, &DC, &CE, &67, &23, &08
 EQUB &22, &0C, &3A, &06, &02, &03, &28, &28
 EQUB &38, &34, &04, &02, &02, &81, &0F, &0F
 EQUB &0F, &0F, &04, &3F

\ ******************************************************************************
\
\       Name: image5
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 5
\
\ ******************************************************************************

.image5

 EQUB &23, &10, &34, &18, &38, &10, &2C, &7E
 EQUB &0D, &22, &10, &30, &0F, &0F, &02, &3D
 EQUB &04, &0C, &04, &04, &0E, &1E, &1E, &0C
 EQUB &3E, &02, &3C, &02, &3C, &7E, &22, &7F
 EQUB &00, &22, &40, &20, &22, &08, &33, &16
 EQUB &3F, &00, &23, &38, &10, &00, &22, &10
 EQUB &0F, &0E, &22, &20, &70, &00, &21, &1C
 EQUB &22, &7E, &BE, &E0, &22, &7C, &35, &3E
 EQUB &1E, &04, &18, &18, &10, &02, &39, &01
 EQUB &1E, &3F, &01, &1E, &1E, &0C, &02, &30
 EQUB &23, &38, &34, &05, &1D, &3C, &3D, &06
 EQUB &22, &80, &0F, &01, &70, &88, &70, &22
 EQUB &F0, &60, &21, &01, &20, &33, &18, &08
 EQUB &08, &88, &98, &22, &9C, &21, &1C, &08
 EQUB &3C, &0E, &1F, &00, &03, &03, &01, &03
 EQUB &00, &3D, &1C, &9C, &1C, &22, &9C, &21
 EQUB &1C, &84, &03, &C0, &22, &E0, &60, &0A
 EQUB &22, &04, &37, &0E, &1E, &1E, &10, &0C
 EQUB &01, &23, &64, &63, &22, &67, &47, &70
 EQUB &22, &BC, &20, &21, &18, &98, &90, &98
 EQUB &10, &08, &33, &1F, &06, &03, &05, &31
 EQUB &18, &25, &3C, &22, &1C, &40, &C0, &22
 EQUB &C8, &C0, &22, &C8, &59, &03, &22, &18
 EQUB &03, &33, &0C, &0E, &2E, &6C, &68, &23
 EQUB &2C, &71, &E7, &CC, &D9, &9B, &23, &B6
 EQUB &D8, &10, &21, &18, &80, &21, &3C, &7C
 EQUB &60, &40, &08, &34, &03, &01, &03, &03
 EQUB &04, &84, &88, &C4, &C8, &21, &04, &03
 EQUB &59, &5D, &32, &0D, &01, &05, &90, &21
 EQUB &13, &B7, &02, &10, &00, &6C, &EC, &94
 EQUB &21, &01, &04, &21, &36, &00, &7D, &FD
 EQUB &21, &0D, &03, &40, &00, &E0, &E8, &F8
 EQUB &0F, &0F, &05, &21, &18, &00, &21, &38
 EQUB &00, &21, &08, &0F, &0C, &3F, &03, &30
 EQUB &10, &00, &40, &8C, &0B, &22, &10, &00
 EQUB &20, &21, &18, &0F, &0F, &03, &21, &06
 EQUB &00, &35, &0A, &04, &0D, &0D, &02, &DC
 EQUB &8C, &4E, &8C, &42, &8D, &22, &9E, &40
 EQUB &00, &A0, &C8, &60, &44, &21, &2C, &4E
 EQUB &21, &38, &50, &58, &50, &20, &00, &22
 EQUB &20, &0F, &0F, &01, &20, &00, &32, &22
 EQUB &31, &F9, &70, &5D, &BB, &21, &13, &CF
 EQUB &E4, &40, &22, &20, &21, &08, &20, &00
 EQUB &5E, &21, &25, &4E, &5E, &35, &26, &2E
 EQUB &16, &2C, &08, &50, &58, &21, &1D, &58
 EQUB &E5, &C9, &59, &0F, &09, &60, &00, &60
 EQUB &68, &48, &10, &20, &36, &01, &26, &10
 EQUB &1C, &1C, &0C, &88, &22, &BA, &08, &73
 EQUB &3E, &26, &03, &01, &05, &03, &04, &0F
 EQUB &48, &29, &28, &A9, &29, &21, &A1, &21
 EQUB &18, &80, &00, &C0, &20, &40, &60, &80
 EQUB &20, &0A, &22, &04, &23, &0D, &34, &02
 EQUB &22, &55, &13, &54, &22, &53, &21, &32
 EQUB &E8, &21, &1A, &92, &21, &1A, &94, &54
 EQUB &48, &54, &21, &08, &08, &A6, &CB, &04
 EQUB &44, &32, &01, &24, &48, &22, &58, &22
 EQUB &48, &21, &28, &A0, &80, &22, &40, &58
 EQUB &50, &40, &21, &18, &88, &03, &22, &18
 EQUB &03, &38, &0A, &08, &0C, &2A, &26, &0A
 EQUB &00, &0A, &C2, &5A, &B7, &8E, &F4, &5B
 EQUB &35, &19, &0D, &34, &E8, &14, &58, &92
 EQUB &B8, &A2, &80, &00, &22, &01, &00, &21
 EQUB &01, &03, &84, &21, &02, &84, &CD, &CC
 EQUB &03, &21, &08, &D4, &8A, &94, &21, &02
 EQUB &03, &8D, &83, &D2, &9E, &21, &0D, &04
 EQUB &21, &02, &B6, &58, &BF, &00, &10, &00
 EQUB &21, &0A, &43, &E2, &9E, &21, &07, &03
 EQUB &5D, &00, &A2, &7B, &21, &32, &03, &80
 EQUB &00, &88, &C0, &E8, &21, &18, &0F, &0F
 EQUB &04, &21, &18, &00, &21, &38, &00, &21
 EQUB &08, &0F, &0C, &3F, &22, &CF, &C7, &22
 EQUB &87, &83, &21, &01, &00, &22, &CF, &C7
 EQUB &22, &87, &83, &21, &01, &00, &17, &BF
 EQUB &17, &BF, &13, &22, &EF, &22, &CF, &87
 EQUB &13, &22, &EF, &22, &CF, &87, &1F, &1F
 EQUB &1F, &1F, &14, &F1, &E0, &F1, &E0, &23
 EQUB &C0, &E0, &F1, &E0, &F1, &E0, &23, &C0
 EQUB &E0, &0F, &01, &BF, &35, &1F, &17, &03
 EQUB &03, &01, &02, &BF, &35, &1F, &17, &03
 EQUB &03, &01, &02, &87, &23, &07, &87, &CF
 EQUB &8F, &21, &07, &87, &23, &07, &87, &CF
 EQUB &8E, &21, &07, &18, &7F, &12, &F7, &12
 EQUB &F2, &CF, &1B, &FE, &FF, &87, &FF, &B0
 EQUB &19, &FB, &13, &FD, &B7, &14, &FE, &DE
 EQUB &CE, &8E, &87, &13, &FE, &DE, &CE, &8E
 EQUB &87, &C0, &80, &06, &C0, &80, &0F, &05
 EQUB &80, &CC, &0F, &01, &22, &07, &21, &02
 EQUB &05, &22, &07, &21, &02, &05, &13, &23
 EQUB &7F, &22, &3F, &12, &D3, &7F, &21, &27
 EQUB &7C, &32, &1B, &02, &18, &FB, &21, &2F
 EQUB &FF, &D2, &BA, &E7, &9C, &21, &01, &FF
 EQUB &24, &FE, &12, &FB, &5F, &E2, &BE, &FA
 EQUB &40, &21, &13, &4C, &A1, &31, &07, &23
 EQUB &03, &32, &02, &06, &22, &8C, &36, &05
 EQUB &03, &02, &03, &00, &06, &8C, &84, &80
 EQUB &C0, &40, &05, &80, &C0, &40, &0D, &F7
 EQUB &5E, &A8, &41, &21, &02, &80, &0C, &C0
 EQUB &B8, &50, &0F, &04, &22, &3F, &22, &1F
 EQUB &24, &0F, &32, &08, &25, &22, &10, &34
 EQUB &0E, &04, &02, &08, &3F, &18, &21, &14
 EQUB &E1, &00, &F0, &21, &06, &88, &32, &23
 EQUB &08, &FB, &F9, &F1, &22, &E0, &22, &C0
 EQUB &E0, &21, &0A, &A9, &21, &11, &60, &A0
 EQUB &02, &20, &88, &07, &88, &0F, &0F, &01
 EQUB &35, &04, &1E, &2E, &1C, &3B, &54, &00
 EQUB &80, &0A, &21, &38, &FC, &D7, &21, &02
 EQUB &0F, &03, &32, &1F, &17, &24, &03, &22
 EQUB &02, &32, &1E, &14, &03, &21, &01, &00
 EQUB &21, &02, &13, &22, &E7, &13, &81, &06
 EQUB &90, &E0, &C0, &80, &02, &24, &80, &06
 EQUB &80, &0F, &0F, &01, &21, &19, &07, &21
 EQUB &05, &04, &10, &21, &24, &00, &21, &05
 EQUB &05, &32, &01, &0B, &5F, &00, &21, &28
 EQUB &10, &02, &32, &01, &0B, &5F, &05, &40
 EQUB &EB, &FF, &05, &40, &EB, &77, &05, &7F
 EQUB &12, &05, &7F, &FF, &9C, &6D, &48, &03
 EQUB &FF, &EF, &FF, &21, &25, &48, &03, &E7
 EQUB &83, &C6, &04, &60, &13, &04, &60, &22
 EQUB &DF, &7F, &05, &C0, &12, &05, &C0, &FF
 EQUB &FE, &06, &E0, &F0, &21, &14, &00, &22
 EQUB &02, &00, &21, &02, &60, &30, &3E, &2F
 EQUB &07, &6F, &0F, &1F, &CF, &17, &4F, &2F
 EQUB &07, &6F, &0D, &1F, &CF, &21, &15, &48
 EQUB &DF, &EF, &BF, &15, &DE, &EF, &BD, &22
 EQUB &FE, &FD, &FF, &FB, &18, &67, &F7, &FF
 EQUB &F7, &E7, &F7, &F9, &EF, &19, &E3, &F4
 EQUB &4E, &F8, &9F, &F4, &BF, &E7, &FF, &C7
 EQUB &FF, &F7, &13, &00, &81, &00, &80, &00
 EQUB &A2, &21, &01, &D3, &18, &F7, &21, &3F
 EQUB &6B, &33, &1F, &39, &0F, &BB, &F1, &18
 EQUB &B7, &BF, &BB, &DE, &FF, &22, &DF, &8F
 EQUB &F0, &F8, &FC, &15, &70, &F8, &FC, &12
 EQUB &EF, &E7, &D7, &3F

\ ******************************************************************************
\
\       Name: image6
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 6
\
\ ******************************************************************************

.image6

 EQUB &40, &10, &80, &20, &02, &40, &0F, &0F
 EQUB &0F, &01, &21, &18, &5E, &21, &3C, &06
 EQUB &80, &03, &40, &02, &90, &21, &02, &05
 EQUB &80, &0A, &C0, &0F, &0F, &0F, &0F, &0F
 EQUB &0D, &21, &18, &0F, &48, &00, &80, &05
 EQUB &21, &03, &00, &21, &02, &00, &21, &01
 EQUB &03, &21, &0E, &79, &21, &35, &4D, &21
 EQUB &3D, &65, &97, &21, &02, &00, &E0, &FF
 EQUB &CF, &F3, &BC, &21, &33, &CF, &03, &F0
 EQUB &78, &F0, &76, &A7, &0F, &0F, &0A, &33
 EQUB &0B, &08, &00, &24, &03, &32, &07, &3F
 EQUB &F1, &7F, &FF, &22, &FE, &FC, &F8, &CF
 EQUB &DF, &9F, &22, &3F, &7F, &12, &80, &C0
 EQUB &E0, &F0, &F8, &FC, &F8, &E6, &07, &21
 EQUB &04, &06, &32, &24, &09, &06, &80, &09
 EQUB &23, &07, &35, &05, &0B, &0B, &0F, &0D
 EQUB &F9, &F1, &60, &67, &21, &0D, &82, &81
 EQUB &21, &07, &FF, &FC, &21, &01, &A7, &21
 EQUB &1F, &7F, &FD, &FA, &9F, &7F, &FB, &EA
 EQUB &B1, &61, &80, &C1, &03, &22, &80, &40
 EQUB &80, &00, &21, &08, &48, &21, &01, &90
 EQUB &21, &04, &20, &02, &20, &00, &80, &0D
 EQUB &32, &0C, &18, &10, &05, &21, &1F, &5B
 EQUB &E8, &05, &D1, &80, &06, &20, &0F, &08
 EQUB &3F, &21, &04, &02, &21, &04, &02, &21
 EQUB &08, &0F, &0F, &0F, &01, &21, &37, &A1
 EQUB &5B, &06, &40, &22, &80, &00, &21, &09
 EQUB &00, &21, &04, &03, &80, &10, &00, &20
 EQUB &00, &21, &08, &40, &21, &03, &07, &21
 EQUB &38, &0F, &0F, &0A, &20, &88, &00, &20
 EQUB &82, &00, &21, &04, &05, &40, &0F, &0F
 EQUB &05, &32, &36, &18, &0F, &01, &21, &08
 EQUB &00, &20, &21, &01, &00, &83, &38, &0C
 EQUB &3B, &0D, &FF, &16, &2E, &59, &27, &F1
 EQUB &86, &CA, &B2, &C2, &92, &68, &FD, &C0
 EQUB &21, &1C, &58, &32, &33, &2C, &5B, &8D
 EQUB &21, &37, &02, &E0, &98, &B8, &F2, &B7
 EQUB &45, &07, &80, &0F, &02, &21, &04, &00
 EQUB &3B, &03, &0D, &80, &02, &01, &8D, &35
 EQUB &D5, &3F, &C0, &11, &4C, &00, &74, &77
 EQUB &FF, &21, &15, &FC, &75, &21, &34, &71
 EQUB &D9, &68, &9F, &C1, &FA, &7C, &B8, &78
 EQUB &83, &DC, &33, &1F, &3F, &0F, &78, &FF
 EQUB &EA, &C0, &E0, &F0, &F8, &FC, &21, &3A
 EQUB &46, &21, &19, &05, &21, &01, &00, &20
 EQUB &04, &21, &11, &00, &21, &08, &80, &40
 EQUB &21, &08, &00, &80, &21, &12, &00, &21
 EQUB &08, &00, &21, &02, &41, &30, &37, &18
 EQUB &08, &44, &01, &01, &28, &09, &A8, &4A
 EQUB &A4, &21, &04, &00, &33, &12, &39, &12
 EQUB &A3, &80, &C2, &35, &0D, &1E, &3A, &50
 EQUB &03, &FE, &5D, &EE, &B1, &82, &21, &05
 EQUB &6A, &B2, &C4, &21, &15, &4F, &9A, &7B
 EQUB &21, &3E, &00, &84, &80, &22, &40, &A0
 EQUB &60, &C0, &21, &1C, &00, &21, &09, &10
 EQUB &00, &21, &01, &00, &34, &04, &01, &00
 EQUB &08, &00, &42, &00, &10, &80, &02, &48
 EQUB &03, &10, &00, &92, &46, &32, &2C, &18
 EQUB &04, &20, &32, &24, &17, &EB, &04, &21
 EQUB &2E, &7F, &FF, &E0, &04, &CD, &B5, &C2
 EQUB &05, &80, &00, &21, &04, &06, &21, &02
 EQUB &10, &05, &3F, &0F, &03, &80, &21, &04
 EQUB &52, &20, &00, &48, &02, &80, &21, &04
 EQUB &52, &20, &00, &48, &04, &21, &12, &6C
 EQUB &8A, &65, &04, &21, &12, &6C, &8A, &65
 EQUB &21, &04, &00, &41, &32, &16, &2C, &9A
 EQUB &E4, &7B, &21, &04, &00, &41, &32, &16
 EQUB &2C, &9A, &E4, &7B, &21, &02, &48, &80
 EQUB &21, &13, &A7, &4B, &DF, &BF, &21, &02
 EQUB &48, &80, &21, &13, &A7, &4A, &DB, &B1
 EQUB &00, &49, &82, &4C, &B9, &E9, &D6, &8B
 EQUB &00, &49, &82, &4C, &B9, &E9, &56, &8B
 EQUB &33, &04, &08, &24, &C1, &80, &03, &33
 EQUB &04, &08, &24, &C1, &80, &03, &84, &00
 EQUB &48, &90, &80, &20, &00, &21, &04, &84
 EQUB &00, &48, &90, &80, &20, &00, &21, &04
 EQUB &0F, &01, &3E, &04, &03, &29, &05, &07
 EQUB &15, &03, &0A, &04, &03, &29, &05, &07
 EQUB &15, &32, &03, &0A, &9B, &FA, &AF, &7D
 EQUB &FF, &76, &DD, &EF, &9B, &FA, &AB, &55
 EQUB &8E, &52, &D5, &AD, &D7, &BF, &F9, &E7
 EQUB &DF, &67, &FF, &6F, &D7, &BE, &D9, &65
 EQUB &DF, &65, &BB, &6F, &FB, &CD, &DC, &7B
 EQUB &A7, &6F, &7E, &F7, &6B, &CD, &88, &7B
 EQUB &A5, &6B, &56, &D5, &53, &21, &37, &EF
 EQUB &DD, &BA, &E6, &EE, &DD, &51, &21, &34
 EQUB &EA, &55, &AA, &C7, &EF, &DA, &23, &80
 EQUB &32, &38, &27, &BF, &7C, &21, &39, &80
 EQUB &A0, &C0, &58, &E7, &7F, &EC, &B9, &00
 EQUB &10, &20, &C4, &90, &20, &42, &B4, &00
 EQUB &10, &20, &C4, &90, &20, &42, &B4, &0F
 EQUB &01, &34, &07, &03, &03, &01, &04, &21
 EQUB &05, &00, &32, &02, &01, &04, &FF, &FB
 EQUB &BF, &12, &EF, &7F, &21, &07, &83, &CB
 EQUB &21, &24, &30, &10, &C8, &40, &21, &06
 EQUB &BA, &FF, &97, &FF, &F7, &12, &FE, &B2
 EQUB &21, &27, &94, &5C, &33, &01, &0A, &01
 EQUB &42, &FF, &FD, &F7, &F5, &DB, &BF, &12
 EQUB &8B, &85, &21, &16, &55, &32, &1B, &2C
 EQUB &88, &00, &7A, &FA, &F4, &E5, &C8, &D9
 EQUB &99, &21, &33, &4D, &75, &4B, &9B, &32
 EQUB &36, &2F, &75, &ED, &F2, &E5, &EF, &4F
 EQUB &DF, &BF, &7F, &FF, &F2, &65, &EE, &44
 EQUB &DA, &A8, &51, &C3, &68, &D0, &F0, &E5
 EQUB &DE, &A6, &FC, &F9, &21, &28, &50, &70
 EQUB &A5, &5E, &A6, &5C, &89, &0F, &0F, &0F
 EQUB &03, &32, &3F, &03, &06, &32, &3E, &02
 EQUB &06, &3F, &FF, &FE, &34, &1C, &05, &01
 EQUB &01, &03, &37, &05, &1F, &02, &06, &0C
 EQUB &08, &18, &76, &65, &E3, &EF, &CF, &4F
 EQUB &8F, &21, &1F, &8A, &9C, &21, &38, &78
 EQUB &30, &21, &34, &68, &62, &13, &FC, &FB
 EQUB &EF, &9F, &EF, &86, &37, &19, &23, &44
 EQUB &1A, &29, &93, &29, &70, &B2, &6F, &EF
 EQUB &DB, &7F, &FE, &FF, &30, &B2, &4F, &AD
 EQUB &5B, &6F, &D4, &21, &03, &0F, &0F, &0F
 EQUB &0F, &22, &01, &32, &03, &07, &08, &30
 EQUB &20, &60, &22, &C0, &80, &02, &35, &3F
 EQUB &0B, &07, &07, &03, &03, &35, &07, &0B
 EQUB &06, &00, &01, &03, &DF, &7F, &FF, &BF
 EQUB &FE, &03, &D4, &60, &80, &20, &21, &06
 EQUB &03, &FE, &FF, &FC, &E0, &04, &33, &06
 EQUB &0B, &14, &A0, &0F, &0F, &0F, &0F, &34
 EQUB &06, &0C, &1C, &18, &30, &70, &60, &C0
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0E, &22
 EQUB &01, &36, &03, &07, &0E, &0E, &1C, &38
 EQUB &08, &C0, &80, &04, &22, &01, &0C, &22
 EQUB &E0, &22, &C0, &0F, &0F, &0F, &03, &3F

\ ******************************************************************************
\
\       Name: image7
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 7
\
\ ******************************************************************************

.image7

 EQUB &44, &10, &80, &32, &28, &02, &40, &08
 EQUB &20, &08, &10, &02, &20, &40, &E0, &7A
 EQUB &FD, &FF, &02, &40, &20, &02, &40, &80
 EQUB &07, &32, &04, &21, &02, &21, &02, &00
 EQUB &32, &08, &01, &05, &20, &06, &10, &02
 EQUB &21, &04, &02, &21, &01, &04, &40, &05
 EQUB &23, &02, &82, &22, &7F, &33, &3F, &1F
 EQUB &06, &03, &D8, &BC, &F8, &E0, &50, &07
 EQUB &21, &04, &00, &10, &04, &40, &00, &21
 EQUB &01, &0A, &21, &02, &0D, &21, &07, &00
 EQUB &22, &02, &36, &07, &1F, &1F, &3F, &FF
 EQUB &3F, &03, &22, &C0, &E0, &F0, &E1, &05
 EQUB &21, &0C, &86, &C0, &03, &21, &03, &00
 EQUB &80, &50, &88, &02, &20, &33, &08, &1F
 EQUB &07, &06, &80, &C0, &E0, &00, &21, &02
 EQUB &02, &21, &01, &02, &32, &01, &08, &02
 EQUB &40, &00, &50, &03, &22, &1F, &21, &06
 EQUB &00, &34, &01, &02, &07, &0B, &C0, &84
 EQUB &21, &2E, &54, &21, &19, &00, &40, &21
 EQUB &08, &20, &32, &18, &0D, &C7, &E7, &FB
 EQUB &FD, &6F, &34, &14, &0B, &02, &0F, &85
 EQUB &C2, &E1, &70, &02, &A0, &10, &80, &C0
 EQUB &70, &30, &0D, &23, &02, &08, &22, &07
 EQUB &33, &04, &01, &08, &03, &B0, &64, &80
 EQUB &21, &03, &04, &21, &22, &03, &80, &00
 EQUB &20, &00, &EC, &F0, &50, &20, &32, &08
 EQUB &04, &02, &33, &0C, &04, &02, &0F, &0F
 EQUB &0F, &0F, &0F, &05, &80, &20, &21, &08
 EQUB &A0, &20, &0F, &0F, &0F, &0B, &3F, &E0
 EQUB &40, &21, &02, &80, &00, &10, &32, &04
 EQUB &01, &00, &40, &00, &10, &00, &80, &21
 EQUB &01, &02, &31, &09, &23, &01, &32, &25
 EQUB &01, &00, &89, &74, &DA, &B5, &21, &1F
 EQUB &85, &21, &22, &51, &00, &C8, &B2, &44
 EQUB &B2, &F4, &A8, &7D, &44, &03, &20, &00
 EQUB &A0, &00, &53, &21, &21, &8A, &35, &27
 EQUB &0A, &15, &4A, &01, &80, &02, &21, &24
 EQUB &50, &20, &82, &21, &08, &40, &04, &20
 EQUB &06, &21, &11, &02, &21, &08, &42, &00
 EQUB &21, &02, &42, &02, &3B, &22, &02, &FA
 EQUB &37, &5A, &24, &49, &13, &80, &09, &27
 EQUB &43, &A6, &5F, &AC, &F0, &02, &41, &00
 EQUB &80, &04, &80, &34, &24, &01, &00, &08
 EQUB &00, &10, &80, &21, &04, &42, &10, &00
 EQUB &21, &01, &40, &32, &08, &02, &03, &10
 EQUB &21, &01, &02, &10, &21, &02, &00, &40
 EQUB &21, &04, &03, &59, &00, &21, &02, &47
 EQUB &33, &3A, &27, &2F, &5F, &FF, &5F, &20
 EQUB &21, &02, &E0, &21, &24, &A0, &D0, &E8
 EQUB &D1, &40, &21, &08, &80, &02, &21, &0C
 EQUB &86, &C0, &03, &21, &03, &00, &80, &50
 EQUB &88, &20, &00, &20, &33, &08, &1F, &07
 EQUB &02, &20, &03, &80, &C0, &E0, &00, &38
 EQUB &01, &02, &01, &80, &05, &01, &0A, &01
 EQUB &00, &50, &21, &22, &50, &80, &41, &3E
 EQUB &24, &01, &2F, &27, &3A, &04, &09, &02
 EQUB &07, &0B, &80, &04, &2E, &54, &21, &19
 EQUB &00, &40, &21, &08, &20, &32, &18, &0D
 EQUB &C7, &E7, &FB, &FD, &6F, &34, &14, &0B
 EQUB &02, &0F, &85, &C2, &E1, &70, &02, &A0
 EQUB &10, &80, &C0, &70, &30, &08, &21, &0A
 EQUB &00, &10, &00, &42, &00, &21, &07, &03
 EQUB &40, &02, &20, &02, &22, &07, &33, &04
 EQUB &01, &08, &03, &B0, &64, &80, &21, &03
 EQUB &04, &21, &22, &03, &80, &00, &20, &00
 EQUB &EC, &F0, &50, &20, &32, &08, &04, &02
 EQUB &33, &0C, &04, &02, &0D, &21, &02, &03
 EQUB &10, &02, &80, &0F, &0F, &0F, &0C, &20
 EQUB &84, &10, &88, &20, &21, &08, &70, &0F
 EQUB &0F, &0F, &0B, &3F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &09, &33, &01, &07, &0E, &05, &33, &01
 EQUB &06, &0C, &03, &32, &07, &3F, &F3, &79
 EQUB &21, &3F, &03, &32, &06, &32, &E1, &30
 EQUB &21, &1A, &02, &7F, &FC, &FF, &7F, &AF
 EQUB &77, &02, &71, &F8, &46, &33, &29, &07
 EQUB &02, &02, &DE, &B7, &E0, &78, &12, &02
 EQUB &21, &06, &20, &80, &60, &F4, &21, &39
 EQUB &03, &E0, &7C, &32, &3F, &1E, &FF, &03
 EQUB &A0, &34, &14, &0B, &06, &03, &0F, &0F
 EQUB &04, &36, &01, &03, &06, &0D, &18, &34
 EQUB &02, &34, &01, &02, &04, &08, &10, &20
 EQUB &21, &3F, &7B, &D1, &AB, &E6, &FF, &BF
 EQUB &F6, &21, &3A, &51, &00, &21, &21, &84
 EQUB &6E, &21, &1E, &42, &3F, &DF, &E7, &F2
 EQUB &36, &38, &18, &04, &02, &90, &04, &82
 EQUB &20, &10, &04, &EB, &F4, &FD, &F0, &7A
 EQUB &32, &3D, &1E, &8F, &48, &A4, &30, &60
 EQUB &30, &33, &1C, &08, &04, &FF, &EF, &5F
 EQUB &EC, &7F, &21, &3F, &8F, &CF, &F3, &37
 EQUB &29, &1E, &44, &23, &19, &06, &03, &FE
 EQUB &7F, &DB, &EF, &6F, &B2, &70, &F9, &D4
 EQUB &6F, &5B, &AD, &4F, &B2, &30, &89, &0F
 EQUB &04, &35, &01, &03, &07, &07, &0A, &03
 EQUB &35, &01, &02, &04, &05, &0A, &78, &F8
 EQUB &FB, &FE, &B7, &FB, &FF, &EF, &40, &C8
 EQUB &B0, &70, &A4, &CB, &83, &AD, &4F, &9B
 EQUB &77, &FC, &12, &FA, &EF, &33, &01, &0A
 EQUB &01, &5C, &FC, &21, &27, &F2, &EF, &DD
 EQUB &FF, &FB, &FD, &7F, &FD, &DF, &F7, &88
 EQUB &6C, &21, &3B, &5D, &21, &1E, &85, &8B
 EQUB &D5, &32, &11, &0F, &AE, &DF, &F7, &FB
 EQUB &7F, &DF, &32, &11, &0B, &00, &83, &40
 EQUB &71, &48, &DA, &F3, &FB, &FD, &5F, &FF
 EQUB &ED, &F2, &B9, &21, &11, &A8, &F8, &54
 EQUB &FE, &6D, &F2, &21, &39, &FC, &A6, &DE
 EQUB &E5, &F0, &D0, &68, &B4, &5C, &A6, &5E
 EQUB &A5, &70, &50, &21, &28, &B4, &0F, &01
 EQUB &3E, &03, &15, &07, &05, &29, &03, &04
 EQUB &48, &03, &15, &07, &05, &29, &03, &21
 EQUB &04, &48, &DD, &77, &FF, &7D, &AF, &FA
 EQUB &9B, &65, &D5, &53, &8E, &55, &AB, &FA
 EQUB &9B, &65, &12, &DF, &EF, &F9, &BF, &D7
 EQUB &7B, &BB, &FD, &DF, &6D, &D9, &BE, &D7
 EQUB &7B, &FE, &6F, &BF, &7F, &DD, &CD, &FB
 EQUB &BF, &D6, &6B, &BD, &7F, &89, &CD, &6B
 EQUB &B1, &EF, &E7, &BA, &DD, &EF, &B7, &53
 EQUB &BB, &EE, &C7, &AA, &55, &EA, &B4, &51
 EQUB &BB, &FC, &FF, &E7, &21, &38, &9C, &8A
 EQUB &E4, &71, &6C, &21, &3F, &E7, &21, &18
 EQUB &9C, &8A, &E4, &71, &42, &20, &90, &C4
 EQUB &20, &10, &80, &21, &04, &42, &20, &90
 EQUB &C4, &20, &10, &80, &21, &04, &0F, &02
 EQUB &20, &52, &21, &04, &80, &02, &21, &08
 EQUB &00, &20, &52, &21, &04, &80, &02, &21
 EQUB &08, &8A, &6C, &21, &12, &05, &8A, &6C
 EQUB &21, &12, &05, &E4, &9A, &32, &2C, &16
 EQUB &41, &00, &21, &04, &00, &E4, &9A, &32
 EQUB &2C, &16, &41, &00, &21, &04, &00, &DF
 EQUB &4B, &A7, &21, &13, &80, &48, &21, &02
 EQUB &20, &DB, &4A, &A7, &21, &13, &80, &48
 EQUB &21, &02, &20, &DF, &E9, &B9, &4C, &82
 EQUB &49, &00, &21, &02, &5E, &E9, &B9, &4C
 EQUB &82, &49, &00, &21, &02, &EA, &A7, &83
 EQUB &C1, &34, &24, &08, &04, &08, &EA, &A7
 EQUB &83, &C1, &34, &24, &08, &04, &08, &40
 EQUB &20, &80, &90, &48, &00, &84, &00, &40
 EQUB &20, &80, &90, &48, &00, &84, &00, &3F

\ ******************************************************************************
\
\       Name: image8
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 8
\
\ ******************************************************************************

.image8

 EQUB &02, &36, &08, &01, &04, &00, &02, &08
 EQUB &02, &21, &04, &02, &80, &0F, &02, &21
 EQUB &01, &09, &40, &80, &21, &24, &42, &EF
 EQUB &F8, &E1, &05, &21, &08, &50, &B0, &08
 EQUB &21, &01, &06, &21, &04, &03, &10, &05
 EQUB &21, &02, &00, &32, &01, &04, &10, &02
 EQUB &21, &08, &40, &10, &00, &40, &0B, &78
 EQUB &7C, &33, &3F, &19, &07, &02, &10, &B8
 EQUB &5C, &8C, &F8, &B0, &08, &21, &08, &08
 EQUB &20, &0F, &0A, &21, &01, &0A, &20, &03
 EQUB &21, &04, &0D, &21, &08, &00, &10, &03
 EQUB &21, &02, &08, &31, &08, &23, &07, &24
 EQUB &10, &21, &3A, &13, &04, &20, &23, &C0
 EQUB &21, &08, &02, &21, &02, &00, &20, &02
 EQUB &32, &0E, &04, &07, &21, &02, &0A, &10
 EQUB &02, &20, &08, &22, &07, &21, &0F, &80
 EQUB &34, &01, &03, &00, &0B, &12, &21, &1E
 EQUB &60, &F3, &FE, &21, &3D, &D0, &22, &C0
 EQUB &40, &00, &A2, &C8, &00, &30, &03, &21
 EQUB &1C, &05, &32, &01, &04, &06, &83, &06
 EQUB &80, &0F, &21, &01, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0E, &3F, &20, &82, &00
 EQUB &20, &21, &04, &10, &21, &02, &00, &10
 EQUB &00, &40, &10, &32, &01, &24, &00, &40
 EQUB &00, &20, &80, &21, &08, &02, &44, &21
 EQUB &01, &02, &21, &04, &00, &21, &01, &84
 EQUB &10, &02, &31, &21, &23, &01, &41, &32
 EQUB &01, &08, &F0, &A1, &77, &DB, &AD, &10
 EQUB &47, &5A, &40, &80, &E4, &21, &18, &C8
 EQUB &F5, &AE, &4C, &00, &20, &04, &21, &24
 EQUB &02, &21, &14, &00, &48, &03, &21, &04
 EQUB &00, &20, &81, &21, &04, &02, &21, &04
 EQUB &00, &80, &00, &10, &21, &01, &40, &21
 EQUB &01, &84, &20, &00, &40, &21, &12, &00
 EQUB &21, &08, &00, &21, &04, &40, &00, &40
 EQUB &00, &80, &00, &21, &08, &00, &20, &A5
 EQUB &21, &3B, &5C, &33, &26, &0B, &03, &02
 EQUB &46, &21, &23, &52, &87, &4C, &F0, &02
 EQUB &40, &00, &82, &04, &21, &02, &00, &40
 EQUB &05, &21, &01, &10, &03, &40, &05, &10
 EQUB &00, &24, &10, &06, &41, &06, &21, &08
 EQUB &06, &21, &01, &00, &21, &04, &40, &00
 EQUB &10, &03, &21, &01, &00, &21, &08, &00
 EQUB &21, &08, &02, &40, &21, &01, &00, &80
 EQUB &21, &08, &02, &20, &00, &21, &08, &00
 EQUB &42, &00, &50, &00, &10, &34, &04, &0C
 EQUB &83, &03, &02, &32, &29, &3B, &D5, &7C
 EQUB &12, &80, &21, &04, &00, &10, &40, &60
 EQUB &81, &80, &02, &10, &80, &02, &21, &04
 EQUB &00, &21, &04, &80, &21, &24, &00, &82
 EQUB &20, &21, &04, &80, &03, &3A, &08, &01
 EQUB &20, &04, &90, &02, &20, &09, &40, &02
 EQUB &02, &20, &21, &08, &07, &8B, &37, &1F
 EQUB &37, &98, &01, &03, &00, &0B, &12, &21
 EQUB &1E, &60, &F3, &FE, &21, &3D, &D0, &A0
 EQUB &F8, &4C, &00, &A2, &C8, &00, &30, &10
 EQUB &21, &22, &00, &21, &1C, &05, &32, &01
 EQUB &04, &06, &83, &06, &80, &0F, &21, &01
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0E
 EQUB &3F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &0D, &3F
 EQUB &0F, &0F, &0F, &09, &21, &31, &DC, &06
 EQUB &21, &31, &84, &00, &80, &F0, &7B, &A5
 EQUB &00, &55, &21, &0F, &00, &22, &80, &72
 EQUB &A5, &00, &55, &21, &0E, &03, &47, &E6
 EQUB &5C, &21, &3F, &F4, &03, &46, &C4, &50
 EQUB &21, &3D, &80, &02, &E1, &9F, &34, &0C
 EQUB &01, &C2, &2F, &02, &20, &21, &08, &06
 EQUB &B0, &FF, &5D, &21, &37, &FF, &CF, &02
 EQUB &B0, &4D, &02, &21, &15, &04, &E3, &13
 EQUB &F8, &05, &A5, &7F, &F8, &00, &32, &02
 EQUB &1B, &FE, &E8, &80, &F4, &02, &33, &02
 EQUB &11, &26, &E8, &80, &F4, &00, &21, &03
 EQUB &7C, &32, &04, &08, &03, &35, &03, &02
 EQUB &38, &04, &08, &04, &78, &B0, &20, &02
 EQUB &34, &02, &0F, &9C, &28, &90, &20, &02
 EQUB &36, &02, &0B, &94, &01, &17, &02, &C1
 EQUB &60, &21, &09, &00, &34, &0C, &01, &17
 EQUB &02, &C1, &60, &21, &09, &00, &21, &0C
 EQUB &7E, &12, &5F, &21, &2B, &7F, &00, &21
 EQUB &15, &50, &FA, &FF, &54, &21, &2A, &7F
 EQUB &00, &21, &15, &15, &FD, &A8, &FF, &57
 EQUB &21, &0A, &57, &21, &03, &BF, &FD, &A8
 EQUB &14, &40, &F5, &02, &40, &45, &E8, &FF
 EQUB &40, &F5, &02, &22, &40, &FD, &A0, &00
 EQUB &20, &03, &40, &5D, &A0, &00, &20, &04
 EQUB &32, &08, &1F, &30, &40, &04, &32, &08
 EQUB &17, &20, &40, &03, &32, &07, &18, &00
 EQUB &40, &04, &32, &03, &18, &00, &40, &04
 EQUB &C8, &60, &06, &C8, &60, &06, &21, &1E
 EQUB &63, &03, &21, &04, &20, &00, &21, &18
 EQUB &62, &03, &21, &04, &20, &03, &C0, &21
 EQUB &08, &02, &C0, &03, &C0, &21, &08, &02
 EQUB &C0, &00, &A0, &07, &A0, &07, &33, &03
 EQUB &2F, &02, &10, &04, &33, &03, &2C, &02
 EQUB &10, &04, &20, &F4, &06, &20, &D4, &08
 EQUB &32, &02, &04, &20, &05, &32, &02, &04
 EQUB &20, &06, &20, &07, &20, &05, &40, &00
 EQUB &21, &08, &05, &40, &00, &21, &08, &04
 EQUB &3F

\ ******************************************************************************
\
\       Name: image9
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 9
\
\ ******************************************************************************

.image9

 EQUB &02, &80, &C0, &E0, &70, &B8, &5C, &0F
 EQUB &0F, &01, &21, &02, &0F, &09, &AE, &D7
 EQUB &6B, &35, &34, &1B, &0D, &06, &03, &00
 EQUB &80, &C0, &E0, &70, &B8, &5C, &AE, &0F
 EQUB &03, &21, &04, &00, &21, &08, &30, &10
 EQUB &E0, &0C, &20, &0B, &21, &01, &04, &40
 EQUB &02, &D7, &7B, &36, &3D, &1E, &1F, &0F
 EQUB &47, &0B, &00, &80, &C0, &70, &21, &38
 EQUB &9C, &DE, &EF, &00, &33, &05, &02, &1C
 EQUB &10, &40, &02, &40, &80, &05, &20, &0F
 EQUB &0F, &06, &20, &00, &80, &00, &F3, &7D
 EQUB &36, &3E, &1B, &0D, &06, &03, &01, &80
 EQUB &C0, &E0, &70, &B8, &DC, &6E, &B7, &00
 EQUB &21, &08, &20, &08, &35, &01, &05, &80
 EQUB &02, &02, &05, &22, &80, &40, &08, &21
 EQUB &08, &07, &20, &0F, &DB, &6D, &35, &32
 EQUB &0D, &06, &03, &01, &00, &80, &E0, &F0
 EQUB &78, &BC, &6F, &B7, &CB, &00, &25, &01
 EQUB &81, &C3, &C0, &22, &20, &70, &22, &90
 EQUB &98, &A8, &21, &02, &03, &40, &0D, &40
 EQUB &05, &20, &0E, &21, &08, &75, &35, &1B
 EQUB &0D, &07, &03, &01, &02, &FF, &7F, &BF
 EQUB &4F, &B0, &CF, &70, &21, &3E, &A8, &AC
 EQUB &A4, &64, &E4, &C4, &33, &0C, &18, &08
 EQUB &0F, &0E, &40, &00, &32, &1C, &08, &00
 EQUB &40, &0C, &32, &0F, &01, &06, &F8, &E0
 EQUB &0A, &21, &08, &03, &3F, &02, &80, &C0
 EQUB &60, &30, &98, &4C, &0F, &09, &21, &01
 EQUB &00, &22, &01, &35, &04, &02, &02, &04
 EQUB &22, &02, &10, &02, &21, &12, &00, &35
 EQUB &08, &01, &04, &20, &08, &80, &00, &21
 EQUB &01, &10, &00, &40, &02, &21, &02, &02
 EQUB &A6, &5B, &36, &2D, &17, &0B, &05, &02
 EQUB &01, &00, &80, &C0, &60, &B0, &D8, &6C
 EQUB &B6, &0E, &37, &02, &01, &12, &0E, &18
 EQUB &4C, &32, &C8, &60, &00, &21, &08, &00
 EQUB &20, &03, &21, &04, &80, &00, &40, &03
 EQUB &21, &02, &02, &32, &08, &01, &02, &10
 EQUB &32, &01, &08, &02, &80, &40, &20, &33
 EQUB &08, &06, &01, &00, &5B, &89, &40, &20
 EQUB &21, &08, &46, &A2, &21, &11, &00, &80
 EQUB &60, &99, &44, &21, &21, &90, &74, &21
 EQUB &12, &8A, &75, &20, &E8, &A0, &80, &00
 EQUB &80, &00, &21, &04, &02, &21, &08, &03
 EQUB &40, &20, &30, &00, &21, &18, &00, &21
 EQUB &0C, &10, &02, &80, &00, &21, &01, &00
 EQUB &21, &02, &20, &00, &90, &00, &4A, &03
 EQUB &21, &01, &80, &00, &36, &04, &01, &40
 EQUB &04, &00, &01, &04, &21, &01, &10, &21
 EQUB &04, &BD, &DE, &47, &34, &0B, &05, &02
 EQUB &01, &20, &00, &80, &44, &A0, &D0, &E8
 EQUB &75, &BB, &00, &80, &02, &21, &08, &02
 EQUB &80, &10, &3E, &06, &08, &06, &03, &06
 EQUB &01, &21, &00, &01, &00, &04, &80, &12
 EQUB &C0, &38, &08, &01, &40, &04, &00, &02
 EQUB &00, &08, &00, &40, &00, &21, &11, &80
 EQUB &03, &21, &01, &03, &10, &09, &21, &08
 EQUB &02, &5D, &35, &2E, &13, &1D, &0E, &05
 EQUB &02, &C0, &C2, &60, &B0, &DA, &54, &BA
 EQUB &4D, &21, &03, &00, &22, &01, &32, &08
 EQUB &02, &46, &BD, &60, &84, &B0, &A0, &50
 EQUB &D9, &D0, &E8, &20, &00, &10, &00, &21
 EQUB &08, &00, &20, &03, &20, &32, &04, &01
 EQUB &80, &02, &21, &04, &00, &32, &08, &02
 EQUB &20, &00, &40, &21, &09, &02, &21, &08
 EQUB &08, &20, &02, &21, &08, &00, &35, &36
 EQUB &3A, &1D, &0B, &01, &02, &21, &04, &E3
 EQUB &FF, &DF, &76, &BF, &CF, &F0, &5E, &ED
 EQUB &E8, &64, &A4, &64, &C4, &32, &08, &1C
 EQUB &40, &00, &41, &10, &34, &04, &01, &00
 EQUB &02, &02, &21, &02, &40, &21, &11, &84
 EQUB &20, &21, &08, &20, &21, &04, &90, &00
 EQUB &20, &00, &80, &00, &21, &08, &40, &06
 EQUB &21, &08, &00, &21, &08, &07, &21, &02
 EQUB &00, &36, &24, &01, &08, &00, &13, &02
 EQUB &02, &20, &21, &04, &00, &20, &F0, &21
 EQUB &11, &02, &44, &00, &20, &02, &21, &01
 EQUB &00, &21, &02, &00, &33, &01, &08, &22
 EQUB &3F, &FF, &7F, &36, &3F, &1F, &0F, &07
 EQUB &03, &01, &84, &50, &21, &02, &00, &33
 EQUB &02, &01, &02, &81, &18, &91, &00, &20
 EQUB &10, &34, &0C, &06, &A3, &01, &15, &FD
 EQUB &FF, &7F, &21, &11, &88, &46, &33, &1A
 EQUB &2F, &15, &BF, &5B, &13, &EF, &FA, &EE
 EQUB &EB, &BC, &21, &23, &8C, &77, &AB, &7A
 EQUB &AE, &CB, &BC, &40, &80, &40, &22, &80
 EQUB &40, &00, &80, &40, &80, &40, &22, &80
 EQUB &40, &00, &80, &0F, &0F, &0F, &06, &80
 EQUB &C0, &E0, &F0, &58, &40, &20, &10, &88
 EQUB &44, &E2, &F1, &58, &7F, &36, &3F, &0F
 EQUB &06, &05, &02, &01, &00, &4B, &35, &25
 EQUB &0B, &06, &05, &02, &81, &40, &BF, &EB
 EQUB &A6, &D1, &DC, &A8, &21, &14, &80, &BF
 EQUB &EB, &21, &26, &D1, &DC, &A8, &21, &14
 EQUB &80, &52, &A8, &CC, &80, &50, &03, &52
 EQUB &A8, &CC, &80, &50, &0F, &0F, &0F, &09
 EQUB &21, &02, &07, &21, &02, &04, &21, &24
 EQUB &10, &05, &20, &21, &24, &10, &05, &20
 EQUB &08, &20, &07, &20, &07, &20, &0F, &0F
 EQUB &0F, &06, &10, &00, &21, &08, &0F, &02
 EQUB &33, &04, &01, &00, &23, &04, &20, &00
 EQUB &36, &04, &01, &00, &04, &00, &04, &20
 EQUB &00, &21, &08, &00, &20, &02, &10, &02
 EQUB &21, &08, &00, &20, &02, &10, &0F, &0E
 EQUB &33, &04, &02, &01, &0F, &01, &80, &40
 EQUB &3F, &08, &80, &0F, &21, &04, &00, &21
 EQUB &02, &02, &21, &01, &09, &21, &01, &07
 EQUB &81, &88, &22, &80, &10, &80, &00, &40
 EQUB &00, &88, &00, &80, &10, &80, &00, &40
 EQUB &0F, &0F, &0F, &0C, &20, &10, &33, &0C
 EQUB &02, &01, &0F, &01, &80, &40, &30, &0F
 EQUB &04, &21, &02, &05, &22, &40, &21, &02
 EQUB &23, &20, &10, &00, &80, &07, &80, &0A
 EQUB &10, &21, &04, &20, &21, &09, &04, &10
 EQUB &21, &04, &20, &21, &09, &0F, &0F, &0F
 EQUB &0B, &33, &08, &04, &02, &0F, &01, &80
 EQUB &40, &30, &32, &0F, &01, &08, &22, &10
 EQUB &23, &18, &21, &38, &F0, &E0, &0F, &01
 EQUB &20, &84, &10, &05, &20, &84, &10, &0F
 EQUB &0F, &0F, &0F, &0A, &80, &10, &80, &05
 EQUB &80, &10, &80, &0F, &0F, &06, &3F

\ ******************************************************************************
\
\       Name: image10
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 10
\
\ ******************************************************************************

.image10

 EQUB &00, &40, &00, &10, &00, &21, &04, &0B
 EQUB &21, &02, &0F, &21, &02, &0F, &21, &02
 EQUB &08, &21, &08, &06, &80, &0F, &0D, &10
 EQUB &60, &0F, &0A, &21, &02, &10, &02, &21
 EQUB &04, &00, &80, &06, &21, &08, &04, &40
 EQUB &32, &01, &0A, &BF, &7F, &02, &32, &05
 EQUB &0E, &57, &13, &21, &01, &82, &57, &EF
 EQUB &7F, &FF, &F4, &E8, &00, &A0, &D0, &A0
 EQUB &40, &80, &20, &0F, &02, &21, &01, &02
 EQUB &10, &07, &39, &01, &03, &01, &22, &00
 EQUB &3F, &5F, &1E, &14, &A8, &40, &02, &FD
 EQUB &E8, &80, &00, &21, &18, &80, &02, &40
 EQUB &0F, &0F, &03, &21, &02, &0F, &0F, &05
 EQUB &32, &01, &0A, &06, &50, &EA, &05, &32
 EQUB &11, &01, &43, &06, &80, &21, &01, &02
 EQUB &22, &01, &33, &03, &06, &2C, &84, &02
 EQUB &22, &80, &21, &01, &03, &21, &02, &00
 EQUB &32, &04, &08, &04, &50, &00, &21, &18
 EQUB &30, &40, &03, &57, &21, &0A, &00, &60
 EQUB &C0, &03, &F0, &C0, &33, &06, &1C, &24
 EQUB &03, &33, &02, &0C, &14, &05, &21, &03
 EQUB &03, &21, &08, &03, &21, &14, &20, &09
 EQUB &10, &00, &32, &05, &23, &04, &21, &01
 EQUB &82, &41, &8A, &21, &01, &03, &33, &04
 EQUB &08, &04, &C1, &F0, &04, &20, &21, &08
 EQUB &A2, &F5, &03, &21, &28, &10, &21, &01
 EQUB &80, &E8, &04, &34, &02, &15, &2E, &07
 EQUB &06, &A8, &47, &04, &21, &02, &81, &21
 EQUB &22, &8D, &3F, &00, &A0, &00, &40, &21
 EQUB &01, &04, &21, &01, &40, &21, &04, &02
 EQUB &40, &00, &20, &07, &20, &0F, &07, &21
 EQUB &01, &00, &21, &05, &20, &21, &02, &02
 EQUB &20, &32, &08, &04, &02, &21, &02, &20
 EQUB &00, &40, &21, &01, &40, &21, &04, &80
 EQUB &10, &00, &40, &0F, &09, &10, &60, &0F
 EQUB &02, &21, &04, &06, &20, &00, &80, &00
 EQUB &20, &00, &80, &02, &80, &04, &21, &08
 EQUB &04, &40, &32, &01, &0A, &BF, &7F, &02
 EQUB &32, &05, &0E, &57, &13, &21, &01, &82
 EQUB &57, &EF, &7F, &FF, &F4, &E8, &00, &A0
 EQUB &D0, &A0, &40, &80, &20, &0F, &03, &20
 EQUB &02, &80, &06, &39, &01, &03, &01, &22
 EQUB &00, &3F, &5F, &1E, &14, &A8, &40, &02
 EQUB &FD, &E8, &80, &00, &21, &18, &80, &02
 EQUB &40, &0F, &0F, &01, &20, &05, &21, &08
 EQUB &0F, &0F, &01, &32, &01, &0A, &06, &50
 EQUB &EA, &05, &10, &21, &02, &40, &05, &80
 EQUB &40, &A2, &22, &01, &34, &02, &12, &04
 EQUB &19, &52, &69, &22, &80, &40, &50, &E2
 EQUB &47, &8A, &35, &05, &02, &00, &0A, &17
 EQUB &B5, &4A, &35, &01, &12, &50, &08, &24
 EQUB &4C, &B9, &D2, &E5, &88, &57, &21, &0A
 EQUB &20, &90, &21, &3A, &E0, &48, &80, &F0
 EQUB &C3, &38, &09, &22, &5A, &24, &89, &02
 EQUB &0D, &12, &AA, &D4, &21, &24, &20, &00
 EQUB &10, &C4, &8D, &00, &32, &06, &15, &63
 EQUB &00, &84, &AA, &54, &EA, &44, &88, &00
 EQUB &32, &11, &02, &40, &BB, &7F, &EE, &D7
 EQUB &21, &3A, &D4, &AB, &88, &52, &B5, &EE
 EQUB &75, &BE, &55, &AA, &5C, &AA, &FF, &DB
 EQUB &B6, &DB, &33, &26, &0D, &15, &A8, &55
 EQUB &BE, &DB, &B7, &5D, &32, &0A, &17, &AB
 EQUB &7F, &D7, &AB, &EE, &43, &21, &14, &41
 EQUB &A8, &C5, &21, &1F, &FD, &EA, &D1, &33
 EQUB &38, &01, &2A, &45, &C2, &ED, &F3, &56
 EQUB &B8, &21, &17, &AA, &F5, &21, &3F, &ED
 EQUB &76, &DD, &52, &3F, &08, &48, &21, &01
 EQUB &44, &02, &80, &20, &08, &21, &02, &10
 EQUB &06, &21, &02, &04, &21, &02, &10, &80
 EQUB &21, &08, &04, &21, &02, &10, &80, &21
 EQUB &08, &06, &32, &01, &26, &06, &32, &01
 EQUB &26, &04, &40, &00, &21, &01, &05, &40
 EQUB &00, &21, &01, &0F, &0A, &21, &02, &00
 EQUB &36, &02, &08, &01, &04, &00, &01, &0A
 EQUB &40, &0A, &33, &01, &03, &05, &05, &36
 EQUB &01, &03, &05, &00, &11, &22, &45, &AF
 EQUB &D7, &FF, &6B, &00, &32, &11, &22, &45
 EQUB &AF, &57, &FA, &6B, &21, &21, &56, &BD
 EQUB &FF, &FD, &FF, &EF, &FF, &21, &21, &56
 EQUB &BD, &F7, &A9, &21, &16, &AD, &FA, &54
 EQUB &FA, &55, &EF, &FD, &FF, &EF, &9F, &54
 EQUB &FA, &55, &EF, &DD, &AF, &34, &06, &0C
 EQUB &40, &04, &51, &A0, &E1, &F2, &12, &40
 EQUB &21, &04, &51, &A0, &61, &F2, &BF, &57
 EQUB &00, &21, &08, &00, &20, &40, &80, &84
 EQUB &21, &28, &00, &21, &08, &00, &20, &40
 EQUB &80, &84, &21, &28, &07, &20, &07, &20
 EQUB &0F, &01, &3B, &06, &0B, &17, &07, &2B
 EQUB &1F, &37, &7F, &06, &8B, &16, &85, &AB
 EQUB &21, &18, &A2, &CE, &13, &BF, &FE, &F5
 EQUB &40, &80, &BF, &F5, &AB, &21, &14, &A0
 EQUB &03, &12, &FA, &F1, &A8, &03, &6D, &F0
 EQUB &40, &05, &FE, &7D, &A8, &10, &80, &00
 EQUB &32, &0B, &17, &70, &06, &21, &01, &FF
 EQUB &5E, &21, &2F, &5F, &BF, &7D, &DF, &FF
 EQUB &37, &0B, &06, &03, &03, &07, &1D, &0A
 EQUB &55, &50, &E0, &D5, &EB, &7D, &FA, &FC
 EQUB &F0, &50, &E0, &D5, &EB, &7D, &EA, &BC
 EQUB &F0, &00, &80, &48, &80, &44, &02, &21
 EQUB &22, &00, &80, &48, &80, &44, &02, &21
 EQUB &22, &0F, &01, &22, &7F, &FF, &FE, &FC
 EQUB &FE, &DD, &7F, &57, &6D, &DA, &F8, &C8
 EQUB &94, &80, &45, &C0, &A0, &E1, &EB, &57
 EQUB &BF, &12, &02, &80, &40, &32, &02, &04
 EQUB &91, &EA, &32, &02, &17, &7F, &FF, &E7
 EQUB &7F, &12, &02, &21, &0A, &51, &82, &21
 EQUB &25, &5F, &EA, &BF, &FF, &FD, &FA, &F7
 EQUB &BF, &FF, &FD, &32, &02, &17, &FD, &5A
 EQUB &F7, &AA, &57, &21, &0D, &3F, &FF, &A8
 EQUB &40, &F0, &E7, &DF, &7F, &12, &A8, &40
 EQUB &F0, &A7, &DA, &75, &AF, &40, &8B, &21
 EQUB &16, &FF, &FD, &F8, &D0, &61, &40, &8B
 EQUB &21, &16, &FB, &5D, &21, &38, &D0, &61
 EQUB &21, &12, &20, &C1, &A9, &40, &34, &01
 EQUB &28, &50, &12, &20, &C1, &A9, &40, &32
 EQUB &01, &28, &50, &0F, &01, &FF, &7F, &AF
 EQUB &7F, &12, &22, &7F, &FF, &7A, &AF, &7E
 EQUB &F4, &DA, &7F, &6F, &17, &7F, &47, &BA
 EQUB &D0, &81, &21, &1A, &F7, &DF, &7D, &13
 EQUB &F5, &DB, &13, &40, &32, &02, &2F, &75
 EQUB &DB, &FD, &AB, &21, &05, &FF, &EE, &7D
 EQUB &F7, &12, &FE, &F5, &21, &3F, &EE, &7D
 EQUB &D7, &7A, &D4, &A0, &00, &F7, &8F, &DE
 EQUB &FD, &12, &AF, &21, &15, &77, &8D, &D6
 EQUB &4D, &A6, &21, &01, &02, &83, &57, &BF
 EQUB &FF, &FE, &EC, &FC, &B0, &83, &56, &BB
 EQUB &D5, &82, &32, &04, &0C, &10, &A0, &E2
 EQUB &B4, &E8, &40, &21, &05, &02, &A0, &E2
 EQUB &B4, &E8, &40, &21, &05, &0F, &03, &7D
 EQUB &33, &3F, &2F, &06, &04, &5D, &33, &0B
 EQUB &25, &02, &04, &22, &FD, &E0, &40, &04
 EQUB &E8, &55, &E0, &40, &04, &AF, &E3, &80
 EQUB &06, &21, &02, &80, &05, &A8, &F5, &8F
 EQUB &06, &40, &8A, &05, &32, &0F, &38, &C0
 EQUB &05, &32, &03, &08, &40, &05, &E0, &40
 EQUB &06, &20, &40, &0F, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &0F, &0F, &0F, &01, &3F

\ ******************************************************************************
\
\       Name: image11
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 11
\
\ ******************************************************************************

.image11

 EQUB &06, &22, &01, &0F, &09, &23, &08, &00
 EQUB &21, &04, &0F, &0C, &34, &01, &02, &02
 EQUB &08, &0F, &0F, &0A, &10, &00, &22, &10
 EQUB &06, &22, &01, &09, &25, &08, &0F, &32
 EQUB &02, &01, &0F, &02, &26, &10, &00, &32
 EQUB &18, &01, &06, &20, &00, &22, &80, &20
 EQUB &02, &40, &02, &21, &04, &00, &22, &02
 EQUB &02, &34, &01, &05, &5F, &0B, &5F, &BF
 EQUB &FF, &BF, &FF, &80, &D4, &F9, &EF, &FF
 EQUB &FA, &FF, &FE, &06, &40, &10, &0A, &36
 EQUB &08, &0E, &08, &0A, &08, &0C, &03, &D0
 EQUB &00, &A0, &00, &50, &22, &40, &02, &10
 EQUB &32, &04, &28, &00, &B3, &32, &11, &3B
 EQUB &10, &D0, &10, &00, &21, &08, &13, &21
 EQUB &06, &00, &21, &02, &02, &22, &FE, &FF
 EQUB &21, &01, &C1, &02, &23, &80, &21, &15
 EQUB &0D, &35, &08, &0D, &08, &00, &18, &10
 EQUB &00, &20, &00, &80, &06, &20, &00, &22
 EQUB &40, &04, &22, &04, &0F, &0F, &08, &22
 EQUB &20, &0F, &0F, &0F, &0F, &0F, &0B, &3F
 EQUB &06, &22, &01, &02, &10, &04, &21, &02
 EQUB &06, &A0, &40, &05, &10, &02, &23, &08
 EQUB &00, &21, &04, &0F, &0C, &34, &01, &02
 EQUB &02, &08, &02, &21, &02, &03, &21, &01
 EQUB &00, &20, &00, &32, &02, &15, &05, &21
 EQUB &02, &A0, &03, &80, &00, &20, &02, &21
 EQUB &08, &06, &21, &08, &05, &10, &00, &22
 EQUB &10, &06, &22, &01, &09, &37, &0A, &08
 EQUB &09, &08, &08, &02, &03, &00, &80, &21
 EQUB &2E, &7F, &32, &14, &0B, &BF, &FF, &02
 EQUB &80, &E0, &40, &A2, &F1, &F8, &00, &32
 EQUB &02, &01, &04, &21, &02, &02, &40, &00
 EQUB &21, &14, &BA, &02, &22, &10, &50, &23
 EQUB &10, &00, &32, &18, &01, &06, &20, &00
 EQUB &22, &80, &20, &02, &40, &02, &21, &05
 EQUB &00, &22, &02, &00, &32, &01, &12, &FA
 EQUB &A0, &F4, &A0, &43, &21, &0F, &5F, &21
 EQUB &1F, &7C, &33, &2A, &07, &11, &C1, &F5
 EQUB &22, &F9, &02, &36, &15, &1E, &0C, &1A
 EQUB &9D, &0F, &00, &20, &54, &80, &32, &02
 EQUB &15, &40, &A0, &00, &31, &08, &23, &16
 EQUB &BF, &32, &16, &17, &03, &80, &00, &80
 EQUB &00, &42, &22, &40, &02, &22, &20, &30
 EQUB &21, &38, &A8, &3D, &2A, &28, &28, &78
 EQUB &28, &00, &08, &3F, &3F, &7F, &06, &00
 EQUB &02, &02, &FD, &FC, &FF, &21, &01, &C1
 EQUB &02, &80, &21, &15, &9F, &21, &0A, &05
 EQUB &21, &0A, &84, &D0, &05, &96, &21, &17
 EQUB &B6, &00, &21, &18, &10, &00, &20, &22
 EQUB &80, &21, &05, &05, &20, &00, &22, &40
 EQUB &04, &22, &04, &0F, &0F, &08, &22, &20
 EQUB &0F, &0F, &0F, &0F, &0F, &0B, &3F, &00
 EQUB &C0, &E8, &F6, &EB, &F3, &EA, &D2, &00
 EQUB &C0, &68, &32, &36, &29, &72, &AA, &52
 EQUB &05, &23, &80, &05, &80, &0F, &0F, &04
 EQUB &23, &06, &35, &0E, &03, &07, &03, &01
 EQUB &23, &02, &3A, &0A, &03, &05, &02, &01
 EQUB &2F, &17, &2F, &17, &0A, &00, &85, &A0
 EQUB &35, &2D, &16, &2D, &16, &0A, &00, &85
 EQUB &A0, &14, &FD, &21, &3F, &E6, &B9, &33
 EQUB &01, &02, &01, &AB, &D5, &21, &3F, &86
 EQUB &A9, &A0, &C0, &A0, &40, &80, &40, &80
 EQUB &00, &A0, &C0, &A0, &40, &80, &40, &80
 EQUB &00, &A2, &45, &21, &0D, &B2, &32, &0C
 EQUB &04, &48, &88, &A0, &44, &21, &09, &A2
 EQUB &32, &08, &04, &48, &23, &80, &07, &80
 EQUB &0F, &0F, &0F, &09, &78, &20, &10, &35
 EQUB &18, &0C, &18, &08, &09, &48, &20, &10
 EQUB &36, &08, &04, &08, &00, &01, &14, &68
 EQUB &B0, &70, &F1, &73, &F2, &72, &21, &14
 EQUB &68, &B0, &70, &D1, &72, &D0, &40, &02
 EQUB &21, &3C, &C3, &AF, &9F, &AF, &9F, &02
 EQUB &21, &3C, &C3, &21, &2F, &9A, &AD, &98
 EQUB &C8, &90, &D0, &B0, &D0, &F0, &80, &D8
 EQUB &C0, &90, &50, &A0, &40, &60, &80, &D8
 EQUB &0F, &02, &21, &02, &00, &3A, &04, &06
 EQUB &01, &00, &02, &00, &02, &00, &04, &02
 EQUB &02, &21, &02, &C0, &30, &70, &B8, &78
 EQUB &10, &E0, &10, &C0, &30, &70, &A8, &48
 EQUB &10, &60, &10, &0F, &01, &3E, &08, &0D
 EQUB &08, &0D, &0E, &0D, &18, &07, &00, &05
 EQUB &00, &05, &06, &05, &32, &08, &07, &F2
 EQUB &73, &F1, &23, &F0, &00, &22, &D0, &42
 EQUB &D1, &80, &D0, &80, &02, &9F, &5F, &65
 EQUB &9E, &C1, &62, &21, &22, &66, &10, &58
 EQUB &21, &25, &9C, &C1, &21, &22, &00, &21
 EQUB &26, &EC, &D8, &EE, &D4, &E4, &C6, &AC
 EQUB &00, &64, &32, &18, &28, &50, &E0, &42
 EQUB &A4, &0F, &02, &22, &01, &06, &21, &01
 EQUB &07, &20, &40, &20, &60, &E0, &03, &20
 EQUB &40, &20, &40, &C0, &03, &3F, &0F, &01
 EQUB &21, &3A, &20, &06, &21, &12, &20, &06
 EQUB &B8, &21, &08, &06, &98, &21, &08, &06
 EQUB &32, &36, &3E, &40, &6E, &04, &34, &14
 EQUB &18, &40, &2A, &0A, &F8, &D4, &04, &21
 EQUB &02, &00, &E9, &54, &0B, &21, &19, &7F
 EQUB &21, &35, &4F, &21, &1B, &00, &21, &01
 EQUB &03, &23, &01, &03, &E6, &21, &3C, &F0
 EQUB &BC, &69, &00, &60, &A0, &20, &60, &20
 EQUB &22, &60, &00, &60, &A0, &20, &60, &21
 EQUB &24, &60, &40, &0C, &20, &21, &04, &00
 EQUB &80, &03, &35, &1F, &27, &2C, &38, &18
 EQUB &03, &10, &34, &27, &04, &08, &08, &03
 EQUB &D0, &21, &08, &50, &A8, &70, &03, &D0
 EQUB &21, &08, &50, &A8, &70, &5E, &7A, &32
 EQUB &22, &26, &4A, &66, &4E, &56, &46, &37
 EQUB &1A, &22, &26, &0A, &26, &4C, &16, &F8
 EQUB &EA, &C6, &E6, &C6, &AC, &02, &30, &6A
 EQUB &C3, &62, &C6, &AC, &0A, &CE, &21, &03
 EQUB &99, &21, &03, &20, &32, &0C, &01, &C0
 EQUB &08, &FE, &DC, &E6, &30, &C2, &21, &18
 EQUB &83, &20, &08, &21, &08, &00, &86, &00
 EQUB &21, &01, &C0, &0A, &21, &02, &30, &00
 EQUB &21, &06, &80, &21, &19, &C0, &3E, &04
 EQUB &18, &19, &38, &3D, &38, &3D, &3A, &3D
 EQUB &08, &09, &08, &0D, &A8, &33, &1D, &2A
 EQUB &3D, &F8, &78, &F8, &78, &24, &F8, &D8
 EQUB &6A, &C8, &6E, &C8, &AB, &C8, &89, &4E
 EQUB &5E, &21, &0C, &05, &4C, &5A, &21, &0C
 EQUB &40, &00, &30, &00, &CC, &09, &21, &06
 EQUB &00, &21, &03, &20, &21, &05, &00, &C0
 EQUB &08, &32, &02, &18, &00, &83, &21, &18
 EQUB &00, &21, &06, &60, &08, &21, &04, &63
 EQUB &00, &21, &2C, &00, &61, &21, &0C, &C1
 EQUB &08, &60, &02, &60, &21, &08, &80, &10
 EQUB &44, &08, &30, &00, &21, &33, &00, &21
 EQUB &0C, &00, &33, &06, &01, &1A, &07, &DA
 EQUB &20, &00, &21, &38, &00, &CC, &00, &99
 EQUB &F0, &07, &C6, &02, &21, &01, &03, &80
 EQUB &09, &37, &31, &06, &90, &03, &60, &0C
 EQUB &01, &3F

\ ******************************************************************************
\
\       Name: image12
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 12
\
\ ******************************************************************************

.image12

 EQUB &12, &FB, &C1, &80, &02, &10, &FF, &FB
 EQUB &E0, &C0, &04, &F8, &F0, &E0, &05, &22
 EQUB &3F, &7F, &13, &22, &7F, &15, &FE, &FD
 EQUB &DA, &13, &FB, &D1, &A1, &22, &01, &FF
 EQUB &80, &03, &23, &80, &FE, &08, &20, &30
 EQUB &50, &00, &10, &50, &20, &0C, &22, &02
 EQUB &22, &04, &7F, &21, &15, &02, &34, &08
 EQUB &1D, &02, &02, &A0, &40, &02, &20, &80
 EQUB &C0, &10, &08, &23, &80, &C0, &22, &40
 EQUB &22, &60, &08, &70, &D0, &C0, &A8, &84
 EQUB &D2, &E9, &C2, &07, &80, &22, &04, &32
 EQUB &0C, &08, &23, &18, &20, &38, &0A, &12
 EQUB &0A, &08, &09, &01, &00, &02, &48, &A8
 EQUB &8C, &21, &24, &00, &40, &C0, &09, &22
 EQUB &20, &36, &01, &03, &03, &07, &0F, &1F
 EQUB &00, &7F, &C1, &83, &FE, &F8, &F0, &F8
 EQUB &E1, &C2, &C4, &89, &34, &12, &28, &40
 EQUB &28, &40, &00, &83, &21, &01, &06, &87
 EQUB &FF, &FD, &7C, &5E, &A3, &00, &20, &21
 EQUB &22, &E7, &C7, &CF, &9F, &BF, &00, &21
 EQUB &0C, &22, &5E, &21, &2F, &87, &D3, &C8
 EQUB &00, &10, &37, &33, &01, &03, &07, &8F
 EQUB &3F, &3F, &7F, &16, &F0, &F8, &F0, &F8
 EQUB &FC, &F8, &FC, &F8, &90, &C6, &36, &04
 EQUB &11, &C2, &04, &10, &07, &C1, &61, &82
 EQUB &33, &07, &0C, &1F, &12, &C0, &87, &9F
 EQUB &1D, &22, &44, &20, &21, &22, &91, &98
 EQUB &8C, &C3, &12, &34, &1F, &07, &00, &38
 EQUB &02, &13, &FE, &7E, &21, &1F, &DF, &21
 EQUB &1F, &BC, &21, &3C, &78, &7C, &F8, &F4
 EQUB &F8, &F0, &1B, &23, &FE, &13, &33, &1F
 EQUB &0F, &07, &00, &8F, &1A, &FC, &12, &F0
 EQUB &E1, &CF, &88, &10, &70, &FE, &FC, &78
 EQUB &C0, &22, &01, &21, &03, &00, &21, &05
 EQUB &42, &81, &80, &02, &40, &30, &21, &03
 EQUB &80, &40, &00, &33, &03, &0F, &3F, &16
 EQUB &FE, &FF, &F3, &F7, &13, &E0, &21, &06
 EQUB &80, &13, &FD, &F6, &21, &38, &02, &FE
 EQUB &F8, &FE, &80, &00, &21, &07, &02, &60
 EQUB &C3, &32, &06, &0C, &78, &C0, &21, &03
 EQUB &00, &87, &33, &06, &0C, &18, &70, &C0
 EQUB &32, &03, &07, &80, &00, &33, &07, &1F
 EQUB &3F, &13, &7F, &17, &3F, &F1, &C0, &32
 EQUB &04, &3E, &7F, &13, &00, &33, &04, &1F
 EQUB &3F, &13, &BF, &33, &07, &0F, &1F, &12
 EQUB &C1, &22, &80, &12, &FA, &FC, &F6, &E8
 EQUB &40, &60, &AA, &50, &A0, &02, &38, &01
 EQUB &02, &25, &02, &02, &03, &07, &2F, &5F
 EQUB &FF, &FE, &00, &7F, &13, &22, &7F, &FF
 EQUB &21, &01, &19, &F7, &23, &70, &F0, &F8
 EQUB &9F, &21, &06, &08, &23, &01, &00, &22
 EQUB &02, &40, &31, &2A, &23, &3F, &33, &0E
 EQUB &07, &07, &5F, &BF, &19, &FC, &F8, &F0
 EQUB &E0, &80, &FF, &22, &7F, &5F, &47, &40
 EQUB &22, &60, &F3, &C1, &22, &80, &04, &D8
 EQUB &78, &7C, &7E, &7F, &BF, &9F, &FF, &05
 EQUB &80, &C0, &E0, &22, &04, &32, &0C, &08
 EQUB &23, &18, &30, &35, &0F, &07, &0F, &0F
 EQUB &0B, &23, &03, &FC, &F8, &EC, &22, &E4
 EQUB &E0, &22, &C0, &08, &22, &20, &22, &21
 EQUB &34, &06, &02, &04, &0C, &00, &7F, &A3
 EQUB &86, &F9, &36, &07, &0E, &05, &99, &33
 EQUB &27, &4F, &DF, &13, &F0, &F8, &EC, &D6
 EQUB &EB, &F5, &FE, &FF, &22, &30, &02, &21
 EQUB &03, &83, &E0, &F0, &33, &01, &31, &13
 EQUB &DA, &BE, &32, &34, &2C, &5C, &80, &8B
 EQUB &D9, &FD, &22, &F8, &FC, &FF, &00, &21
 EQUB &18, &CC, &FE, &FD, &FB, &76, &DC, &32
 EQUB &1C, &3C, &7D, &F9, &9B, &21, &32, &62
 EQUB &E2, &3A, &0E, &05, &0E, &05, &02, &07
 EQUB &02, &07, &7F, &3F, &C7, &9F, &13, &F8
 EQUB &15, &F8, &00, &21, &03, &FC, &FB, &EF
 EQUB &BF, &7F, &FF, &7F, &21, &3F, &7C, &22
 EQUB &F8, &24, &F0, &F8, &14, &23, &7F, &33
 EQUB &3F, &1F, &0F, &FE, &F8, &14, &C6, &84
 EQUB &32, &0D, &1B, &FB, &E6, &E0, &FC, &22
 EQUB &C3, &87, &83, &34, &07, &0B, &07, &0F
 EQUB &05, &34, &01, &03, &07, &07, &5F, &7F
 EQUB &12, &FD, &C0, &C8, &9F, &EF, &D7, &8B
 EQUB &DF, &70, &02, &22, &F0, &E0, &C0, &81
 EQUB &36, &07, &0F, &3E, &03, &00, &38, &EF
 EQUB &DF, &BF, &7F, &FF, &BF, &32, &07, &0F
 EQUB &12, &FE, &FF, &FE, &12, &BF, &6F, &E7
 EQUB &C7, &CF, &16, &FC, &22, &F0, &22, &07
 EQUB &03, &32, &03, &3F, &FF, &98, &21, &08
 EQUB &02, &7E, &DF, &12, &03, &32, &07, &1F
 EQUB &13, &7D, &F7, &21, &03, &1F, &15, &FE
 EQUB &12, &FE, &F0, &E1, &83, &32, &1F, &3F
 EQUB &E8, &A0, &E0, &22, &C0, &80, &02, &3F
 EQUB &07, &10, &07, &10, &0F, &0F, &0F, &0F
 EQUB &0F, &0F, &0F, &08, &20, &30, &24, &70
 EQUB &02, &20, &30, &50, &00, &10, &50, &0F
 EQUB &0F, &07, &34, &08, &0C, &07, &07, &04
 EQUB &34, &08, &0C, &02, &02, &04, &20, &80
 EQUB &C0, &50, &04, &20, &80, &C0, &10, &0F
 EQUB &04, &23, &40, &22, &60, &03, &23, &40
 EQUB &22, &60, &0F, &01, &50, &22, &70, &35
 EQUB &38, &1C, &1E, &0F, &03, &22, &50, &40
 EQUB &35, &28, &04, &12, &09, &02, &07, &80
 EQUB &07, &80, &22, &04, &32, &0C, &08, &23
 EQUB &18, &30, &22, &04, &32, &0C, &08, &23
 EQUB &18, &20, &35, &0E, &06, &0E, &0E, &0B
 EQUB &23, &03, &38, &0A, &02, &0A, &08, &09
 EQUB &01, &00, &02, &C8, &E8, &EC, &E4, &44
 EQUB &22, &C0, &80, &48, &A8, &8C, &21, &24
 EQUB &00, &40, &C0, &0F, &02, &24, &20, &04
 EQUB &22, &20, &0F, &07, &3E, &01, &03, &07
 EQUB &0F, &1E, &38, &70, &38, &01, &02, &04
 EQUB &09, &12, &28, &40, &21, &28, &C0, &22
 EQUB &80, &05, &40, &00, &83, &21, &01, &04
 EQUB &22, &30, &04, &40, &E0, &02, &87, &FF
 EQUB &F8, &00, &40, &A0, &22, &01, &21, &03
 EQUB &07, &32, &02, &04, &04, &3F, &22, &80
 EQUB &22, &C0, &22, &E0, &F0, &F8, &02, &22
 EQUB &40, &20, &80, &D0, &C8, &0A, &21, &03
 EQUB &03, &32, &01, &03, &0C, &60, &C0, &80
 EQUB &0F, &02, &34, &1F, &07, &07, &1F, &FE
 EQUB &FC, &F0, &F8, &10, &35, &06, &04, &11
 EQUB &C2, &04, &10, &00, &C1, &E1, &83, &33
 EQUB &07, &0C, &18, &02, &C1, &61, &82, &33
 EQUB &07, &0C, &18, &02, &C0, &23, &80, &04
 EQUB &C0, &23, &80, &0F, &05, &22, &7C, &36
 EQUB &3C, &3E, &1F, &1F, &0F, &03, &22, &44
 EQUB &20, &35, &22, &11, &18, &0C, &03, &05
 EQUB &F8, &12, &05, &21, &38, &08, &C0, &FC
 EQUB &06, &C0, &21, &1C, &0F, &0A, &32, &03
 EQUB &1F, &7E, &FE, &F8, &22, &F0, &0F, &0F
 EQUB &21, &0F, &FE, &0F, &05, &34, &01, &0F
 EQUB &0F, &1F, &04, &37, &01, &0F, &08, &10
 EQUB &3F, &07, &0F, &7F, &FF, &23, &FE, &30
 EQUB &32, &06, &0C, &78, &C0, &02, &21, &02
 EQUB &12, &9F, &34, &0F, &07, &07, &0F, &7F
 EQUB &00, &33, &05, &02, &01, &03, &40, &F0
 EQUB &14, &FC, &22, &F0, &30, &21, &03, &80
 EQUB &40, &03, &30, &07, &21, &03, &E0, &C0
 EQUB &80, &04, &21, &03, &06, &21, &07, &FF
 EQUB &33, &01, &07, &0F, &03, &21, &06, &80
 EQUB &03, &33, &01, &07, &3F, &12, &FC, &C0
 EQUB &80, &33, &01, &06, &38, &04, &21, &03
 EQUB &15, &02, &21, &02, &80, &00, &21, &07
 EQUB &02, &7F, &17, &60, &C3, &32, &06, &0C
 EQUB &78, &C0, &21, &03, &00, &17, &FE, &87
 EQUB &33, &06, &0C, &18, &70, &C0, &32, &03
 EQUB &06, &12, &FE, &F0, &E0, &80, &02, &80
 EQUB &00, &21, &06, &10, &20, &80, &02, &E0
 EQUB &80, &06, &63, &8F, &33, &1F, &3F, &3F
 EQUB &7F, &12, &3F

\ ******************************************************************************
\
\       Name: image13
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 13
\
\ ******************************************************************************

.image13

 EQUB &23, &1F, &22, &0F, &33, &05, &03, &01
 EQUB &FE, &F4, &A0, &FD, &E8, &40, &A8, &40
 EQUB &80, &0F, &04, &21, &08, &0C, &21, &02
 EQUB &0F, &04, &21, &04, &0F, &04, &21, &08
 EQUB &00, &21, &02, &20, &0A, &21, &04, &05
 EQUB &21, &01, &08, &C0, &E0, &0A, &21, &02
 EQUB &02, &40, &0A, &21, &01, &03, &21, &04
 EQUB &06, &80, &04, &37, &0A, &25, &03, &09
 EQUB &04, &02, &01, &03, &80, &C0, &E0, &70
 EQUB &21, &38, &9C, &70, &35, &38, &1C, &0A
 EQUB &05, &02, &07, &80, &00, &20, &0F, &0B
 EQUB &40, &B0, &78, &FC, &FE, &7F, &08, &4E
 EQUB &36, &27, &13, &09, &04, &02, &01, &03
 EQUB &80, &C0, &A0, &50, &21, &28, &84, &0C
 EQUB &20, &05, &22, &01, &23, &03, &21, &01
 EQUB &00, &70, &F8, &EA, &D0, &F8, &B0, &40
 EQUB &36, &3F, &1F, &0F, &07, &03, &01, &02
 EQUB &80, &C0, &E0, &F0, &F8, &7C, &BE, &57
 EQUB &08, &40, &21, &01, &10, &0E, &21, &01
 EQUB &0F, &02, &22, &01, &05, &C0, &E0, &F0
 EQUB &F8, &5C, &37, &2A, &0A, &01, &00, &04
 EQUB &02, &01, &02, &80, &40, &20, &10, &21
 EQUB &08, &00, &80, &0F, &05, &40, &02, &10
 EQUB &80, &06, &21, &04, &09, &33, &15, &08
 EQUB &04, &06, &80, &0F, &0F, &3F, &38, &0F
 EQUB &07, &0A, &15, &00, &0A, &0C, &06, &E9
 EQUB &4A, &5F, &32, &02, &17, &BA, &57, &BF
 EQUB &74, &A8, &D4, &FA, &90, &00, &40, &EA
 EQUB &40, &02, &88, &00, &10, &00, &20, &10
 EQUB &80, &03, &80, &10, &00, &21, &08, &00
 EQUB &21, &02, &02, &40, &02, &10, &82, &20
 EQUB &21, &06, &10, &21, &01, &00, &80, &44
 EQUB &10, &80, &21, &08, &20, &00, &48, &00
 EQUB &32, &03, &01, &03, &80, &02, &F5, &7E
 EQUB &95, &20, &21, &08, &02, &44, &50, &80
 EQUB &32, &01, &04, &10, &00, &21, &04, &80
 EQUB &41, &80, &03, &84, &03, &21, &02, &40
 EQUB &00, &21, &04, &40, &00, &21, &04, &05
 EQUB &21, &01, &04, &21, &01, &03, &C0, &E0
 EQUB &00, &20, &34, &02, &08, &00, &02, &02
 EQUB &21, &08, &07, &10, &82, &20, &21, &04
 EQUB &10, &21, &01, &00, &80, &20, &02, &40
 EQUB &02, &20, &02, &20, &02, &20, &00, &80
 EQUB &00, &37, &0A, &25, &03, &09, &04, &02
 EQUB &01, &03, &80, &C0, &E0, &70, &21, &38
 EQUB &9C, &70, &35, &38, &1C, &0A, &05, &02
 EQUB &07, &80, &00, &20, &10, &80, &02, &21
 EQUB &08, &80, &10, &02, &21, &02, &02, &21
 EQUB &04, &40, &05, &10, &06, &40, &B0, &78
 EQUB &FC, &FE, &7F, &08, &4E, &36, &27, &13
 EQUB &09, &04, &02, &01, &03, &80, &C0, &A0
 EQUB &50, &21, &28, &84, &08, &21, &04, &00
 EQUB &21, &09, &00, &52, &03, &21, &08, &02
 EQUB &34, &03, &01, &82, &01, &42, &00, &AC
 EQUB &F6, &55, &FE, &A4, &4D, &B8, &36, &3F
 EQUB &1F, &0F, &07, &03, &01, &02, &80, &C0
 EQUB &E0, &F0, &F8, &7C, &BE, &57, &08, &40
 EQUB &21, &01, &10, &0D, &80, &21, &02, &20
 EQUB &00, &40, &00, &10, &00, &21, &03, &81
 EQUB &00, &20, &00, &48, &00, &10, &E1, &30
 EQUB &84, &22, &01, &05, &C0, &E0, &F0, &F8
 EQUB &5C, &37, &2A, &0A, &01, &00, &04, &02
 EQUB &01, &02, &80, &40, &20, &10, &21, &08
 EQUB &00, &80, &0F, &03, &80, &02, &10, &C0
 EQUB &00, &44, &00, &80, &02, &21, &22, &0B
 EQUB &33, &15, &08, &04, &06, &80, &0F, &0F
 EQUB &3F, &0F, &0F, &0F, &0F, &0F, &40, &0F
 EQUB &0D, &34, &12, &05, &22, &04, &0C, &40
 EQUB &10, &80, &00, &20, &0F, &0F, &04, &44
 EQUB &0F, &0F, &07, &33, &01, &0F, &3B, &05
 EQUB &32, &01, &0B, &20, &04, &21, &3F, &FE
 EQUB &12, &04, &21, &3C, &F8, &FC, &FE, &04
 EQUB &FC, &FF, &32, &3F, &1F, &04, &FC, &33
 EQUB &37, &19, &0C, &05, &80, &F0, &FC, &05
 EQUB &80, &F0, &FC, &0F, &09, &10, &21, &02
 EQUB &20, &21, &04, &0C, &20, &08, &3E, &01
 EQUB &03, &07, &0F, &1F, &3F, &3F, &00, &01
 EQUB &03, &07, &0F, &1F, &37, &21, &23, &75
 EQUB &DA, &FC, &F6, &FB, &FD, &FE, &FF, &40
 EQUB &80, &40, &20, &90, &C8, &E4, &F2, &12
 EQUB &7F, &32, &3F, &1F, &8F, &C7, &63, &7F
 EQUB &36, &3F, &1F, &0F, &07, &03, &01, &00
 EQUB &8F, &C7, &E3, &F5, &FA, &FD, &12, &21
 EQUB &06, &83, &C1, &E0, &F0, &F8, &FC, &22
 EQUB &FE, &14, &7F, &FF, &DF, &7E, &21, &3F
 EQUB &9F, &CF, &67, &33, &33, &19, &0C, &0B
 EQUB &40, &0F, &07, &22, &01, &23, &03, &21
 EQUB &07, &02, &21, &01, &00, &21, &02, &02
 EQUB &21, &06, &7F, &FF, &BF, &4F, &87, &32
 EQUB &03, &01, &80, &51, &88, &33, &04, &02
 EQUB &01, &03, &3F, &18, &F9, &FC, &7E, &32
 EQUB &3F, &1F, &8F, &47, &21, &23, &B1, &D8
 EQUB &EC, &F6, &FB, &FD, &FE, &FF, &00, &80
 EQUB &40, &20, &90, &E8, &F4, &FA, &12, &7F
 EQUB &21, &3B, &5F, &AE, &D7, &7B, &7F, &36
 EQUB &3F, &1F, &0B, &07, &02, &01, &20, &16
 EQUB &77, &BB, &21, &06, &A3, &D1, &EA, &F7
 EQUB &FB, &75, &BA, &08, &20, &80, &00, &20
 EQUB &00, &20, &21, &04, &0F, &02, &32, &07
 EQUB &01, &06, &32, &07, &01, &06, &C0, &E0
 EQUB &F0, &F8, &7C, &7E, &22, &7F, &00, &80
 EQUB &C0, &E0, &70, &78, &37, &3C, &1E, &7F
 EQUB &3F, &1F, &0F, &07, &83, &41, &A8, &35
 EQUB &11, &08, &04, &02, &01, &03, &13, &EF
 EQUB &FF, &FB, &FD, &FE, &FD, &FF, &7F, &32
 EQUB &2F, &1F, &8B, &45, &21, &22, &BF, &FE
 EQUB &EF, &BF, &FF, &EF, &F7, &FB, &00, &88
 EQUB &C4, &A2, &F1, &E8, &F5, &FA, &D5, &E8
 EQUB &F4, &F8, &FC, &FE, &DF, &FF, &55, &32
 EQUB &28, &14, &88, &44, &EA, &55, &BA, &08
 EQUB &21, &11, &00, &35, &01, &08, &01, &00
 EQUB &02, &0F, &01, &80, &02, &36, &01, &06
 EQUB &0E, &0F, &07, &07, &03, &35, &04, &08
 EQUB &0C, &06, &05, &FF, &FE, &34, &3C, &1A
 EQUB &0D, &06, &A3, &D5, &AF, &37, &16, &0C
 EQUB &02, &05, &06, &03, &01, &F5, &FE, &7F
 EQUB &32, &3B, &1D, &8E, &D7, &FB, &E0, &F0
 EQUB &78, &32, &38, &18, &88, &D4, &FA, &7F
 EQUB &BF, &DF, &EF, &F7, &FF, &7F, &FF, &33
 EQUB &11, &0A, &05, &82, &41, &21, &28, &57
 EQUB &21, &3F, &7D, &BE, &CF, &E7, &F3, &F9
 EQUB &FC, &FE, &7D, &BE, &4F, &A7, &53, &E9
 EQUB &7C, &BA, &F7, &FB, &7D, &AA, &51, &E8
 EQUB &D0, &62, &D7, &FB, &7D, &AA, &51, &E8
 EQUB &D0, &62, &0F, &0F, &02, &31, &07, &23
 EQUB &03, &22, &01, &02, &36, &06, &01, &01
 EQUB &02, &00, &01, &02, &EA, &F7, &FB, &13
 EQUB &F7, &7B, &80, &40, &A0, &D1, &68, &7D
 EQUB &B6, &7B, &FD, &76, &FB, &FD, &FE, &13
 EQUB &34, &3D, &16, &0B, &15, &AA, &7D, &FF
 EQUB &7F, &12, &7F, &BB, &9D, &4E, &A6, &D3
 EQUB &21, &1F, &AF, &5F, &AB, &9D, &4A, &A6
 EQUB &53, &7F, &BB, &DD, &AA, &44, &A2, &02
 EQUB &5F, &BB, &DD, &AA, &44, &A2, &02, &10
 EQUB &80, &44, &A0, &10, &21, &08, &00, &82
 EQUB &10, &80, &44, &A0, &10, &21, &08, &00
 EQUB &82, &3F

\ ******************************************************************************
\
\       Name: image14
\       Type: Variable
\   Category: Drawing images
\    Summary: Data for image 14
\
\ ******************************************************************************

.image14

 EQUB &00, &10, &04, &21, &01, &02, &33, &04
 EQUB &0E, &04, &04, &21, &04, &03, &10, &03
 EQUB &21, &02, &0E, &C0, &21, &04, &02, &10
 EQUB &06, &80, &21, &04, &0F, &0F, &06, &36
 EQUB &03, &06, &0C, &1C, &38, &38, &22, &70
 EQUB &0F, &08, &21, &0E, &05, &21, &08, &C0
 EQUB &21, &01, &0F, &09, &78, &FC, &24, &F8
 EQUB &FB, &FE, &03, &32, &01, &0F, &78, &C0
 EQUB &02, &32, &03, &3E, &F0, &04, &78, &C0
 EQUB &0F, &06, &21, &03, &04, &37, &07, &38
 EQUB &C0, &02, &00, &03, &1E, &F0, &80, &03
 EQUB &78, &FC, &7D, &35, &3E, &1F, &0F, &07
 EQUB &01, &05, &C0, &A0, &C0, &0F, &09, &21
 EQUB &07, &07, &E0, &0F, &08, &74, &0F, &0F
 EQUB &0F, &01, &21, &08, &08, &20, &00, &21
 EQUB &28, &00, &20, &00, &21, &08, &0F, &0F
 EQUB &0C, &20, &02, &21, &04, &0F, &20, &0A
 EQUB &21, &01, &06, &21, &18, &40, &04, &80
 EQUB &03, &40, &07, &3F, &80, &21, &01, &00
 EQUB &21, &08, &00, &80, &10, &00, &21, &04
 EQUB &00, &21, &04, &80, &21, &04, &00, &21
 EQUB &08, &02, &40, &00, &21, &04, &02, &21
 EQUB &02, &30, &10, &02, &21, &01, &10, &04
 EQUB &20, &00, &21, &04, &03, &20, &40, &03
 EQUB &21, &02, &04, &10, &06, &81, &00, &10
 EQUB &02, &80, &21, &02, &0F, &0B, &36, &01
 EQUB &03, &0A, &16, &75, &3E, &6C, &80, &0F
 EQUB &06, &32, &01, &11, &05, &32, &17, &38
 EQUB &80, &0F, &09, &D7, &72, &E4, &F4, &F7
 EQUB &F5, &E5, &4F, &03, &80, &32, &07, &3C
 EQUB &E0, &02, &32, &07, &1C, &E0, &80, &03
 EQUB &B0, &80, &21, &02, &05, &21, &08, &60
 EQUB &0C, &32, &01, &05, &03, &32, &01, &0F
 EQUB &7C, &60, &85, &00, &32, &07, &3C, &E0
 EQUB &00, &21, &04, &60, &00, &74, &C7, &36
 EQUB &3E, &1D, &0C, &05, &03, &02, &C0, &A0
 EQUB &C0, &80, &C8, &30, &59, &BE, &0F, &09
 EQUB &21, &03, &07, &90, &0F, &21, &01, &03
 EQUB &21, &08, &03, &8B, &21, &3F, &07, &C0
 EQUB &0F, &0D, &21, &04, &08, &21, &08, &08
 EQUB &20, &00, &21, &28, &00, &21, &22, &00
 EQUB &21, &08, &05, &80, &02, &21, &04, &07
 EQUB &21, &02, &0F, &0A, &20, &02, &21, &04
 EQUB &00, &32, &0A, &1D, &05, &32, &0C, &21
 EQUB &80, &02, &21, &08, &00, &20, &02, &80
 EQUB &00, &33, &11, &08, &14, &BE, &20, &80
 EQUB &21, &01, &00, &10, &00, &80, &02, &21
 EQUB &18, &40, &04, &80, &00, &32, &05, &2B
 EQUB &40, &00, &32, &01, &07, &00, &40, &C0
 EQUB &D0, &3F, &0F, &0F, &0F, &05, &80, &07
 EQUB &80, &0F, &0F, &0D, &20, &07, &20, &05
 EQUB &21, &04, &07, &21, &04, &05, &10, &07
 EQUB &10, &0C, &10, &07, &10, &80, &06, &21
 EQUB &04, &80, &06, &21, &04, &0F, &0F, &0F
 EQUB &0F, &06, &20, &07, &20, &05, &80, &02
 EQUB &21, &02, &02, &20, &00, &80, &02, &21
 EQUB &02, &02, &20, &05, &21, &04, &00, &40
 EQUB &05, &21, &04, &00, &40, &02, &80, &04
 EQUB &10, &21, &04, &00, &80, &04, &10, &21
 EQUB &04, &0F, &0F, &0F, &06, &21, &01, &00
 EQUB &21, &04, &00, &21, &02, &03, &21, &01
 EQUB &00, &21, &04, &00, &21, &02, &00, &21
 EQUB &04, &00, &10, &21, &01, &00, &84, &21
 EQUB &11, &00, &21, &04, &00, &10, &21, &01
 EQUB &00, &84, &34, &11, &02, &40, &08, &A1
 EQUB &54, &AA, &74, &F8, &21, &02, &40, &21
 EQUB &08, &A1, &54, &AA, &74, &F8, &21, &08
 EQUB &20, &21, &04, &02, &36, &01, &0F, &30
 EQUB &08, &20, &04, &02, &32, &01, &0F, &30
 EQUB &40, &02, &34, &03, &1E, &F0, &07, &7F
 EQUB &40, &02, &34, &03, &1E, &F0, &07, &7F
 EQUB &03, &C0, &00, &F0, &F8, &FC, &03, &C0
 EQUB &00, &F0, &F8, &FC, &3F, &0F, &07, &32
 EQUB &01, &03, &06, &36, &01, &03, &15, &0A
 EQUB &17, &3D, &6F, &12, &BD, &34, &15, &0A
 EQUB &17, &3D, &6F, &12, &BD, &40, &AA, &55
 EQUB &EB, &BE, &FF, &F7, &FF, &40, &AA, &55
 EQUB &EB, &BE, &FF, &F7, &FF, &F8, &F7, &7F
 EQUB &15, &F8, &D7, &7F, &FF, &7B, &FF, &AE
 EQUB &55, &21, &07, &FF, &7E, &15, &21, &07
 EQUB &FF, &7E, &FF, &F7, &BE, &EB, &55, &DF
 EQUB &17, &DF, &FB, &FF, &DF, &FE, &F5, &A8
 EQUB &00, &EE, &12, &25, &80, &AE, &FF, &EF
 EQUB &00, &A2, &00, &21, &2A, &02, &C0, &FF
 EQUB &35, &3F, &1F, &0F, &07, &07, &00, &C0
 EQUB &FF, &21, &3F, &9B, &21, &0D, &80, &00
 EQUB &32, &0F, &3F, &FB, &15, &32, &0E, &3F
 EQUB &FB, &FF, &BD, &57, &8A, &00, &17, &FE
 EQUB &12, &F7, &BF, &EE, &55, &88, &21, &02
 EQUB &12, &EF, &13, &F8, &00, &7F, &FF, &ED
 EQUB &FF, &DA, &75, &A8, &00, &13, &FE, &04
 EQUB &A8, &02, &21, &02, &02, &50, &00, &FF
 EQUB &FE, &E0, &05, &A0, &21, &02, &20, &02
 EQUB &20, &00, &21, &22, &FF, &21, &07, &07
 EQUB &21, &06, &03, &80, &00, &23, &80, &06
 EQUB &21, &0A, &00, &21, &02, &00, &21, &08
 EQUB &00, &21, &22, &00, &22, &07, &21, &04
 EQUB &05, &80, &00, &84, &21, &01, &00, &21
 EQUB &01, &80, &21, &01, &FF, &8F, &07, &88
 EQUB &00, &40, &00, &40, &00, &40, &F8, &C0
 EQUB &06, &21, &08, &40, &03, &40, &0D, &21
 EQUB &02, &00, &10, &21, &01, &09, &54, &00
 EQUB &54, &00, &40, &21, &0A, &40, &21, &0A
 EQUB &03, &32, &09, &12, &04, &21, &0A, &03
 EQUB &80, &00, &80, &08, &21, &01, &80, &00
 EQUB &21, &13, &0C, &21, &2A, &00, &21, &22
 EQUB &00, &21, &0A, &00, &21, &2A, &09, &80
 EQUB &00, &80, &03, &21, &04, &20, &0B, &21
 EQUB &02, &10, &80, &00, &21, &02, &09, &21
 EQUB &04, &20, &00, &21, &02, &10, &40, &09
 EQUB &32, &01, &04, &20, &80, &00, &21, &15
 EQUB &00, &21, &05, &3F

\ ******************************************************************************
\
\       Name: copyrightMessage
\       Type: Variable
\   Category: Text
\    Summary: A copyright message buried in the code, complete with typo
\
\ ******************************************************************************

.copyrightMessage

 EQUS "C", 0
 EQUS "c", 0
 EQUS "p", 0
 EQUS "y", 0
 EQUS "r", 0
 EQUS "i", 0
 EQUS "g", 0
 EQUS "h", 0
 EQUS "t", 0
 EQUS " ", 0
 EQUS "(", 0
 EQUS "C", 0
 EQUS ")", 0
 EQUS " ", 0
 EQUS "D", 0
 EQUS ".", 0
 EQUS "B", 0
 EQUS "r", 0
 EQUS "a", 0
 EQUS "b", 0
 EQUS "e", 0
 EQUS "n", 0
 EQUS ",", 0
 EQUS " ", 0
 EQUS "I", 0
 EQUS ".", 0
 EQUS "B", 0
 EQUS "e", 0
 EQUS "l", 0
 EQUS "l", 0
 EQUS " ", 0
 EQUS "1", 0
 EQUS "9", 0
 EQUS "9", 0
 EQUS "1", 0
 EQUS ".", 0

\ ******************************************************************************
\
\       Name: SetSystemImage1
\       Type: Subroutine
\   Category: Drawing images
\    Summary: ???
\
\ ******************************************************************************

.SetSystemImage1

 JSR GetSystemImage1    \ Fetch the system image for the current system and
                        \ store it in the pattern buffers, starting at tile
                        \ number pictureTile

 LDA #HI(16*69)         \ Set PPU_ADDR to the address of pattern #69 in pattern
 STA PPU_ADDR           \ table 0
 LDA #LO(16*69)
 STA PPU_ADDR

 JSR UnpackToPPU        \ Unpack the rest of the image data to the PPU ???

 JMP UnpackToPPU+2      \ Unpack the rest of the image data to the PPU, ???
                        \ returning from the subroutine using a tail call

\ ******************************************************************************
\
\       Name: GetSystemImage1
\       Type: Subroutine
\   Category: Drawing images
\    Summary: Fetch the image for the current system and store it in the pattern
\             buffers
\
\ ------------------------------------------------------------------------------
\
\ Arguments:
\
\   pictureTile         The number of the tile in the pattern table from which
\                       we store the image data
\
\ ******************************************************************************

.GetSystemImage1

 LDA #0                 \ Set (SC+1 A) = (0 pictureTile)
 STA SC+1               \              = pictureTile
 LDA pictureTile

 ASL A                  \ Set SC(1 0) = (SC+1 A) * 8
 ROL SC+1               \             = pictureTile * 8
 ASL A
 ROL SC+1
 ASL A
 ROL SC+1
 STA SC

 STA SC2                \ Set SC2(1 0) = pattBuffer1 + SC(1 0)
 LDA SC+1               \              = pattBuffer1 + pictureTile * 8
 ADC #HI(pattBuffer1)
 STA SC2+1

 LDA SC+1               \ Set SC(1 0) = pattBuffer0 + SC(1 0)
 ADC #HI(pattBuffer0)   \             = pattBuffer0 + pictureTile * 8
 STA SC+1

 LDA QQ15+1             \ Set X to a number between 0 and 15 that is generated
 EOR QQ15+4             \ from the high bytes of the 16-bit seeds for the
 EOR QQ15+3             \ selected system (s0_hi, s1_hi and s2_hi)
 AND #&0F
 TAX

 CPX imageCount         \ If X < imageCount, skip the following two instructions
 BCC gsys1

 LDX imageCount         \ Set X = imageCount - 1 so X has a maximum value of 14
 DEX                    \ (as imageCount is 15)

.gsys1

 TXA                    \ Set systemFlag to %1100xxxx where X is %xxxx
 ORA #%11000000
 STA systemFlag

 TXA                    \ Set X = X * 2 so we can use it as an index into the
 ASL A                  \ table of 16-bit addresses at imageOffset
 TAX

 LDA imageOffset,X      \ Set V(1 0) = imageOffset for image X + imageCount
 ADC #LO(imageCount)    \
 STA V                  \ So V(1 0) points to image0 when X = 0, image1 when
 LDA imageOffset+1,X    \ X = 1, and so on up to image14 when X = 14
 ADC #HI(imageCount)
 STA V+1

 JSR UnpackToRAM        \ Unpack the data at V(1 0) into SC(1 0), updating
                        \ V(1 0) as we go
                        \
                        \ SC(1 0) is pattBuffer0 + pictureTile * 8, so this
                        \ unpacks the data from tile number pictureTile in
                        \ into pattern buffer 0

 LDA SC2                \ Set SC(1 0) = SC2(1 0)
 STA SC                 \             = pattBuffer1 + pictureTile * 8
 LDA SC2+1
 STA SC+1

 JMP UnpackToRAM        \ Unpack the data at V(1 0) into SC(1 0), updating
                        \ V(1 0) as we go
                        \
                        \ SC(1 0) is pattBuffer1 + pictureTile * 8, so this
                        \ unpacks the data from tile number pictureTile in
                        \ into pattern buffer 1
                        \
                        \ When done, we return from the subroutine using a tail
                        \ call

\ ******************************************************************************
\
\       Name: subm_BF41
\       Type: Subroutine
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.subm_BF41

 LDA #5                 \ Set a bunch of L046x variables ???
 JSR subm_E909

 JSR subm_F362          \ Set a bunch of ZP variables, including RAND ???

 LDX language           \ Set addr2(1 0) to the current language's entry from
 LDA addrLo,X           \ the addrLo and addrHi tables
 STA addr2
 LDA addrHi,X
 STA addr2+1

 LDA #0                 \ ???
 STA L04BC
 STA L04BD

 LDX #&80               \ ???
 STX L03EE

 RTS                    \ Return from the subroutine

\ ******************************************************************************
\
\       Name: addrLo
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.addrLo

 EQUB LO(LE5B0_EN)      \ English

 EQUB LO(LE602_DE)      \ German

 EQUB LO(LE653_FR)      \ French

 EQUB LO(LE5B0_EN)      \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: addrHi
\       Type: Variable
\   Category: ???
\    Summary: ???
\
\ ******************************************************************************

.addrHi

 EQUB HI(LE5B0_EN)      \ English

 EQUB HI(LE602_DE)      \ German

 EQUB HI(LE653_FR)      \ French

 EQUB HI(LE5B0_EN)      \ There is no fourth language, so this byte is ignored

\ ******************************************************************************
\
\       Name: Vectors
\       Type: Variable
\   Category: Text
\    Summary: Vectors and padding at the end of the ROM bank
\
\ ******************************************************************************

 FOR I%, P%, &BFF9

  EQUB &FF              \ Pad out the rest of the ROM bank with &FF

 NEXT

 EQUW Interrupts+&4000  \ Vector to the NMI handler in case this bank is loaded
                        \ into &C000 during startup (the handler contains an RTI
                        \ so the interrupt is processed but has no effect)

 EQUW ResetMMC1+&4000   \ Vector to the RESET handler in case this bank is
                        \ loaded into &C000 during startup (the handler resets
                        \ the MMC1 mapper to map bank 7 into &C000 instead)

 EQUW Interrupts+&4000  \ Vector to the IRQ/BRK handler in case this bank is
                        \ loaded into &C000 during startup (the handler contains
                        \ an RTI so the interrupt is processed but has no
                        \ effect)

\ ******************************************************************************
\
\ Save bank5.bin
\
\ ******************************************************************************

 PRINT "S.bank5.bin ", ~CODE%, " ", ~P%, " ", ~LOAD%, " ", ~LOAD%
 SAVE "3-assembled-output/bank5.bin", CODE%, P%, LOAD%
