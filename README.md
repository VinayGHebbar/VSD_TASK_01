 Verilog Implementation Report: Blue LED Blinking on VSDSquadron FPGA Mini

 Objective

To understand, document, and implement the Verilog code that drives the blue LED on the VSDSquadron FPGA Mini using the internal oscillator, a frequency counter, and appropriate pin mappings via the PCF file.

Step 1: Understanding the Verilog Code

## GitHub Link to Code

Verilog Code on GitHub

## Module Ports

• input hw_clk: Hardware oscillator input.  
• output led_red, led_green, led_blue: Outputs to control RGB LED.  
• output testwire: Test output.

## Key Components in Code

• SB_HFOSC: Instantiates a high-frequency internal oscillator (~48 MHz).  
• counter: 26-bit counter that increments on each rising clock edge.

## LED logic

\`\`\`verilog  
assign led_blue = counter\[25\]; // Blinks blue LED based on MSB  
assign led_red = 0;  
assign led_green = 0; // Only the blue LED blinks. Red and green are off.  
\`\`\`

#  Step 2: PCF File and Pin Mapping

## GitHub Link to PCF File

PCF File on GitHub

## Pin Assignments

Signal | FPGA Pin  
\--------|----------  
led_red | 39  
led_blue| 40  
led_green| 41  
hw_clk | 20  
testwire| 17  

These pins correspond to the RGB LED and oscillator clock input as per the VSDSquadron FPGA Mini board’s datasheet.

# 🛠 Step 3: Toolchain and Flashing

## Required Tools Installed

• yosys: Synthesizes the Verilog code.  
• nextpnr-ice40: Places and routes design.  
• icepack, icetime: Converts to binary and checks timing.  
• iceprog: Flashes .bin file to the FPGA board.

## Build & Flash Commands

\`\`\`bash  
make clean  
make build  
sudo make flash  
\`\`\`

Outcome: Blue LED blinks visibly.

## Timing report

6.29 ns (159.10 MHz estimate).

Flashing was successful once FTDI USB connection was detected and VM USB passthrough was set correctly.

#  Observations

• Blinking pattern is based on counter\[25\], which toggles approximately once every 0.67 seconds (assuming ~48MHz clock).  
• The FPGA internal oscillator was successfully utilized without requiring external clocks.  
• testwire can be used for debugging or scope probing.

# Final Files

• top.v: Verilog source file.  
• VSDSquadronFM.pcf: Physical constraints file.  
• Makefile: Build and flashing automation.

#  Contact Information

Author: Vinay G Hebber  
Email: <vinayghebbar@gmail.com>

#  License

This project is licensed under the MIT License - see the LICENSE file for details.

#  Project Demonstration

Click the link below to view the output demonstration video:  
▶ \[Watch Demo on Google Drive\](<https://drive.google.com/drive/folders/1ESlpbtCvimwV5oFMvRNM5W1NDFtUdzI3>)
