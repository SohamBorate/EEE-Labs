ORG 0000H

START: MOV A, 30H // Load first ASCII digit
CLR C // Clear carry
SUBB A, #30H // Convert ASCII to hexadecimal
SWAP A // Move digit to upper nibble
MOV R2, A // Save upper nibble
MOV A, 31H // Load second ASCII digit
CLR C // Clear carry
SUBB A, #30H // Convert ASCII to hexadecimal
ANL A, #0FH // Keep lower nibble
ORL A, R2 // Pack both digits
MOV P1, A // Display result in Port 1
ACALL DELAY1MIN // Generate 1 minute delay
SJMP $ // Stop execution

DELAY1MIN: MOV R5, #60 // Repeat delay 60 times
D1: ACALL DELAY1SEC // Generate approximately 1 second delay
DJNZ R5, D1 // Repeat 60 times
RET // Return

DELAY1SEC: MOV R6, #8 // Delay loop
D2: MOV R7, #225 // Delay loop
D3: MOV R4, #255 // Delay loop
D4: DJNZ R4, D4 // Inner delay
DJNZ R7, D3 // Middle delay
DJNZ R6, D2 // Outer delay
RET // Return

END
