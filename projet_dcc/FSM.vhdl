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

entity FSM is
    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            ------register dcc------
            FIN_DCC: in std_logic;
            CMD : in STD_LOGIC;
            ------senders 0/1 & tempo------
            FIN_0, FIN_1, Fin_tempo: in STD_LOGIC;
            Go_0, Go_1 : out STD_LOGIC; 
            Com_tempo, Com_reg : out STD_LOGIC         
);
end FSM;

architecture Behavioral of FSM is

----------------mea fsm
TYPE state IS (init, ask, send_one, send_zero, send_over, pause, pausing);
signal EP, EF : state;

----------------i/o signals
signal Go_zero : std_logic;
signal Go_one : std_logic;
signal tempo : std_logic;
signal reg : std_logic;          



begin
    Go_0 <= go_zero;
    Go_1 <= go_one;
    Com_tempo <= tempo;
    Com_reg <= reg;--------------reg = '1' ==> call your bit
                   --------------reg = '0' ==> hold your bit

    ----states
    process (clk_100MHz, reset)
    begin 
        if reset = '0' then 
            EP <= init;
        elsif rising_edge(clk_100MHz) then
            EP <= EF;  
        end if;
    end process;
    
    ----mae
    process (EP, CMD, FIN_DCC, FIN_0, FIN_1, Fin_tempo)
        begin 
        case EP is 
            -- init
            when init =>
	            go_zero <= '0';
                    go_one <= '0';
                    reg <= '0';
	            tempo <= '0';
                    EF <= ask;

	    --hold your bit shift register dcc
            when ask =>
	            go_zero <= '0';
                    go_one <= '0';
                    reg <= '1';
	            tempo <= '0';
                if cmd = '0' then
                    EF <= send_zero;
                elsif cmd = '1' then
                    EF <= send_one;
                end if;
            --sending '1' 
            when send_one =>
	            go_zero <= '0';
                    go_one <= '1';
                    reg <= '0';
	            tempo <= '0';
                if fin_1 = '0' then
                    EF <= send_one;
                elsif fin_1 = '1' then
                    EF <= send_over;
                end if;
            --sending '0' 
            when send_zero =>
	            go_zero <= '1';
                    go_one <= '0';
                    reg <= '0';
	            tempo <= '0';
                if fin_0 = '0' then
                    EF <= send_zero;
                elsif fin_0 = '1' then
                    EF <= send_over;
                end if;
            --send over : releas next bit from register dcc
            when send_over =>
	            go_zero <= '0';
                    go_one <= '0';
                    reg <= '0';
	            tempo <= '0';
                if FIN_DCC = '0' then
                    EF <= ask;
                elsif FIN_DCC = '1' then
                    EF <= pause;
                end if;
            --finished
            when pause =>
	            go_zero <= '0';
                    go_one <= '0';
                    reg <= '0';
	            tempo <= '1';
                    EF <= pause;
            when pausing =>
	            go_zero <= '0';
                    go_one <= '0';
                    reg <= '0';
	            tempo <= '0';
                if FIN_tempo = '0' then
                    EF <= pausing;
                elsif FIN_tempo = '1' then
                    EF <= init;
                end if;
            when others => null;
        end case;
    end process;

end Behavioral;

