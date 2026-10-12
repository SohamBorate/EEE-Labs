ORG 0000H

MOV A, 61H // lower byte
ADD A, 51H
MOV 72H, A

MOV A, 60H // upper byte + carry of lower byte
ADDC A, 50H
MOV 71H, A

CLR A // carry of upper byte
ADDC A, #00H // C is a bit not byte
MOV 70H, A

END
