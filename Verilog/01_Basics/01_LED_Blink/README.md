# 01 – LED Blink

Blinks all 10 on-board LEDs at ~0.75 Hz by dividing the 50 MHz system clock.

## Pin Assignments (Core EP4CE10)

| Signal    | FPGA Pin | Direction |
|-----------|----------|-----------|
| `clk`     | PIN_23   | Input     |
| `led[0]`  | PIN_87   | Output    |
| `led[1]`  | PIN_86   | Output    |
| `led[2]`  | PIN_85   | Output    |
| `led[3]`  | PIN_84   | Output    |
| `led[4]`  | PIN_83   | Output    |
| `led[5]`  | PIN_80   | Output    |
| `led[6]`  | PIN_77   | Output    |
| `led[7]`  | PIN_76   | Output    |
| `led[8]`  | PIN_75   | Output    |
| `led[9]`  | PIN_74   | Output    |

## Description

A 26-bit counter increments on every rising clock edge.  
The MSB (bit 25) toggles at `50 000 000 / 2^26 ≈ 0.75 Hz`, giving a
visible blink. All LEDs are driven from the same bit so they blink in unison.

LEDs are **active-low** on this board (LED illuminates when the pin is `0`).
