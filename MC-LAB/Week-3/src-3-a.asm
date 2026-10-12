ORG 0000H

START: MOV A, 50H // load packed hexadecimal number
ANL A, #0F0H // extract upper nibble
SWAP A // move upper nibble to lower nibble
MOV DPTR, #TABLE // load look up table address
MOVC A, @A+DPTR // get ASCII code from table
MOV P0, A // display upper ASCII digit
MOV A, 50H // reload packed hexadecimal number
ANL A, #0FH // extract lower nibble
MOV DPTR, #TABLE // load look up table address
MOVC A, @A+DPTR // get ASCII code from table
MOV P1, A // display lower ASCII digit

SJMP $ // end program

TABLE: DB 30H,31H,32H,33H,34H,35H,36H,37H // ASCII 0–7
DB 38H,39H,41H,42H,43H,44H,45H,46H // ASCII 8–F

END
