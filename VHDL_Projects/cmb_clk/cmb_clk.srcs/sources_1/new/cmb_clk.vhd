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
entity cmb_clk is
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;
        a_in : in  std_logic;
        ab_in: in  std_logic;
        cmb_out: out std_logic;
        ltch_out: out std_logic;
        ff_out:    out  std_logic);
end entity cmb_clk;
architecture rtl of cmb_clk is
    begin -- architecture rtl
    p_ff : process (clk, rst, a_in, ab_in) is
        begin -- process flipflop
            if rst = '1' then
                ff_out <= '0';
            elsif rising_edge(clk) then
                ff_out <= a_in and ab_in;
            end if;
        end process p_ff;
    p_ltch: process ( clk, rst, a_in, ab_in) is
        begin
            if rst = '1' then
                ltch_out <= '0';
            elsif clk = '1' then
                ltch_out <= a_in and ab_in;
            end if;
        end process p_ltch;
    cmb_out <= a_in and ab_in;
end architecture rtl;