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
    PORT(
         clk_100MHz : IN  std_logic;
         reset : IN  std_logic;
         Frame_DCC : IN  std_logic_vector(31 downto 0);
         Out_to_Train : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_100MHz : std_logic := '0';
   signal reset : std_logic := '1';
   signal Frame_DCC : std_logic_vector(31 downto 0) := (others => '1');

 	--Outputs
   signal Out_to_Train : std_logic;

   -- Clock period definitions
   constant clk_100MHz_period : time := 10 ns;
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP_DCC PORT MAP (
          clk_100MHz => clk_100MHz,
          reset => reset,
          Frame_DCC => Frame_DCC,
          Out_to_Train => Out_to_Train
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
