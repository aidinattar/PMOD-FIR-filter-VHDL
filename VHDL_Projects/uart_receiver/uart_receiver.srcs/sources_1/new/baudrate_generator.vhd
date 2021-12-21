----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 17:05:43
-- Design Name: 
-- Module Name: Baudrate - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Baudrate is
    Port ( clk    : in STD_LOGIC;
           enable : in STD_LOGIC;
           b_out  : out STD_LOGIC);
end Baudrate;

architecture Behavioral of Baudrate is
    signal counter: unsigned( 9 downto 0):= (others => '0');
    begin
        p_cnt: process(clk) is
        begin
            if rising_edge(clk) then
                if enable = '1' then
                    counter <= counter + 1;
                else
                    counter <= (others => '0');
                end if;
            end if;
            
            b_out <= not counter(0) and 
                     not counter(1) and
                         counter(2) and
                     not counter(3) and 
                     not counter(4) and 
                         counter(5) and
                         counter(6) and
                     not counter(7) and 
                         counter(8) and
                         counter(9);
        end process p_cnt;
end Behavioral;