//============================================================================
// Seven-Segment Display — Verilog
//
// Description : Drives a 6-digit multiplexed 7-segment display. A BCD
//               counter (0-9) is shown on all six digits simultaneously.
//               Segments and digit selects are active-low.
//               Multiplexing frequency: 50e6 / 2^16 ≈ 763 Hz per digit.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module seven_segment (
    input  wire        clk,         // 50 MHz system clock
    output reg  [6:0]  hex,         // 7-segment segments a-g (active-low)
    output reg  [5:0]  digit_sel    // digit select lines (active-low)
);

    // -----------------------------------------------------------------------
    // Slow counter: upper bits select the active digit, lower bits are BCD
    // -----------------------------------------------------------------------
    reg [25:0] slow_cnt;

    always @(posedge clk)
        slow_cnt <= slow_cnt + 1'b1;

    // BCD digit 0-9 cycling every ~0.67 s
    reg [3:0] bcd;

    always @(posedge clk) begin
        if (slow_cnt == 26'd49_999_999)
            bcd <= (bcd == 4'd9) ? 4'd0 : bcd + 1'b1;
    end

    // -----------------------------------------------------------------------
    // Multiplexer: cycle through 6 digits at ~763 Hz
    // -----------------------------------------------------------------------
    wire [2:0] digit_idx = slow_cnt[18:16];

    always @(*) begin
        digit_sel = 6'b111111;           // all off
        case (digit_idx)
            3'd0: digit_sel = 6'b111110;
            3'd1: digit_sel = 6'b111101;
            3'd2: digit_sel = 6'b111011;
            3'd3: digit_sel = 6'b110111;
            3'd4: digit_sel = 6'b101111;
            3'd5: digit_sel = 6'b011111;
            default: digit_sel = 6'b111111;
        endcase
    end

    // -----------------------------------------------------------------------
    // BCD to 7-segment decoder (active-low: 0 = segment on)
    // Segment order: {g, f, e, d, c, b, a}
    // -----------------------------------------------------------------------
    always @(*) begin
        case (bcd)
            4'd0: hex = 7'b100_0000;  // 0
            4'd1: hex = 7'b111_1001;  // 1
            4'd2: hex = 7'b010_0100;  // 2
            4'd3: hex = 7'b011_0000;  // 3
            4'd4: hex = 7'b001_1001;  // 4
            4'd5: hex = 7'b001_0010;  // 5
            4'd6: hex = 7'b000_0010;  // 6
            4'd7: hex = 7'b111_1000;  // 7
            4'd8: hex = 7'b000_0000;  // 8
            4'd9: hex = 7'b001_0000;  // 9
            default: hex = 7'b111_1111; // all off
        endcase
    end

endmodule
