
# UART-Controlled RGB LED System Using FPGA

A hands-on digital design project leveraging the **VSDSquadron FPGA Mini** to decode serial commands and control **RGB LEDs**, simulating actuator control for embedded automation systems.

---

## 📌 Project Summary

This project illustrates the use of an FPGA to:
- Interface with a UART communication protocol.
- Decode serial input commands.
- Drive outputs (RGB LEDs) based on the decoded data.

The implementation demonstrates control of **two RGB LEDs** responding to ASCII commands:
- `'r'` → Activates red on both LEDs (with minor output variations).
- `'g'` → Lights green on RGB1, green on RGB2.
- `'b'` → Displays blue on RGB1 and blue on RGB2.
-''y''→displays mixture red and blue on RGB1 and RGB2
-''w''→displays mixture red and green on RGB1 and RGB2
-''w''→displays mixture green and blue on RGB1 and RGB2

This is a foundational step toward UART-based actuator control in embedded and robotic systems.

---

## 🎯 Key Objectives

- Implement UART receive functionality in Verilog.
- Decode and map input commands to LED output states.
- Ensure safe GPIO manipulation from FPGA to external devices.

---

## 🛠️ System Requirements

### Hardware
- VSDSquadron FPGA Mini Board
- 2x RGB LEDs (common cathode/anode)
- Current limiting resistors (typically 220Ω)
- USB-to-UART converter (if board lacks direct USB serial support)

### Software
- Verilog HDL (for design logic)
- Yosys (synthesis tool)
- icestorm (place-and-route and programming)
- A serial terminal (e.g., `minicom`)

---

## 🧱 System Architecture

![Block Diagram](https://github.com/VinayGHebbar/VSD_TASK_01/blob/main/task_five/block%20diagram.png)

---

## 📡 UART Protocol Mapping

| Command | RGB1 Color | RGB2 Color |
|---------|------------|------------|
| `'r'`   | Red        | Red        |
| `'g'`   | Green      | Blue       |
| `'b'`   | Blue       | Red        |

> Commands must be sent as ASCII characters.

---

## 🔌 Circuit Layout

![Circuit Diagram](https://github.com/VinayGHebbar/VSD_TASK_01/blob/main/task_five/circuit%20diagram.png)

*Note: Double-check common cathode/anode configuration and resistor placement.*

---

## 🔧 Design and Implementation Notes

- UART RX module crafted using Verilog FSM.

- Internal 12 MHz oscillator enabled via `SB_HFOSC`.

- Input decoding directly controls output pins mapped to RGB LED channels.

- Design is synchronized to avoid glitches and misfiring.


### 💡 Code Sample

```verilog
if (rx_data == "r") begin
  rgb_red      <= 1;
  rgb_green    <= 0;
  rgb_blue     <= 0;
  rgb2_red_r   <= 1;
  rgb2_green_r <= 0;
  rgb2_blue_r  <= 0;
end
```

---

## 📚 Reference Sources

- [UART Design in Verilog](https://www.fpga4student.com/2017/06/uart-serial-communication-in-verilog.html)

- Lattice iCE40 Family Documentation

- Public Verilog RGB LED projects


---

## 🚀 Expansion Possibilities

- Integrate TX path for real-time feedback

- Add control for more actuators (e.g., DC motors, relays)

- Support multi-byte command protocols or instruction sets


---

## ▶️ How to Use

1. Compile and flash your bitstream using `iceprog`.

2. Open a serial terminal at **115200 baud**, 8N1 configuration.

3. Send single-character ASCII commands: `'r'`, `'g'`, `'b'`,'y'`, `'w'`, `'c'`

4. Observe RGB LEDs respond based on command mappings and along with RGB it also get mixer of two colors from the rgb with the ASCII commands y,w,c.


---

## 🎥 Demo Video

[Watch the Project in Action](https://github.com/VinayGHebbar/VSD_TASK_01/blob/main/task_five/demo_video.mp4)

---

## 👤 Author

**Vinay G Hebbar**  

📧 vinayghebbar@gmail.com

---

## 📄 License

Released under the **MIT License**. Feel free to modify and distribute.

