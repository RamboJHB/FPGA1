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
    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            ------register dcc------
            Frame_DCC: out std_logic;
            ------user interface------
            switch  : in STD_LOGIC_VECTOR(13 downto 0);
            led     : out STD_LOGIC_VECTOR(13 downto 0);
            BNTC    : in STD_LOGIC;
            BNTU    : in STD_LOGIC;
            BNTD    : in STD_LOGIC;
            BNTL    : in STD_LOGIC;
);
end Gene_Frame;

architecture Behavioral of Gene_Frame is

----------------signal
--speed cmd
signal speed : std_logic_vector(4 downto 0);
signal direction : std_logic;
signal cmd_speed : std_logic_vector(7 downto 0);

--function cmd
signal func : std_logic_vector(4 downto 0);
signal cmd_func : std_logic;

--control 
signal ctrl std_logic_vector(7 downto 0);

signal cpt : integer;

begin
    Frame_DCC <= Frame_DCC_reg;
    
    --constructor Frame_DCC 
    Frame_DCC_reg( 46 downto 33) <= "111111111111110" -- 14 bits '1' start bit 0 
    Frame_DCC_reg( 32 downto 26 ) <= address;
    Frame_DCC_reg(25) <= "0";
    Frame_DCC_reg( 24 downto 17 ) <= cmd_speed; --func13-20 : cmd_speed = 110 11110 
    Frame_DCC_reg( 16 downto 9 ) <= cmd_func;
    Frame_DCC_reg(8) <= "0";
    Frame_DCC_reg( 7 downto 0 ) <= ctrl;
    

    
    --address cmd 
    address <= 

    --speed
    cmd_speed(4 downto 0) <=  speed;
    cmd_speed(6) <= direction;
    
    --function 

    --control
    ctrl <= cmd_speed XOR cmd_func;

    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            cpt <= 0;

        elsif rising_edge(clk_100MHz) then
            case switch is   

                when "0000000"  =>
                    led <= "000000000";
                    Frame_DCC <= "000000";

                when "0000000"  =>
                    led <= "000000000";
                    Frame_DCC <= "000000";

                when "0000000"  =>
                    led <= "000000000";
                    Frame_DCC <= "000000";

                when "0000000"  =>
                    led <= "000000000";
                    Frame_DCC <= "000000";

                when others => NULL;

            end case;
        end if;
    end process;
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
                  --speed up  -- bottun function



                end if;
            end if;

            start_u <= '0'; --stop conting 
        end if;

        lock_u <= BTNU; --lock??????????????? 
    
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
                  --speed goes down         ; -- bottun function 



                end if;
            end if;

            start_d <= '0'; --stop conting 
        end if;

        lock_d <= BTND; --lock??????????????? 
    
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
                  --switch train            ; -- bottun function



                end if;
            end if;

            start_l <= '0'; --stop conting 
        end if;

        lock_l <= BTNL; --lock??????????????? 
    
      end if;
    end process;
    --speed  

end Behavioral;
