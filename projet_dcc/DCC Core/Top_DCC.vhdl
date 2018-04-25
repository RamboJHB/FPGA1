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
entity Top_DCC is
	port (
		leds: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end Top_DCC;

architecture arch_dcc of my_led_v1_0 is

	-- component declaration
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
        end component send_zero;

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
            Com_tempo, Com_reg : out STD_LOGIC    
	);
	end component FSM;

begin

-- Instantiation of top dcc
Instantiation:
--rest








end arch_dcc;
