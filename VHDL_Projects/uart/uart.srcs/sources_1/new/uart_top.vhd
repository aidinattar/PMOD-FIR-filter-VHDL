----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2021 12:59:12 PM
-- Design Name: 
-- Module Name: uart_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity uart_top is
    Port ( clk  : in STD_LOGIC;
           --data : in std_logic;
           btn  : in STD_LOGIC;
           tx   : out STD_LOGIC );
           --busy : out STD_LOGIC);
end uart_top;

architecture Behavioral of uart_top is
component Baudrate is
    Port ( clk : in std_logic;
           b_out : out std_logic );
end component;

type state_type is (IDLE,    VALID,   STOP,  START,
                    TxBIT0, TxBIT1, TxBIT2, TxBIT3,
                    TxBIT4, TxBIT5, TxBIT6, TxBIT7);
signal state   : state_type := IDLE;
signal counter : unsigned(3 downto 0) := (others => '0');
signal data    : unsigned(7 downto 0) := ('0','1','1','0','0','0','0','1');
signal brate   : std_logic;

begin

    uut : Baudrate port map( b_out => brate, clk => clk );
    
    p_uart : process(clk) is
    begin
        if rising_edge(clk) then
            if brate = '1' then
                case state is
                when IDLE =>
                    if btn = '1' then
                        state <= VALID;
                    end if;
                    tx <= '1';
                when VALID =>
                    state <= START;
                    tx <= '1';
                when START =>
                    state <= TxBIT0;
                    tx <= '1';
                when TxBIT0 =>
                    tx <= data(0);
                    state <= TxBIT1;
                when TxBIT1 =>
                    tx <= data(1);
                    state <= TxBIT2;
                when TxBIT2 =>
                    tx <= data(2);
                    state <= TxBIT3;
                when TxBIT3 =>
                    tx <= data(3);
                    state <= TxBIT4;
                when TxBIT4 =>
                    tx <= data(4);
                    state <= TxBIT5;
                when TxBIT5 =>
                    tx <= data(5);
                    state <= TxBIT6;
                when TxBIT6 =>
                    tx <= data(6);
                    state <= TxBIT7;
                when TxBIT7 =>
                    tx <= data(7);
                    state <= STOP;
                when STOP =>
                    state <= IDLE;
                    tx <= '1';
                end case;
            end if;
        end if;
    end process p_uart;
end Behavioral;
