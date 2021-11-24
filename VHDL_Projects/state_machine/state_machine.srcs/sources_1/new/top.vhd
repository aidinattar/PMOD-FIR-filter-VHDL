----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/23/2021 05:48:07 PM
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
           rst : in STD_LOGIC;
           ina : in STD_LOGIC;
           outa : out STD_LOGIC);
end top;

architecture tff_sm of top is

type state_type is (ST0, ST1);
signal state : state_type;
begin
    sync_proc : process(clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= ST0;
                outa <= '0'; -- pre-assign
            else
                case state is
                when ST0 => -- items regarding state ST0 Z1 <= '0'; -- Moore output
                    outa <= '0'; -- pre-assign
                    if (ina = '1') then state <= ST1;
                    end if;
                when ST1 => -- items regarding state ST1
                    outa <= '1'; -- Moore output
                    if (ina = '1') then state <= ST0;
                    end if;
                when others => -- the catch-all condition
                    outa <= '0'; -- arbitrary; it should never
                    state <= ST0; -- make it to these two statements
                end case;
            end if;
        end if;
    end process sync_proc;

end tff_sm;
