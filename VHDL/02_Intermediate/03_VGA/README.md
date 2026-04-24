# 03 – VGA

Generates a **640×480 @ 60 Hz** VGA signal and fills the screen with a
colour-bar test pattern.

## Pin Assignments (Core EP4CE10)

| Signal    | FPGA Pin | Direction | Description           |
|-----------|----------|-----------|-----------------------|
| `clk`     | PIN_23   | Input     | 50 MHz system clock   |
| `rst_n`   | PIN_25   | Input     | Active-low reset      |
| `vga_r[0]`| PIN_106  | Output    | Red bit 0             |
| `vga_r[1]`| PIN_105  | Output    | Red bit 1             |
| `vga_r[2]`| PIN_104  | Output    | Red bit 2             |
| `vga_g[0]`| PIN_103  | Output    | Green bit 0           |
| `vga_g[1]`| PIN_101  | Output    | Green bit 1           |
| `vga_g[2]`| PIN_100  | Output    | Green bit 2           |
| `vga_b[0]`| PIN_99   | Output    | Blue bit 0            |
| `vga_b[1]`| PIN_98   | Output    | Blue bit 1            |
| `vga_hs`  | PIN_113  | Output    | Horizontal sync       |
| `vga_vs`  | PIN_112  | Output    | Vertical sync         |

## VGA Timing (640×480 @ 60 Hz)

A **25.175 MHz** pixel clock is required.  This design uses the 50 MHz
on-board clock divided by 2 (25 MHz), which is close enough for most monitors.

| Parameter        | Value |
|------------------|-------|
| Pixel clock      | 25 MHz (approx.) |
| H active pixels  | 640   |
| H front porch    | 16    |
| H sync pulse     | 96    |
| H back porch     | 48    |
| H total          | 800   |
| V active lines   | 480   |
| V front porch    | 10    |
| V sync pulse     | 2     |
| V back porch     | 33    |
| V total          | 525   |

## Description

The design generates standard **HSYNC** and **VSYNC** pulses (both
active-low) and outputs an 8-colour bar test pattern during the active
display area.  Pixel data is blanked outside the active area.
