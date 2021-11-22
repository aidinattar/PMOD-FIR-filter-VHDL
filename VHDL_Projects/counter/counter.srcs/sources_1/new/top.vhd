----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.11.2021 13:13:01
-- Design Name: 
-- Module Name: top - Behavioral
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

entity blink is
    Port ( clk:     in std_logic;
           rst:     in std_logic;
           x_out:   out std_logic;
           y_out:  out std_logic);
end blink;

architecture Behavioral of blink is
    signal counter: unsigned( 27 downto 0);
    begin
        p_cnt: process(clk, rst) is
        begin
            if rst = '1' then
                counter <= (others => '0');
            elsif rising_edge(clk) then
                counter <= counter + 1;
                x_out <= '1';
            end if;
        
            y_out <= counter(6);
        end process;
end Behavioral;
