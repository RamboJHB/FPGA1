----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2018 08:46:32
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity Gene_Frame is

    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            ------register dcc------
            Frame_DCC_0 : out STD_LOGIC_VECTOR(2 downto 0);  -- LSB 
            Frame_DCC_1 : out STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_2 : out STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_3 : out STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_4 : out STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_5 : out STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_6 : out STD_LOGIC_VECTOR(7 downto 0);  --MSB
            ------user interface------
            sw  : in STD_LOGIC_VECTOR(13 downto 0);
            leds     : out STD_LOGIC_VECTOR(15 downto 0);
            BNTC    : in STD_LOGIC;
            BNTU    : in STD_LOGIC;
            BNTD    : in STD_LOGIC;
            BNTL    : in STD_LOGIC;
            BNTR    : in STD_LOGIC

);
end Gene_Frame;

architecture Behavioral of Gene_Frame is
    
--signal Buttons
signal start_c, start_u, start_d, start_l, start_r : std_logic;
signal lock_c, lock_u, lock_d, lock_l, lock_r  : std_logic;
signal cpt_btnc, cpt_btnu, cpt_btnd, cpt_btnl, cpt_btnr: std_logic_vector(13 downto 0):=(others => '0');

--resgisters
signal DCC_Param_Address : std_logic_vector(7 downto 0) := "00000000"; --1st train by defaut
signal DCC_Param_Speed : std_logic_vector(7 downto 0)   := "01100000"; --
signal DCC_Param_Funct : std_logic_vector(7 downto 0)   := "10000000"; -- 
signal DCC_Param_Funct_plus : std_logic_vector(15 downto 0) := "1101111000000000";

signal DCC_Param_Control : std_logic_vector(7 downto 0);

----------------signal
--speed cmd
signal speed_step : std_logic_vector(3 downto 0) := "0000";            ----step 0 by defaut
signal direction : std_logic := '0';

--function cmd
signal active_go : std_logic := '0';

