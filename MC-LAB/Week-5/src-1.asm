ORG 0000H
LJMP MAIN
ORG 001BH // Timer 1 ISR vector
LJMP ISR_T1
ORG 0030H

MAIN: MOV TMOD, #20H // Timer 1, Mode 2 (8-bit auto-reload)
MOV TH1,  #48H // 256-200 = 56 = 48H -> 200 us reload
MOV TL1,  #38H // preload TL1 too, so 1st overflow is also ~200us
MOV R0,   #01H // main loop counter
CLR 20H.0
MOV IE, #88H // EA=1, ET1=1
SETB TR1 // start Timer 1

AGAIN: MOV A, R0
MOV P0, A // output count to Port 0
ACALL DELAY50U

JNB 20H.0, SKIP // did the ISR flag a snapshot?
ACALL DOWNCOUNT  // do the P1 countdown IN MAINLINE, not in ISR
CLR 20H.0
SKIP: INC R0
CJNE R0, #31H, AGAIN // loop 01H..30H
MOV R0, #01H
SJMP AGAIN

//////////

DELAY50U: MOV R7, #22
D50: DJNZ R7, D50
RET

//////////
// runs from MAIN, can block safely
DOWNCOUNT: MOV A, 31H
DLOOP: MOV P1, A // display down-counter on Port 1
ACALL DELAY1SEC
JZ DDONE
DEC A
SJMP DLOOP
DDONE: RET

//////////

DELAY1SEC: MOV R5, #8
D1: MOV R6, #225
D2: MOV R7, #255
D3: DJNZ R7, D3
DJNZ R6, D2
DJNZ R5, D1
RET

//////////
// SHORT — just snapshot + flag, no delays
ISR_T1: PUSH ACC
PUSH PSW
MOV A, R0
MOV 31H, A
SETB 20H.0
POP PSW
POP ACC
RETI
END