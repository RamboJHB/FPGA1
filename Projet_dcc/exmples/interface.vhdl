----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2017 12:41:34
-- Design Name: 
-- Module Name: interface - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity interface is
    Port ( clk : in STD_LOGIC;
           Reset: in STD_LOGIC;
           BTNU: in STD_LOGIC;
           BTND: in STD_LOGIC;
           BTNL: in STD_LOGIC;
           BTNR: in STD_LOGIC;
           BTNC: in STD_LOGIC;
           LED: out STD_LOGIC_vector(15 downto 0);
           go: out STD_LOGIC;
           consigne : out STD_LOGIC_VECTOR (7 downto 0));
end interface;

architecture Behavioral of interface is
signal active_go: std_logic:= '0';
signal out_go: std_logic:= '0';
signal count_go: std_logic_vector(21 downto 0):=(others => '0');
signal cpt_btnc: std_logic_vector(13 downto 0):=(others => '0');
signal lock_c: std_logic:= '0';
signal cpt_btnl: std_logic_vector(13 downto 0):=(others => '0');
signal lock_l: std_logic:= '0';
signal cpt_btnr: std_logic_vector(13 downto 0):=(others => '0');
signal lock_r: std_logic:= '0';
signal cpt_btnu: std_logic_vector(13 downto 0):=(others => '0');
signal lock_u: std_logic:= '0';
signal cpt_btnd: std_logic_vector(13 downto 0):=(others => '0');
signal lock_d: std_logic:= '0';
signal start_c: std_logic:= '0';
signal start_u: std_logic:= '0';
signal start_d: std_logic:= '0';
signal start_l: std_logic:= '0';
signal start_r: std_logic:= '0';
signal option: std_logic_vector(1 downto 0):="00";
signal fonction_t: std_logic_vector(1 downto 0):= "00";
signal vitesse_t: std_logic_vector(1 downto 0):= "00";
signal adresse_t: std_logic_vector(2 downto 0):= "000";
begin


process(reset,clk)

	begin

		if reset = '0' then
		      count_go<=(others => '0');
		      out_go <= '0';
		elsif rising_edge(Clk) and active_go = '1' then			
	           count_go <= count_go + 1;
	           if count_go = "1010000110111110010000" then
	               out_go <= not out_go;
	               count_go<=(others => '0');
	           end if;
		end if;
		
	end process;
	


-- button_C pour activer go	

process(clk)
begin
    if rising_edge(clk) then
        if BTNC = '1' and lock_c = '0' then
            start_c <= '1';
            cpt_btnc <= (others => '0');
        else
            if start_c = '1' then
                cpt_btnc <= cpt_btnc + 1;
            end if;
            if cpt_btnc = "11111010000000" then
                if BTNC = '1' then
                    active_go <= not active_go;
                end if;
                start_c <= '0';
            end if;
        end if;
        lock_c <= BTNC;
    end if;
end process;

--process(BTNC)
--begin
--    if rising_edge(BTNC) then
--        active_go <= not active_go;
--    end if;
--end process;
	
--process(clk)
--begin
--if rising_edge(clk) then
--    if lock_c = '1' then
--	   cpt_btnc <= cpt_btnc + 1;
--	   if cpt_btnc = "1111101000" and BTNC = '1' then
--	       active_go <= not active_go;
--	       lock_c <= '0';
--	   end if;
--	else
--	   cpt_btnc <= (others => '0');
--	end if;
--end if;
--end process;

-- button_L button_R pour changer l'option

process(clk)
begin
    if rising_edge(clk) then
        if BTNL = '1' and lock_l = '0' then
            start_l <= '1';
            cpt_btnl <= (others => '0');
        else
            if start_l = '1' then
                cpt_btnl <= cpt_btnl + 1;
            end if;
            if cpt_btnl = "11111010000000" then
                if BTNL = '1' then
                    if option = "10" then
                        option <= "00";
                    else
                        option <= option + 1;
                    end if;
                end if;
                start_l <= '0';
            end if;
        end if;
        if BTNR = '1' and lock_r = '0' then
                start_r <= '1';
                cpt_btnr <= (others => '0');
        else
                if start_r = '1' then
                    cpt_btnr <= cpt_btnr + 1;
                end if;
                if cpt_btnr = "11111010000000" then
                    if BTNR = '1' then
                        if option = "00" then
                             option <= "10";
                        else
                             option <= option - 1;
                        end if;
                    end if;
                    start_r <= '0';
                end if;
        end if;
        lock_l <= BTNL;
        lock_r <= BTNR;
    end if;
end process;
	
--process(clk)
--begin
--if rising_edge(clk) then
--    if lock_l = '1' then
--	   cpt_btnl <= cpt_btnl + 1;
--	   if cpt_btnl = "1111101000" and BTNL = '1' then
--	       if option = "00" then
--	           option <= "10";
--	       else
--	           option <= option - 1;
--	       end if;
--	       lock_l <= '0';
--	   end if;
--	else
--	   cpt_btnl <= (others => '0');
--	end if;
--end if;
--end process;


--process(BTNR)
--begin
--    if rising_edge(BTNR) then
--        if option = "10" then
--                   option <= "00";
--        else
--                   option <= option + 1;
--        end if;
--    end if;
--end process;
	
