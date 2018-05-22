library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Shift_register_VHDL is

   port( clk: in std_logic;
 	 L: in std_logic; 
 	 w: in std_logic; -- new data to shift in
 	 Output: out std_logic_vector(3 downto 0);
 	 Input: in std_logic_vector( 3 downto 0));

end Shift_register_VHDL;

architecture Behavioral of Shift_register_VHDL is
begin
   process
   variable temp: std_logic_vector(3 downto 0); 
   begin
      wait until rising_edge (clk);
      temp := Input; 
      if L='1' then 
         for i in 0 to 2 loop
            temp(i) := temp(i+1);
         end loop;
         temp(3) := w;
      end if;
      Output <= temp;
    end process;
end Behavioral;

