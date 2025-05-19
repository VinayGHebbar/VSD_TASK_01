# UART Loopback using VSD Squadron Mini FPGA

## Overview

This project demonstrates a **UART (Universal Asynchronous Receiver/Transmitter) loopback** setup on the **VSD Squadron Mini FPGA**, following the **8N1 UART format**. Additionally, it includes **RGB LED control** driven by UART signals, and operates with the help of an **internal oscillator and timing logic**.

Source Code: [GitHub Repository](https://github.com/VinayGHebbar/VSD_TASK_01.git)

---

## 🔧 FPGA Interface - Port Description

| **Signal Name** | **Direction** | **Bit Width** | **Function** |
|-----------------|---------------|---------------|--------------|
| `led_red`       | Output        | 1-bit         | Controls the Red LED (active high) |
| `led_blue`      | Output        | 1-bit         | Drives the Blue LED (active high) |
| `led_green`     | Output        | 1-bit         | Activates the Green LED (active high) |
| `uarttx`        | Output        | 1-bit         | UART Transmit Line |
| `uartrx`        | Input         | 1-bit         | UART Receive Line |
| `hw_clk`        | Input         | 1-bit         | System clock source for FPGA |

---

## ⛓ Internal Building Blocks

### 1. Internal Oscillator

```verilog
SB_HFOSC #(.CLKHF_DIV("0b10")) u_SB_HFOSC (
    .CLKHFPU(1'b1),
    .CLKHFEN(1'b1),
    .CLKHF(int_osc)
);
```

- Utilizes the Lattice internal oscillator to generate a reliable system clock.
- Division factor `0b10` scales down the frequency for logic compatibility.
- Clock output: `int_osc`.

---

### 2. Timing Counter

```verilog
reg [27:0] frequency_counter_i;

always @(posedge int_osc) begin
    frequency_counter_i <= frequency_counter_i + 1;
end
```

- 28-bit counter for generating delays and time-based events.
- Increments on each internal clock edge.
- May assist in deriving baud-rate timing indirectly.

---

### 3. UART Transmission - FSM Based

```verilog
module uart_tx_8n1 (
    input wire clk,
    input wire [7:0] txbyte,
    input wire senddata,
    output reg txdone,
    output wire tx
);
```

#### FSM States:
```verilog
parameter STATE_IDLE    = 8'd0;
parameter STATE_STARTTX = 8'd1;
parameter STATE_TXING   = 8'd2;
parameter STATE_TXDONE  = 8'd3;
```

#### Description:

- `STATE_IDLE`: Waits for the send trigger.
- `STATE_STARTTX`: Transmits start bit (0).
- `STATE_TXING`: Shifts out 8-bit payload (LSB first).
- `STATE_TXDONE`: Sends stop bit (1), ends transmission.

---

### 4. UART Loopback Function

```verilog
assign uarttx = uartrx;
```

- Implements basic hardware loopback.
- Transmitted data is directly echoed to receiver pin.

---

### 5. RGB LED Control

```verilog
SB_RGBA_DRV RGB_DRIVER (
    .RGBLEDEN(1'b1),
    .RGB0PWM(uartrx),
    .RGB1PWM(uartrx),
    .RGB2PWM(uartrx),
    .CURREN(1'b1),
    .RGB0(led_green),
    .RGB1(led_blue),
    .RGB2(led_red)
);
```

- LED PWM driven by incoming UART signal.
- Fixed current values set brightness for RGB channels.

---

## 🧠 Understanding UART Loopback

**UART** is an asynchronous serial communication protocol that transmits data bit-by-bit without a separate clock line.

### Why Loopback?

- Self-verification of UART transmission.
- No external receiver hardware needed.
- Ideal for FPGA UART debug and basic functionality check.

### Loopback Concept Diagram

![UART Loopback](https://github.com/VinayGHebbar/VSD_TASK_01/blob/main/task_two/BLOCKDIAGRAM.jpg)

---

## ⚡ Circuit Overview

![Circuit Diagram](https://github.com/vinaysubramanya/VSDSQUADRON/blob/main/uart_loopback/cktdiagram.jpg)

| Component       | FPGA Pin | Role                                |
|----------------|----------|-------------------------------------|
| UART TX        | 14       | Transmit (looped to RX)             |
| UART RX        | 15       | Receives UART data                  |
| FTDI TX        | 14       | USB → UART input                    |
| FTDI RX        | 13       | UART output → USB                   |
| RGB LED Output | PWM      | Color changes based on UART input  |

---

## 🚀 Getting Started

### Clone the Project
```bash
git clone https://github.com/vinaysubramanya/VSDSQUADRON.git
cd VsdSquadron_mini_fpga_uart_loopback
```

### Build Bitstream
```bash
make build
```

### Flash to FPGA
```bash
sudo make flash
```

### Run UART Loopback Test
```bash
sudo minicom -b 9600 /dev/ttyUSB0 --echo
```

### Expected Result

| Input          | Output       |
|----------------|--------------|
| `vinay`         | `vviinnaayy`   |


---

## 📹 Demo

Watch the demo here: [Video Link]
