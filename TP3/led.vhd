LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY LED IS
	PORT(	sw_state : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END LED;

ARCHITECTURE Behavioral OF LED IS
	
BEGIN
	leds(3 DOWNTO 0) <= sw_state(0) & sw_state(0) & sw_state(0) & sw_state(0);
	leds(7 DOWNTO 4) <= sw_state(1) & sw_state(1) & sw_state(1) & sw_state(1);
	leds(11 DOWNTO 8) <= sw_state(2) & sw_state(2) & sw_state(2) & sw_state(2);
	leds(12 DOWNTO 15) <= sw_state(3) & sw_state(3) & sw_state(3) & sw_state(3);
END Behavioral;	
