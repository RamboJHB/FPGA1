----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	Test_CPT - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Test_CPT.xdc					

-- Description: Compteurs Imbriqués - Version KO
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Test_CPT is
    Port ( Clk : in  STD_LOGIC;								-- Horloge
           Reset : in  STD_LOGIC;							-- Reset Asynchrone
           Button_L : in  STD_LOGIC;						-- Bouton Left
           LED : out  STD_LOGIC_VECTOR (3 downto 0));	-- LED de sortie
end Test_CPT;

architecture Behavioral of Test_CPT is

signal Cpt: integer range 0 to 20000000;		-- Compteur Modulo N
signal CPT2: std_logic_vector(27 downto 0); 	-- Compteur sur 27 bits
signal start : std_logic;							-- Commande Incrementation CPT2

begin

	--------------------------
	-- Gestion Cpt et Start --
	--------------------------
	process(Clk,Reset)
	
	begin
	
		-- Reset Asynchrone
		if Reset = '1' then Cpt <= 0; start <='0';
	
		-- Au Front d'Horloge...
		elsif rising_edge(Clk) then
	
			Cpt <= Cpt + 1;	-- Incrémentation CPT
		
			-- Si on Arrive à la Valeur Limite
			if Cpt = 70000000 then 
				start <= not start; 	-- On Inverse le Niveau de Start
				Cpt <= 0; 				-- RAZ Synchrone de CPT
			end if;
		
		end if;
	end process;
	
	
	------------------
	-- Gestion CPT2 --
	------------------
	process(Clk,Reset)
	
	begin
	
		-- Reset Asynchrone
		if Reset = '1' then Cpt2 <= (others => '0');
	
		-- Au Front d'Horloge...
		elsif rising_edge(Clk) then
	
			-- Incrémentation de CPT2 sur Start
			if start = '1' then 
				Cpt2 <= Cpt2 + 1;
			end if;
		end if;
	end process;
	
	
	------------------
	-- Gestion LED--
	------------------
		-- Bouton Relâché --> Affichage des 4 MSB de CPT2
		-- Bouton Appuyé  --> Les 4 LED sont Allumées
	
	LED <= Cpt2(27 downto 24) when Button_L='0'
			else "1111";

	
end Behavioral;

