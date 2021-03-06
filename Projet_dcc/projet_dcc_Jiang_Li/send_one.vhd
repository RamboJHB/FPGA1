----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 14:12:39
-- Design Name: 
-- Module Name: send_one - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity send_one is
    Port (  Go_1 : in STD_LOGIC;
            clk_100MHz: in STD_LOGIC;
            clk_1MHz : in std_logic;
            reset : in std_logic;
            FIN_1 : out STD_LOGIC;
            DCC_1 : out STD_LOGIC
);
end send_one;

architecture Behavioral of send_one is

----------------mea fsm
TYPE state IS (idle, reset_cpt, send_low, send_high, send_fin);
signal EP, EF : state;

----------------counter P.S.40ns error at 1st send
signal cpt : integer range 0 to 117; ----0 to 116 error: bound check failed (#1)
signal ena : std_logic;
signal halftime : std_logic;
signal fulltime : std_logic;
signal raz : std_logic; 

----------------out signals
signal fin : std_logic;     
signal dcc : std_logic;     -- out put

begin
    FIN_1 <= fin;
    DCC_1 <= dcc;

    ----states
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            EP <= idle;	-- present state to idle
	    -- cpt <= 0  will cause error: "several sources for unresolved signal" in ghdl

        elsif rising_edge(clk_100MHz) then
            EP <= EF;  
        end if;
    end process;
    
    ----mae
    process (EP, Go_1, halftime, fulltime)
        begin 
        case EP is 
            -- idle
            when idle =>
		if Go_1 = '0' then 

                    EF <=  idle;
                    dcc <= '0';
                    ena <= '0';
                    raz <= '0';
                    fin <= '0';                    
                else 
                    EF <= reset_cpt;
                end if;
	    --reset cpt 
            when reset_cpt =>
                    dcc <= '0';
                    ena <= '1';
                    raz <= '1';
                    fin <= '0';
                    EF <= send_low;
            --sending 
            when send_low =>
                if halftime = '0' then 	
                    dcc <= '0';
	                ena <= '1';
	                raz <= '0';
		            fin <= '0';
                    EF <= send_low;
                else EF <= send_high;
                end if;
            when send_high =>
                if fulltime = '0' then
                    dcc <= '1';
                    ena <= '1';
                    raz <= '0';
                    fin <= '0';
                    EF <= send_high;
                else EF <= send_fin;
                end if;
            --finished
            when send_fin =>
                    dcc <= '0';
                    ena <= '0';
                    raz <= '0';
                    fin <= '1';
		EF <= idle;
            when others => null;
        end case;
    end process;

    ----counter
    process (clk_1MHz, raz, ena)  ---1 us  
        begin 
	if raz = '1' then 
		cpt <= 0;
		halftime <= '0';
		fulltime <= '0';
	
	elsif  rising_edge(clk_1MHz) then
		if ena = '1' then
			cpt <= cpt + 1;
			if cpt = 58 then
				halftime <= '1';
				fulltime <= '0';
			elsif cpt = 116 then 
				halftime <= '0';
				fulltime <= '1';
				cpt <= 0;
			end if;
		else
			halftime <= '0';
			fulltime <= '0';
			cpt <= 0;
		end if;
				
        end if;

    end process;
end Behavioral;