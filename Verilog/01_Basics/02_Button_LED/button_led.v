//============================================================================
// Button LED — Verilog
//
// Description : Illuminates an LED while the corresponding push-button is
//               pressed.  Both keys and LEDs are active-low on the board.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
//============================================================================

module button_led (
    input  wire [3:0] key,  // 4 push-buttons (active-low)
    output wire [3:0] led   // 4 LEDs (active-low)
);

    // LED follows key: button pressed (key=0) -> LED on (led=0)
    assign led = key;

endmodule
