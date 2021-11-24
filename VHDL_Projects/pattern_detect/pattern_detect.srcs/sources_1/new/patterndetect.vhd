----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/24/2021 01:49:43 PM
-- Design Name: 
-- Module Name: patterndetect - rtl
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

entity patterndetect is
    Port ( a : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           y : out STD_LOGIC);
end patterndetect;

architecture rtl of patterndetect is
type state_t is (S0, S1, S2, S3, Detect);
signal state : state_t := S0;
begin
    main : process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                state <= S0;
                y <= '0';
            else
                case state is
                when S0 =>
                    y <= '0';
                    if a = '0' then
                        state <= S1;
                    end if;
                when S1 =>
                    y <= '0';
                    if a = '1' then
                        state <= S2;
                    elsif a = '0' then
                        state <= S1;
                    else
                        null;
                    end if;
                when S2 =>
                    y <= '0';
                    if a = '0' then
                        state <= S3;
                    elsif a = '1' then
                        state <= S0;
                    else
                        null;
                    end if;
                when S3 =>
                    y <= '0';
                    if a = '1' then
                        state <= Detect;
                    elsif a = '0' then
                        state <= S1;
                    else
                        null;
                    end if;
                when Detect =>
                    y <= '1';
                    state <= S0;
                when others => null;
                end case;
            end if;
        end if;
    end process main;  

end architecture rtl;