--process(clk)
--begin
--if rising_edge(clk) then
--    if lock_r = '1' then
--	   cpt_btnr <= cpt_btnr + 1;
--	   if cpt_btnr = "1111101000" and BTNR = '1' then
--	       if option = "10" then
--	           option <= "00";
--	       else
--	           option <= option + 1;
--	       end if;
--	       lock_r <= '0';
--	   end if;
--	else
--	   cpt_btnr <= (others => '0');
--	end if;
--end if;
--end process;


-- button_U button_D pour changer la valeur

process(clk)
begin
    if rising_edge(clk) then
        if BTNU = '1' and lock_u = '0' then
            start_u <= '1';
            cpt_btnu <= (others => '0');
        else
            if start_u = '1' then
                cpt_btnu <= cpt_btnu + 1;
            end if;
            if cpt_btnu = "11111010000000" then
                if BTNU = '1' then
                    case option is
                                     when "00" =>
                                               fonction_t <= fonction_t + 1;
                                     when "01" =>
                                               vitesse_t <= vitesse_t + 1;
                                     when "10" =>
                                              adresse_t <= adresse_t + 1;
                                     when others => NULL;
                    end case;
                end if;
                start_u <= '0';
            end if;
        end if;
        if BTND = '1' and lock_d = '0' then
                start_d <= '1';
                cpt_btnd <= (others => '0');
        else
                if start_d = '1' then
                    cpt_btnd <= cpt_btnd + 1;
                end if;
                if cpt_btnd = "11111010000000" then
                    if BTND = '1' then
                        case option is
                                    when "00" =>
                                        fonction_t <= fonction_t - 1;
                                    when "01" =>
                                        vitesse_t <= vitesse_t - 1;
                                    when "10" =>
                                        adresse_t <= adresse_t - 1;
                                    when others => NULL;
                        end case;
                    end if;
                    start_d <= '0';
                end if;
        end if;
        lock_u <= BTNU;
        lock_d <= BTND;
    end if;
end process;

--process(clk)
--begin
--    if rising_edge(clk) then
--        if BTNU = '1' and lock_u = '0' then
--            case option is
--                     when "00" =>
--                               fonction_t <= fonction_t + 1;
--                     when "01" =>
--                               vitesse_t <= vitesse_t + 1;
--                     when "10" =>
--                              adresse_t <= adresse_t + 1;
--                     when others => NULL;
--            end case;
--        elsif BTND = '1' and lock_d = '0' then
--            case option is
--                when "00" =>
--                    fonction_t <= fonction_t - 1;
--                when "01" =>
--                    vitesse_t <= vitesse_t - 1;
--                when "10" =>
--                    adresse_t <= adresse_t - 1;
--                when others => NULL;
--            end case;
--        end if;
--        lock_u <= BTNU;
--        lock_d <= BTND;
--    end if;
--end process;

--process(BTNU)
--begin
--    if rising_edge(BTNU) then
--        case option is
--             when "00" =>
--                       fonction_t <= fonction_t + 1;
--             when "01" =>
--                       vitesse_t <= vitesse_t + 1;
--             when "10" =>
--                       adresse_t <= adresse_t + 1;
--             when others => NULL;
--        end case;
--    end if;
--end process;
	
--process(clk)
--begin
--if rising_edge(clk) then
--    if lock_u = '1' then
--	   cpt_btnu <= cpt_btnu + 1;
--	   if cpt_btnu = "1111101000" and BTNU = '1' then
--	       case option is
--	           when "00" =>
--	               fonction_t <= fonction_t + 1;
--	           when "01" =>
--                   vitesse_t <= vitesse_t + 1;
--               when "10" =>
--                   adresse_t <= adresse_t + 1;
--              when others => NULL;
--	       end case;
--	       lock_u <= '0';
--	   end if;
--	else
--	   cpt_btnu <= (others => '0');
--	end if;
--end if;
--end process;


--process(BTND)
--begin
--    if rising_edge(BTND) then
--        case option is
--                   when "00" =>
--                      fonction_t <= fonction_t - 1;
--                   when "01" =>
--                       vitesse_t <= vitesse_t - 1;
--                   when "10" =>
--                       adresse_t <= adresse_t - 1;
--                   when others => NULL;
--        end case;
--    end if;
--end process;
	
--process(clk)
--begin
--if rising_edge(clk) then
--    if lock_d = '1' then
--	   cpt_btnd <= cpt_btnd + 1;
--	   if cpt_btnd = "1111101000" and BTND = '1' then
--	       case option is
--	           when "00" =>
--	               fonction_t <= fonction_t - 1;
--	           when "01" =>
--                   vitesse_t <= vitesse_t - 1;
--               when "10" =>
--                   adresse_t <= adresse_t - 1;
--               when others => NULL;
--	       end case;
--	       lock_d <= '0';
--	   end if;
--	else
--	   cpt_btnd <= (others => '0');
--	end if;
--end if;
--end process;



--leds

LED(15) <= active_go;
LED(14) <= '1' when option = "10" else
           '0';
LED(13) <= '1' when option = "01" else
                      '0';
LED(12) <= '1' when option = "00" else
           '0';
           
LED(6 downto 4) <= adresse_t;
LED(3 downto 2) <= vitesse_t;
LED(1 downto 0) <= fonction_t;

go <= out_go;
consigne(7) <= '0';
consigne(6 downto 4) <= adresse_t;
consigne(3 downto 2) <= vitesse_t;
consigne(1 downto 0) <= fonction_t;

end Behavioral;
