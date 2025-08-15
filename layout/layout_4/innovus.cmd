#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Aug 15 13:57:45 2025                
#                                                     
#######################################################

#@(#)CDS: Innovus v21.18-s099_1 (64bit) 07/18/2023 13:03 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: NanoRoute 21.18-s099_1 NR230707-1955/21_18-UB (database version 18.20.605) {superthreading v2.17}
#@(#)CDS: AAE 21.18-s017 (64bit) 07/18/2023 (Linux 3.10.0-693.el7.x86_64)
#@(#)CDS: CTE 21.18-s022_1 () Jul 11 2023 23:10:24 ( )
#@(#)CDS: SYNTECH 21.18-s010_1 () Jul  5 2023 06:32:03 ( )
#@(#)CDS: CPE v21.18-s053
#@(#)CDS: IQuantus/TQuantus 21.1.1-s966 (64bit) Wed Mar 8 10:22:20 PST 2023 (Linux 3.10.0-693.el7.x86_64)

#@ source _1_init.tcl 
#@ Begin verbose source (pre): source _1_init.tcl 
set_db init_power_nets VDD
set_db init_ground_nets VSS
read_mmmc top.mmmc
#@ Begin verbose source top.mmmc (pre)
create_library_set -name nangate_libset_fast \
   -timing \
    [list ../../lib/NangateOpenCellLibrary_fast_ccs.lib]
create_library_set -name nangate_libset_typical \
   -timing \
    [list ../../lib/NangateOpenCellLibrary_typical_ccs.lib]
create_library_set -name nangate_libset_worst \
   -timing \
    [list ../../lib/NangateOpenCellLibrary_worst_low_ccs.lib]
create_timing_condition -name nangate_tc_fast \
   -library_sets [list nangate_libset_fast]
create_timing_condition -name nangate_tc_typical \
   -library_sets [list nangate_libset_typical]
create_timing_condition -name nangate_tc_worst \
   -library_sets [list nangate_libset_worst]
create_rc_corner -name nangate_rc_typical \
   -pre_route_res 1 \
   -post_route_res 1 \
   -pre_route_cap 1 \
   -post_route_cap 1 \
   -post_route_cross_cap 1 \
   -pre_route_clock_res 0 \
   -pre_route_clock_cap 0
create_delay_corner -name nangate_delay_corner_fast \
   -timing_condition nangate_tc_fast \
   -rc_corner nangate_rc_typical
create_delay_corner -name nangate_delay_corner_typical \
   -timing_condition nangate_tc_typical \
   -rc_corner nangate_rc_typical
create_delay_corner -name nangate_delay_corner_worst \
   -timing_condition nangate_tc_worst \
   -rc_corner nangate_rc_typical
create_constraint_mode -name nangate_constraint_mode \
   -sdc_files [list top.sdc]
create_analysis_view -name nangate_view_setup \
   -constraint_mode nangate_constraint_mode \
   -delay_corner nangate_delay_corner_worst
create_analysis_view -name nangate_view_hold \
   -constraint_mode nangate_constraint_mode \
   -delay_corner nangate_delay_corner_fast
