----------------------------------------------------------------------------------
-- Company: UPMC
-- Engineer: Julien Denoulet
-- 
-- Create Date:   	Septembre 2016 
-- Module Name:    	TB_Selector - Behavioral 
-- Project Name: 		TP1 - FPGA1
-- Target Devices: 	Nexys4 / Artix7

-- XDC File:			Aucun					

-- Description: Testbench du Décodeur
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Selector IS
END TB_Selector;
 
ARCHITECTURE behavior OF TB_Selector IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Selector
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Button_R : IN  std_logic;
         Count : IN  std_logic_vector(3 downto 0);
         Sup : IN  std_logic;
         Limit : OUT  std_logic_vector(27 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Button_R : std_logic := '0';
   signal Count : std_logic_vector(3 downto 0) := "0001";
   signal Sup : std_logic := '0';

 	--Outputs
   signal Limit : std_logic_vector(27 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Selector PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Button_R => Button_R,
          Count => Count,
          Sup => Sup,
          Limit => Limit
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 
	Reset <= '1', '0' after 2 ns;
 
	Count <= "0011" after 102 ns, "0111" after 302 ns, "1011" after 502 ns, "0100" after 702 ns;
	
	Sup <= '1' after 502 ns, '0' after 702 ns;
	
	Button_R <= '1' after 22 ns, '0' after 42 ns,
					'1' after 222 ns, '0' after 242 ns, 	
					'1' after 422 ns, '0' after 442 ns, 
					'1' after 622 ns, '0' after 642 ns, 
					'1' after 822 ns, '0' after 842 ns;

END;
