

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
    d_width : integer;
    shift   : integer;
    coeff1  : integer;
    coeff2  : integer;
    coeff3  : integer;
    coeff4  : integer;
    coeff5  : integer;
    coeff6  : integer;
    coeff7  : integer;
    coeff8  : integer;
    coeff9  : integer;
    coeff10 : integer;
    coeff11 : integer;
    coeff12 : integer;
    coeff13 : integer;
    coeff14 : integer;
    coeff15 : integer);
port(
    clk        : in  std_logic;                        -- system clock
    rst        : in  std_logic;                        -- reset
    i_data     : in  std_logic_vector( d_width-1 downto 0);    -- input at time n
    o_data     : out std_logic_vector( d_width-1 downto 0));   -- output at time n
end fir_filter;

architecture rtl of fir_filter is

type t_data_pipe      is array (0 to 14) of signed(d_width-1   downto 0);
type t_coeff          is array (0 to 14) of signed(7           downto 0);
type t_mult           is array (0 to 14) of signed(8+d_width-1 downto 0);
--type t_add_st0        is array (0 to 1) of signed(15+1        downto 0);

signal r_coeff              : t_coeff := (to_signed(coeff1 , 8), to_signed(coeff2 , 8), to_signed(coeff3 , 8), to_signed(coeff4 , 8), to_signed(coeff5 , 8),
                                          to_signed(coeff6 , 8), to_signed(coeff7 , 8), to_signed(coeff8 , 8), to_signed(coeff9 , 8), to_signed(coeff10, 8),
                                          to_signed(coeff11, 8), to_signed(coeff12, 8), to_signed(coeff13, 8), to_signed(coeff14, 8), to_signed(coeff15, 8));
signal p_data               : t_data_pipe;
signal r_mult               : t_mult;
--signal r_add_st0            : t_add_st0;
signal r_add_st1            : signed(13+d_width downto 0);

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
    r_add_st1 <= resize(r_mult(0),r_add_st1'length) + resize(r_mult(1),r_add_st1'length) +
                 resize(r_mult(2),r_add_st1'length) + resize(r_mult(3),r_add_st1'length) +
                 resize(r_mult(4),r_add_st1'length) + resize(r_mult(5),r_add_st1'length) +
                 resize(r_mult(6),r_add_st1'length) + resize(r_mult(7),r_add_st1'length) +
                 resize(r_mult(8),r_add_st1'length) + resize(r_mult(9),r_add_st1'length) +
                 resize(r_mult(10),r_add_st1'length) + resize(r_mult(11),r_add_st1'length) +
                 resize(r_mult(12),r_add_st1'length) + resize(r_mult(13),r_add_st1'length) +
                 resize(r_mult(14),r_add_st1'length);
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
