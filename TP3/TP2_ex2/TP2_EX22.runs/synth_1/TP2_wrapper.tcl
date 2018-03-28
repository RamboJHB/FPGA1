# 
# Synthesis run script generated by Vivado
# 

  set_param gui.test TreeTableDev
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
set_param project.compositeFile.enableAutoGeneration 0
set_property default_lib xil_defaultlib [current_project]

add_files C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/TP2.bd
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_0/TP2_microblaze_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_0/TP2_microblaze_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_dlmb_v10_0/TP2_dlmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_dlmb_v10_0/TP2_dlmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_ilmb_v10_0/TP2_ilmb_v10_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_ilmb_v10_0/TP2_ilmb_v10_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_dlmb_bram_if_cntlr_0/TP2_dlmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_ilmb_bram_if_cntlr_0/TP2_ilmb_bram_if_cntlr_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_lmb_bram_0/TP2_lmb_bram_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0_clocks.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_mdm_1_0/TP2_mdm_1_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_mdm_1_0/TP2_mdm_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/ip/TP2_xbar_0/TP2_xbar_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/TP2_ooc.xdc]
set_msg_config -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property is_locked true [get_files C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/TP2.bd]

read_vhdl -library xil_defaultlib C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/sources_1/bd/TP2/hdl/TP2_wrapper.vhd
read_xdc {{C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/constrs_1/imports/Fichiers XDC/Nexys4DDR_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/3502859/TP/TP2_ex2/TP2_EX22.srcs/constrs_1/imports/Fichiers XDC/Nexys4DDR_Master.xdc}}]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/3502859/TP/TP2_ex2/TP2_EX22.cache/wt [current_project]
set_property parent.project_dir C:/Users/3502859/TP/TP2_ex2 [current_project]
catch { write_hwdef -file TP2_wrapper.hwdef }
synth_design -top TP2_wrapper -part xc7a100tcsg324-1
write_checkpoint TP2_wrapper.dcp
report_utilization -file TP2_wrapper_utilization_synth.rpt -pb TP2_wrapper_utilization_synth.pb
