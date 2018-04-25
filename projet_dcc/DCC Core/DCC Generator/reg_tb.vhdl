----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2018 10:06:05
-- Design Name: 
-- Module Name: DCC_BIT_0 - Behavioral
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

entity reg_tb is
end reg_tb;

architecture Behavioral of reg_tb is
    
-- Signaux pour le port map du module à tester


signal            clk_100MHz:  STD_LOGIC;
signal            reset :  std_logic;
signal            Frame_DCC :  STD_LOGIC_VECTOR(7 downto 0);
signal            Com_reg:  STD_LOGIC_VECTOR(1 downto 0);
signal            FIN_DCC:  std_logic;
signal            cmd :  STD_LOGIC;

constant clk_100MHz_period : time := 10 ns;


begin

-- Instanciation du Module Test
label0: entity work.REG_DCC

port map(
     clk_100MHz,
            reset,            Frame_DCC,
            Com_reg,
            FIN_DCC,            cmd
);


-- Evolution des Entrees
reset <= '0', '1' after 10 ns;
Frame_DCC <= "10100000", "01010100" after  900 us;
Com_reg <= "00", "01" after 200 us, "00" after 400 us ,"01" after  500 us, "00" after 600 us, "01" after 700 us, "00" after 800 us, "01" after 900 us,"11" after 1000 us, "01" after 1100 us , "00" after 1200 us, "01" after 1300 us ;


 clk_100M :process
   begin
        clk_100MHz  <= '0';
        wait for clk_100MHz_period/2;  --for 0.5 ns signal is '0'.
        clk_100MHz  <= '1';
        wait for clk_100MHz_period/2;  --for next 0.5 ns signal is '1'.
   end process;

end Behavioral;
