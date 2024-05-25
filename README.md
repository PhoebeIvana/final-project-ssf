# Smart Trash Bin Project

## Table of Contents
- [Introduction](#introduction)
- [Components](#components)
- [Hardware Setup](#hardware-setup)
- [Software Setup](#software-setup)
- [Arduino Code](#arduino-code)
- [Conclusion](#conclusion)

## Introduction
This project involves creating a smart trash bin that automatically opens and closes using an IR sensor. It also measures the fill level of the bin using an Ultrasonic sensor and provides visual feedback using 7 segment display. Additionally, it measures the weight of the trash using an piezo sensor module and provides visual feedback using LCD 16x2. The system uses two Arduino boards communicating via I2C protocol: one Arduino handles sensor readings and weight measurement, and the other controls the motor, display distance from ultrasonic sensor, and LEDs.

## Components
### Sensors
- Ultrasonic sensor
- IR sensor
- Piezo sensor

### Actuators
- motor DC with l298n motor drivers
- 3 LEDs

### Others
- 2 Arduino boards
- I2C communication wires
- Breadboard and jumper wires
- Power supply
- Trash bin

## Hardware Setup

### Ultrasonic Sensor
- VCC to 5V
- GND to GND
- Trig to Digital Pin 9
- Echo to Digital Pin 10

### IR Sensor
- VCC to 5V
- GND to GND
- Signal to Analog Pin A0

### HX711 Weight Sensor Module
- VCC to 5V
- GND to GND
- DT to Digital Pin 3
- SCK to Digital Pin 2

### Servo Motor
- VCC to 5V
- GND to GND
- Signal to Digital Pin 6

### LEDs
- Connect 5 LEDs in series with 220-ohm resistors
- LED1 to Digital Pin 7
- LED2 to Digital Pin 8
- LED3 to Digital Pin 11
- LED4 to Digital Pin 12
- LED5 to Digital Pin 13

### Arduino Boards
- Master Arduino (handles sensors)
- Slave Arduino (handles actuators)

### I2C Communication
- SDA (A4 on both Arduinos)
- SCL (A5 on both Arduinos)

## Software Setup
1. **Install Arduino IDE**: Download and install the Arduino IDE from the [official website](https://www.arduino.cc/en/software).
2. **Install Libraries**:
   - `Wire` library for I2C communication.
   - `HX711` library for the weight sensor.

### Arduino Code

#### Master Arduino Code (Sensor Readings)


#### Slave Arduino Code (Actuators Control)


## Conclusion
This project will demonstrates the integration of multiple sensors and actuators using two Arduino boards and I2C communication. The smart trash bin opens and closes based on the distance measured by the ultrasonic sensor, indicates the fill level with LEDs using the IR sensor, and measures the weight of the trash using the HX711 weight sensor. This project can be expanded and refined for various practical applications, including waste management systems and smart home automation.
