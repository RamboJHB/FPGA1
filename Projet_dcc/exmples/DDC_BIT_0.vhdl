----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2018 10:06:05
-- Design Name: 
-- Module Name: DCC_BIT_0 - Behavioral
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

entity DCC_BIT_0 is
    Port (  Go_0 : in STD_LOGIC;
            clk_100MHz: in STD_LOGIC;
            clk_1MHz : in std_logic;
            reset : in std_logic;
            FIN_0 : out STD_LOGIC;
            DCC_0 : out STD_LOGIC
);
end DCC_BIT_0;

architecture Behavioral of DCC_BIT_0 is

TYPE state IS (idle, send_low, send_high , fini);
signal EP, EF : state;

signal cpt : integer range 0 to 100000;
signal fin : std_logic;     
signal dcc : std_logic;     -- out put
signal start : std_logic;   -- start sending

begin
    FIN_0 <= fin;
    DCC_0 <= dcc;
    
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            EP <= idle;
            cpt <= 0;
        elsif rising_edge(clk_100MHz) then
            EP <= EF;  
        end if;
    end process;
    
    ----mae
    process (clk_100MHz, Go_0)
        begin 
        case EP is 
            -- idle
            when idle =>
                if Go_0 = '1' then 
                    EF <= send_low;
                else EF <= idle;
                end if;
            --sending 
            when send_low =>
                dcc <= '0';
                cpt <= cpt + 1;
                if cpt = 100000 then
                    cpt <= 0; 
                    EF <= send_high;
                else EF <= send_low;
                end if;
            when send_high =>
                dcc <= '1';
                cpt <= cpt + 1;
                if cpt = 100000 then
                    fin <= '1';
                    EF <= fini;
                else EF <= send_high;
                end if;
            --finished
            when fini => EF <= idle;
            when others => null;
        end case;
    end process;
 
end Behavioral;
