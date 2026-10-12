ORG 0000H

BEGIN: MOV R0, #30H // initialise source address
MOV R2, #11 // initialise counter
MOV A, #00H // clear A

BACK: ADD A, @R0 // add source to low byte of result
DA A
JNC AFTERCARRY
XCH A, 40H // increment result high byte if carry true
ADD A, #01H
DA A
XCH A, 40H

AFTERCARRY: INC R0 // increment source address
DJNZ R2, BACK

MOV 41H, A // lower byte

END
