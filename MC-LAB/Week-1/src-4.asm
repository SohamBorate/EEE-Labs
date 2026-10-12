ORG 0000H

START: MOV R2, #5 // counter
MOV R0, #20H // internal destination address
MOV DPTR, #2000H // external source address

BACK: MOVX A, @DPTR
XCH A, @R0
MOVX @DPTR, A
INC DPTR
INC R0
DJNZ R2, BACK

END
