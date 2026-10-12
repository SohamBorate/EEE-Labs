ORG 0000H

START: MOV A,50H // load packed hexadecimal number
ANL A, #0F0H // extract upper nibble
SWAP A // move upper nibble to lower nibble
ACALL ASCII // convert upper nibble to ASCII
MOV P0, A  // display upper ASCII digit
MOV A, 50H // reload packed hexadecimal number
ANL A, #0FH // extract lower nibble
ACALL ASCII // convert lower nibble to ASCII
MOV P1, A // display lower nibble to ASCII
SJMP $ // stop program


ASCII: CJNE A, #0AH, CHK // Compare with 0AH
ADD A,#37H // Convert 0AH to ASCII A
RET // return

CHK: JC DIGIT // Jump if value is below 0AH
ADD A, #37H // Convert A–F to ASCII
RET // return

DIGIT: ADD A, #30H // Convert 0–9 to ASCII
RET // return

END
