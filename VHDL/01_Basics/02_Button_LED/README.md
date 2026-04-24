# 02 – Button LED

Turns on a corresponding LED while a push-button is held down.  
Demonstrates reading active-low button inputs and driving active-low LED outputs.

## Pin Assignments (Core EP4CE10)

| Signal    | FPGA Pin | Direction |
|-----------|----------|-----------|
| `key[0]`  | PIN_25   | Input     |
| `key[1]`  | PIN_24   | Input     |
| `key[2]`  | PIN_14   | Input     |
| `key[3]`  | PIN_13   | Input     |
| `led[0]`  | PIN_87   | Output    |
| `led[1]`  | PIN_86   | Output    |
| `led[2]`  | PIN_85   | Output    |
| `led[3]`  | PIN_84   | Output    |

## Description

Both buttons and LEDs are **active-low** on this board.  
When a key is pressed the pin reads `0`; the corresponding LED is illuminated
by also driving its output `0`.  The design passes the inverted key value
directly to the LED so that pressing a button lights the matching LED.
