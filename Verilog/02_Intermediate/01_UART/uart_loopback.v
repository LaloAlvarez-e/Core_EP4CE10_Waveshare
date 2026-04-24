//============================================================================
// UART Loopback — Verilog (top-level)
//
// Description : Echoes every received byte back to the transmitter.
//               Connect with any serial terminal at 115200-8-N-1.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module uart_loopback (
    input  wire clk,    // 50 MHz system clock
    input  wire rst_n,  // active-low reset (KEY0)
    input  wire rx,     // UART RX (PIN_2)
    output wire tx      // UART TX (PIN_1)
);

    wire [7:0] data;
    wire       valid;
    wire       busy;

    uart_rx #(
        .CLK_FREQ (50_000_000),
        .BAUD_RATE(115_200)
    ) u_rx (
        .clk     (clk),
        .rst_n   (rst_n),
        .rx      (rx),
        .rx_data (data),
        .rx_valid(valid)
    );

    uart_tx #(
        .CLK_FREQ (50_000_000),
        .BAUD_RATE(115_200)
    ) u_tx (
        .clk     (clk),
        .rst_n   (rst_n),
        .tx_data (data),
        .tx_start(valid & ~busy),
        .tx      (tx),
        .tx_busy (busy)
    );

endmodule
