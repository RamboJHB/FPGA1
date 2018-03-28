----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	Impulse_Selector - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Impulse_Selector.xdc					

-- Description: Top Level Impulse_Count + Selector
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Impulse_Selector is
    Port ( Clk: in STD_LOGIC;
			  Reset : in  STD_LOGIC;
           Button_L : in  STD_LOGIC;
           Button_C : in  STD_LOGIC;
           Button_R: in STD_LOGIC;
           Limit : out  STD_LOGIC_VECTOR (27 downto 0));
end Impulse_Selector;

architecture Behavioral of Impulse_Selector is

signal Sup : STD_LOGIC;
signal Count : STD_LOGIC_VECTOR (3 downto 0);

begin

   Sel: entity work.Selector PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Button_R => Button_R,
          Count => Count,
          Sup => Sup,
          Limit => Limit
        );

	-- Instantiate the Unit Under Test (UUT)
   Impulse: entity work.IMPULSE_COUNT PORT MAP (
          Clk => Clk,
			 Reset => Reset,
          Button_L => Button_L,
          Button_C => Button_C,
          Count => Count,
          Sup => Sup
        );


end Behavioral;

