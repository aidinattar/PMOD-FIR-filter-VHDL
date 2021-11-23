----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2021 05:04:43 PM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( clk : in STD_LOGIC;
           ina : in STD_LOGIC;
           rsta : in STD_LOGIC;
           sync_in : out STD_LOGIC);
end top;

architecture Behavioral of top is

component dff is
    Port (
        clk : in  std_logic;
        rst : in  std_logic;
        d:    in  std_logic;
        q:    out std_logic);
end component;

signal internal : std_logic;
          
begin

    uut1 : dff port map (clk => clk, rst => rsta, d => ina, q => internal);
    uut2 : dff port map (clk => clk, rst => rsta, d => internal, q => sync_in);

end Behavioral;
