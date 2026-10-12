ORG 0000H

START: MOV R2, #5
MOV R0, #55H

BACK: MOV A, @R0

MOV R3, A // save original packed BCD (need it again for units digit)
ANL A, #0F0H // isolate upper nibble (tens digit, still shifted left)
SWAP A // shift down: e.g. 70H -> 07H
MOV B, #0AH
MUL AB // A = tens_digit * 10
MOV R4, A // stash this partial result
MOV A, R3 // reload original packed byte
ANL A, #0FH // isolate lower nibble = units digit
ADD A, R4 // A = (tens*10) + units = hex equivalent

MOV P1, A
INC R0
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