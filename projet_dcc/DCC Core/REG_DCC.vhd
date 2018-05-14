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
    generic (DATA_WIDTH	: integer := 32);

    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            Frame_DCC : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
            Com_reg: in STD_LOGIC_VECTOR(1 downto 0);
            FIN_DCC: out std_logic;
            cmd : out STD_LOGIC
);
end reg_dcc;

architecture Behavioral of reg_dcc is

signal bit_cmd, fin : std_logic;
signal tmp_shift: std_logic_vector(DATA_WIDTH-1 downto 0); 
signal cpt : integer range 0 to DATA_WIDTH := 0;
----------------counter
signal end_cmd, ena, raz : std_logic;
----------------shift and charge
signal shift_sig, charge_sig : std_logic;
----------------mea fsm
TYPE state IS (init, charge_cmd, hold, sending, shift, cmd_end); 
--------can also use a state register : SIGNAL sreg :std_logic_vector(6 DOWNTO 0);
signal EP, EF : state;

begin
    FIN_DCC <= fin;
    --cmd <= bit_cmd;
    cmd <= tmp_shift(DATA_WIDTH-1);
        ----states
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            EP <= init;
        elsif rising_edge(clk_100MHz) then
            EP <= EF;  
        end if;
    end process;

    process (EP, Com_reg, cpt)
        begin
        case EP is 
            -- init
            when init =>    --state 0
                fin <= '0';                
                ena <= '0';
                raz <= '1';
                shift_sig <= '0';
                charge_sig <= '0';
                
                EF <= charge_cmd;
            when charge_cmd =>  --state 1
                fin <= '0';                
                ena <= '0';
                raz <= '1';
                shift_sig <= '0';
                charge_sig <= '1';-- tmp_shift <= Frame_DCC; 
                              
                EF <= hold;
            when hold =>----------------charge next cmd frame   --state 2
                fin <= '0';
                ena <= '0';
                raz <= '0';           
                shift_sig <= '0';
                charge_sig <= '0';
                
                if Com_reg = "00" then --hold
                    EF <= hold;
                elsif Com_reg = "01" then --next
                    EF <= sending;
                end if;
            when sending =>  --state 3
                fin <= '0';
                ena <= '1';
                raz <= '0';           
                shift_sig <= '0';
                charge_sig <= '0';
                
                --bit_cmd <= tmp_shift(DATA_WIDTH-1);
                EF <= shift;
            when shift =>   --state 4
                fin <= '0';
                ena <= '1';
                raz <= '0';           
                charge_sig <= '0';
                shift_sig <= '1'; --tmp_shift((DATA_WIDTH-1) downto 1) <= tmp_shift((DATA_WIDTH-2) downto 0);       
          
                    if cpt = DATA_WIDTH  then
                        EF <= cmd_end;
                    else
                        if Com_reg = "00" then --hold
                            EF <= hold;
                        elsif Com_reg = "01" then --next
                            EF <= sending;
                        end if;
                    end if;
            when cmd_end =>  --state 5
                fin <= '1';
                ena <= '0';
                raz <= '1';          
                shift_sig <= '0';
                charge_sig <= '0';

                if Com_reg = "11" then 
                    EF <= charge_cmd;
                else 
                    EF <= cmd_end;
                end if; 
            when others => null;
        end case;
            
     end process;
     
     ----counter
     process ( raz, ena)   
     begin 
        if raz = '1' then 
            cpt <= 0;
        elsif  rising_edge(ena) then --------------------------wtf post sythesis simu OK
            cpt <= cpt + 1;
        end if; 
     end process;
     
    --  shift
     process (clk_100MHz)
          begin 
              if rising_edge(clk_100MHz) then
                  if shift_sig = '1' then
                       tmp_shift((DATA_WIDTH-1) downto 1) <= tmp_shift((DATA_WIDTH-2) downto 0);
                       tmp_shift(0) <= '0';
                  end if;
              end if;
          end process;
          
    --charge  
    process (charge_sig)
          begin 
                    if charge_sig = '1' then
                        tmp_shift <= Frame_DCC;
                    end if;
                end process;          
--    process (reset, Com_reg)
--        begin 
--            if reset = '0' then
--                tmp <= Frame_DCC;
--            else 
--                if Com_reg = "11"   then-- if rising_edge(com_reg(1))then 
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
