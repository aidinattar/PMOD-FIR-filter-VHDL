----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.11.2021 17:28:58
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
end tb_top;

architecture Behavioral of tb_top is

component Baudrate is
    Port ( clk   : in  STD_LOGIC;
           b_out : out STD_LOGIC);
end component;
signal s_clk : std_logic; signal s_b_out: std_logic;
begin
    uut : Baudrate port map( clk => s_clk, b_out => s_b_out ); 

    p_clk : process 
    begin
        s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns;
    end process;
end Behavioral;
