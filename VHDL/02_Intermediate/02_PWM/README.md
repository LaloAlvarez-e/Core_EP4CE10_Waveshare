# 02 – PWM

A parameterisable **Pulse-Width Modulation** generator. The duty cycle is
controlled by a push-button which cycles through 0 %, 25 %, 50 %, 75 % and
100 %. The PWM output is connected to an LED to demonstrate the brightness
change.

## Pin Assignments (Core EP4CE10)

| Signal   | FPGA Pin | Direction | Description             |
|----------|----------|-----------|-------------------------|
| `clk`    | PIN_23   | Input     | 50 MHz system clock     |
| `rst_n`  | PIN_25   | Input     | Active-low reset (KEY0) |
| `btn`    | PIN_24   | Input     | Duty-cycle select (KEY1)|
| `pwm_out`| PIN_87   | Output    | PWM signal / LED0       |

## Description

The PWM period is `2^RESOLUTION` clock cycles.  With a resolution of 8 bits
and a 50 MHz clock the switching frequency is:

```
f_pwm = 50 000 000 / 256 ≈ 195 kHz
```

A button-press debouncer detects a rising edge on **KEY1** and increments the
duty-cycle step (each step = 25 %). The current duty cycle is visible as LED
brightness via PWM.
