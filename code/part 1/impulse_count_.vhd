----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	Impulse_Count - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Impulse_Count.xdc					

-- Description: Compteur d'Impulsions - Version KO
--
--		Compteur d'Impulsions sur 4 bits
--			- Le Compteur s'Incrémente si on Appuie sur le Bouton Left
--			- Le Compteur se'Décrémente si on Appuie sur le Bouton Center
--			- Sup Passe à 1 si le Compteur Dépasse 9
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity IMPULSE_COUNT is
    Port ( Reset : in  STD_LOGIC;								-- Reset Asynchrone
           Button_L : in  STD_LOGIC;							-- Bouton Left
           Button_C : in  STD_LOGIC;							-- Bouton Center
           Count : out  STD_LOGIC_VECTOR (3 downto 0);	-- Compteur d'Impulsions
           Sup : out  STD_LOGIC);								-- Indicateur Valeur Seuil
end IMPULSE_COUNT;

architecture Behavioral of IMPULSE_COUNT is

signal cpt: std_logic_vector(3 downto 0);		-- Compteur d'Impulsions

begin

	count <= cpt;	-- Affichage en Sortie du Compteur

	-------------------------
	-- Gestion du Compteur --
	-------------------------
	process(reset,Button_L,Button_C)

	begin

		-- Reset Asynchrone
		if reset='1' then cpt<="0000"; end if;

		-- Incrémentation Si on Appuie sur le Bouton Left
		if rising_edge(Button_L) then			
			cpt<=cpt+1;
		end if;
		
		-- Décrémentation Si on Appuie sur le Bouton Center
		if rising_edge(Button_C) then			
            cpt<=cpt-1;
        end if;
		
	end process;

	-------------------------
	-- Gestion du Flag Sup --
	-------------------------
	process(Cpt)

	begin
		
		-- Mise à 1 si CPT Dépasse 9. A 0 Sinon...
		if (cpt > 9) then 			
			Sup<='1'; 									
		else 							
			Sup<='0'; 
		end if;
	end process;

end Behavioral;

