--------------------------------------------------------------------------------
-- LED Blink — VHDL
--
-- Description : Blinks all 10 on-board LEDs at ~0.75 Hz by dividing the
--               50 MHz system clock with a 26-bit counter.
--               LEDs are active-low on the Core EP4CE10 board.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity led_blink is
    port (
        clk : in  std_logic;                    -- 50 MHz system clock
        led : out std_logic_vector(9 downto 0)  -- 10 user LEDs (active-low)
    );
end entity led_blink;

architecture rtl of led_blink is

    -- 26-bit counter — MSB toggles at ~0.75 Hz
    signal counter : unsigned(25 downto 0) := (others => '0');

begin

    process (clk) is
    begin
        if rising_edge(clk) then
            counter <= counter + 1;
        end if;
    end process;

    -- Drive all LEDs from the MSB (active-low: invert the bit)
    led <= (others => not counter(25));

end architecture rtl;
