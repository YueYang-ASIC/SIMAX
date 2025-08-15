#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Aug 15 13:39:20 2025                
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
gui_select -point {0.02600 0.00100}
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 5 -start_from left -start_offset 11.5 -stop_offset 11.5 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
gui_select -point {24.32100 -0.51300}
gui_select -point {7.96400 0.95900}
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 14.75 -stop_offset 14.75-switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source _2_power.tcl
delete_all_floorplan_objs
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 14.75 -stop_offset 14.75-switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source _2_power.tcl
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 14.5 -stop_offset 14.5-switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source _2_power.tcl
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 14.5 -stop_offset 14.5 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 4 -start_from left -start_offset 12 -stop_offset 12 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
delete_all_floorplan_objs
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 4 -start_from left -start_offset 12 -stop_offset 12 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
set_db add_stripes_ignore_block_check false
set_db add_stripes_break_at none
set_db add_stripes_route_over_rows_only false
set_db add_stripes_rows_without_stripes_only false
set_db add_stripes_extend_to_closest_target none
set_db add_stripes_stop_at_last_wire_for_area false
set_db add_stripes_partial_set_through_domain false
set_db add_stripes_ignore_non_default_domains false
set_db add_stripes_trim_antenna_back_to_shape none
set_db add_stripes_spacing_type edge_to_edge
set_db add_stripes_spacing_from_block 0
set_db add_stripes_stripe_min_length stripe_width
set_db add_stripes_stacked_via_top_layer metal10
set_db add_stripes_stacked_via_bottom_layer metal1
set_db add_stripes_via_using_exact_crossover_size false
set_db add_stripes_split_vias false
set_db add_stripes_orthogonal_only true
set_db add_stripes_allow_jog { padcore_ring  block_ring }
set_db add_stripes_skip_via_on_pin {  standardcell }
set_db add_stripes_skip_via_on_wire_shape {  noshape   }
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.8 -set_to_set_distance 12 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_block_check false
set_db add_stripes_break_at none
set_db add_stripes_route_over_rows_only false
set_db add_stripes_rows_without_stripes_only false
set_db add_stripes_extend_to_closest_target none
set_db add_stripes_stop_at_last_wire_for_area false
set_db add_stripes_partial_set_through_domain false
set_db add_stripes_ignore_non_default_domains false
set_db add_stripes_trim_antenna_back_to_shape none
set_db add_stripes_spacing_type edge_to_edge
set_db add_stripes_spacing_from_block 0
set_db add_stripes_stripe_min_length stripe_width
set_db add_stripes_stacked_via_top_layer metal10
set_db add_stripes_stacked_via_bottom_layer metal1
set_db add_stripes_via_using_exact_crossover_size false
set_db add_stripes_split_vias false
set_db add_stripes_orthogonal_only true
set_db add_stripes_allow_jog { padcore_ring  block_ring }
set_db add_stripes_skip_via_on_pin {  standardcell }
set_db add_stripes_skip_via_on_wire_shape {  noshape   }
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 5 -start_from left -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
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
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 12 -stop_offset 12 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none
#@ End verbose source: _2_power.tcl
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
#@ source _3_Sroute.tcl 
#@ Begin verbose source (pre): source _3_Sroute.tcl 
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
#@ End verbose source: _3_Sroute.tcl
