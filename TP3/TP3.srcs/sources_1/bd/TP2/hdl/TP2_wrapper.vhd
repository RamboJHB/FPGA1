--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.2 (win64) Build 932637 Wed Jun 11 13:33:10 MDT 2014
--Date        : Mon Feb 27 11:00:39 2017
--Host        : S228-01 running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target TP2_wrapper.bd
--Design      : TP2_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity TP2_wrapper is
  port (
    led_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    reset : in STD_LOGIC;
    reset_rtl : in STD_LOGIC;
    sw_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sys_clock : in STD_LOGIC
  );
end TP2_wrapper;

architecture STRUCTURE of TP2_wrapper is
  component TP2 is
  port (
    sw_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    reset_rtl : in STD_LOGIC;
    led_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );
  end component TP2;
begin
TP2_i: component TP2
    port map (
      led_tri_o(15 downto 0) => led_tri_o(15 downto 0),
      reset => reset,
      reset_rtl => reset_rtl,
      sw_tri_i(3 downto 0) => sw_tri_i(3 downto 0),
      sys_clock => sys_clock
    );
end STRUCTURE;
