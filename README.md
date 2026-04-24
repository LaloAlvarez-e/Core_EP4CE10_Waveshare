# Core_EP4CE10_Waveshare

FPGA hardware description programs for the **Waveshare Core EP4CE10** development board, featuring the **Intel (Altera) Cyclone IV EP4CE10** FPGA.  Programs are written in both **Verilog** and **VHDL** using **Intel Quartus Prime**.

---

## Board Overview

| Feature | Details |
|---|---|
| FPGA | Intel Cyclone IV EP4CE10E22C8N |
| Logic Elements | 10,320 LEs |
| Clock | 50 MHz on-board oscillator |
| LEDs | 10 user LEDs |
| Push-buttons | 4 user keys |
| 7-Segment displays | 6-digit multiplexed |
| UART | USB-UART bridge |
| VGA | 15-pin D-sub connector |
| SDRAM | 32 MB |
| GPIO | 2 × 40-pin expansion headers |

---

## Repository Structure

```
Core_EP4CE10_Waveshare/
├── 01_Basics/
│   ├── 01_LED_Blink/          # Toggle an LED using the system clock
│   ├── 02_Button_LED/         # Control an LED with a push-button
│   ├── 03_Counter/            # N-bit binary counter with LED output
│   └── 04_Seven_Segment/      # Drive a 7-segment display
├── 02_Intermediate/
│   ├── 01_UART/               # UART transmitter / receiver
│   ├── 02_PWM/                # Pulse-Width Modulation generator
│   └── 03_VGA/                # VGA signal generator (640×480 @ 60 Hz)
└── 03_Advanced/               # (Planned) DSP and image-processing cores
```

Each project folder contains:
- `Verilog/` — `.v` source files
- `VHDL/`    — `.vhd` source files
- `README.md` — pin assignments and usage notes

---

## Getting Started

1. Install **Intel Quartus Prime** (Lite edition is free and sufficient).
2. Open Quartus, create a new project, and set the target device to **EP4CE10E22C8N**.
3. Add the `.v` or `.vhd` source file from the desired project folder.
4. Apply the pin assignments from the project `README.md`.
5. Compile and download the bitstream via the USB-Blaster programmer.

---

## Roadmap

- [x] Basic I/O (LEDs, buttons, 7-segment displays)
- [x] Serial communication (UART)
- [x] PWM and motor control
- [x] VGA display output
- [ ] SDRAM interface
- [ ] Digital Signal Processing (FIR/IIR filters, FFT)
- [ ] Digital Image Processing (edge detection, convolution)

---

## License

This project is released under the [MIT License](LICENSE).
