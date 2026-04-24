# 03 – Counter

A parameterisable N-bit binary up-counter whose value is displayed on the
on-board LEDs. Includes a synchronous reset driven by a push-button.

## Pin Assignments (Core EP4CE10)

| Signal     | FPGA Pin | Direction |
|------------|----------|-----------|
| `clk`      | PIN_23   | Input     |
| `rst_n`    | PIN_25   | Input     |
| `led[0]`   | PIN_87   | Output    |
| `led[1]`   | PIN_86   | Output    |
| `led[2]`   | PIN_85   | Output    |
| `led[3]`   | PIN_84   | Output    |
| `led[4]`   | PIN_83   | Output    |
| `led[5]`   | PIN_80   | Output    |
| `led[6]`   | PIN_77   | Output    |
| `led[7]`   | PIN_76   | Output    |
| `led[8]`   | PIN_75   | Output    |
| `led[9]`   | PIN_74   | Output    |

## Description

A 26-bit prescaler divides the 50 MHz clock down to ~1.49 Hz.  
The lower 10 bits of the counter are displayed on the LEDs (active-low).  
Hold **KEY0** (PIN_25) to hold the counter at zero.
