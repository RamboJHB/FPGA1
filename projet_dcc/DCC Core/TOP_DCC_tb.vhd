--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:01:33 05/16/2018
-- Design Name:   
-- Module Name:   D:/Xilinx/workspace/TOP_DCC/TOP_DCC_tb.vhd
-- Project Name:  TOP_DCC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP_DCC
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TOP_DCC_tb IS
END TOP_DCC_tb;
 
ARCHITECTURE behavior OF TOP_DCC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP_DCC

        generic ( Data_Width_DCC : integer := 50);
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
    END COMPONENT;
    

   --Inputs
   signal clk_100MHz : std_logic := '0';
   signal reset : std_logic := '1';

 	--Outputs
   signal Out_to_Train : std_logic;

   -- Clock period definitions
   constant clk_100MHz_period : time := 10 ns;
 
    signal sw  : STD_LOGIC_VECTOR(13 downto 0);
    signal leds    : STD_LOGIC_VECTOR(15 downto 0);
    signal BNTC ,BNTU ,BNTD  ,BNTL ,BNTR :  STD_LOGIC;
 
BEGIN
    sw(0) <= '0', '1' after 5 ms, '0' after 6 ms;
    BNTC <= '0', '1'after  20ms , '0' after 30ms ;
    BNTU <= '0', '1'after  50ms , '0' after 60ms;

	-- Instantiate the Unit Under Test (UUT)
   uut: TOP_DCC PORT MAP (
          clk_100MHz => clk_100MHz,
          reset => reset,
          Out_to_Train => Out_to_Train,
                     sw  => sw,
                     leds => leds,
                     BNTC  => BNTC,
                     BNTU  => BNTU,
                     BNTD  => BNTD,
                     BNTL  => BNTL,
                     BNTR   => BNTR
              );


   -- Clock process definitions
   clk_100MHz_process :process
   begin
		clk_100MHz <= '0';
		wait for clk_100MHz_period/2;
		clk_100MHz <= '1';
		wait for clk_100MHz_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_100MHz_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
