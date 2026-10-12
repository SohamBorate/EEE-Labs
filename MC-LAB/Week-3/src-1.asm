ORG 0000H

START: MOV R2, #3 // 2 digit hex yeild max 3 digits of decimal
MOV A, 70H

BACK: MOV B, #0AH
DIV AB
MOV P0, B
ACALL DELAY
DJNZ R2, BACK

SJMP SKIPDELAY // 1 second

DELAY: MOV R7, #8 // down-counter, after each tick, R7 decreases
LOOP1: MOV R6, #225 // prescalar 2
LOOP2: MOV R5, #255 // prescalar 1
LOOP3: DJNZ R5, LOOP3
DJNZ R6, LOOP2
DJNZ R7, LOOP1
RET

SKIPDELAY:

END
