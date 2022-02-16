

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or signed values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fir_filter is
generic(
    d_width : integer := 24;
    shift   : integer :=  7;
    coeff1  : integer :=  3;
    coeff2  : integer := 12;
    coeff3  : integer := 30;
    coeff4  : integer := 39;
    coeff5  : integer := 30;
    coeff6  : integer := 12;
    coeff7  : integer :=  3);
    --coeff8  : integer := 17;
    --coeff9  : integer := 16;
    --coeff10 : integer := 14;
    --coeff11 : integer := 11;
    --coeff12 : integer :=  7;
    --coeff13 : integer :=  4;
    --coeff14 : integer :=  2;
    --coeff15 : integer :=  1);
port(
    clk        : in  std_logic;                        -- system clock
    rst        : in  std_logic;                        -- reset
    i_data     : in  std_logic_vector( d_width-1 downto 0);    -- input at time n
    o_data     : out std_logic_vector( d_width-1 downto 0));   -- output at time n
end fir_filter;

architecture rtl of fir_filter is

type t_data_pipe      is array (0 to 6) of signed(d_width-1     downto 0);
type t_coeff          is array (0 to 6) of signed(7             downto 0);
type t_mult           is array (0 to 6) of signed(8+d_width-1   downto 0);
--type t_add_st0        is array (0 to 1) of signed(15+1        downto 0);

signal r_coeff              : t_coeff := (to_signed(coeff1 , 8), to_signed(coeff2 , 8), to_signed(coeff3 , 8), to_signed(coeff4 , 8), to_signed(coeff5 , 8),
                                          to_signed(coeff6 , 8), to_signed(coeff7 , 8));--, to_signed(coeff8 , 8), to_signed(coeff9 , 8), to_signed(coeff10, 8),
                                          --to_signed(coeff11, 8), to_signed(coeff12, 8), to_signed(coeff13, 8), to_signed(coeff14, 8), to_signed(coeff15, 8));
signal p_data               : t_data_pipe;
signal r_mult               : t_mult;
--signal r_add_st0            : t_add_st0;
signal r_add_st1            : signed(14+d_width downto 0);

begin

p_input : process (rst,clk)
begin
  if(rst='1') then
    p_data       <= (others=>(others=>'0'));
    --r_coeff      <= (others=>(others=>'0'));
  elsif(rising_edge(clk)) then
    p_data      <= signed(i_data)&p_data(0 to p_data'length-2);
  end if;
end process p_input;

p_mult : process (rst,clk)
begin
  if(rst='1') then
    r_mult       <= (others=>(others=>'0'));
  elsif(rising_edge(clk)) then
    for k in 0 to p_data'length-1 loop
      r_mult(k)       <= p_data(k) * r_coeff(k);
    end loop;
  end if;
end process p_mult;

--p_add_st0 : process (rst,clk)
--begin
--  if(rst='1') then
--    r_add_st0     <= (others=>(others=>'0'));
--  elsif(rising_edge(clk)) then
--   for k in 0 to 1 loop
--      r_add_st0(k)     <= resize(r_mult(2*k),17)  + resize(r_mult(2*k+1),17);
--    end loop;
--  end if;
--end process p_add_st0;

p_add_st1 : process (rst,clk)
begin
  if(rst='1') then
    r_add_st1     <= (others=>'0');
  elsif(rising_edge(clk)) then
    r_add_st1 <= (others=>'0');
    for k in 0 to r_mult'length-1 loop
        r_add_st1 <= r_add_st1 + resize(r_mult(k),r_add_st1'length);
    end loop;
  end if;
end process p_add_st1;

p_output : process (rst,clk)
begin
  if(rst='1') then
    o_data     <= (others=>'0');
  elsif(rising_edge(clk)) then
    o_data     <= std_logic_vector(r_add_st1(shift+23 downto shift));
  end if;
end process p_output;


end rtl;
