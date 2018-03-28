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
           Clk : IN STD_LOGIC;									-- Signal Horloge
		   Button_L : in  STD_LOGIC;							-- Bouton Left
           Button_C : in  STD_LOGIC;							-- Bouton Center
           Count : out  STD_LOGIC_VECTOR (3 downto 0);	-- Compteur d'Impulsions
           Sup : out  STD_LOGIC);								-- Indicateur Valeur Seuil
end IMPULSE_COUNT;

architecture Behavioral of IMPULSE_COUNT is

signal cpt: std_logic_vector(3 downto 0);		-- Compteur d'Impulsions
SIGNAL imp_L : STD_LOGIC;
SIGNAL imp_C : STD_LOGIC;
SIGNAL L_last : STD_LOGIC;
SIGNAL C_last : STD_LOGIC;
SIGNAL lock : STD_LOGIC;
SIGNAL cpt_lock : INTEGER := 0;
BEGIN

	imp_L <= Button_L AND (NOT L_last);
	imp_C <= Button_C AND (NOT C_last);
	count <= cpt;	-- Affichage en Sortie du Compteur

	-------------------------
	-- Gestion du Compteur --
	-------------------------
	process(Clk,Reset)

	begin

	IF Reset = '1'
	THEN
		cpt <= "0000";
		L_last <= '0';
		C_last <= '0';
		lock <= '0';
		
		ELSIF RISING_EDGE(Clk)
		THEN
			L_last <= Button_L;
			C_last <= Button_C;
			
			IF imp_L = '1'
			THEN
				IF lock = '0'
				THEN 
					cpt <= cpt - 1;
					lock <= '1';
				END IF;
			
			IF imp_C = '1'
			THEN
				IF lock = '0'
				THEN
					cpt <= cpt - 1;
					lock <= '1';
				END IF;
			END IF;
			
			IF lock = '1'
			THEN
				cpt_lock <= cpt_lock + 1;
				IF cpt_lock = 10000000
				THEN
					cpt_lock <= 0;
					lock <= '0';
				END IF;
			END IF;
		END IF;
	END IF;
	END PROCESS;

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

