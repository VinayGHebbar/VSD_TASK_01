# Real-Time Sensor Data Transmission via UART using VSD SQUIDRON FPGA Mini

## 🎯 Project Objective

This project aims to design a functional UART transmitter on the VSD SQUIDRON FPGA Mini to send live sensor readings through a serial connection. The goal is to enable seamless communication between the FPGA and external systems using the standard UART protocol.

---

## 📘 1. Understanding the Existing Design

### 🔍 Module Breakdown

This implementation involves two essential Verilog modules:

- **`top`**: Acts as the central integration unit, handling clock signals, UART interface, and basic LED indicators.
- **`uart_tx_8n1`**: Handles the UART transmission mechanism using the 8N1 configuration — 8 data bits, no parity bit, and 1 stop bit.

### 🧠 Design Overview

#### Key Functionalities:
- **Sensor Input Processing**
- **Baud Rate Control**
- **UART Signal Generation**
- **State Machine for Byte-Level Control**

---

## 🧱 2. System Architecture

### 📊 Block Diagram

![Block Diagram](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_tx_sense/blockdiagramuart.jpg)

### 🧾 ASCII Schematic

![Circuit Diagram](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_tx_sense/cicruitdiagram.png)

---

## 🛠️ 3. Synthesis & Deployment

### 📂 Repository Setup

Clone the repository and navigate to the project folder:

```bash
git clone https://github.com/vinaysubramanya/VSDSQUADRON.git
cd vsd_squadron_minifpga_4/uart_tx_sense
```

### 🔧 Building the Bitstream

Compile the design files to generate the bitstream:

```bash
make build
```
This produces the `top.bin` file necessary for FPGA programming.

### 🚀 Uploading to FPGA

Flash the generated bitstream onto the VSD SQUIDRON FPGA Mini:

```bash
sudo make flash
```

### 🖥️ Serial Terminal Access

Start the UART terminal to monitor real-time data transmission:

```bash
sudo make terminal
```

---

## 📡 4. Validating UART Output

### ✅ Functional Testing

- Interact with or simulate the sensor input.
- Monitor UART output (e.g., ASCII character like `"D"`) at **9600 baud rate** via the terminal.
- Optional: Use external tools like a USB-to-Serial adapter or logic analyzer to verify UART waveform and data consistency.

---

## 🎬 Demonstration

Watch the full hardware demo here:

▶️ [Click to View Demo](https://drive.google.com/file/d/1Va9m0Ph3c5LruW6TbAxQjprSipHgXmQI/view?usp=drive_link)

---

## 📌 Notes

- This project provides a simple yet effective foundation for integrating sensors with FPGA and transmitting data to host systems.
- Designed specifically for learning, experimentation, and extension to real-world applications.
