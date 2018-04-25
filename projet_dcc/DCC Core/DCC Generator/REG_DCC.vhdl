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

entity reg_dcc is
    generic (DATA_WIDTH	: integer := 8);

    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            Frame_DCC : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);------------------------1 bit
            Com_reg: in STD_LOGIC_VECTOR(1 downto 0);
            FIN_DCC: out std_logic;
            cmd : out STD_LOGIC
);
end reg_dcc;

architecture Behavioral of reg_dcc is

signal fin : std_logic;
signal tmp: std_logic_vector(DATA_WIDTH-1 downto 0); 

begin

    FIN_DCC <= fin;


    process (reset, Com_reg)
    begin 
        if reset = '0' then
	    tmp <= Frame_DCC;
        --elsif rising_edge(clk_100MHz) then 	    
        else 
            if Com_reg = "11"   then
                
                tmp <= Frame_DCC;
            elsif Com_reg = "01" then	---------charge and shift
                cmd <= tmp(DATA_WIDTH-1);
                --for i in DATA_WIDTH-2 to 0  loop
                    tmp(DATA_WIDTH-1 downto 1) <= tmp(DATA_WIDTH-2 downto 0);
               -- end loop;
            end if;
        end if;
    
    end process;

end Behavioral;

