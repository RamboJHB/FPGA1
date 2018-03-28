set_property SRC_FILE_INFO {cfile:c:/Users/3502859/TP/TP3.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0.xdc rfile:../../../TP3.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0.xdc id:1 order:EARLY scoped_inst:TP2_i/clk_wiz_1/U0} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:56 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
