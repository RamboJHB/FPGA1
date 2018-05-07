----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.04.2018 14:12:39
-- Design Name: 
-- Module Name: diviseur_clk - Behavioral
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

entity diviseur_clk is
    Port ( clk_100MHz   : in STD_LOGIC;
           reset        : in STD_LOGIC; 
           clk_1MHz     : out STD_LOGIC);
end diviseur_clk;

architecture Behavioral of diviseur_clk is

signal cpt : INTEGER range  0 to 49;    --" 0 to 49 " different with "49 to 0" 
signal output : STD_LOGIC := '0';          -- cant use "clk" as signal name 
                                    
begin

    clk_1MHz <= output;
    process (clk_100MHz, reset)
    begin
        if reset = '0' then output <= '0';
                            cpt <= 0;
        elsif rising_edge(clk_100MHz) then
            cpt <= cpt + 1;
            if cpt = 49 then
                output <= not output;
                cpt <= 0;
            end if;
        end if;
    end process;
end Behavioral;