set_analysis_view -setup [list nangate_view_setup] -hold [list nangate_view_hold]
#@ End verbose source top.mmmc
read_physical -lef ../../lef/NangateOpenCellLibrary.lef
read_netlist top.vg
init_design
set_io_flow_flag 0
create_floorplan -site FreePDK45_38x28_10R_NP_162NW_34O -core_density_size 0.998244226723 0.699994 10.0 10.0 10.0 10.0
set_db finish_floorplan_active_objs {core macro}
set_db finish_floorplan_drc_region_objs {macro macro_halo hard_blockage min_gap core_spacing}
set_db finish_floorplan_add_blockage_direction xy
set_db finish_floorplan_override false
finish_floorplan -auto_halo
check_floorplan -place -power_domain -feed_through -partition_clone -report_density -multi_layer_pin -partition_in_partition -bus_guide -out_file top.checkFPlan
check_timing_library_consistency
set_db design_process_node 45
save_global top.globals
#@ End verbose source _1_init.tcl
write_db top_import
#@ source _2_power.tcl 
#@ Begin verbose source (pre): source _2_power.tcl 
delete_global_net_connections
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -hinst {}
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VSS -type tie_lo -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VDD -type tie_hi -pin_base_name VDD -inst_base_name * -hinst {}
set_db add_rings_target default ;
set_db add_rings_extend_over_row 0 ;
set_db add_rings_ignore_rows 0 ;
set_db add_rings_avoid_short 0 ;
set_db add_rings_skip_shared_inner_ring none ;
set_db add_rings_stacked_via_top_layer metal10 ;
set_db add_rings_stacked_via_bottom_layer metal1 ;
set_db add_rings_via_using_exact_crossover_size 1 ;
set_db add_rings_orthogonal_only true ;
set_db add_rings_skip_via_on_pin {  standardcell } ;
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_drc 1
set_db generate_special_via_ignore_drc 1
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 11.25 -stop_offset 11.25 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
gui_select -point {0.03900 0.01750}
#@ source _3_Sroute.tcl 
#@ Begin verbose source (pre): source _3_Sroute.tcl 
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
#@ End verbose source: _3_Sroute.tcl
read_db top_import/
set_db read_db_stop_at_design_in_memory false
read_db top_import/
#@ source _2_power.tcl 
#@ Begin verbose source (pre): source _2_power.tcl 
delete_global_net_connections
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -hinst {}
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VSS -type tie_lo -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VDD -type tie_hi -pin_base_name VDD -inst_base_name * -hinst {}
set_db add_rings_target default ;
set_db add_rings_extend_over_row 0 ;
set_db add_rings_ignore_rows 0 ;
set_db add_rings_avoid_short 0 ;
set_db add_rings_skip_shared_inner_ring none ;
set_db add_rings_stacked_via_top_layer metal10 ;
set_db add_rings_stacked_via_bottom_layer metal1 ;
set_db add_rings_via_using_exact_crossover_size 1 ;
set_db add_rings_orthogonal_only true ;
set_db add_rings_skip_via_on_pin {  standardcell } ;
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_drc 1
set_db generate_special_via_ignore_drc 1
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 11.25 -stop_offset 11.25 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
gui_select -point {-1.85000 8.97400}
write_db top_power_planed
#@ source _3_Sroute.tcl 
#@ Begin verbose source (pre): source _3_Sroute.tcl 
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
#@ End verbose source: _3_Sroute.tcl
write_db top_Srouted
set_db finish_floorplan_active_objs {core macro}
set_db finish_floorplan_drc_region_objs {macro macro_halo hard_blockage min_gap core_spacing}
set_db finish_floorplan_add_blockage_direction xy
set_db finish_floorplan_override false
finish_floorplan -auto_halo
read_db top_import/
#@ source _2_fp.tcl 
#@ Begin verbose source (pre): source _2_fp.tcl 
delete_global_net_connections
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -hinst {}
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VSS -type tie_lo -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VDD -type tie_hi -pin_base_name VDD -inst_base_name * -hinst {}
set_db add_rings_target default ;
set_db add_rings_extend_over_row 0 ;
set_db add_rings_ignore_rows 0 ;
set_db add_rings_avoid_short 0 ;
set_db add_rings_skip_shared_inner_ring none ;
set_db add_rings_stacked_via_top_layer metal10 ;
set_db add_rings_stacked_via_bottom_layer metal1 ;
set_db add_rings_via_using_exact_crossover_size 1 ;
set_db add_rings_orthogonal_only true ;
set_db add_rings_skip_via_on_pin {  standardcell } ;
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_drc 1
set_db generate_special_via_ignore_drc 1
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 11.25 -stop_offset 11.25 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
finish_floorplan -auto_halo
write_db top_fp	#check point 
#@ End verbose source _2_fp.tcl
gui_select -point {76.99100 -0.34950}
read_db top_import/
#@ source _2_fp.tcl 
#@ Begin verbose source (pre): source _2_fp.tcl 
delete_global_net_connections
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -hinst {}
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VSS -type tie_lo -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VDD -type tie_hi -pin_base_name VDD -inst_base_name * -hinst {}
set_db add_rings_target default ;
set_db add_rings_extend_over_row 0 ;
set_db add_rings_ignore_rows 0 ;
set_db add_rings_avoid_short 0 ;
set_db add_rings_skip_shared_inner_ring none ;
set_db add_rings_stacked_via_top_layer metal10 ;
set_db add_rings_stacked_via_bottom_layer metal1 ;
set_db add_rings_via_using_exact_crossover_size 1 ;
set_db add_rings_orthogonal_only true ;
set_db add_rings_skip_via_on_pin {  standardcell } ;
set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_drc 1
set_db generate_special_via_ignore_drc 1
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 11.25 -stop_offset 11.25 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
finish_floorplan -auto_halo
write_db top_fp	
#@ End verbose source: _2_fp.tcl
gui_select -point {17.94200 -2.47600}
#@ source _3_placement.tcl 
#@ Begin verbose source (pre): source _3_placement.tcl 
place_opt_design 
set_db route_early_global_bottom_routing_layer 2 ;
set_db route_early_global_top_routing_layer 10 ;
set_db route_early_global_honor_power_domain false ;
set_db route_early_global_honor_partition_pin_guide true
route_early_global 
reset_parasitics 
extract_rc
time_design -pre_cts -path_report -drv_report -slack_report -num_paths 50 -report_prefix top_preCTS -report_dir timingReports
set_db opt_drv_fix_max_cap true ;
set_db opt_drv_fix_max_tran true ;
set_db opt_fix_fanout_load true
opt_design -pre_cts
#@ End verbose source: _3_placement.tcl
write_db top_Pre_CTS
#@ source  _4_CTS.tcl 
#@ Begin verbose source (pre): source  _4_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32} 
ccopt_design
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
time_design -post_cts
time_design -post_cts -hold
#@ End verbose source: _4_CTS.tcl
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
gui_select -point {-2.50450 6.84750}
ccopt_design 
man IMPCCOPT-2215
read_db top_Pre_CTS/
#@ source  _4_CTS.tcl 
#@ Begin verbose source (pre): source  _4_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32} 
set_ccopt_property buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
#@ End verbose source _4_CTS.tcl
set_ccopt_property buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
#@ source  _4_CTS.tcl 
#@ Begin verbose source (pre): source  _4_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32}  
ccopt_design
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
time_design -post_cts -hold
#@ End verbose source: _4_CTS.tcl
opt_design -post_cts -hold
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -side Top -layer 7 -assign 0.0 0.0 -pin preload_valid
set_db assign_pins_edit_in_batch false
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -side Top -layer 8 -assign 0.0 0.0 -pin clk
set_db assign_pins_edit_in_batch false
set_db assign_pins_edit_in_batch true
edit_pin -pin_width 0.4 -pin_depth 0.4 -fix_overlap 1 -unit micron -spread_direction clockwise -side Top -layer 8 -spread_type start -spacing 0.8 -start 0.925 78.96 -pin clk
set_db assign_pins_edit_in_batch false
set_db assign_pins_edit_in_batch true
edit_pin -pin_width 0.4 -pin_depth 0.4 -fix_overlap 1 -side Top -layer 1 -assign 0.925 78.96 -pin clk
set_db assign_pins_edit_in_batch false
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -side Right -layer 8 -assign 0.0 0.0 -pin {{result_flat[0]} {result_flat[1]} {result_flat[2]} {result_flat[3]} {result_flat[4]} {result_flat[5]} {result_flat[6]} {result_flat[7]} {result_flat[8]} {result_flat[9]} {result_flat[10]} {result_flat[11]} {result_flat[12]} {result_flat[13]} {result_flat[14]} {result_flat[15]} {result_flat[16]} {result_flat[17]} {result_flat[18]} {result_flat[19]} {result_flat[20]} {result_flat[21]} {result_flat[22]} {result_flat[23]} {result_flat[24]} {result_flat[25]} {result_flat[26]} {result_flat[27]} {result_flat[28]} {result_flat[29]} {result_flat[30]} {result_flat[31]}}
set_db assign_pins_edit_in_batch false
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Right -layer 8 -spread_type center -spacing 0.8 -pin {{result_flat[0]} {result_flat[1]} {result_flat[2]} {result_flat[3]} {result_flat[4]} {result_flat[5]} {result_flat[6]} {result_flat[7]} {result_flat[8]} {result_flat[9]} {result_flat[10]} {result_flat[11]} {result_flat[12]} {result_flat[13]} {result_flat[14]} {result_flat[15]} {result_flat[16]} {result_flat[17]} {result_flat[18]} {result_flat[19]} {result_flat[20]} {result_flat[21]} {result_flat[22]} {result_flat[23]} {result_flat[24]} {result_flat[25]} {result_flat[26]} {result_flat[27]} {result_flat[28]} {result_flat[29]} {result_flat[30]} {result_flat[31]}}
set_db assign_pins_edit_in_batch false
setPinAssignMode -top_layer M8 -bottom_layer M7
set_db assign_pins_edit_in_batch true
edit_pin -pin_width 0.4 -pin_depth 0.4 -fix_overlap 1 -unit micron -spread_direction clockwise -side Top -layer 8 -spread_type center -spacing 0.14 -pin clk
set_db assign_pins_edit_in_batch false
set_partition_pin_status -partition top -pins rst_n -status unplaced -quiet
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Top -layer 7 -spread_type center -spacing 0.14 -pin start
set_db assign_pins_edit_in_batch false
gui_select -point {1.25750 49.21250}
read_db top_Pre_CTS/
#@ source _4_CTS.tcl 
#@ Begin verbose source (pre): source _4_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32}  
creat_clock_tree_spec
#@ End verbose source _4_CTS.tcl
create_clock_tree_spec 
read_db top_Pre_CTS/
#@ source _4_CTS.tcl 
#@ Begin verbose source (pre): source _4_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32}  
create_clock_tree_spec
ccopt_design
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
time_design -post_cts -hold
#@ End verbose source: _4_CTS.tcl
