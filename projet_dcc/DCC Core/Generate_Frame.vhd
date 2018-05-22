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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Gene_Frame is
    generic ( Frame_width : integer := 47 );
    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            ------register dcc------
            Frame_DCC: out std_logic_vector(47 downto 0);
            ------user interface------
            sw  : in STD_LOGIC_VECTOR(13 downto 0);
            leds     : out STD_LOGIC_VECTOR(13 downto 0);
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

signal Frame_DCC_reg : std_logic_vector(Frame_width-1 downto 0);
--resgisters
signal DCC_Param_Address : std_logic_vector(7 downto 0) := "00000000"; ----1st train by defaut
signal DCC_Param_Speed : std_logic_vector(7 downto 0)   := "01100001";
signal DCC_Param_Funct : std_logic_vector(7 downto 0);
signal DCC_Param_Funct_plus : std_logic_vector(16 downto 0);

signal DCC_Param_Control : std_logic_vector(31 downto 0);

----------------signal
--speed cmd
signal speed_step : std_logic_vector(4 downto 0) := "00000";            ----step 0 by defaut
signal direction : std_logic := '0';
signal speed_cpt : integer range 0 to 28 := 0;


--function cmd
signal func_sig : std_logic_vector(4 downto 0);


begin
    --------------------------------output------------------------------
    Frame_DCC <= Frame_DCC_reg;

    leds(15) = active_go;
	leds(11 DOWNTO 8) = sw_state(1) & sw_state(1) & sw_state(1) & sw_state(1);
    leds(7 DOWNTO 0) = speed_step;

    -------------------------constructor Frame_DCC ---------------------
    Frame_DCC_reg( 46 downto 33) <= "111111111111110"; -- 14 bits '1' start bit 0 
    Frame_DCC_reg( 32 downto 24 ) <= DCC_Param_Address;-- 8 bits address
    Frame_DCC_reg(23) <= '0';
    --func 0 -12 : cmd_speed = 110 xxxxx
    Frame_DCC_reg( 22 downto 14 ) <= DCC_Param_Speed; 
    Frame_DCC_reg( 16 downto 9 ) <= 00000;

    --if function cmd is 16 bit (F13-F20)
        --Frame_DCC_reg( 22 downto 14 ) <= DCC_Param_Funct; --func13-20 : cmd_speed = 110 11110 
        --Frame_DCC_reg( 16 downto 9 ) <= DCC_Param_Funct_plus;
    Frame_DCC_reg(8) <= '0';
    Frame_DCC_reg( 7 downto 0 ) <= DCC_Param_Control;
    

    ------------------------------choose train ----------------------------
    --address cmd 
    --address <= 

    ----------------------------------set speed--------------------------------
    DCC_Param_Speed(4 downto 0) <=  speed_step;
    DCC_Param_Speed(6) <= direction;
    
    ---------------------------------setfunction --------------------------------
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 

        elsif rising_edge(clk_100MHz) then
            case sw is   
                when "00000000000001"  =>
                    DCC_Param_Funct <= "000000";
                when "00000000000010"  =>
                    DCC_Param_Funct <= "000000";
                when "00000000000100"  =>
                    DCC_Param_Funct <= "000000";
                when "00000000001000"  =>
                    DCC_Param_Funct <= "000000";

                when others => NULL;

            end case;
        end if;
    end process;
    process (active_go, ac)
    ----------------------------------"control" bits--------------------------------  
    --DCC_Param_Control <= cmd_speed XOR cmd_func;
    --or
    for i in 0 to 7 loop
        DCC_Param_Control(i) <= DCC_Param_Funct(i) xor DCC_Param_Speed(i);
    end loop
    -----------------------------get Button signals---------------------------------
    --center - active_go    - go/stop
    --up     - speed_step+1 - speed up
    --down   - speed_step-1 - speed down 
    --right  - change address   - swtich train
    --left   - change address   - switch train
    
    ----------------------------user interface-------------------------------- 
    -- Button_center 160 us ====>   active_go
    process (clk_100MHz)
    begin 
    if rising_edge(clk_100MHz) then
        if lock_c = '0' and BTNC = '1' then --pressed
            cpt_btnc <= 0;
            start_c <= '1';
        else 
            if start_c = '1' then --counting 
                cpt_btnc <= cpt_btnc + 1;
            end if;

            if cpt_btnc = 234234234 then -- count done
                if BTNC = '1' then  --still pressing
                  active_go <= not active_go; -- bottun function 
                end if;
            end if;

            start_c <= '0'; --stop conting 
        end if;

        lock_c <= BTNC; --lock??????????????? 
    
      end if;
    end process;
    -- Button_UP 160 us ====>  speed up  
    process (clk_100MHz)
    begin 
    if rising_edge(clk_100MHz) then
        if lock_u = '0' and BTNU = '1' then --pressed
            cpt_btnu <= 0;
            start_u <= '1';
        else 
            if start_u = '1' then --counting 
                cpt_btnu <= cpt_btnu + 1;
            end if;

            if cpt_btnu = 234234234 then -- count done
                if BTNU = '1' then  --still pressing
                    speed_step <= speed_step + 1 ;      -- bottun function
                end if;
            end if;

            start_u <= '0'; --stop conting 
        end if;

        lock_u <= BTNU;  
    
      end if;
    end process;

    -- Button_DOWN   160 us ====>   speed down
    process (clk_100MHz)
    begin 
    if rising_edge(clk_100MHz) then
        if lock_d = '0' and BTND = '1' then --pressed
            cpt_btnd <= 0;
            start_d <= '1';
        else 
            if start_d = '1' then --counting 
                cpt_btnd <= cpt_btnd + 1;
            end if;

            if cpt_btnd = 234234234 then -- count done
                if BTND = '1' then  --still pressing
                    speed_step <= speed_step - 1 ;  -- bottun function



                end if;
            end if;

            start_d <= '0'; --stop conting 
        end if;

        lock_d <= BTND;  
    
      end if;
    end process;

    -- Button_left   160 us ====>  switch train
    process (clk_100MHz)
    begin 
    if rising_edge(clk_100MHz) then
        if lock_l = '0' and BTNL = '1' then --pressed
            cpt_btnl <= 0;
            start_l <= '1';
        else 
            if start_l = '1' then --counting 
                cpt_btnl <= cpt_btnl + 1;
            end if;

            if cpt_btnl = 234234234 then -- count done
                if BTNL = '1' then  --still pressing
                    DCC_ <= speed_step + 1 ;  -- bottun function



                end if;
            end if;

            start_l <= '0'; --stop conting 
        end if;

        lock_l <= BTNL; 
    
      end if;
    end process;
    -- Button_Right   160 us ====>  switch train
    process (clk_100MHz)
    begin 
    if rising_edge(clk_100MHz) then
        if lock_r = '0' and BTNR = '1' then --pressed
            cpt_btnr <= 0;
            start_r <= '1';
        else 
            if start_r = '1' then --counting 
                cpt_btnr <= cpt_btnr + 1;
            end if;

            if cpt_btnr = 234234234 then -- count done
                if BTNR = '1' then  --still pressing
                   DCC_Param_Address <= "00000001" when DCC_Param_Address = "00000010"
                                                   else "00000001";--switch train
                end if;
            end if;

            start_r <= '0'; --stop conting 
        end if;

        lock_r <= BTNR;
    
      end if;
    end process;
          
    --speed  

end Behavioral;
