--------------------------------------------------------------------------------
-- UART Receiver — VHDL
--
-- Description : 8-N-1 UART receiver.
--               rx_valid pulses high for one clock cycle when a new byte
--               is available in rx_data.
--
-- Generics    : CLK_FREQ  — system clock frequency in Hz (default 50 MHz)
--               BAUD_RATE — baud rate in bps (default 115200)
--
-- Board       : Waveshare Core EP4CE10
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_rx is
    generic (
        CLK_FREQ  : integer := 50_000_000;
        BAUD_RATE : integer := 115_200
    );
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        rx       : in  std_logic;
        rx_data  : out std_logic_vector(7 downto 0);
        rx_valid : out std_logic
    );
end entity uart_rx;

architecture rtl of uart_rx is

    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD_RATE;
    constant HALF_BIT     : integer := CLKS_PER_BIT / 2;

    type state_t is (IDLE, START, DATA, STOP);
    signal state    : state_t := IDLE;
    signal baud_cnt : integer range 0 to CLKS_PER_BIT - 1 := 0;
    signal bit_idx  : integer range 0 to 7 := 0;
    signal shift_r  : std_logic_vector(7 downto 0) := (others => '0');

    -- Two-stage synchroniser
    signal rx_s1, rx_s2 : std_logic := '1';

begin

    -- Synchronise external RX signal to clock domain
    process (clk) is
    begin
        if rising_edge(clk) then
            rx_s1 <= rx;
            rx_s2 <= rx_s1;
        end if;
    end process;

    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            state    <= IDLE;
            rx_valid <= '0';
            baud_cnt <= 0;
            bit_idx  <= 0;
            shift_r  <= (others => '0');
            rx_data  <= (others => '0');

        elsif rising_edge(clk) then
            rx_valid <= '0';

            case state is

                when IDLE =>
                    if rx_s2 = '0' then     -- falling edge = start bit
                        baud_cnt <= 0;
                        state    <= START;
                    end if;

                when START =>
                    if baud_cnt = HALF_BIT - 1 then
                        if rx_s2 = '0' then
                            baud_cnt <= 0;
                            bit_idx  <= 0;
                            state    <= DATA;
                        else
                            state <= IDLE;  -- false start
                        end if;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when DATA =>
                    if baud_cnt = CLKS_PER_BIT - 1 then
                        baud_cnt          <= 0;
                        shift_r(bit_idx)  <= rx_s2;
                        if bit_idx = 7 then
                            state <= STOP;
                        else
                            bit_idx <= bit_idx + 1;
                        end if;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when STOP =>
                    if baud_cnt = CLKS_PER_BIT - 1 then
                        if rx_s2 = '1' then  -- valid stop bit
                            rx_data  <= shift_r;
                            rx_valid <= '1';
                        end if;
                        baud_cnt <= 0;
                        state    <= IDLE;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

            end case;
        end if;
    end process;

end architecture rtl;
