----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2018 10:51:12
-- Design Name: 
-- Module Name: Tempo - Behavioral
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

entity Tempo is
    Port ( Com_tempo : in STD_LOGIC;
           clk_1MHz : in STD_LOGIC;
           reset : in STD_LOGIC;
           FIN_tempo : out STD_LOGIC);
end Tempo;

architecture Behavioral of Tempo is

signal fin : std_logic ;
signal start : std_logic ;

begin
FIN_tempo <= fin;

process(clk_1MHz, reset, start)
variable cpt : integer range 0 to 10000 := 0;
begin
    if(reset = '0') then 
        fin <= '0';
    elsif rising_edge(clk_1MHz) then
        if start = '1' then
            cpt := cpt + 1;
            if(cpt>6000) then
                cpt := 0 ;
                fin <= '1';
            end if;
        elsif start = '0' then
            fin <= '0';
        end if;
    end if;
end process;

 

process(Com_tempo, fin, reset)
begin
    if(reset = '0') then 
        start <= '0';                  
    elsif( Com_tempo = '1') then 
        start <= '1';
    elsif(fin = '1') then 
        start <= '0';
    end if;               

end process;

end Behavioral;
