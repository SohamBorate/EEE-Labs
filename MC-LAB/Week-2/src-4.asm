ORG 0000H

MOV B, 30H // move internal number to B
MOV DPTR, #2001H // initialise external address to byte low
MOVX A, @DPTR // copy external low byte to accumulator
MUL AB
MOV 52H, A // move initial multiplication lower byte to least significant byte of result
MOV R0, B // move initial multiplication high byte to R0
MOV B, 30H // move internal number to B

MOV DPTR, #2000H // initialise external address to byte high
MOVX A, @DPTR // copy external high byte to accumulator
MUL AB
ADD A, R0 // add secondary multiplication low byte and initial multiplication high byte
JNC NEXT // if not carry, jump to NEXT
INC B // if carry, increment high byte of secondary multiplication

NEXT: MOV 51H, A
MOV 50H, B // copy most significant byte to 50H

END
