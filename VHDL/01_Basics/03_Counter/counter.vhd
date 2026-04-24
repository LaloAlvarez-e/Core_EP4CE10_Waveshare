--------------------------------------------------------------------------------
-- Counter — VHDL
--
-- Description : Parameterisable N-bit binary up-counter displayed on LEDs.
--               A 26-bit prescaler slows the 50 MHz clock to ~1.49 Hz so
--               the count is visible. rst_n is active-low (KEY0).
--               LEDs are active-low.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter is
    generic (
        N : integer := 10  -- number of counter bits shown on LEDs
    );
    port (
        clk   : in  std_logic;                   -- 50 MHz system clock
        rst_n : in  std_logic;                   -- active-low reset (KEY0)
        led   : out std_logic_vector(N-1 downto 0)  -- N LEDs (active-low)
    );
end entity counter;

architecture rtl of counter is

    constant PRESCALER_BITS : integer := 26;

    signal prescaler : unsigned(PRESCALER_BITS-1 downto 0) := (others => '0');
    signal count     : unsigned(N-1 downto 0)              := (others => '0');

begin

    process (clk) is
    begin
        if rising_edge(clk) then
            if rst_n = '0' then
                prescaler <= (others => '0');
                count     <= (others => '0');
            else
                prescaler <= prescaler + 1;
                if prescaler = (prescaler'range => '1') then
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;

    -- LEDs are active-low: invert the count bits
    led <= not std_logic_vector(count);

end architecture rtl;
