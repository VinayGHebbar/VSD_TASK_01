# UART Transmitter Module

## 1. Overview of the Existing Design

The design under analysis is implemented in Verilog and hosted on GitHub:  
🔗 [View Source Code](https://github.com/VinayGHebbar/VSD_TASK_01.git)

### Understanding the Design

#### 🔹 Top-Level Module

The `top` module serves as the main control unit for UART transmission. It combines essential components including:

- **Clock Source**: An internal 12 MHz oscillator (`SB_HFOSC`) is instantiated to act as the system clock.
- **Baud Rate Generation**: The 12 MHz clock is divided to generate a 9600 Hz signal, which matches the standard UART baud rate.
- **UART Communication**: A UART transmitter (defined in `uart_tx_8n1`) is responsible for serial data transmission in the standard 8N1 format—8 data bits, no parity, and 1 stop bit.
- **RGB LED Feedback**: LEDs are driven by the internal signals, providing a visual representation of activity in the system.

This combination enables reliable UART communication while also offering visual feedback through RGB LEDs for ease of debugging or demonstration.

#### 🔹 UART Transmission Logic (`uart_tx_8n1`)

The UART transmitter is implemented as a finite state machine (FSM) that handles serial transmission with precise timing:

- **Baud Rate Division**:  
  A counter-based method is used to derive a 9600 Hz baud clock from the 12 MHz source.

- **FSM Operation**:

  1. **IDLE**: Awaits a high signal on `senddata`. Loads data and transitions to start bit.
  2. **STARTTX**: Sends a start bit (logic low) to initiate the frame.
  3. **TXING**: Transmits the 8-bit data word LSB-first, shifting each bit sequentially.
  4. **TXDONE**: Outputs the stop bit (logic high), resets internal counters, and returns to idle.

---

## 2. System Architecture

### Block Diagram

![Block Diagram](https://github.com/VinayGHebbar/VSD_TASK_01/blob/main/task_three/block_diagram.png))

### Circuit Diagram

![Circuit Diagram](https://raw.githubusercontent.com/vinaysubramanya/VSDSQUADRON/main/uart_tx/ckt%20(1)%20(1).drawio.png)

These diagrams illustrate how the oscillator, baud generator, UART FSM, and RGB driver are interconnected to form the full system.

---

## 3. Building and Programming the FPGA

### Clone the Repository

```bash
https://github.com/VinayGHebbar/VSD_TASK_01.git
cd VSDSQUADRON/uart_tx
```

### Compile the Design

```bash
make build
```

This step compiles the Verilog design and produces the `top.bin` bitstream file.

### Flash the Bitstream

```bash
sudo make flash
```

This uploads the compiled design to the FPGA hardware.

### Test UART Output

```bash
sudo make terminal
```

You can use any terminal program (e.g., PuTTY, minicom) to view the transmitted data. Ensure the baud rate is set to 9600.

---

## 4. UART Output Demonstration

Once the FPGA is programmed, the UART transmitter starts sending the ASCII character `'D'` at 9600 baud in 8N1 format. RGB LEDs on the board give visual feedback synchronized with the internal counter, confirming operational status.

---

## 5. Demo Video

🎥 [Watch Demonstration on Google Drive](https://drive.google.com/file/d/1cDMsikjzdnfnlmxQdxnY9RZjrTezvj9C/view?usp=drive_link)

---

## Conclusion

This module presents a clean and effective UART transmission setup suitable for educational and prototype use. By using a counter-based baud rate generator and an FSM-driven transmitter, it ensures accurate and robust communication. The integration of RGB LEDs enhances the user experience by providing real-time visual feedback.

