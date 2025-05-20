
# VSDSQUADRON FPGA Projects

Welcome to the **VSDsquadron_FPGA_Project** repository — a curated collection of hardware design projects tailored for the **VSDSquadron FPGA Mini** board. These projects span basic digital logic to serial communication protocols, providing hands-on exposure to real-world FPGA applications.

---

## 📁 Directory Overview

- **Task_one/** – Simple blue LED control projects to demonstrate GPIO usage.
- **Task_two/** – RGB LED-based experiments showing multi-color actuator control.
- **Task_three/** – Loopback tests to validate UART receiver-transmitter integrity.
- **Task_four/** – Verilog implementations for UART transmission modules.
- **Task_five/** – Combines sensor data input with UART TX for live data streaming.

---

## 🚀 Quick Start Guide

To run or modify any project from this repository:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/VinayGHebbar/VSDsquadron_FPGA.git
   cd VSDSQUADRON
   ```

2. **Navigate to a Specific Project**
   ```bash
   cd RGB_TASK5  # Replace with the project directory of your choice
   ```

3. **Build the Project using Make**
   ```bash
   make
   ```

4. **Upload the Bitstream to FPGA**
   Use a supported toolchain such as `iceprog` to flash the design onto your VSDSquadron FPGA Mini.

---

## 🧰 Requirements

- VSDSquadron Mini FPGA board
- USB-to-serial interface (if required)
- Serial terminal software (e.g., `minicom`, `screen`)
- FPGA development toolchain: Yosys, nextpnr, icestorm

---

## 👨‍💻 Maintainer

**Vinay G Hebbar**  
📧 vinayghebbar@gmail.com  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/vinay-g-hebbar-5560a9280/)

---

## 📄 License

Distributed under the **MIT License**. Feel free to use, share, and adapt the code with proper attribution.

