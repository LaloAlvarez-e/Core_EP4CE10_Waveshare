--------------------------------------------------------------------------------
-- VGA Controller — VHDL
--
-- Description : Generates 640×480 @ 60 Hz VGA timing and displays an
--               8-colour bar test pattern.
--               Uses 50 MHz / 2 = 25 MHz pixel clock (≈ 25.175 MHz).
--               HSYNC and VSYNC are active-low.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_controller is
    port (
        clk    : in  std_logic;                   -- 50 MHz system clock
        rst_n  : in  std_logic;                   -- active-low reset
        vga_r  : out std_logic_vector(2 downto 0);-- red   (3 bits)
        vga_g  : out std_logic_vector(2 downto 0);-- green (3 bits)
        vga_b  : out std_logic_vector(1 downto 0);-- blue  (2 bits)
        vga_hs : out std_logic;                   -- horizontal sync (active-low)
        vga_vs : out std_logic                    -- vertical sync   (active-low)
    );
end entity vga_controller;

architecture rtl of vga_controller is

    -- VGA timing constants (640×480 @ 60 Hz)
    constant H_ACTIVE : integer := 640;
    constant H_FP     : integer := 16;
    constant H_SYNC   : integer := 96;
    constant H_BP     : integer := 48;
    constant H_TOTAL  : integer := H_ACTIVE + H_FP + H_SYNC + H_BP; -- 800

    constant V_ACTIVE : integer := 480;
    constant V_FP     : integer := 10;
    constant V_SYNC   : integer := 2;
    constant V_BP     : integer := 33;
    constant V_TOTAL  : integer := V_ACTIVE + V_FP + V_SYNC + V_BP; -- 525

    signal pclk  : std_logic := '0';
    signal h_cnt : unsigned(9 downto 0) := (others => '0');
    signal v_cnt : unsigned(9 downto 0) := (others => '0');

    signal active : std_logic;
    signal bar    : integer range 0 to 7;

begin

    -- -----------------------------------------------------------------------
    -- Pixel clock: 50 MHz / 2 = 25 MHz
    -- -----------------------------------------------------------------------
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            pclk <= '0';
        elsif rising_edge(clk) then
            pclk <= not pclk;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- Horizontal and vertical counters
    -- -----------------------------------------------------------------------
    process (pclk, rst_n) is
    begin
        if rst_n = '0' then
            h_cnt <= (others => '0');
            v_cnt <= (others => '0');
        elsif rising_edge(pclk) then
            if h_cnt = H_TOTAL - 1 then
                h_cnt <= (others => '0');
                if v_cnt = V_TOTAL - 1 then
                    v_cnt <= (others => '0');
                else
                    v_cnt <= v_cnt + 1;
                end if;
            else
                h_cnt <= h_cnt + 1;
            end if;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- Sync signals (active-low)
    -- -----------------------------------------------------------------------
    vga_hs <= '0' when (h_cnt >= H_ACTIVE + H_FP) and
                       (h_cnt <  H_ACTIVE + H_FP + H_SYNC) else '1';
    vga_vs <= '0' when (v_cnt >= V_ACTIVE + V_FP) and
                       (v_cnt <  V_ACTIVE + V_FP + V_SYNC) else '1';

    -- -----------------------------------------------------------------------
    -- Active-area and colour bar
    -- -----------------------------------------------------------------------
    active <= '1' when (h_cnt < H_ACTIVE) and (v_cnt < V_ACTIVE) else '0';
    bar    <= to_integer(h_cnt(9 downto 7));

    process (all) is
    begin
        if active = '0' then
            vga_r <= (others => '0');
            vga_g <= (others => '0');
            vga_b <= (others => '0');
        else
            case bar is
                when 0 => vga_r <= "111"; vga_g <= "111"; vga_b <= "11"; -- white
                when 1 => vga_r <= "111"; vga_g <= "111"; vga_b <= "00"; -- yellow
                when 2 => vga_r <= "000"; vga_g <= "111"; vga_b <= "11"; -- cyan
                when 3 => vga_r <= "000"; vga_g <= "111"; vga_b <= "00"; -- green
                when 4 => vga_r <= "111"; vga_g <= "000"; vga_b <= "11"; -- magenta
                when 5 => vga_r <= "111"; vga_g <= "000"; vga_b <= "00"; -- red
                when 6 => vga_r <= "000"; vga_g <= "000"; vga_b <= "11"; -- blue
                when 7 => vga_r <= "000"; vga_g <= "000"; vga_b <= "00"; -- black
                when others => vga_r <= "000"; vga_g <= "000"; vga_b <= "00";
            end case;
        end if;
    end process;

end architecture rtl;
