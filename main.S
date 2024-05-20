.def temp = R16
.def distance = R17
.def IR_value = R18

;initialize
LDI temp,0xFF
;Output for the ultrasonic
OUT DDRD,temp
LDI temp,0x00
;Input for the ultrasonic and IR
OUT DDRC,temp

;Initialize I2C, are used to communicate (SDA and SCL)
LDI temp (1<<TWEN) || (1<<TWEA) || (1<<TWINT)
OUT TWCR, temp

;Measuring the Distance using ultrasonic
measure_distance:
;Triggering the ultrasonic (set bit to 0)
SBI PORTD,0
;Synchronizing the delayed input
NOP
CBI PORTD,0

;Waiting for the Echo
;will be skipping the next instruction if the first bit of PINC
;is low. Pin 1 == low means the echo is not happening atm
SBIC PINC,1
RJMP measure_distance

;Calculating the Echo Time 
LDI distance,0
echo_wait:
;Skip if bit in I/O is set, means if the echo
;pin is high, then we'll skip the next instruction
SBIS PINC,1
RMJP echo_end
INC distance
RJMP echo_wait

echo_end:
    RET 

;Reading IR 
read_ir:
    ;skip the next instruction if the PINC for the
    ;0th -byte is set / 1
    ;PINC0 HIGH means there's an object that's detected by
    ;the IR Sensor
    SBIS PINC,0
    ;setting the ir_value = 0, means there's no
    ;object detected
    LDI ir_value,0
    ;Because the PINC0 is HIGH, then the next 
    ;instruction wont be skipped.
    SBIC PINC,0
    ;Setting the value of ir_value = 1, means
    ;there's an object detected.
    LDI ir_value,1
    RET

main_loop:
    RCALL measure_distance
    RCALL read_ir
    LDI temp, (1 << TWSTA) | (1 << TWEN) | (1 << TWINT)
    ;Start the 'START PROCESS' in I2C bus
    OUT TWCR, temp
    ;If the operation is not done, the next
    ;instruction will be skipped.
    SBIS TWCR, TWINT
    RJMP main_loop
    ;Sending the value of distance to TWDR
    OUT TWDR, distance
    ;Starting the transmission data process
    LDI temp, (1 << TWINT) | (1 << TWEN)
    OUT TWCR, temp

    ;If the operation is not done, the next
    ;instruction will be skipped.
    SBIS TWCR, TWINT
    RJMP main_loop
    ;Sending the value of ir_value to TWDR
    OUT TWDR, ir_value
    ;Entering the 'STOP CONDITION' to end
    ;the transmission process
    LDI temp, (1 << TWINT) | (1 << TWEN) | (1 << TWSTO)
    OUT TWCR, temp

    RJMP main_loop
