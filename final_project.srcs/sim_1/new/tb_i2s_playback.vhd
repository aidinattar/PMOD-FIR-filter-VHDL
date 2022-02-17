----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/15/2022 11:37:03 AM
-- Design Name: 
-- Module Name: tb_i2s_playback - Behavioral
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

use STD.textio.all; --per caricare i file

ENTITY tb_top IS
END tb_top;

architecture Behavioral of tb_top is

component top is
    GENERIC(
        shift   : INTEGER := 7;
        d_width : INTEGER := 24;
        coeff1  : integer :=  0;
        coeff2  : integer :=  0;
        coeff3  : integer :=  0;
        coeff4  : integer :=  0;
        coeff5  : integer :=  0;
        coeff6  : integer :=  0;
        coeff7  : integer :=  0;
        coeff8  : integer :=  0;
        coeff9  : integer :=  0;
        coeff10 : integer :=  0;
        coeff11 : integer :=  0;
        coeff12 : integer :=  0;
        coeff13 : integer :=  0;
        coeff14 : integer :=  0;
        coeff15 : integer :=  0);                    --data width
    PORT(
        CLK100MHZ    :  IN  STD_LOGIC;                     --system clock (100 MHz on Basys board)
        reset_n      :  IN  STD_LOGIC;                     --active low asynchronous reset
        rst_l        :  IN  STD_LOGIC;                     --reset FIR left
        rst_r        :  IN  STD_LOGIC;                     --reset FIR right
        mclk         :  OUT STD_LOGIC_VECTOR(1 DOWNTO 0);  --master clock
        sclk         :  OUT STD_LOGIC_VECTOR(1 DOWNTO 0);  --serial clock (or bit clock)
        ws           :  OUT STD_LOGIC_VECTOR(1 DOWNTO 0);  --word select (or left-right clock)
        sd_rx        :  IN  STD_LOGIC;                     --serial data in
        sd_tx        :  OUT STD_LOGIC;
        uart_rxd_out :  OUT STD_LOGIC);                    --serial data out UART
end component top;

signal s_clk, s_rst, s_sd_rx, s_sd_tx, s_data : std_logic;
signal s_mclk, s_sclk, s_ws : std_logic_vector(1 downto 0);
signal s_rst_r, s_rst_l : std_logic;
signal s_uart_rxd_out : std_logic;
file file_VECTORS   : text; --file di input

begin

uut : top port map( CLK100MHZ => s_clk, reset_n => s_rst, rst_r => s_rst_r, rst_l => s_rst_l, sd_rx => s_sd_rx, sd_tx => s_sd_tx, mclk => s_mclk, sclk => s_sclk, ws => s_ws, uart_rxd_out => s_uart_rxd_out );

p_clk : process is
begin
    s_clk <= '1'; wait for 5 ns;
    s_clk <= '0'; wait for 5 ns;
end process p_clk;

p_rst : process is
begin
    s_rst <= '1'; wait for 10 ns;
    s_rst <= '0'; wait;
end process p_rst;

p_rst_l : process is
begin
    s_rst_l <= '1'; wait for 10 ns;
    s_rst_l <= '0'; wait;
end process p_rst_l;

p_rst_r : process is
begin
    s_rst_r <= '1'; wait for 10 ns;
    s_rst_r <= '0'; wait;
end process p_rst_r;

p_sd_rx : process is
variable v_LINE : line;
variable i_data : integer;
begin 
    --file_open(file_VECTORS, "/home/alberto/input.txt", read_mode); --apro l'input
    file_open(file_VECTORS, "/home/aidin/CrucialSSD/University/Management_and_Analysis_of_Physics_Datasets/Laboratory/input.txt", read_mode); --apro l'input
    wait until rising_edge(s_clk); --ricorda che questi sono i clock veloci 
    data : while not endfile(file_VECTORS) loop --  ciclo fin quando non finiscono i dati
        readline(FILE_VECTORS, v_LINE);
        read(v_LINE, i_data);
        if i_data = 1 then
            s_sd_rx <= '1'; wait for 5 ns;
        else
            s_sd_rx <= '0'; wait for 5 ns;
        end if;
    end loop data;
    
end process p_sd_rx;

end Behavioral;
