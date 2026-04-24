//============================================================================
// VGA Controller — Verilog
//
// Description : Generates 640×480 @ 60 Hz VGA timing and displays an
//               8-colour bar test pattern.
//               Uses 50 MHz / 2 = 25 MHz pixel clock (≈ 25.175 MHz).
//               HSYNC and VSYNC are active-low.
//
// Board       : Waveshare Core EP4CE10
// Device      : EP4CE10E22C8N
// Clock       : 50 MHz (PIN_23)
//============================================================================

module vga_controller (
    input  wire       clk,      // 50 MHz system clock
    input  wire       rst_n,    // active-low reset
    output wire [2:0] vga_r,    // red   (3 bits)
    output wire [2:0] vga_g,    // green (3 bits)
    output wire [1:0] vga_b,    // blue  (2 bits)
    output wire       vga_hs,   // horizontal sync (active-low)
    output wire       vga_vs    // vertical sync   (active-low)
);

    // -----------------------------------------------------------------------
    // Pixel clock: 50 MHz / 2 = 25 MHz
    // -----------------------------------------------------------------------
    reg pclk;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) pclk <= 1'b0;
        else        pclk <= ~pclk;
    end

    // -----------------------------------------------------------------------
    // VGA timing constants (640×480 @ 60 Hz)
    // -----------------------------------------------------------------------
    localparam H_ACTIVE     = 640;
    localparam H_FP         = 16;
    localparam H_SYNC       = 96;
    localparam H_BP         = 48;
    localparam H_TOTAL      = H_ACTIVE + H_FP + H_SYNC + H_BP; // 800

    localparam V_ACTIVE     = 480;
    localparam V_FP         = 10;
    localparam V_SYNC       = 2;
    localparam V_BP         = 33;
    localparam V_TOTAL      = V_ACTIVE + V_FP + V_SYNC + V_BP; // 525

    // -----------------------------------------------------------------------
    // Horizontal and vertical counters
    // -----------------------------------------------------------------------
    reg [9:0] h_cnt;
    reg [9:0] v_cnt;

    always @(posedge pclk or negedge rst_n) begin
        if (!rst_n) begin
            h_cnt <= 10'd0;
            v_cnt <= 10'd0;
        end else begin
            if (h_cnt == H_TOTAL - 1) begin
                h_cnt <= 10'd0;
                if (v_cnt == V_TOTAL - 1)
                    v_cnt <= 10'd0;
                else
                    v_cnt <= v_cnt + 1'b1;
            end else
                h_cnt <= h_cnt + 1'b1;
        end
    end

    // -----------------------------------------------------------------------
    // Sync signals (active-low)
    // -----------------------------------------------------------------------
    assign vga_hs = ~((h_cnt >= H_ACTIVE + H_FP) &&
                      (h_cnt <  H_ACTIVE + H_FP + H_SYNC));
    assign vga_vs = ~((v_cnt >= V_ACTIVE + V_FP) &&
                      (v_cnt <  V_ACTIVE + V_FP + V_SYNC));

    // -----------------------------------------------------------------------
    // Active-area flag
    // -----------------------------------------------------------------------
    wire h_active = (h_cnt < H_ACTIVE);
    wire v_active = (v_cnt < V_ACTIVE);
    wire active   = h_active && v_active;

    // -----------------------------------------------------------------------
    // Colour bar test pattern (8 columns × 80 pixels each)
    // -----------------------------------------------------------------------
    reg [2:0] r_reg, g_reg;
    reg [1:0] b_reg;

    always @(*) begin
        if (!active) begin
            r_reg = 3'b000;
            g_reg = 3'b000;
            b_reg = 2'b00;
        end else begin
            case (h_cnt[9:7])          // divide 640 px into 8 × 80 bars
                3'd0: begin r_reg=3'b111; g_reg=3'b111; b_reg=2'b11; end // white
                3'd1: begin r_reg=3'b111; g_reg=3'b111; b_reg=2'b00; end // yellow
                3'd2: begin r_reg=3'b000; g_reg=3'b111; b_reg=2'b11; end // cyan
                3'd3: begin r_reg=3'b000; g_reg=3'b111; b_reg=2'b00; end // green
                3'd4: begin r_reg=3'b111; g_reg=3'b000; b_reg=2'b11; end // magenta
                3'd5: begin r_reg=3'b111; g_reg=3'b000; b_reg=2'b00; end // red
                3'd6: begin r_reg=3'b000; g_reg=3'b000; b_reg=2'b11; end // blue
                3'd7: begin r_reg=3'b000; g_reg=3'b000; b_reg=2'b00; end // black
                default: begin r_reg=3'b000; g_reg=3'b000; b_reg=2'b00; end
            endcase
        end
    end

    assign vga_r = r_reg;
    assign vga_g = g_reg;
    assign vga_b = b_reg;

endmodule
