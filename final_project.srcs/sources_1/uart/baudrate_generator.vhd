library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity baudrate_generator is

  port (
    clock        : in  std_logic;
    baudrate_out : out std_logic);

end entity baudrate_generator;


architecture rtl of baudrate_generator is
  signal counter   : unsigned(9 downto 0) := (others => '0');
  --constant divisor : unsigned(9 downto 0) := to_unsigned(97, 10); --modified such that it takes in input master clock and not the system clock
    constant divisor : unsigned(9 downto 0) := to_unsigned(10, 10); --modified such that it takes in input master clock and goes faster

begin  -- architecture rtl
  main : process (clock) is
  begin  -- process main
    if rising_edge(clock) then          -- rising clock edge
      counter <= counter + 1;
      if counter = divisor then
        baudrate_out <= '1';
        counter      <= (others => '0');
      else
        baudrate_out <= '0';
      end if;
    end if;
  end process main;

end architecture rtl;
