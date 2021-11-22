----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2021 17:03:04
-- Design Name: 
-- Module Name: dff - Behavioral
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


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
entity dff is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        d:    in   std_logic;
        q:    out  std_logic);
end entity dff;
architecture rtl of dff is
    begin -- architecture rtl
    flipflop : process (clk) is
        begin -- process flipflop
            if rising_edge(clk) then
                if rst = '0' then
                    q <= '0';
                else
                    q <= d;
                end if;
            end if;
        end process flipflop;
    end architecture rtl;