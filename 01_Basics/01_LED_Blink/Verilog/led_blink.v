//============================================================================
// LED Blink — Verilog
//
// Description : Blinks all 10 on-board LEDs at ~0.75 Hz by dividing the
//               50 MHz system clock with a 26-bit counter.
//               LEDs are active-low on the Core EP4CE10 board.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module led_blink (
    input  wire        clk,     // 50 MHz system clock
    output wire [9:0]  led      // 10 user LEDs (active-low)
);

    // 26-bit counter — MSB toggles at ~0.75 Hz
    reg [25:0] counter;

    always @(posedge clk) begin
        counter <= counter + 1'b1;
    end

    // Drive all LEDs from the MSB (active-low: invert the bit)
    assign led = {10{~counter[25]}};

endmodule
