//============================================================================
// Counter — Verilog
//
// Description : Parameterisable N-bit binary up-counter displayed on LEDs.
//               A 26-bit prescaler slows the 50 MHz clock to ~1.49 Hz so
//               the count is visible. rst_n is active-low (KEY0).
//               LEDs are active-low.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module counter #(
    parameter N = 10  // number of counter bits shown on LEDs
)(
    input  wire        clk,    // 50 MHz system clock
    input  wire        rst_n,  // active-low reset (KEY0)
    output wire [N-1:0] led    // N LEDs (active-low)
);

    localparam PRESCALER_BITS = 26;

    reg [PRESCALER_BITS-1:0] prescaler;
    reg [N-1:0]              count;

    wire tick = (prescaler == {PRESCALER_BITS{1'b1}});

    always @(posedge clk) begin
        if (!rst_n) begin
            prescaler <= {PRESCALER_BITS{1'b0}};
            count     <= {N{1'b0}};
        end else begin
            prescaler <= prescaler + 1'b1;
            if (tick)
                count <= count + 1'b1;
        end
    end

    // LEDs are active-low: invert the count bits
    assign led = ~count;

endmodule