begin
    --------------------------------output------------------------------
    --Frame_DCC <= Frame_DCC_reg;

    leds(15) <= active_go;
    leds(3 DOWNTO 0) <= speed_step;
    leds(14 downto 4) <= "00000000000";
    -------------------------constructor Frame_DCC ---------------------
    --Frame_DCC_reg( 49 downto 35) <= "111111111111110"; -- 14 bits '1' start bit 0 
    Frame_DCC_6 <= "11111111";
    Frame_DCC_5(7 downto 1) <= "1111110";
    --Frame_DCC_reg( 34 downto 27 ) <= DCC_Param_Address;-- 8 bits address
    Frame_DCC_5(0) <= DCC_Param_Address(7);
    Frame_DCC_4(7 downto 1) <= DCC_Param_Address(6 downto 0);
    --Frame_DCC_reg(26) <= '0';
    Frame_DCC_4(0) <= '0'; 
    --func 0 -12 : cmd_speed = 110 xxxxx
    --Frame_DCC_reg( 25 downto 18 ) <= DCC_Param_Speed; 
    Frame_DCC_3 <= DCC_Param_Speed;
    --Frame_DCC_reg( 17 downto 10 ) <= DCC_Param_Funct;
    Frame_DCC_2 <= DCC_Param_Funct;
    --if function cmd is 16 bit (F13-F20)
        --Frame_DCC_reg( 22 downto 14 ) <= DCC_Param_Funct; --func13-20 : cmd_speed = 110 11110 
        --Frame_DCC_reg( 16 downto 9 ) <= DCC_Param_Funct_plus;
    --Frame_DCC_reg(9) <= '0';
    Frame_DCC_1 (7) <= '0';
    Frame_DCC_1( 6 downto 0 ) <= DCC_Param_Control( 7 downto 1 );
    Frame_DCC_0(1) <= DCC_Param_Control(0);
    Frame_DCC_0(0) <= '1';


    ------------------------------choose train ----------------------------
    --address cmd 
    --address <= 

    ----------------------------------set speed--------------------------------
    DCC_Param_Speed(3 downto 0) <=  speed_step;
    DCC_Param_Speed(4) <= '1';
    DCC_Param_Speed(5) <= direction;
 
    ---------------------------------set function --------------------------------
    process (clk_100MHz)
    begin 
	if rising_edge(clk_100MHz) then
            if sw(0)='1' or sw(1)='1' or sw(2)='1' or sw(3)='1' or sw(4)='1'  then      --------F0 - F4
		DCC_Param_Funct(7 downto 5) <= "100"; 
		if sw(0) = '1' then DCC_Param_Funct(0) <= '1'; else DCC_Param_Funct(0) <= '0'; end if;
		if sw(1) = '1' then DCC_Param_Funct(1) <= '1'; else DCC_Param_Funct(1) <= '0'; end if;
		if sw(3) = '1' then DCC_Param_Funct(2) <= '1'; else DCC_Param_Funct(2) <= '0'; end if;
		if sw(4) = '1' then DCC_Param_Funct(3) <= '1'; else DCC_Param_Funct(3) <= '0'; end if;
            elsif sw(5)='1' or sw(6)='1' or sw(7)='1' or sw(8)='1' then           --------F5 - F8
		DCC_Param_Funct(7 downto 4) <= "1011";
		if sw(5) = '1' then DCC_Param_Funct(0) <= '1'; else DCC_Param_Funct(0) <= '0'; end if;
		if sw(6) = '1' then DCC_Param_Funct(1) <= '1'; else DCC_Param_Funct(1) <= '0'; end if;
		if sw(7) = '1' then DCC_Param_Funct(2) <= '1'; else DCC_Param_Funct(2) <= '0'; end if;
		if sw(8) = '1' then DCC_Param_Funct(3) <= '1'; else DCC_Param_Funct(3) <= '0'; end if;
		 
	    elsif sw(9)='1' or sw (10) = '1' then                           --------F9 - F10
		DCC_Param_Funct(7 downto 4) <= "1010";
		if sw(9) = '1' then DCC_Param_Funct(0) <= '1'; else DCC_Param_Funct(0) <= '0'; end if;
		if sw(10) = '1' then DCC_Param_Funct(1) <= '1'; else DCC_Param_Funct(1) <= '0'; end if;
            else
                DCC_Param_Funct(7 downto 5) <= "110";
            end if;
        end if;
    end process;

    ----------------------------------"control" bits--------------------------------  
        DCC_Param_Control <= DCC_Param_Funct xor DCC_Param_Speed;
    -----------------------------get Button signals---------------------------------
    --center - active_go    - go/stop
    --up     - speed_step+1 - speed up
    --down   - speed_step-1 - speed down 
    --right  - change address   - swtich train
    --left   - change address   - switch train
    
    ----------------------------user interface-------------------------------- 
    process (clk_100MHz)
    begin 
    -- Button_center 160 us ====>   active_go
    if rising_edge(clk_100MHz) then
        if lock_c = '0' and BNTC = '1' then --pressed
            cpt_btnc <= (others => '0');
            start_c <= '1';
        else 
            if start_c = '1' then --counting 
                cpt_btnc <= cpt_btnc + 1;
            end if;

            if cpt_btnc = "11111010000000" then -- count done
                if BNTC = '1' then  --still pressing
                  active_go <= not active_go; -- bottun function 
                end if;
               start_c <= '0'; --stop conting 
            end if;
        end if;
        lock_c <= BNTC;

      if active_go = '0' then   
        speed_step <= "0000";
      else                      
        if speed_step = "0000" then
            speed_step <= "0001";
        else
            speed_step <= speed_step;
        end if;
      end if;
      
    -- Button_UP 160 us ====>  speed up  
        if lock_u = '0' and BNTU = '1' then --pressed
            cpt_btnu <= (others => '0');
            start_u <= '1';
        else 
            if start_u = '1' then --counting 
                cpt_btnu <= cpt_btnu + 1;
            end if;

            if cpt_btnu = "11111010000000" then -- count done
                if BNTU = '1' then  --still pressing
		            if speed_step = "0000" then 
	                   speed_step <= "0001";
		            else 
			           speed_step <= speed_step + 1;
                    end if;
                end if;
                start_u <= '0'; --stop conting 
            end if;
        end if;
        lock_u <= BNTU;  

    -- Button_DOWN   160 us ====>   speed down
        if lock_d = '0' and BNTD = '1' then --pressed
            cpt_btnd <= (others => '0');
            start_d <= '1';
        else 
            if start_d = '1' then --counting 
                cpt_btnd <= cpt_btnd + 1;
            end if;

            if cpt_btnd = "11111010000000" then -- count done
                if BNTD = '1' then  --still pressing
 		             if speed_step = "0001" then 
                        speed_step <= "0001";
		              else 
			             speed_step <= speed_step - 1;
                      end if;
                end if;
                start_d <= '0'; --stop conting 
            end if;
        end if;
        lock_d <= BNTD;  

    -- Button_left   160 us ====>  switch train
        if lock_l = '0' and BNTL = '1' then --pressed
            cpt_btnl <= (others => '0');
            start_l <= '1';
        else 
            if start_l = '1' then --counting 
                cpt_btnl <= cpt_btnl + 1;
            end if;

            if cpt_btnl = "11111010000000" then -- count done
                if BNTL = '1' then  --still pressing
		          if DCC_Param_Address = "00000001" then 
	                   DCC_Param_Address <= "00000010";
		          else 
			           DCC_Param_Address <= "00000010";
                  end if;
                end if;
                start_l <= '0'; --stop conting 
            end if;
        end if;
        lock_l <= BNTL; 
    
        end if;
    -- Button_Right   160 us ====>  switch train
        if lock_r = '0' and BNTR = '1' then --pressed
            cpt_btnr <= (others => '0');
            start_r <= '1';
        else 
            if start_r = '1' then --counting 
                cpt_btnr <= cpt_btnr + 1;
            end if;

            if cpt_btnr = "11111010000000" then -- count done
                if BNTR = '1' then  --still pressing
		          if DCC_Param_Address = "00000010" then 
	                DCC_Param_Address <= "00000001";
		          else 
			         DCC_Param_Address <= "00000001";
                  end if;
                end if;
                start_r <= '0'; --stop conting 
            end if;
        end if;
        lock_r <= BNTR;
    end process;
          
    --speed  

end Behavioral;
