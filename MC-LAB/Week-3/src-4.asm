ORG 0000H

START: MOV R0, #40H // initialise source pointer
MOV R1, #51H // initialise position 3 destination
MOV R3, #61H // initialise other destination
MOV R2, #05 // iniitalise counter
MOV 50H, #00H // initialise size to zero

BACK: MOV A, @R0 // read data byte
MOV B, A // save original data
CLR C // clear carry
MOV R4, #07H // start checking from bit 7
MOV R5, #08 // initialise bit counter

CHECK: RLC A // shift next bit into carry
JC FOUND // if bit is HIGH, HIGH bit found
DEC R4 // move to next bit position
DJNZ R5, CHECK // continue checking
SJMP NEXT // no high bit found

FOUND: MOV A, B // restore original data
CJNE R4, #03H, OTHER // check whether position is 3
MOV @R1, A // store number at 51H series
INC R1 // increment destination pointer
INC 50H // increment sie
SJMP NEXT // process next number

OTHER: MOV @R3, A // store number at 61H series
INC R3 // increment destination pointer

NEXT: INC R0 // point to next input
DJNZ R2, BACK // repeat for 5 numbers
SJMP $ // stop execution

END
