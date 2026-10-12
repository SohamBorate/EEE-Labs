ORG 0000H

BEGIN: MOV R0, #50H // source address
MOV R1, #30H // destination address
MOV R2, #5 // assumed size of array
MOV R3, #00 // tracker

BACK: MOV B, #4H // assuming hexadecimal and not decimal
MOV A, @R0 // copy source data to accumulator
DIV AB

// assume case divisible
MOV A, @R0
MOV @R1, A
INC R1
INC R3

MOV A, B // move remainder to accumulator

// case not divisible, reverse changes
JZ NEXT
DEC R1
DEC R3
MOV @R0, #00H
MOV @R1, #00H

NEXT: INC R0
DJNZ R2, BACK

MOV A, R3

END
