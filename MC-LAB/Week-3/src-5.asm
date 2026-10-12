ORG 0000H

START: MOV DPTR, #9050H // Point to external RAM
MOVX A, @DPTR // Read data from 9050H
MOV R7, A // Save original data
MOV R6, #00H // Clear 1s counter
MOV R5, #08 // Initialize bit counter
CLR C // Clear carry

COUNT: RRC A // Move next bit into carry
JNC NEXTBIT // Skip if bit is zero
INC R6 // Increment 1s count

NEXTBIT: DJNZ R5, COUNT // Repeat for 8 bits
MOV A, R6 // Load number of 1s
MOV DPTR, #9051H // Point to 9051H
MOVX @DPTR, A // Store number of 1s
MOV A, R7 // Restore original number
MOV R4, #00H // Clear reverse result
MOV R5, #08 // Initialize reverse counter

REV: CLR C // Clear carry
RRC A // Extract next bit
MOV R7, A // Save shifted source
MOV A, R4 // Load reverse result
RLC A // Shift bit into reverse result
MOV R4, A // Save reverse result
MOV A, R7 // Restore shifted source
DJNZ R5, REV // Repeat 8 times
MOV A, R4 // Load reverse result
MOV DPTR, #9052H // Point to 9052H
MOVX @DPTR, A // Store reverse number
CLR 00H // Clear user flag bit 0
CLR 01H // Clear user flag bit 1
MOV A, R6 // Load number of 1s
ANL A, #01H // Check parity
JZ EVEN // Jump if even
SETB 00H // Set user flag bit 0

SJMP DONE // Finish

EVEN: SETB 01H // Set user flag bit 1

DONE: SJMP $ // Stop execution

END
