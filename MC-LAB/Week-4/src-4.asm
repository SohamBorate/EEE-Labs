ORG 0000H

START: MOV R0, #1FH // from high
MOV R1, #00H // from low
MOV R2, #20H // to high
MOV R3, #26H // to low

INC R3 // stops at R3 - 1

BACK: MOV P1, R0 // display high byte
MOV P2, R1 // display low byte
ACALL DELAY

MOV A, R1 // increment low byte
CLR C
ADD A, #01H
MOV R1, A
JNC CHECK

MOV A, R0 // increment high byte
INC R0

CHECK: MOV A, R0 // check current high byte
CLR C
SUBB A, R2
JC BACK

MOV A, R1 // check current low byte
CLR C
SUBB A, R3
JC BACK
SJMP SKIPDELAY

SJMP SKIPDELAY // 0.5 second

DELAY: MOV R7, #4 // down-counter, after each tick, R7 decreases
LOOP1: MOV R6, #225 // prescalar 2
LOOP2: MOV R5, #255 // prescalar 1
LOOP3: DJNZ R5, LOOP3
DJNZ R6, LOOP2
DJNZ R7, LOOP1
RET

SKIPDELAY:

END
