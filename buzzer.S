; Assembly Code
;---------------
#define __SFR_OFFSET 0x00
#include "avr/io.h"
;------------------------
.global main
;------------------------

main:
  SBI DDRB, 4         ; Set PB4 (LED) as output
  CBI DDRD, 2         ; Set PD2 (IR sensor) as input

btnPressed:
  SBIC PIND, 2        ; Check if IR sensor is reading something
  RJMP MotorOn        ; If yes, go to MotorOn
  RJMP btnPressed     ; If not, keep checking

MotorOn:
  SBI PORTB, 4        ; Turn on LED
  RCALL delay_timer1  ; Delay for 2 seconds
  RJMP btnPressed     ; Go back to checking IR sensor

delay_timer1:             ;2 sec delay via timer1
    ;-------------------------------------------------------
.EQU value, 34285         ;value to give 2 sec delay
    LDI   R20, hi8(value)
    STS   TCNT1H, R20
    LDI   R20, lo8(value)
    STS   TCNT1L, R20     ;initialize counter TCNT1 = value
    ;-------------------------------------------------------
    LDI   R20, 0b00000000
    STS   TCCR1A, R20
    LDI   R20, 0b00000101
    STS   TCCR1B, R20     ;normal mode, prescaler = 1024
    ;-------------------------------------------------------
l2: IN    R20, TIFR1      ;get TIFR1 byte & check
    SBRS  R20, TOV1       ;if TOV1=1, skip next instruction
    RJMP  l2              ;else, loop back & check TOV1 flag
    ;-------------------------------------------------------
    LDI   R20, 1<<TOV1
    OUT   TIFR1, R20      ;clear TOV1 flag
    ;-------------------------------------------------------
    LDI   R20, 0b00000000
    STS   TCCR1B, R20     ;stop timer1
    RET

    