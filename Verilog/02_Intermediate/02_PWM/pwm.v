//============================================================================
// PWM Generator — Verilog
//
// Description : Parameterisable PWM generator with button-controlled
//               duty cycle (0 %, 25 %, 50 %, 75 %, 100 %).
//               An 8-bit counter produces ~195 kHz switching at 50 MHz.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module pwm #(
    parameter RESOLUTION = 8  // PWM resolution in bits
)(
    input  wire clk,      // 50 MHz system clock
    input  wire rst_n,    // active-low reset (KEY0)
    input  wire btn,      // active-low button to change duty cycle (KEY1)
    output wire pwm_out   // PWM output
);

    // -----------------------------------------------------------------------
    // Button debouncer (20 ms @ 50 MHz = 1 000 000 cycles)
    // -----------------------------------------------------------------------
    localparam DEBOUNCE_CNT = 20'd1_000_000;

    reg [19:0] deb_cnt;
    reg        btn_sync1, btn_sync2, btn_prev, btn_edge;

    always @(posedge clk) begin
        btn_sync1 <= btn;
        btn_sync2 <= btn_sync1;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            deb_cnt  <= 20'd0;
            btn_prev <= 1'b1;
            btn_edge <= 1'b0;
        end else begin
            btn_edge <= 1'b0;
            if (btn_sync2 != btn_prev) begin
                deb_cnt <= 20'd0;
            end else if (deb_cnt < DEBOUNCE_CNT) begin
                deb_cnt <= deb_cnt + 1'b1;
            end else begin
                // Stable state reached — detect falling edge (button press)
                if (!btn_sync2 && btn_prev)
                    btn_edge <= 1'b1;
                btn_prev <= btn_sync2;
            end
        end
    end

    // -----------------------------------------------------------------------
    // Duty-cycle selector: 0 -> 0%, 1 -> 25%, 2 -> 50%, 3 -> 75%, 4 -> 100%
    // -----------------------------------------------------------------------
    reg [2:0] duty_step;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            duty_step <= 3'd0;
        else if (btn_edge)
            duty_step <= (duty_step == 3'd4) ? 3'd0 : duty_step + 1'b1;
    end

    // Map step to compare value (8-bit resolution)
    reg [RESOLUTION-1:0] threshold;

    always @(*) begin
        case (duty_step)
            3'd0: threshold = {RESOLUTION{1'b0}};          // 0 %
            3'd1: threshold = {2'b00, {(RESOLUTION-2){1'b1}}} >> 1; // ~25 %
            3'd2: threshold = {1'b0, {(RESOLUTION-1){1'b1}}} >> 1;  // ~50 %
            3'd3: threshold = {2'b01, {(RESOLUTION-2){1'b1}}};      // ~75 %
            3'd4: threshold = {RESOLUTION{1'b1}};           // 100 %
            default: threshold = {RESOLUTION{1'b0}};
        endcase
    end

    // -----------------------------------------------------------------------
    // PWM counter and comparator
    // -----------------------------------------------------------------------
    reg [RESOLUTION-1:0] pwm_cnt;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pwm_cnt <= {RESOLUTION{1'b0}};
        else
            pwm_cnt <= pwm_cnt + 1'b1;
    end

    assign pwm_out = (pwm_cnt < threshold) ? 1'b1 : 1'b0;

endmodule
