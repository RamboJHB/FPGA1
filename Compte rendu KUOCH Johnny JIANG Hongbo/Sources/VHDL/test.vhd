LIBRARY IEEE;			-- Inclusion de la library IEEE
USE IEEE.STD_LOGIC_1164.ALL;			-- Utilisation de toutes les fonctions du package STD_LOGIC_1164 de la library IEEE

ENTITY Test IS			-- Définition de l'entité
	PORT(	SW0 : IN STD_LOGIC;			-- Déclaration de ses ports d'entrées
			SW1 : IN STD_LOGIC;
			SW2 : IN STD_LOGIC;
			LED : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)			-- Déclaration de son port de sortie
		);
END Test;			-- Fin de la définition de l'entité

ARCHITECTURE ArchTest OF Test IS			-- Définition de l'architecture
	
BEGIN

	LED(0) <= SW0;			-- L'état logique de la led 0 est égal à l'état logique de l'interrupteur 0
	LED(1) <= SW1;			-- L'état logique de la led 1 est égal à l'état logique de l'interrupteur 1
	LED(2) <= SW2 AND SW1 AND SW0;			-- L'état logique de la led 2 est égal 1 si l'état logique des interrupteurs 0 et 1 est 1
	
END ArchTest;			-- Fin de la définition de l'architecture