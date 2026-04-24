# 04 – Seven-Segment Display

Displays a 4-bit BCD digit (0–9) on a single 7-segment display digit using
a combinational decoder.

## Pin Assignments (Core EP4CE10)

| Signal     | FPGA Pin | Direction | Description               |
|------------|----------|-----------|---------------------------|
| `clk`      | PIN_23   | Input     | 50 MHz system clock       |
| `hex[0]`   | PIN_128  | Output    | Segment a                 |
| `hex[1]`   | PIN_121  | Output    | Segment b                 |
| `hex[2]`   | PIN_125  | Output    | Segment c                 |
| `hex[3]`   | PIN_129  | Output    | Segment d                 |
| `hex[4]`   | PIN_132  | Output    | Segment e                 |
| `hex[5]`   | PIN_126  | Output    | Segment f                 |
| `hex[6]`   | PIN_124  | Output    | Segment g                 |
| `digit_sel[0]` | PIN_133 | Output | Digit select 0 (active-low) |
| `digit_sel[1]` | PIN_135 | Output | Digit select 1 (active-low) |
| `digit_sel[2]` | PIN_136 | Output | Digit select 2 (active-low) |
| `digit_sel[3]` | PIN_137 | Output | Digit select 3 (active-low) |
| `digit_sel[4]` | PIN_138 | Output | Digit select 4 (active-low) |
| `digit_sel[5]` | PIN_139 | Output | Digit select 5 (active-low) |

## Description

A 4-bit counter (BCD) drives a combinational 7-segment decoder.  
Multiplexing cycles through all 6 digits using a prescaler to produce a
flicker-free display at ~1 kHz refresh rate.  
Segments and digit selects are **active-low**.

### Segment Mapping

```
 _
|_|
|_|

Bit:  6 5 4 3 2 1 0
Seg:  g f e d c b a
```
