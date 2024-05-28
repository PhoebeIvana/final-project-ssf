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

### Piezo Weight Sensor Module
- VCC to 5V
- GND to GND
- PZ to Analog Pin 0

### Motor DC
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
   - `PiezoElectric` library for the weight sensor.

## i. Introduction to the problem and the solution
Pertumbuhan populasi yang cepat dan urbanisasi pesat telah menyebabkan peningkatan volume sampah secara signifikan di kota-kota besar. Pengelolaan sampah konvensional menjadi semakin tidak memadai dengan meningkatnya jumlah penduduk dan ekspansi perkotaan. Metode pengelolaan yang kurang efektif dapat menyebabkan dampak lingkungan serius, seperti pencemaran sumber air, tanah, dan udara, yang mengancam kesehatan manusia dan ekosistem. Oleh karena itu, diperlukan solusi teknologi yang inovatif untuk mengelola sampah secara lebih berkelanjutan. Penerapan teknologi modern dalam sistem pengelolaan sampah, seperti sensor cerdas dan alat pemantauan otomatis, menjadi sangat penting untuk meningkatkan efisiensi dan efektivitas pengelolaan sampah.

Proyek "Smart Trash Bin" dikembangkan untuk mengatasi masalah pengelolaan sampah di perkotaan dengan menggunakan teknologi modern. Sistem ini menggabungkan sensor ultrasonik dan inframerah, indikator LED, serta tampilan LCD. Dua Arduino terhubung melalui I2C, di mana satu membaca data dari sensor dan yang lainnya mengendalikan motor, menampilkan data di LCD, dan mengoperasikan indikator LED. Sensor ultrasonik mendeteksi tingkat sampah dengan akurat dan sensor inframerah mendeteksi jarak, sementara LCD menampilkan status sampah secara real-time. Indikator LED memberikan indikasi visual tentang status pengisian tong sampah, dan tutup otomatis yang dikendalikan motor membuka dan menutup berdasarkan pembacaan sensor, meningkatkan kebersihan dan kenyamanan. Sistem ini dirancang hemat energi dengan komponen yang optimal untuk kinerja jangka panjang. Dengan solusi ini, pengelolaan sampah di perkotaan diharapkan menjadi lebih efisien, mengurangi dampak sampah terhadap lingkungan, dan meningkatkan kesehatan masyarakat sekitar.

## ii. Hardware design and implementation details
Smart Trash Bin memiliki beberapa fitur utama yang melibatkan sensor inframerah, sensor ultrasonik, dan sensor piezo. Sensor inframerah digunakan untuk menggerakkan motor DC yang membuka dan menutup tutup sampah saat mendeteksi keberadaan objek di dekat tong sampah, seperti kaki pengguna. Sensor ultrasonik berfungsi mengukur ketinggian sampah dengan mengirimkan dan menerima pantulan gelombang ultrasonik, memungkinkan mikrokontroler menghitung jarak antara tutup dan sampah, lalu menampilkan hasilnya pada layar. Sensor piezo digunakan untuk mendeteksi getaran setiap kali sampah dimasukkan, yang kemudian ditampilkan pada layar LCD.

## iii. Software implementation details
Smart Trash Bin menggunakan dua Arduino yang terhubung melalui protokol I2C, di mana Arduino Master mengontrol komunikasi, membaca nilai dari ADC, dan menampilkan data pada LCD, sedangkan Arduino Slave mengukur jarak dengan sensor ultrasonik HC-SR04 dan menampilkan data pada display MAX7219. Arduino Master menginisialisasi pin I/O, modul TWI, dan ADC, serta mengelola komunikasi I2C, membaca tegangan pada pin PC0, dan menampilkan hasilnya dalam format ASCII pada LCD. Arduino Slave menerima data dari Master, mengukur jarak tutup ke bawah tong sampah, dan menampilkan hasilnya dalam format desimal melalui interface SPI pada MAX7219. Kedua Arduino bekerja sinkron untuk memastikan tampilan dan operasi yang stabil, dengan penundaan waktu untuk pengaturan parameter dan tampilan data yang akurat.

## iv. Test results and performance evaluation
Setelah dilakukan pengujian, rangkaian Smart Trash Bin berhasil dijalankan di simulasi Proteus, namun mengalami masalah pada rangkaian aslinya. Modul MAX7219 tidak menampilkan apa-apa, dan motor tidak berfungsi stabil meskipun berjalan dengan benar di simulasi Proteus. Masalah utama pada motor adalah inkonsistensi dalam rotasi searah jarum jam dan berlawanan, yang mengakibatkan fungsi buka tutup tong sampah tidak selalu konsisten. Karena MAX7219 tidak bermasalah pada simulasi Proteus, kami mencoba menganalisa apakah perangkatnya sendiri rusak atau apakah kami melakukan kesalahan, tapi sejauh ini, display masih tidak menampilkan apapun. Di sisi lain, selain display MAX7219 yang tidak bekerja dan motor yang tidak stabil, semua bagian yang lain berhasil berjalan seperti seharusnya.

## v. Conclusion and future work
Proyek "Smart Trash Bin" telah berhasil menunjukkan potensi teknologi modern dalam mengelola sampah secara lebih efisien dan ramah lingkungan. Dengan menggabungkan sensor inframerah, ultrasonik, dan piezo serta menggunakan dua Arduino yang terhubung melalui protokol I2C, sistem ini dapat secara otomatis mendeteksi, mengukur, dan menampilkan informasi mengenai status pengisian dan berat sampah. Meskipun pengujian menunjukkan keberhasilan dalam simulasi, beberapa tantangan teknis masih perlu diatasi dalam implementasi perangkat keras asli. Untuk pekerjaan di masa depan, fokus akan diberikan pada peningkatan stabilitas dan keandalan komponen, serta penyempurnaan algoritma pengendalian motor dan komunikasi antar perangkat, serta pengembangan fitur lebih lanjut dapat meningkatkan manfaat dan aplikasi praktis dari Smart Trash Bin dalam upaya mengatasi masalah pengelolaan sampah di perkotaan.
