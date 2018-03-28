----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	TB_Test - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Aucun					

-- Description: Testbench 1er Programme de Prise en Main
--
--------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Test is
end TB_Test;

architecture Behavioral of TB_Test is
    
-- Signaux pour le port map du module à tester
signal SW0 : STD_LOGIC;
signal SW1 : STD_LOGIC;
signal SW2 : STD_LOGIC;
signal LED : STD_LOGIC_VECTOR (2 downto 0);

begin

-- Instanciation du Module Test
l0: entity work.Test
port map(SW0,SW1,SW2,LED);

-- Evolution des Entrees
SW0 <= '0', '1' after 200 ns, '0' after 800 ns;
SW1 <= '0', '1' after 400 ns;
SW2 <= '0', '1' after 600 ns;

end Behavioral;
