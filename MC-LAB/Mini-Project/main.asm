ORG 0000H
LJMP MAIN
ORG 000BH
LJMP TFZERO

MAIN:

// data to put in TH0 and TL0
MOV 30H, #0FEH // zero position - 500 us
MOV 31H, #33H
MOV 32H, #0C0H // idle time - 17600 us
MOV 33H, #0A4H
MOV 34H, #0F9H // 180 - zero - 1900 us
MOV 35H, #29H
MOV 36H, #00H // pwm HIGH time
MOV 37H, #00H
MOV 38H, #00H // pwm LOW time
MOV 39H, #00H
MOV 3AH, #00H // adc 8 bit input
MOV 3BH, #07 // f*[180-0]/12*255

CLR P3.4 // output PWM
CLR 00H // HIGH done
CLR 01H // LOW done
CLR 02H // IDLE done

// configure timer 0
MOV TMOD, #01H // timer 0 mode 1
SETB IE.1 // enable timer 0 interrupt
SETB IE.7 // enable all interrupt
MOV TH0, 30H
MOV TL0, 31H
SETB P3.4
SETB TR0 // start the timer

LJMP LOOP

//////////
// load timer and set output level
//////////

TFZERO: JB 00H, TFZEROLOW
	MOV TH0, 36H // HIGH
	MOV TL0, 37H
	SETB 00H
	SETB P3.4
	RETI
	TFZEROLOW: JB 01H, TFZEROIDLE
	MOV TH0, 38H // LOW
	MOV TL0, 39H
	SETB 01H
	CLR P3.4
	RETI
	TFZEROIDLE: JB 02H, TFZEROEND
	MOV TH0, 32H // IDLE
	MOV TL0, 33H
	SETB 02H
	CLR P3.4
	RETI
	TFZEROEND:
	MOV TH0, 30H // next initial HIGH
	MOV TL0, 31H
	CLR 00H // HIGH done
	CLR 01H // LOW done
	CLR 02H // IDLE done
	SETB P3.4
	RETI

LOOP: ACALL SAMPLEADC
ACALL CALCULATEDELAY
SJMP LOOP

SAMPLEADC: RET

//////////
// calculate timer values from adc
//////////

CALCULATEDELAY: MOV A, 3AH // load ADC input into A
MOV B, 3BH // load multiplier into B
CLR C
MUL AB
MOV 37H, A // store low byte
MOV 36H, B // store high byte

// 65536 - number => 2's compliment of number
MOV A, 37H // low byte
CPL A // one's complement
ADD A, #01H // +1 ? two's complement of low byte
MOV 37H, A

MOV A, 36H // high byte
CPL A // one's complement
ADDC A, #00H // add carry-out from the low byte step
MOV 36H, A

// calculate low pulse

MOV A, #0FFH
CLR C
SUBB A, 3AH
MOV B, 3BH // load multiplier into B
CLR C
MUL AB
MOV 39H, A // store low byte
MOV 38H, B // store high byte

MOV A, 39H // low byte
CPL A // one's complement
ADD A, #01H // +1 ? two's complement of low byte
MOV 39H, A

MOV A, 38H // high byte
CPL A // one's complement
ADDC A, #00H // add carry-out from the low byte step
MOV 38H, A

RET

END
