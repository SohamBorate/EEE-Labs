ORG 0000H
// bubble sort
START: MOV R2, #05 // size of array
DEC R2 // counter should be size - 1

LOOP: MOV R0, #60H // source memory pointer
MOV R1, #61H // source memory pointer + 1
MOV 03H, R2 // counter

BACK: MOV A, @R0 // compare adjacent values
CLR C
SUBB A, @R1

JNC NEXT
MOV A, @R0 // swap
XCH A, @R1
MOV @R0, A

NEXT: INC R0 // next iteration
INC R1
DJNZ R3, BACK

NEXTLOOP: DJNZ R2, LOOP // next loop

END
