LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

ENTITY led IS
	PORT(	sw_state : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			leds : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
END led;

ARCHITECTURE ArchLed OF led IS

BEGIN

	leds(15 DOWNTO 12) <= sw_state(3) & sw_state(3) & sw_state(3) & sw_state(3);
	leds(11 DOWNTO 8) <= sw_state(2) & sw_state(2) & sw_state(2) & sw_state(2);
	leds(7 DOWNTO 4) <= sw_state(1) & sw_state(1) & sw_state(1) & sw_state(1);
	leds(3 DOWNTO 0) <= sw_state(0) & sw_state(0) & sw_state(0) & sw_state(0);
	
END ArchLed;