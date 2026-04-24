--------------------------------------------------------------------------------
-- UART Transmitter — VHDL
--
-- Description : 8-N-1 UART transmitter.
--               tx_busy is high while a byte is being transmitted.
--               Transmission starts when tx_start pulses for one cycle.
--
-- Generics    : CLK_FREQ  — system clock frequency in Hz (default 50 MHz)
--               BAUD_RATE — baud rate in bps (default 115200)
--
-- Board       : Waveshare Core EP4CE10
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_tx is
    generic (
        CLK_FREQ  : integer := 50_000_000;
        BAUD_RATE : integer := 115_200
    );
    port (
        clk      : in  std_logic;
        rst_n    : in  std_logic;
        tx_data  : in  std_logic_vector(7 downto 0);
        tx_start : in  std_logic;
        tx       : out std_logic;
        tx_busy  : out std_logic
    );
end entity uart_tx;

architecture rtl of uart_tx is

    constant CLKS_PER_BIT : integer := CLK_FREQ / BAUD_RATE;

    type state_t is (IDLE, START, DATA, STOP);
    signal state    : state_t := IDLE;
    signal baud_cnt : integer range 0 to CLKS_PER_BIT - 1 := 0;
    signal bit_idx  : integer range 0 to 7 := 0;
    signal shift_r  : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_i     : std_logic := '1';
    signal busy_i   : std_logic := '0';

begin

    tx      <= tx_i;
    tx_busy <= busy_i;

    process (clk, rst_n) is
    begin
        if rst_n = '0' then
            state    <= IDLE;
            tx_i     <= '1';
            busy_i   <= '0';
            baud_cnt <= 0;
            bit_idx  <= 0;
            shift_r  <= (others => '0');

        elsif rising_edge(clk) then
            case state is

                when IDLE =>
                    tx_i   <= '1';
                    busy_i <= '0';
                    if tx_start = '1' then
                        shift_r  <= tx_data;
                        baud_cnt <= 0;
                        busy_i   <= '1';
                        state    <= START;
                    end if;

                when START =>
                    tx_i <= '0';
                    if baud_cnt = CLKS_PER_BIT - 1 then
                        baud_cnt <= 0;
                        bit_idx  <= 0;
                        state    <= DATA;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when DATA =>
                    tx_i <= shift_r(bit_idx);
                    if baud_cnt = CLKS_PER_BIT - 1 then
                        baud_cnt <= 0;
                        if bit_idx = 7 then
                            state <= STOP;
                        else
                            bit_idx <= bit_idx + 1;
                        end if;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when STOP =>
                    tx_i <= '1';
                    if baud_cnt = CLKS_PER_BIT - 1 then
                        baud_cnt <= 0;
                        state    <= IDLE;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

            end case;
        end if;
    end process;

end architecture rtl;
