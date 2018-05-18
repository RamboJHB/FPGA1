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

signal tmp_in_0: std_logic_vector(1 downto 0); 
signal tmp_in_1: std_logic_vector(2 downto 0); 
signal tmp_in_2: std_logic_vector(2 downto 0); 
signal tmp_in_3: std_logic_vector(2 downto 0); 
signal tmp_in_4: std_logic_vector(2 downto 0); 
signal tmp_in_5: std_logic_vector(2 downto 0); 
signal tmp_in_6: std_logic_vector(2 downto 0); 
signal tmp_in_7: std_logic_vector(2 downto 0); 
signal tmp_in_8: std_logic_vector(2 downto 0); 
signal tmp_in_9: std_logic_vector(2 downto 0); 
signal tmp_in_10: std_logic_vector(2 downto 0); 

signal tmp_shift: std_logic; 
signal cpt : integer range 0 to (DATA_WIDTH + 1) := 0;


----------------counter
signal end_cmd, ena, raz : std_logic;
----------------shift and charge
signal shift_sig, charge_sig : std_logic;
----------------mea fsm
TYPE state IS (init, charge_cmd, charge_end, hold, sending, shift, shift_end, cmd_end);
--------can also use a state register : SIGNAL sreg :std_logic_vector(6 DOWNTO 0);
signal EP, EF : state;

begin
    FIN_DCC <= fin;
    --cmd <= bit_cmd;


    cmd <= tmp_in_10(2);
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
                charge_sig <= '1';
                              
                EF <= charge_end;
            when charge_end =>  --state 2
                fin <= '0';
                ena <= '0';
                raz <= '0';
                shift_sig <= '0';
                charge_sig <= '0';-- tmp_shift <= Frame_DCC;

                EF <= hold;

            when hold =>   --state 3
                fin <= '0';
                ena <= '0';
                raz <= '0';           
                shift_sig <= '0';
                charge_sig <= '0';
                
                if Com_reg = "00" then --hold
                    EF <= hold;
                elsif Com_reg = "01" then --next
                    EF <= sending;
                else
                    EF <=hold;
                end if;
            when sending =>  --state 4
                fin <= '0';
                ena <= '1';
                raz <= '0';           
                shift_sig <= '0';
                charge_sig <= '0';
                
                --bit_cmd <= tmp_shift(DATA_WIDTH-1);
                EF <= shift;

            when shift =>
                fin <= '0';
                ena <= '1';
                raz <= '0';
                shift_sig <= '1';
                charge_sig <= '0';

                EF <= shift_end;

            when shift_end =>   --state 5
                fin <= '0';
                ena <= '0';
                raz <= '0';           
                charge_sig <= '0';
                shift_sig <= '0';      
          
                    if cpt = DATA_WIDTH  then
                        EF <= cmd_end;
                    else
                        if Com_reg = "00" then --hold
                            EF <= hold;
                        elsif Com_reg = "01" then --next
                            EF <= sending;
                        else 
                            EF <= charge_cmd;
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
     

          
    --charge and shift  
    process (charge_sig, shift_sig)
          begin 
             if charge_sig = '1' then
             tmp_in_10 <= Frame_DCC(DATA_WIDTH-1 downto DATA_WIDTH-3);
             tmp_in_9 <= Frame_DCC(DATA_WIDTH-4 downto DATA_WIDTH-6);
             tmp_in_8 <= Frame_DCC(DATA_WIDTH-7 downto DATA_WIDTH-9);
             tmp_in_7 <= Frame_DCC(DATA_WIDTH-10 downto DATA_WIDTH-12);
             tmp_in_6 <= Frame_DCC(DATA_WIDTH-13 downto DATA_WIDTH-15);
             tmp_in_5 <= Frame_DCC(DATA_WIDTH-16 downto DATA_WIDTH-18);
             tmp_in_4 <= Frame_DCC(DATA_WIDTH-19 downto DATA_WIDTH-21);
             tmp_in_3 <= Frame_DCC(DATA_WIDTH-22 downto DATA_WIDTH-24);
             tmp_in_2 <= Frame_DCC(DATA_WIDTH-25 downto DATA_WIDTH-27);
             tmp_in_1 <= Frame_DCC(DATA_WIDTH-28 downto DATA_WIDTH-30);
             tmp_in_0 <= Frame_DCC(DATA_WIDTH-31 downto DATA_WIDTH-32); -- 2 bits
             elsif rising_edge(shift_sig) then
             tmp_in_10(2 downto 1) <= tmp_in_10(1 downto 0);
             tmp_in_10(0) <= tmp_in_9(2);
                                                     
             tmp_in_9(2 downto 1) <= tmp_in_9(1 downto 0);
             tmp_in_9(0) <= tmp_in_8(2);
             
             tmp_in_8(2 downto 1) <= tmp_in_8(1 downto 0);
             tmp_in_8(0) <= tmp_in_7(2);
             
             tmp_in_7(2 downto 1) <= tmp_in_7(1 downto 0);
             tmp_in_7(0) <= tmp_in_6(2);
             
             tmp_in_6(2 downto 1) <= tmp_in_6(1 downto 0);
             tmp_in_6(0) <= tmp_in_5(2);
             
             tmp_in_5(2 downto 1) <= tmp_in_5(1 downto 0);
             tmp_in_5(0) <= tmp_in_4(2);
             
             tmp_in_4(2 downto 1) <= tmp_in_4(1 downto 0);
             tmp_in_4(0) <= tmp_in_3(2);
             
             tmp_in_3(2 downto 1) <= tmp_in_3(1 downto 0);
             tmp_in_3(0) <= tmp_in_2(2);
             
             tmp_in_2(2 downto 1) <= tmp_in_2(1 downto 0);
             tmp_in_2(0) <= tmp_in_1(2);
            
             tmp_in_1(2 downto 1) <= tmp_in_1(1 downto 0);
             tmp_in_1(0) <= tmp_in_0(1);
             
             tmp_in_0(1) <=tmp_in_0(0);
             tmp_in_0(0) <= '0';
             
             else
             tmp_in_0 <= tmp_in_0;
             tmp_in_1 <= tmp_in_1;
             tmp_in_2 <= tmp_in_2;
             tmp_in_3 <= tmp_in_3;
             tmp_in_4 <= tmp_in_4;
             tmp_in_5 <= tmp_in_5;
             tmp_in_6 <= tmp_in_6;
             tmp_in_7 <= tmp_in_7;
             tmp_in_8 <= tmp_in_8;
             tmp_in_9 <= tmp_in_9;
             tmp_in_10 <= tmp_in_10;
             end if;
    end process;  
        
--    process (reset, Com_reg)
--        begin 
--            if reset = '0' then
--                tmp_shift <= Frame_DCC;
--            else 
--                if Com_reg = "11"   then-- if rising_edge(com_reg(1))then 
--                    fin <= '0';
--                    tmp_shift <= Frame_DCC;
--                elsif Com_reg = "01" then    ---------charge and shift
--                    cpt <= cpt + 1;
--                    cmd <= tmp_shift(DATA_WIDTH-1);
--                    fin <= '0';
--                    tmp_shift(DATA_WIDTH-1 downto 1) <= tmp_shift(DATA_WIDTH-2 downto 0);
--                    tmp_shift(0) <= '0';
--                    if cpt = DATA_WIDTH then 
--                        fin <= '1';
--                        cpt <= 0;
--                    end if;
--                end if;
--            end if;
--    end process;

end Behavioral;
