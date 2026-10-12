ORG 0000H
LJMP MAIN

ORG 0003H // External Interrupt 0 vector
LJMP ISR_INT0

ORG 0030H
MAIN: MOV 30H, #00H // init flag byte at address 30H: 0=run, nonzero=stop
CLR P1.2
SETB IT0 // INT0 = edge-triggered (falling edge)
SETB EX0 // enable external interrupt 0
SETB EA // global interrupt enable

AGAIN:  MOV A, 30H
JNZ HALT
SETB P1.2 // HIGH phase (30% of period)
ACALL DEL150U
MOV A, 30H
JNZ HALT
CLR P1.2 // LOW phase (70% of period)
ACALL DEL350U
SJMP AGAIN

HALT: CLR P1.2 // leave pin in a defined LOW state
SJMP HALT // waveform generation halted permanently

//////////

DEL150U: MOV R7, #67
D150: DJNZ R7, D150
RET

//////////

DEL350U: MOV R7, #136
D350: DJNZ R7, D350
RET

//////////

ISR_INT0: PUSH ACC
PUSH PSW
MOV 30H, #01H // write stop signal directly to address 30H
POP PSW
POP ACC
RETI

END