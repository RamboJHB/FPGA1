----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2018 08:49:05
-- Design Name: 
-- Module Name: REG_DCC - Behavioral
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

signal bit_cmd, fin : std_logic;
signal tmp: std_logic_vector(DATA_WIDTH-1 downto 0); 
signal cpt : integer range 0 to DATA_WIDTH := 0;

----------------mea fsm
TYPE state IS (init, charge_cmd, hold, sending, shift, cmd_end); 
--------can also use a state register : SIGNAL sreg :std_logic_vector(6 DOWNTO 0);
signal EP, EF : state;

begin
    FIN_DCC <= fin;
    cmd <= bit_cmd;
        ----states
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            EP <= init;
        elsif rising_edge(clk_100MHz) then
            EP <= EF;  
        end if;
    end process;

    process (EP, Com_reg)
        begin 
        case EP is 
            -- init
            when init =>
                fin <= '0';
                EF <= charge_cmd;
            when charge_cmd =>
                tmp <= Frame_DCC;
                EF <= hold;
            when hold =>----------------charge next cmd frame
                fin <= '0';
               
                if Com_reg = "00" then --hold
                    EF <= hold;
                elsif Com_reg = "01" then --next
                    EF <= sending;
                end if;
            when sending =>
                fin <= '0';
                bit_cmd <= tmp(DATA_WIDTH-1);
                EF <= shift;
            when shift =>
                    tmp(DATA_WIDTH-1 downto 1) <= tmp(DATA_WIDTH-2 downto 0);
                    cpt <= cpt + 1 ;
                    if cpt = DATA_WIDTH-1  then
                        EF <= cmd_end;
                        cpt <= 0;
                    else
                        if Com_reg = "00" then --hold
                            EF <= hold;
                        elsif Com_reg = "01" then --next
                            EF <= sending;
                        end if;
                    end if;
            when cmd_end =>
                fin <= '1';
                bit_cmd <= tmp(DATA_WIDTH-1); -------------last cmd bit
                if Com_reg = "11" then 
                    EF <= charge_cmd;
                else 
                    EF <= cmd_end;
                end if; 
            when others => null;
        end case;
            
     end process;
--    process (reset, Com_reg)
--        begin 
--            if reset = '0' then
--                tmp <= Frame_DCC;
--            else 
--                if Com_reg = "11"   then
--                    fin <= '0';
--                    tmp <= Frame_DCC;
--                elsif Com_reg = "01" then    ---------charge and shift
--                    cpt <= cpt + 1;
--                    cmd <= tmp(DATA_WIDTH-1);
--                    fin <= '0';
--                    tmp(DATA_WIDTH-1 downto 1) <= tmp(DATA_WIDTH-2 downto 0);
--                    if cpt = DATA_WIDTH then 
--                        fin <= '1';
--                        cpt <= 0;
--                    end if;
--                end if;
--            end if;
--    end process;

end Behavioral;