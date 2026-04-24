--------------------------------------------------------------------------------
-- Seven-Segment Display — VHDL
--
-- Description : Drives a 6-digit multiplexed 7-segment display. A BCD
--               counter (0-9) is shown on all six digits simultaneously.
--               Segments and digit selects are active-low.
--               Multiplexing frequency: 50e6 / 2^16 ≈ 763 Hz per digit.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seven_segment is
    port (
        clk       : in  std_logic;                   -- 50 MHz system clock
        hex       : out std_logic_vector(6 downto 0); -- segments a-g (active-low)
        digit_sel : out std_logic_vector(5 downto 0)  -- digit selects (active-low)
    );
end entity seven_segment;

architecture rtl of seven_segment is

    signal slow_cnt  : unsigned(25 downto 0) := (others => '0');
    signal bcd       : unsigned(3 downto 0)  := (others => '0');
    signal digit_idx : unsigned(2 downto 0);

    -- BCD to 7-segment ROM type
    type seg_rom_t is array (0 to 9) of std_logic_vector(6 downto 0);

    -- Active-low segment encoding {g,f,e,d,c,b,a}
    constant SEG_ROM : seg_rom_t := (
        0 => "1000000",  -- 0
        1 => "1111001",  -- 1
        2 => "0100100",  -- 2
        3 => "0110000",  -- 3
        4 => "0011001",  -- 4
        5 => "0010010",  -- 5
        6 => "0000010",  -- 6
        7 => "1111000",  -- 7
        8 => "0000000",  -- 8
        9 => "0010000"   -- 9
    );

begin

    -- -----------------------------------------------------------------------
    -- Slow counter
    -- -----------------------------------------------------------------------
    process (clk) is
    begin
        if rising_edge(clk) then
            slow_cnt <= slow_cnt + 1;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- BCD counter cycling 0-9 every ~0.67 s
    -- -----------------------------------------------------------------------
    process (clk) is
    begin
        if rising_edge(clk) then
            if slow_cnt = to_unsigned(49_999_999, 26) then
                if bcd = 9 then
                    bcd <= (others => '0');
                else
                    bcd <= bcd + 1;
                end if;
            end if;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- Digit multiplexer (~763 Hz per digit)
    -- -----------------------------------------------------------------------
    digit_idx <= slow_cnt(18 downto 16);

    process (digit_idx) is
    begin
        case to_integer(digit_idx) is
            when 0      => digit_sel <= "111110";
            when 1      => digit_sel <= "111101";
            when 2      => digit_sel <= "111011";
            when 3      => digit_sel <= "110111";
            when 4      => digit_sel <= "101111";
            when 5      => digit_sel <= "011111";
            when others => digit_sel <= "111111";
        end case;
    end process;

    -- -----------------------------------------------------------------------
    -- BCD to 7-segment decoder
    -- -----------------------------------------------------------------------
    hex <= SEG_ROM(to_integer(bcd));

end architecture rtl;
