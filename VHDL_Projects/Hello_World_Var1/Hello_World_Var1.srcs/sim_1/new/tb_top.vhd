----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.11.2021 17:16:29
-- Design Name: 
-- Module Name: tb_top - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

component top is 
    Port (btn_in1, btn_in2 : in std_logic;
    led_out1 : out std_logic);
end component;

signal btn1, btn2, led1 : std_logic;

begin

uut : top port map (btn_in1 => btn1, btn_in2 => btn2, led_out1 => led1);

pi : process
    begin
        btn1 <= '0';
        btn2 <= '0';
        wait for 100 ns;
        btn1 <= '1';
        wait for 100 ns;
        btn2 <= '1';
        wait for 100 ns;
    end process;
    
end Behavioral;

