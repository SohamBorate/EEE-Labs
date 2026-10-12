ORG 0000H

/*
24H/34H/44H is most significant byte
20H/30H/40H is least significant byte
*/

MOV R2, #4 // counter / byte size
MOV R0, #20H // higher source address
MOV R1, #30H // lower source address
MOV R3, #40H // destination address

BACK: MOV A, @R0
CLR C
SUBB A, @R1
PUSH 00H // push current higher source address to stack
MOV 00H, 03H // destination address to R0
MOV @R0, A // copy result from A to destination address
INC R0 // increment destination address
MOV 03H, 00H // copy address from R0 to R3
POP 00H // retrieve current higher source address from stack
INC R0 // increment higher source address
INC R1 // increment lower source address
DJNZ R2, BACK

END
