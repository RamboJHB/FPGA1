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

entity send_tb is
end send_tb;

architecture Behavioral of send_tb is
    
-- Signaux pour le port map du module à tester
signal Go_0 :  STD_LOGIC;
signal clk_100MHz:  STD_LOGIC;
signal clk_1MHz :  std_logic;
signal reset :  std_logic;
signal FIN_0 :  STD_LOGIC;
signal DCC_0 :  STD_LOGIC;

signal Go_1 :  STD_LOGIC;
signal FIN_1 :  STD_LOGIC;
signal DCC_1 :  STD_LOGIC;

constant clk_100MHz_period : time := 10 ns;
constant clk_1MHz_period : time := 1 us;

begin

-- Instanciation du Module Test


l0: entity work.send_zero
port map(
	    Go_0,
            clk_100MHz,
            clk_1MHz ,
            reset,
            FIN_0,
            DCC_0
);
l1: entity work.send_one

port map(
	    Go_1,
            clk_100MHz,
            clk_1MHz ,
            reset,
            FIN_1,
            DCC_1
);


-- Evolution des Entrees

GO_0 <= '0', '1' after 200 ns, '0' after 800 ns ,'1' after 2 ms, '0' after 3 ms;
GO_1 <= '0', '1' after 200 ns, '0' after 800 ns ,'1' after 2 ms, '0' after 3 ms;

 clk_100M :process
   begin
        clk_100MHz  <= '0';
        wait for clk_100MHz_period/2;  --for 0.5 ns signal is '0'.
        clk_100MHz  <= '1';
        wait for clk_100MHz_period/2;  --for next 0.5 ns signal is '1'.
   end process;

 clk_1M :process
   begin
        clk_1MHz  <= '0';
        wait for clk_1MHz_period/2;  --for 0.5 ns signal is '0'.
        clk_1MHz  <= '1';
        wait for clk_1MHz_period/2;  --for next 0.5 ns signal is '1'.
   end process;

end Behavioral;
