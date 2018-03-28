proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/3502859/TP/TP2_ex2/TP2_ex2.cache/wt [current_project]
  set_property parent.project_dir C:/Users/3502859/TP/TP2_ex2 [current_project]
  add_files -quiet C:/Users/3502859/TP/TP2_ex2/TP2_ex2.runs/synth_1/TP2_wrapper.dcp
  add_files C:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/TP2.bmm
  set_property SCOPED_TO_REF TP2 [get_files -all C:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/TP2.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all C:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/TP2.bmm]
  add_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_3/62751c34/data/mb_bootloop_le.elf
  set_property SCOPED_TO_REF TP2 [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_3/62751c34/data/mb_bootloop_le.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_3/62751c34/data/mb_bootloop_le.elf]
  read_xdc -ref TP2_microblaze_0_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_0/TP2_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_0/TP2_microblaze_0_0.xdc]
  read_xdc -ref TP2_dlmb_v10_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_dlmb_v10_0/TP2_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_dlmb_v10_0/TP2_dlmb_v10_0.xdc]
  read_xdc -ref TP2_ilmb_v10_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_ilmb_v10_0/TP2_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_ilmb_v10_0/TP2_ilmb_v10_0.xdc]
  read_xdc -ref TP2_microblaze_0_axi_intc_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0.xdc]
  read_xdc -ref TP2_mdm_1_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_mdm_1_0/TP2_mdm_1_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_mdm_1_0/TP2_mdm_1_0.xdc]
  read_xdc -ref TP2_clk_wiz_1_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0.xdc]
  read_xdc -prop_thru_buffers -ref TP2_clk_wiz_1_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_clk_wiz_1_0/TP2_clk_wiz_1_0_board.xdc]
  read_xdc -ref TP2_rst_clk_wiz_1_100M_0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref TP2_rst_clk_wiz_1_100M_0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_rst_clk_wiz_1_100M_0/TP2_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref TP2_axi_gpio_0_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref TP2_axi_gpio_0_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_0/TP2_axi_gpio_0_0_board.xdc]
  read_xdc -ref TP2_axi_gpio_0_1 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1.xdc]
  read_xdc -prop_thru_buffers -ref TP2_axi_gpio_0_1 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_axi_gpio_0_1/TP2_axi_gpio_0_1_board.xdc]
  read_xdc {{C:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/constrs_1/imports/Fichiers XDC/Nexys4DDR_Master.xdc}}
  read_xdc -ref TP2_microblaze_0_axi_intc_0 -cells U0 c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/3502859/TP/TP2_ex2/TP2_ex2.srcs/sources_1/bd/TP2/ip/TP2_microblaze_0_axi_intc_0/TP2_microblaze_0_axi_intc_0_clocks.xdc]
  link_design -top TP2_wrapper -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  catch {update_ip_catalog -quiet -current_ip_cache {c:/Users/3502859/TP/TP2_exo2/TP2_exo2.cache} }
  opt_design 
  write_checkpoint -force TP2_wrapper_opt.dcp
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force TP2_wrapper_placed.dcp
  catch { report_io -file TP2_wrapper_io_placed.rpt }
  catch { report_clock_utilization -file TP2_wrapper_clock_utilization_placed.rpt }
  catch { report_utilization -file TP2_wrapper_utilization_placed.rpt -pb TP2_wrapper_utilization_placed.pb }
  catch { report_control_sets -verbose -file TP2_wrapper_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force TP2_wrapper_routed.dcp
  catch { report_drc -file TP2_wrapper_drc_routed.rpt -pb TP2_wrapper_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -file TP2_wrapper_timing_summary_routed.rpt -pb TP2_wrapper_timing_summary_routed.pb }
  catch { report_power -file TP2_wrapper_power_routed.rpt -pb TP2_wrapper_power_summary_routed.pb }
  catch { report_route_status -file TP2_wrapper_route_status.rpt -pb TP2_wrapper_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_bmm -force TP2_wrapper_bd.bmm }
  write_bitstream -force TP2_wrapper.bit 
  if { [file exists C:/Users/3502859/TP/TP2_ex2/TP2_ex2.runs/synth_1/TP2_wrapper.hwdef] } {
    catch { write_sysdef -hwdef C:/Users/3502859/TP/TP2_ex2/TP2_ex2.runs/synth_1/TP2_wrapper.hwdef -bitfile TP2_wrapper.bit -meminfo TP2_wrapper_bd.bmm -file TP2_wrapper.sysdef }
  }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

