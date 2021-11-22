----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2021 13:07:16
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

entity tb_blink is
--  Port ( );
end tb_blink;

architecture Behavioral of tb_blink is

component blink is
    Port (
        clk : in  std_logic;
        rst : in  std_logic;
        x_out: out std_logic;
        y_out:    out std_logic);
end component;

signal clk, rst: std_logic; signal y, x: std_logic;
          
begin

    uut : blink port map (clk => clk, rst => rst, y_out => y, x_out => x);
    
    p_clk : process
    begin
        clk <= '0'; wait for 5 ns;
        clk <= '1'; wait for 5 ns;
    end process;
    
    p_rst : process
    begin
        rst <= '1'; wait for 15 ns;
        rst <= '0'; wait;
    end process;

 --   p_cmb : process
 --   begin
  --      a <= '0'; wait for 0.2 ns; ab <= '1'; wait for 67 ns;
 --       a <= '1'; wait for 0.2 ns; ab <= '0'; wait for 67 ns;
 --   end process;    

end Behavioral;