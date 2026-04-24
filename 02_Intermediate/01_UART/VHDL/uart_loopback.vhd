--------------------------------------------------------------------------------
-- UART Loopback — VHDL (top-level)
--
-- Description : Echoes every received byte back to the transmitter.
--               Connect with any serial terminal at 115200-8-N-1.
--
-- Board       : Waveshare Core EP4CE10
-- Device      : EP4CE10E22C8N
-- Clock       : 50 MHz (PIN_23)
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity uart_loopback is
    port (
        clk   : in  std_logic;  -- 50 MHz system clock
        rst_n : in  std_logic;  -- active-low reset (KEY0)
        rx    : in  std_logic;  -- UART RX (PIN_2)
        tx    : out std_logic   -- UART TX (PIN_1)
    );
end entity uart_loopback;

architecture rtl of uart_loopback is

    signal data  : std_logic_vector(7 downto 0);
    signal valid : std_logic;
    signal busy  : std_logic;

    component uart_rx is
        generic (CLK_FREQ : integer; BAUD_RATE : integer);
        port (
            clk      : in  std_logic;
            rst_n    : in  std_logic;
            rx       : in  std_logic;
            rx_data  : out std_logic_vector(7 downto 0);
            rx_valid : out std_logic
        );
    end component;

    component uart_tx is
        generic (CLK_FREQ : integer; BAUD_RATE : integer);
        port (
            clk      : in  std_logic;
            rst_n    : in  std_logic;
            tx_data  : in  std_logic_vector(7 downto 0);
            tx_start : in  std_logic;
            tx       : out std_logic;
            tx_busy  : out std_logic
        );
    end component;

begin

    u_rx : uart_rx
        generic map (CLK_FREQ => 50_000_000, BAUD_RATE => 115_200)
        port map (
            clk      => clk,
            rst_n    => rst_n,
            rx       => rx,
            rx_data  => data,
            rx_valid => valid
        );

    u_tx : uart_tx
        generic map (CLK_FREQ => 50_000_000, BAUD_RATE => 115_200)
        port map (
            clk      => clk,
            rst_n    => rst_n,
            tx_data  => data,
            tx_start => valid and not busy,
            tx       => tx,
            tx_busy  => busy
        );

end architecture rtl;
