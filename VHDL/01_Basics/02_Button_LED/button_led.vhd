--------------------------------------------------------------------------------
-- Button LED — VHDL
--
-- Description : Illuminates an LED while the corresponding push-button is
--               pressed.  Both keys and LEDs are active-low on the board.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity button_led is
    port (
        key : in  std_logic_vector(3 downto 0);  -- 4 push-buttons (active-low)
        led : out std_logic_vector(3 downto 0)   -- 4 LEDs (active-low)
    );
end entity button_led;

architecture rtl of button_led is
begin

    -- LED follows key: button pressed (key='0') -> LED on (led='0')
    led <= key;

end architecture rtl;
