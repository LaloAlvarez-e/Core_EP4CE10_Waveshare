--------------------------------------------------------------------------------
-- PWM Generator — VHDL
--
-- Description : Parameterisable PWM generator with button-controlled
--               duty cycle (0 %, 25 %, 50 %, 75 %, 100 %).
--               An 8-bit counter produces ~195 kHz switching at 50 MHz.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm is
    generic (
        RESOLUTION : integer := 8  -- PWM resolution in bits
    );
    port (
        clk     : in  std_logic;  -- 50 MHz system clock
        rst_n   : in  std_logic;  -- active-low reset (KEY0)
        btn     : in  std_logic;  -- active-low button (KEY1)
        pwm_out : out std_logic   -- PWM output
    );
end entity pwm;

architecture rtl of pwm is

    constant DEBOUNCE_CNT : integer := 1_000_000;

    -- Synchroniser
    signal btn_s1, btn_s2 : std_logic := '1';

    -- Debouncer
    signal deb_cnt  : integer range 0 to DEBOUNCE_CNT := 0;
    signal btn_prev : std_logic := '1';
    signal btn_edge : std_logic := '0';

    -- Duty-cycle step (0-4)
    signal duty_step : integer range 0 to 4 := 0;

    -- Threshold and counter
    signal threshold : unsigned(RESOLUTION-1 downto 0) := (others => '0');
    signal pwm_cnt   : unsigned(RESOLUTION-1 downto 0) := (others => '0');

begin

    -- -----------------------------------------------------------------------
    -- Two-stage synchroniser
    -- -----------------------------------------------------------------------
    process (clk) is
    begin
        if rising_edge(clk) then
            btn_s1 <= btn;
            btn_s2 <= btn_s1;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- Debouncer
    -- -----------------------------------------------------------------------
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            deb_cnt  <= 0;
            btn_prev <= '1';
            btn_edge <= '0';
        elsif rising_edge(clk) then
            btn_edge <= '0';
            if btn_s2 /= btn_prev then
                deb_cnt <= 0;
            elsif deb_cnt < DEBOUNCE_CNT then
                deb_cnt <= deb_cnt + 1;
            else
                if btn_s2 = '0' and btn_prev = '1' then
                    btn_edge <= '1';
                end if;
                btn_prev <= btn_s2;
            end if;
        end if;
    end process;

    -- -----------------------------------------------------------------------
    -- Duty-cycle selector
    -- -----------------------------------------------------------------------
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            duty_step <= 0;
        elsif rising_edge(clk) then
            if btn_edge = '1' then
                if duty_step = 4 then
                    duty_step <= 0;
                else
                    duty_step <= duty_step + 1;
                end if;
            end if;
        end if;
    end process;

    -- Map step to compare threshold
    process (duty_step) is
    begin
        case duty_step is
            when 0      => threshold <= (others => '0');                              -- 0 %
            when 1      => threshold <= to_unsigned(2**(RESOLUTION-2),     RESOLUTION); -- 25 %
            when 2      => threshold <= to_unsigned(2**(RESOLUTION-1),     RESOLUTION); -- 50 %
            when 3      => threshold <= to_unsigned(3 * 2**(RESOLUTION-2), RESOLUTION); -- 75 %
            when 4      => threshold <= (others => '1');                              -- 100 %
            when others => threshold <= (others => '0');
        end case;
    end process;

    -- -----------------------------------------------------------------------
    -- PWM counter and comparator
    -- -----------------------------------------------------------------------
    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            pwm_cnt <= (others => '0');
        elsif rising_edge(clk) then
            pwm_cnt <= pwm_cnt + 1;
        end if;
    end process;

    pwm_out <= '1' when pwm_cnt < threshold else '0';

end architecture rtl;
