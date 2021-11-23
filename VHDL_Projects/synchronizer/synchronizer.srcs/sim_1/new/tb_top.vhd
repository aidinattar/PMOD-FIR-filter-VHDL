----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2021 05:23:13 PM
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

component top is
    Port ( clk : in STD_LOGIC;
           rsta : in STD_LOGIC;
           ina : in STD_LOGIC;
           sync_in : out STD_LOGIC);
end component;

signal sclk, srsta, sina, ssync_in : std_logic;

begin

    uut : top port map ( clk => sclk, rsta => srsta, ina => sina, sync_in => ssync_in );
    
    pclk : process
    begin
        sclk <= '0';
        wait for 50 ns;
        sclk <= '1';
        wait for 50 ns;
    end process;
    
    prst : process
    begin
        srsta <= '0';
        wait;
    end process;
    
    pina : process
    begin
        sina <= '0';
        wait for 200 ns;
        sina <= '1';
        wait for 200 ns;
        sina <= '0';
        wait for 100 ns;
        sina <= '1';
        wait for 50 ns;
        
    end process;
        

end Behavioral;
