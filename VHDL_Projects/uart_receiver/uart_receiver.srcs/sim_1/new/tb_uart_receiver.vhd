----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2021 17:45:25
-- Design Name: 
-- Module Name: tb_uart_receiver - Behavioral
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

entity tb_uart_receiver is
--  Port ( );
end tb_uart_receiver;

architecture Behavioral of tb_uart_receiver is

component UART_receiver is
  port (                                                
    clock         : in  std_logic;                      
    uart_rx       : in  std_logic;                      
    valid         : out std_logic;                      
    received_data : out std_logic_vector(7 downto 0));  
  end component UART_receiver;
  
  component sampler_generator is       
    port (                             
      clock        : in  std_logic;    
      uart_rx      : in  std_logic;    
      baudrate_out : out std_logic);   
  end component sampler_generator;
       
  component baudrate_generator is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           b_out : out STD_LOGIC);
  end component baudrate_generator;
  
  signal s_clock, s_uart_rx, s_valid : std_logic;
  signal s_received_data : std_logic_vector(7 downto 0);
  signal s_baudrate_out, s_enable, s_b_out : std_logic;
  signal fake_data : unsigned(8 downto 0) := ( '1','1','0','0','0','0','1', '1', '0');
  signal counter : integer := 0;
  
  begin
  
      uut1 : UART_receiver port map( clock => s_clock, uart_rx => s_uart_rx, valid => s_valid, received_data => s_received_data );
      uut2 : sampler_generator port map ( clock => s_clock, uart_rx => s_uart_rx, baudrate_out => s_baudrate_out );
      uut3 : baudrate_generator port map ( clock => s_clock, enable => s_enable, b_out => s_b_out );

      p_clk : process is 
      begin
        s_clock <= '1'; wait for 5 ns;
        s_clock <= '0'; wait for 5 ns;
      end process p_clk;
  
      p_uart_rx : process(s_clock,s_b_out) is
      begin
          if rising_edge(s_clock) then
            
              if counter < 9 then
                if s_b_out = '1' then
                    s_uart_rx <= fake_data(counter);
                    counter <= counter + 1;
                end if;
              else 
                counter <= 0;
              end if;
        end if;
      end process p_uart_rx;
      
      p_enable : process is
      begin
        wait for 50 ns;
        s_enable <= '1';
        wait for 1000000 ns;
        s_enable <= '0';
      end process p_enable;
end Behavioral;
