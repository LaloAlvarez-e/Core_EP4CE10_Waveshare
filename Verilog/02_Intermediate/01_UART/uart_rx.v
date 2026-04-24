//============================================================================
// UART Receiver — Verilog
//
// Description : 8-N-1 UART receiver.
//               rx_valid pulses high for one clock cycle when a new byte
//               has been received in rx_data.
//
// Parameters  : CLK_FREQ  — system clock frequency in Hz (default 50 MHz)
//               BAUD_RATE — baud rate in bps (default 115200)
//
// Board       : Waveshare Core EP4CE10
//============================================================================

module uart_rx #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 115_200
)(
    input  wire       clk,      // system clock
    input  wire       rst_n,    // active-low reset
    input  wire       rx,       // UART RX line
    output reg  [7:0] rx_data,  // received byte
    output reg        rx_valid  // pulses high for one cycle when byte ready
);

    localparam CLKS_PER_BIT  = CLK_FREQ / BAUD_RATE;
    localparam HALF_BIT      = CLKS_PER_BIT / 2;

    localparam IDLE  = 2'd0,
               START = 2'd1,
               DATA  = 2'd2,
               STOP  = 2'd3;

    // Two-stage synchroniser for RX input
    reg rx_sync1, rx_sync2;
    always @(posedge clk) begin
        rx_sync1 <= rx;
        rx_sync2 <= rx_sync1;
    end

    reg [1:0]  state;
    reg [15:0] baud_cnt;
    reg [2:0]  bit_idx;
    reg [7:0]  shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= IDLE;
            rx_valid <= 1'b0;
            baud_cnt <= 16'd0;
            bit_idx  <= 3'd0;
            shift_reg<= 8'd0;
            rx_data  <= 8'd0;
        end else begin
            rx_valid <= 1'b0;

            case (state)

                IDLE: begin
                    if (!rx_sync2) begin    // falling edge = start bit
                        baud_cnt <= 16'd0;
                        state    <= START;
                    end
                end

                START: begin
                    // Sample in the middle of the start bit
                    if (baud_cnt == HALF_BIT - 1) begin
                        if (!rx_sync2) begin
                            baud_cnt <= 16'd0;
                            bit_idx  <= 3'd0;
                            state    <= DATA;
                        end else
                            state <= IDLE;  // false start
                    end else
                        baud_cnt <= baud_cnt + 1'b1;
                end

                DATA: begin
                    if (baud_cnt == CLKS_PER_BIT - 1) begin
                        baud_cnt              <= 16'd0;
                        shift_reg[bit_idx]    <= rx_sync2;
                        if (bit_idx == 3'd7)
                            state <= STOP;
                        else
                            bit_idx <= bit_idx + 1'b1;
                    end else
                        baud_cnt <= baud_cnt + 1'b1;
                end

                STOP: begin
                    if (baud_cnt == CLKS_PER_BIT - 1) begin
                        if (rx_sync2) begin  // valid stop bit
                            rx_data  <= shift_reg;
                            rx_valid <= 1'b1;
                        end
                        baud_cnt <= 16'd0;
                        state    <= IDLE;
                    end else
                        baud_cnt <= baud_cnt + 1'b1;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
