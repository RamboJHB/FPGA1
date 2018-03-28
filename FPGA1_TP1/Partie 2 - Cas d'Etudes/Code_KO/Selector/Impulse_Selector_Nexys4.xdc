## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports Clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports Clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports Clk]
 
## Switches
##Bank = 34, Pin name = IO_L21P_T3_DQS_34,					Sch name = SW0
set_property PACKAGE_PIN U9 [get_ports {Reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Reset}]


## LEDs
##Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {Limit[12]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[12]}]
##Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {Limit[13]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[13]}]
##Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {Limit[14]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[14]}]
##Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {Limit[15]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[15]}]
##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {Limit[16]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[16]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch	name = LED5
set_property PACKAGE_PIN T4 [get_ports {Limit[17]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[17]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {Limit[18]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[18]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {Limit[19]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[19]}]
##Bank = 34, Pin name = IO_L10N_T1_34,						Sch name = LED8
set_property PACKAGE_PIN V4 [get_ports {Limit[20]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[20]}]
##Bank = 34, Pin name = IO_L8N_T1_34,						Sch name = LED9
set_property PACKAGE_PIN U3 [get_ports {Limit[21]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[21]}]
##Bank = 34, Pin name = IO_L7N_T1_34,						Sch name = LED10
set_property PACKAGE_PIN V1 [get_ports {Limit[22]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[22]}]
##Bank = 34, Pin name = IO_L17P_T2_34,						Sch name = LED11
set_property PACKAGE_PIN R1 [get_ports {Limit[23]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[23]}]
##Bank = 34, Pin name = IO_L13N_T2_MRCC_34,					Sch name = LED12
set_property PACKAGE_PIN P5 [get_ports {Limit[24]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[24]}]
##Bank = 34, Pin name = IO_L7P_T1_34,						Sch name = LED13
set_property PACKAGE_PIN U1 [get_ports {Limit[25]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[25]}]
##Bank = 34, Pin name = IO_L15N_T2_DQS_34,					Sch name = LED14
set_property PACKAGE_PIN R2 [get_ports {Limit[26]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[26]}]
##Bank = 34, Pin name = IO_L15P_T2_DQS_34,					Sch name = LED15
set_property PACKAGE_PIN P2 [get_ports {Limit[27]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[27]}]

##Buttons
##Bank = 15, Pin name = IO_L11N_T1_SRCC_15,					Sch name = BTNC
set_property PACKAGE_PIN E16 [get_ports Button_C]						
	set_property IOSTANDARD LVCMOS33 [get_ports Button_C]
##Bank = CONFIG, Pin name = IO_L15N_T2_DQS_DOUT_CSO_B_14,	Sch name = BTNL
set_property PACKAGE_PIN T16 [get_ports Button_L]						
	set_property IOSTANDARD LVCMOS33 [get_ports Button_L]
##Bank = 14, Pin name = IO_25_14,							Sch name = BTNR
set_property PACKAGE_PIN R10 [get_ports Button_R]						
	set_property IOSTANDARD LVCMOS33 [get_ports Button_R]
 


##Pmod Header JA
##Bank = 15, Pin name = IO_L1N_T0_AD0N_15,					Sch name = JA1
set_property PACKAGE_PIN B13 [get_ports {Limit[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[0]}]
##Bank = 15, Pin name = IO_L5N_T0_AD9N_15,					Sch name = JA2
set_property PACKAGE_PIN F14 [get_ports {Limit[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[1]}]
##Bank = 15, Pin name = IO_L16N_T2_A27_15,					Sch name = JA3
set_property PACKAGE_PIN D17 [get_ports {Limit[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[2]}]
##Bank = 15, Pin name = IO_L16P_T2_A28_15,					Sch name = JA4
set_property PACKAGE_PIN E17 [get_ports {Limit[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[3]}]
##Bank = 15, Pin name = IO_0_15,								Sch name = JA7
set_property PACKAGE_PIN G13 [get_ports {Limit[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[4]}]
##Bank = 15, Pin name = IO_L20N_T3_A19_15,					Sch name = JA8
set_property PACKAGE_PIN C17 [get_ports {Limit[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[5]}]
##Bank = 15, Pin name = IO_L21N_T3_A17_15,					Sch name = JA9
set_property PACKAGE_PIN D18 [get_ports {Limit[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[6]}]
##Bank = 15, Pin name = IO_L21P_T3_DQS_15,					Sch name = JA10
set_property PACKAGE_PIN E18 [get_ports {Limit[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[7]}]



##Pmod Header JB
##Bank = 15, Pin name = IO_L15N_T2_DQS_ADV_B_15,				Sch name = JB1
set_property PACKAGE_PIN G14 [get_ports {Limit[8]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[8]}]
##Bank = 14, Pin name = IO_L13P_T2_MRCC_14,					Sch name = JB2
set_property PACKAGE_PIN P15 [get_ports {Limit[9]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[9]}]
##Bank = 14, Pin name = IO_L21N_T3_DQS_A06_D22_14,			Sch name = JB3
set_property PACKAGE_PIN V11 [get_ports {Limit[10]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[10]}]
##Bank = CONFIG, Pin name = IO_L16P_T2_CSI_B_14,				Sch name = JB4
set_property PACKAGE_PIN V15 [get_ports {Limit[11]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {Limit[11]}]
