# Traffic Light Control System 🚦
This repository contains the design files for a digital traffic light control system. The system is designed to manage the flow of traffic at an intersection, likely implemented using a hardware description language (HDL) for a field-programmable gate array (FPGA).
# Project Overview
The project simulates a two-way traffic intersection with signals for both North-South and East-West directions. The system includes a countdown timer and logic for controlling the red, yellow, and green lights.
<img width="619" height="607" alt="TrafficControlSysimg" src="https://github.com/user-attachments/assets/73e3db99-ef4f-4fc2-b47c-bfc18f5e860a" />

# Key Components
* **Traffic Control Unit:** The central logic unit that determines the state of the traffic lights. How the state of the signals changes are followed as below:
  1. North-South Signal: Green (Straight & Left turn) ; East-West: Red (upto timer hits 15 seconds).
  2. North-South Signal: Yellow ; East-West: Red (upto timer hits 10 seconds).
  3. North-South Signal: Red & Green (Right turn) ; East-West: Red (upto timer hits 0 seconds).
  4. North-South Signal: Red ; East-West: Green (Straight & Left turn) (upto timer hits 15 seconds).
  5. North-South Signal: Red ; East-West: Yellow (upto timer hits 10 seconds).
  6. North-South Signal: Red; East-West: Red & Green (Right turn) (upto timer hits 0 seconds).
*  **Mod-60 Down Counter:** A timer component likely used to control the duration of each light state (e.g., 60 seconds).
* **Binary to BCD Converter:** A module to convert the binary output of the counter into a format suitable for display on a 7-segment decoder.
* **7-Segment Decoder:** A component that drives a 7-segment display to show the countdown timer.
*  **Signal Logic:** Separate logic for controlling the North-South and East-West traffic signals, including red, yellow, and green lights.
<img width="501" height="485" alt="TrafficControlSysRTLimg" src="https://github.com/user-attachments/assets/eb673ec0-caf3-4dc1-beb5-25bb03fbfb05" />
<img width="1061" height="223" alt="TrafficControlSimulationWaveform" src="https://github.com/user-attachments/assets/f2ae044f-c76c-4b6e-bafa-f1305b149b83" />


# Simulation (Visually)
The system is built up from the scratch using basic logic gates, flip flops and tested in time clock signal (1 hz), in Digital simulation Software (built by H. Neemann). Here's a glimpse 📽 of the working:
[screen-capture.webm](https://github.com/user-attachments/assets/6f4e76b3-3bee-4af3-bf9b-01813d1e30f3)
