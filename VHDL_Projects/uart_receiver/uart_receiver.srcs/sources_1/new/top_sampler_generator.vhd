----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 13:50:45
-- Design Name: 
-- Module Name: top_pulse - Behavioral
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sampler_generator is
  port (
    clock        : in  std_logic;
    uart_rx      : in  std_logic;
    baudrate_out : out std_logic);
end entity sampler_generator;

architecture rtl of sampler_generator is
    type state_type is (IDLE,             STOP,  START,
                        TxBIT0, TxBIT1, TxBIT2, TxBIT3,
                        TxBIT4, TxBIT5, TxBIT6, TxBIT7);

  signal state : state_type := IDLE;

  signal counter        : unsigned(10 downto 0) := (others => '0');
  signal delay_counter  : unsigned(10 downto 0) := (others => '0');
  constant divisor      : unsigned(10 downto 0) := to_unsigned(867, 11);
  constant half_divisor : unsigned(10 downto 0) := to_unsigned(433, 11);
  signal busy           : std_logic             := '0';
  signal pulse_out      : std_logic;
  signal enable_counter : std_logic             := '0';
  signal enable_delay   : std_logic             := '0';
  component baudrate_generator is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           b_out : out STD_LOGIC);
  end component baudrate_generator;
begin

  uut : baudrate_generator port map( b_out  => pulse_out, 
                                     enable => enable_counter,
                                     clock  => clock );

  -- 
  --pulse_generator : process (clock) is
  --begin  -- process main
  --  if rising_edge(clock) then          -- rising clock edge
  --    if enable_counter = '1' then
  --      counter <= counter + 1;
  --      if counter = divisor then
  --        pulse_out <= '1';
  --       counter   <= (others => '0');
  --     else
  --        pulse_out <= '0';
  --      end if;
  --    else
  --      counter <= (others => '0');
  --    end if;
  --  end if;
  --end process pulse_generator;

  state_machine : process (clock) is
  begin  -- process state_machine
    if rising_edge(clock) then          -- rising clock edge
      case state is
        when IDLE =>
          enable_counter <= '0';
          if uart_rx = '0' then
            state <= START;
          end if;
        when START =>
          -- enable baudrate_generator
          enable_counter <= '1';
          if pulse_out = '1' then
            state <= TxBIT0;
          end if;
        when TxBIT0 =>
          if pulse_out = '1' then
            state <= TxBIT1;
          end if;
        when TxBIT1 =>
          if pulse_out = '1' then
            state <= TxBIT2;
          end if;
        when TxBIT2 =>
          if pulse_out = '1' then
            state <= TxBIT3;
          end if;
        when TxBIT3 =>
          if pulse_out = '1' then
            state <= TxBIT4;
          end if;
        when TxBIT4 =>
          if pulse_out = '1' then
            state <= TxBIT5;
          end if;
        when TxBIT5 =>
          if pulse_out = '1' then
            state <= TxBIT6;
          end if;
        when TxBIT6 =>
          if pulse_out = '1' then
            state <= TxBIT7;
          end if;
        when TxBIT7 =>
          if pulse_out = '1' then
            state <= IDLE;
          end if;
        when others => null;
      end case;
    end if;
  end process state_machine;

  delay_line : process (clock) is
  begin  -- process delay_line
    if rising_edge(clock) then          -- rising clock edge
      if pulse_out = '1' then
        --start_count
        enable_delay <= '1';
      end if;
      if delay_counter = half_divisor then
        enable_delay <= '0';
        baudrate_out <= '1';
      --end count
      else
        baudrate_out <= '0';
      end if;
      if enable_delay = '1' then
        delay_counter <= delay_counter + 1;
      else
        delay_counter <= (others => '0');
      end if;
    end if;
  end process delay_line;

end architecture rtl;