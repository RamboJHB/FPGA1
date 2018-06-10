----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2018 09:12:15
-- Design Name: 
-- Module Name: TOP_DCC - Behavioral
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

entity TOP_DCC is
    Port ( clk_100MHz : in STD_LOGIC;
           reset : in STD_LOGIC;
           Out_to_Train : out STD_LOGIC;
           sw  : in STD_LOGIC_VECTOR(13 downto 0);
           leds    : out STD_LOGIC_VECTOR(15 downto 0);
           BNTC    : in STD_LOGIC;
           BNTU    : in STD_LOGIC;
           BNTD    : in STD_LOGIC;
           BNTL    : in STD_LOGIC;
           BNTR    : in STD_LOGIC
    );
end TOP_DCC;

architecture Behavioral of TOP_DCC is
-- component declaration
           component Gene_Frame is

           Port ( 
                       clk_100MHz: in STD_LOGIC;
                       reset : in std_logic;
                       ------register dcc------
		       Frame_DCC_0 : out STD_LOGIC_VECTOR(1 downto 0);  -- LSB 
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
                       BNTR    : in STD_LOGIC);
           end component Gene_Frame;

        component diviseur_clk is
        Port ( 
           clk_100MHz   : in STD_LOGIC;
           reset        : in STD_LOGIC; 
           clk_1MHz     : out STD_LOGIC);
        end component diviseur_clk;
        
        component Tempo is
        Port ( 
                   Com_tempo : in STD_LOGIC;
                   clk_1MHz : in STD_LOGIC;
                   reset : in STD_LOGIC;
                   FIN_tempo : out STD_LOGIC);
        end component Tempo;
        
        component send_zero is
        Port (  
            Go_0 : in STD_LOGIC;
            clk_100MHz: in STD_LOGIC;
            clk_1MHz : in std_logic;
            reset : in std_logic;
            FIN_0 : out STD_LOGIC;
            DCC_0 : out STD_LOGIC
            );
        end component send_zero;

        component send_one is
        Port (  
            Go_1 : in STD_LOGIC;
            clk_100MHz: in STD_LOGIC;
            clk_1MHz : in std_logic;
            reset : in std_logic;
            FIN_1 : out STD_LOGIC;
            DCC_1 : out STD_LOGIC
            );
        end component send_one;

	component FSM is
	port (
            clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
            ------register dcc------
            FIN_DCC: in std_logic;
            CMD : in STD_LOGIC;
            ------senders 0/1 & tempo------
            FIN_0, FIN_1, Fin_tempo: in STD_LOGIC;
            Go_0, Go_1 : out STD_LOGIC; 
            Com_tempo : out STD_LOGIC;
            Com_reg   : out STD_LOGIC_VECTOR (1 downto 0)  
	);
    end component FSM;
    
    component reg_dcc is
    Port (  clk_100MHz: in STD_LOGIC;
            reset : in std_logic;
	    Frame_DCC_0 : in STD_LOGIC_VECTOR(1 downto 0);  --LSB 
            Frame_DCC_1 : in STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_2 : in STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_3 : in STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_4 : in STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_5 : in STD_LOGIC_VECTOR(7 downto 0);
            Frame_DCC_6 : in STD_LOGIC_VECTOR(7 downto 0);  --MSB
            Com_reg: in STD_LOGIC_VECTOR(1 downto 0);
            FIN_DCC: out std_logic;
            cmd : out STD_LOGIC
    );
    end component reg_dcc;

    

--signal of FSM
signal FIN_DCC, CMD, FIN_0, FIN_1, FIN_tempo, Go_0, Go_1, Com_tempo : std_logic;

signal Com_reg : std_logic_vector (1 downto 0);
--other signals
signal DCC_1, DCC_0, clk_1MHz : std_logic;

--generate frame signals 
signal Frame_DCC_0 :  STD_LOGIC_VECTOR(1 downto 0);  -- LSB 
signal Frame_DCC_1 :  STD_LOGIC_VECTOR(7 downto 0);
signal Frame_DCC_2 :  STD_LOGIC_VECTOR(7 downto 0);
signal Frame_DCC_3 :  STD_LOGIC_VECTOR(7 downto 0);
signal Frame_DCC_4 :  STD_LOGIC_VECTOR(7 downto 0);
signal Frame_DCC_5 :  STD_LOGIC_VECTOR(7 downto 0);
signal Frame_DCC_6 :  STD_LOGIC_VECTOR(7 downto 0);  --MSB
signal leds_sig : std_logic_vector( 15 downto 0 );
begin
-- Instantiation of top dcc need this

Mealy_FSM: FSM port map (clk_100MHz, reset, FIN_DCC, CMD, FIN_0, FIN_1, FIN_tempo, Go_0, Go_1, Com_tempo, Com_reg);

Send_one_ins:send_one port map (Go_1, clk_100MHz, clk_1MHz, reset, FIN_1, DCC_1 ); 

Send_zero_ins:send_zero port map (Go_0, clk_100MHz, clk_1MHz, reset, FIN_0, DCC_0 ); 

clk_div: diviseur_clk port map ( clk_100MHz, reset, clk_1MHz);

Tempo_ins: Tempo port map( Com_tempo, clk_1MHz, reset, FIN_tempo);

shift_reg:  reg_dcc 
Port map(clk_100MHz,reset, Frame_DCC, Com_reg, FIN_DCC, cmd);

generator_frame:  Gene_Frame
Port map(
            clk_100MHz=>clk_100MHz,
            reset=>reset,
            Frame_DCC => Frame_DCC,
            sw=>sw,
            leds=>leds_sig,
	    Frame_DCC_0 => Frame_DCC_0 ,
	    Frame_DCC_1 => Frame_DCC_1 ,
	    Frame_DCC_2 => Frame_DCC_2 ,
	    Frame_DCC_3 => Frame_DCC_3 ,
	    Frame_DCC_4 => Frame_DCC_4 ,
	    Frame_DCC_5 => Frame_DCC_5 ,
	    Frame_DCC_6 => Frame_DCC_6);
leds <= leds_sig;
Out_to_Train <= DCC_1 or DCC_0;

end Behavioral;
