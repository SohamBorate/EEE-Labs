ORG 0000H

START: MOV R0, 50H // initialise number
MOV 51H, #1 // initialise multipler
MOV R1, #51H // initialise source multipler pointer
MOV R2, #10 // initialise counter

BACK: MOV A, R0 // load number
MOV B, @R1 // load multiplier
MUL AB
MOV 52H, B // display result high byte
MOV 53H, A // display result low byte
ACALL DELAY // delay 3 seconds
DJNZ R2, NEXT

SJMP TERMINATE

NEXT: INC @R1 // increment source multiplier pointer
MOV A, @R1
DA A
MOV @R1, A
SJMP BACK

// 3 second

DELAY: MOV R7, #24 // down-counter, after each tick, R7 decreases
LOOP1: MOV R6, #225 // prescalar 2
LOOP2: MOV R5, #255 // prescalar 1
LOOP3: DJNZ R5, LOOP3
DJNZ R6, LOOP2
DJNZ R7, LOOP1
RET

TERMINATE:

END
