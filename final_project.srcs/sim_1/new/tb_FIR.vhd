----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/14/2022 03:39:42 PM
-- Design Name: 
-- Module Name: tb_FIR - Behavioral
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

entity tb_FIR is
--  Port ( );
end tb_FIR;

architecture Behavioral of tb_FIR is

component fir_filter is
port (
  clk        : in  std_logic;                        -- system clock
  rst        : in  std_logic;                        -- reset
  i_data     : in  std_logic_vector( 23 downto 0);    -- input at time n
  o_data     : out std_logic_vector( 23 downto 0));   -- output at time n
end component fir_filter;

signal s_clk, s_rst : std_logic;
signal s_i_data     : std_logic_vector( 23 downto 0 );
signal s_o_data     : std_logic_vector( 23 downto 0 ); 

begin

uut : fir_filter port map( clk => s_clk, rst => s_rst, i_data => s_i_data, o_data => s_o_data );

p_clk : process is
begin
    s_clk <= '1'; wait for 13 us;
    s_clk <= '0'; wait for 12 us;
end process p_clk;

p_rst : process is
begin
    s_rst <= '1'; wait for 10 ns;
    s_rst <='0'; wait;
end process p_rst;

p_i_data : process is
begin
    s_i_data <= std_logic_vector(to_signed(0, s_i_data'length)); wait for 25 us;
    s_i_data <= std_logic_vector(to_signed(4, s_i_data'length)); wait for 25 us;
    s_i_data <= std_logic_vector(to_signed(0, s_i_data'length)); wait for 25 us;
    s_i_data <= std_logic_vector(to_signed(4, s_i_data'length)); wait for 25 us;
    end process p_i_data;

end Behavioral;
