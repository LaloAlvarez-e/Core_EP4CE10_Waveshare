//============================================================================
// UART Transmitter — Verilog
//
// Description : 8-N-1 UART transmitter.
//               Asserts tx_busy while transmitting.
//               Transmission starts on the rising edge of tx_start.
//
// Parameters  : CLK_FREQ  — system clock frequency in Hz (default 50 MHz)
//               BAUD_RATE — baud rate in bps (default 115200)
//
// Board       : Waveshare Core EP4CE10
//============================================================================

module uart_tx #(
    parameter CLK_FREQ  = 50_000_000,
    parameter BAUD_RATE = 115_200
)(
    input  wire       clk,       // system clock
    input  wire       rst_n,     // active-low reset
    input  wire [7:0] tx_data,   // byte to transmit
    input  wire       tx_start,  // pulse high for one cycle to start TX
    output reg        tx,        // UART TX line (idle high)
    output reg        tx_busy    // high while transmitting
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    localparam IDLE  = 2'd0,
               START = 2'd1,
               DATA  = 2'd2,
               STOP  = 2'd3;

    reg [1:0]  state;
    reg [15:0] baud_cnt;
    reg [2:0]  bit_idx;
    reg [7:0]  shift_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state    <= IDLE;
            tx       <= 1'b1;
            tx_busy  <= 1'b0;
            baud_cnt <= 16'd0;
            bit_idx  <= 3'd0;
            shift_reg<= 8'd0;
        end else begin
            case (state)

                IDLE: begin
                    tx      <= 1'b1;
                    tx_busy <= 1'b0;
                    if (tx_start) begin
                        shift_reg <= tx_data;
                        baud_cnt  <= 16'd0;
                        tx_busy   <= 1'b1;
                        state     <= START;
                    end
                end

                START: begin
                    tx <= 1'b0;             // start bit
                    if (baud_cnt == CLKS_PER_BIT - 1) begin
                        baud_cnt <= 16'd0;
                        bit_idx  <= 3'd0;
                        state    <= DATA;
                    end else
                        baud_cnt <= baud_cnt + 1'b1;
                end

                DATA: begin
                    tx <= shift_reg[bit_idx];
                    if (baud_cnt == CLKS_PER_BIT - 1) begin
                        baud_cnt <= 16'd0;
                        if (bit_idx == 3'd7) begin
                            state <= STOP;
                        end else
                            bit_idx <= bit_idx + 1'b1;
                    end else
                        baud_cnt <= baud_cnt + 1'b1;
                end

                STOP: begin
                    tx <= 1'b1;             // stop bit
                    if (baud_cnt == CLKS_PER_BIT - 1) begin
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
