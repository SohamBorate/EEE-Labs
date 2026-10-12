ORG 0000H
LJMP MAIN

ORG 0003H // External Interrupt 0 vector
LJMP INT0_ISR

ORG 000BH // Timer 0 overflow vector
LJMP TIMER0_ISR

ORG 0013H // External Interrupt 1 vector
LJMP INT1_ISR

ORG 001BH // Timer 1 overflow vector
LJMP TIMER1_ISR

ORG 0030H
MAIN: MOV TMOD, #22H // Timer0 = Mode2 (auto-reload), Timer1 = Mode2
MOV TH0, #141 // 125 us reload  (4 kHz half-period)
MOV TH1, #198 // 63 us reload (8 kHz half-period, approx)
CLR P1.6

CLR IT0 // INT0 = level-triggered
CLR IT1 // INT1 = level-triggered

MOV IP, #0AH // PX1=1, PT1=1 (high priority group)
// PX0=0, PT0=0 (low priority group)
MOV IE, #8FH // EA=1, EX0=1, ET0=1, EX1=1, ET1=1

HERE: SJMP HERE // wait here — everything else is interrupt-driven

//////////
// entered while INT0 pin is held low
INT0_ISR: CLR TR1 // make sure the 8 kHz timer is stopped
SETB TR0 // start/keep the 4 kHz timer running
RETI

//////////
// fires every 125 us while TR0=1
TIMER0_ISR: CPL P1.6 // toggle -> 250 us period -> 4 kHz
RETI // TH0 auto-reloads into TL0, no manual reload needed

//////////
// entered while INT1 pin is held low
INT1_ISR: CLR TR0 // stop the 4 kHz timer
SETB TR1 // start the 8 kHz timer
RETI

//////////
// fires every ~63 us while TR1=1
TIMER1_ISR: CPL P1.6 // toggle -> ~126 us period -> ~7.94 kHz
RETI

END
