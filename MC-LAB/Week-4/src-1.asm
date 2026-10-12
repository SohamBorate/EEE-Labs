ORG 0000H

START: MOV R2, 60H // counter
MOV R0, #61H // source memory pointer
MOV R1, #0FFH // default smallest number

BACK: MOV A, @R0 // copy from source memory pointer
CLR C
SUBB A, R1 // subtract smallest number

JNC NEXT
MOV 01H, @R0

NEXT: INC R0 // increment counter
DJNZ R2, BACK

MOV P3, R1 // display result

END
