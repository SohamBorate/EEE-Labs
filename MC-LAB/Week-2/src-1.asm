ORG 0000H

START: MOV R2, #10 // counter
MOV R0, #30H // source address
MOV 40H, #00 // higher byte of result
CLR A

BACK: ADD A, @R0
JNC NEXT
INC 40H // if carry, increment higher byte of result

NEXT: INC R0 // increment source address
DJNZ R2, BACK

MOV 41H, A // lower byte of result

END
