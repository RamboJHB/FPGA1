----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	TB_FSM - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Aucun		

-- Description: Testbench Machine à Etat
--
--				Fixe le Comportement des LEDs (Allumées/Eteintes/Clignotement)
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_FSM IS
END TB_FSM;
 
ARCHITECTURE behavior OF TB_FSM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FSM
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Mode : IN  std_logic_vector(1 downto 0);
         Seuil : IN  std_logic_vector(25 downto 0);
         LED : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Mode : std_logic_vector(1 downto 0) := (others => '0');
   signal Seuil : std_logic_vector(25 downto 0) := (others => '0');

 	--Outputs
   signal LED : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FSM PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Mode => Mode,
          Seuil => Seuil,
          LED => LED
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
	Reset <= '1', '0' after 2 ns;
	Seuil <= "00000000000000000000001001";
	Mode <= "00", "10" after 1 us, "11" after 3 us, "00" after 4 us; 

END;
