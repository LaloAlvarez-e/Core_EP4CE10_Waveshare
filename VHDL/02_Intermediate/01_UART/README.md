# 01 – UART

A simple **8-N-1** UART transmitter and receiver operating at 115 200 baud
with a 50 MHz system clock.

## Pin Assignments (Core EP4CE10)

| Signal      | FPGA Pin | Direction | Description               |
|-------------|----------|-----------|---------------------------|
| `clk`       | PIN_23   | Input     | 50 MHz system clock       |
| `rst_n`     | PIN_25   | Input     | Active-low reset (KEY0)   |
| `rx`        | PIN_2    | Input     | UART RX (from PC)         |
| `tx`        | PIN_1    | Output    | UART TX (to PC)           |

## Description

The design implements a **loopback**: every byte received on `rx` is echoed
back on `tx`. This makes it easy to test with any serial terminal at
**115 200-8-N-1**.

### Baud-rate divider

```
clk_freq / baud = 50 000 000 / 115 200 ≈ 434 cycles per bit
```

### Modules

| Module        | File              | Description                   |
|---------------|-------------------|-------------------------------|
| `uart_tx`     | `uart_tx.v/.vhd`  | Serialises one byte           |
| `uart_rx`     | `uart_rx.v/.vhd`  | Deserialises one byte         |
| `uart_loopback` | `uart_loopback.v/.vhd` | Top-level echo design  |
