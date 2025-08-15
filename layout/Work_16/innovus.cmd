#######################################################
#                                                     
#  Innovus Command Logging File                     
#  Created on Fri Aug  1 12:45:24 2025                
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
    [list /home/lunayang/Documents/Many-Core-SIMD-Research/lib/NangateOpenCellLibrary_fast_ccs.lib]
create_library_set -name nangate_libset_typical \
   -timing \
    [list /home/lunayang/Documents/Many-Core-SIMD-Research/lib/NangateOpenCellLibrary_typical_ccs.lib]
create_library_set -name nangate_libset_worst \
   -timing \
    [list /home/lunayang/Documents/Many-Core-SIMD-Research/lib/NangateOpenCellLibrary_worst_low_ccs.lib]
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
read_physical -lef ../lef/NangateOpenCellLibrary.lef
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
#@ End verbose source: _1_init.tcl
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
gui_select -point {0.01050 0.00750}
report_area 
#@ source _3_Sroute.tcl 
#@ Begin verbose source (pre): source _3_Sroute.tcl 
set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 
#@ End verbose source: _3_Sroute.tcl
gui_select -point {6.58600 9.00100}
gui_select -point {10.54050 139.78850}
set_power_output_dir -reset
set_power_output_dir ./run1
set_default_switching_activity -reset
set_default_switching_activity -input_activity 0.2 -period 10.0
read_activity_file -reset
set_power -reset
set_dynamic_power_simulation -reset
report_power -rail_analysis_format VS -out_file ./run1/top.rpt
#@ source _4_placement.tcl 
#@ Begin verbose source (pre): source _4_placement.tcl 
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
#@ End verbose source: _4_placement.tcl
#@ source _5_CTS.tcl 
#@ Begin verbose source (pre): source _5_CTS.tcl 
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32} 
ccopt_design
time_design -post_cts
time_design -post_cts -hold
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
opt_design -post_cts -hold
#@ End verbose source: _5_CTS.tcl
#@ source _6_Route.tcl 
#@ Begin verbose source (pre): source _6_Route.tcl 
set_db route_design_with_timing_driven 1
set_db route_design_with_si_driven 1
set_db route_design_selected_net_only 1
set_db route_design_top_routing_layer 10
set_db route_design_bottom_routing_layer 1
set_db route_design_detail_end_iteration 1
route_design -global_detail 
#@ End verbose source _6_Route.tcl
#@ source _6_Route.tcl 
#@ Begin verbose source (pre): source _6_Route.tcl 
set_db route_design_with_timing_driven 1
set_db route_design_with_si_driven 1
set_db route_design_selected_net_only 1
set_db route_design_top_routing_layer 10
set_db route_design_bottom_routing_layer 1
set_db route_design_detail_end_iteration 1 
#@ End verbose source: _6_Route.tcl
set_db route_design_with_timing_driven 1
set_db route_design_with_eco 0
set_db route_design_with_si_driven 1
set_db route_design_selected_net_only 1
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
route_design -global_detail
route_design -global_detail
route_design 
set_db route_design_detail_use_multi_cut_via_effort medium
set_db timing_analysis_type ocv
route_opt_design 
#@ source _6_Route.tcl 
#@ Begin verbose source (pre): source _6_Route.tcl 
set_db route_design_with_timing_driven 1
set_db route_design_with_si_driven 1
set_db route_design_selected_net_only 1
set_db route_design_top_routing_layer 10
set_db route_design_bottom_routing_layer 1
set_db route_design_detail_end_iteration 1 
set_db route_design_detail_use_multi_cut_via_effort medium
set_db timing_analysis_type ocv
route_opt_design
#@ End verbose source _6_Route.tcl
time_design -post_route 
time_design -post_route -hold 
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
eval_legacy { setDelayCalMode -engine default -siAware true }
opt_design -post_route -hold
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
eval_legacy { setDelayCalMode -engine default -siAware true }
route_opt_design 
set_db opt_drv_fix_max_cap true ;
set_db opt_drv_fix_max_tran true ;
set_db opt_fix_fanout_load true
opt_design -post_route -hold
set_db route_design_with_eco 1
set_db route_design_selected_net_only 0
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
report_obj -set_by_user -compact -categories {design extract_rc route delaycal}
eval_legacy { checkPlace -ignoreOutOfcore -placeLegalityChecks -noHalo -preserveMaskShift -noHardfence }
route_global_detail
eval_legacy { setDelayCalMode -quiet -engine aae }
set_db delaycal_enable_si true
reset_db delaycal_combine_mmmc
set_db timing_analysis_check_type setup
set_db timing_analysis_type ocv
reset_db timing_analysis_cppr
set_db extract_rc_engine post_route
reset_db extract_rc_effort_level
set_db extract_rc_coupled true
set_db si_delay_separate_on_data true
reset_db si_analysis_type
eval_legacy { setDelayCalMode -quiet -engine aae }
set_db delaycal_enable_si true
reset_db delaycal_combine_mmmc
set_db timing_analysis_check_type setup
set_db timing_analysis_type ocv
reset_db timing_analysis_cppr
set_db extract_rc_engine post_route
reset_db extract_rc_effort_level
set_db extract_rc_coupled true
set_db si_delay_separate_on_data true
reset_db si_analysis_type
time_design -post_route -hold 
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
eval_legacy { setDelayCalMode -engine default -siAware true }
set_db opt_all_end_points true
set_db opt_exp_buffer_congestion_aware_extreme false
eval_legacy { setOptMode -expTATEnhancementV3 1 }
eval_legacy { setOptMode -expNewStandardFlow true -expBufferingTatEnhancement true -expRebufferRATATFix true -extremeCCOptTATEnhancementV2 true -expRoiFlowTatEnhancements true -expGlsTATFix true -fixSIAttacker false -expTvp low }
set_db delaycal_enable_high_fanout true
set_db opt_post_route_area_reclaim none
set_db si_delay_separate_on_data true
set_db delaycal_socv_accuracy_mode low
reset_db opt_power_unit_total_power
set_db route_design_exp_signature_eco true
set_db route_design_exp_dirty_area_eco true
reset_db route_design_exp_dirty_area_eco
reset_db route_design_exp_signature_eco
eval_legacy { checkPlace -noPreplaced -ignoreOutOfCore -noHalo -preserveMaskShift -noCheckPinAccess -noHardFence }
eval_legacy { setIlmType 1 }
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
set_db opt_effort high
set_db opt_setup_target_slack 0
set_db opt_route_mode no_incremental
extract_rc
reset_db opt_power_unit_total_power
eval_legacy { createBasicPathGroups -quiet }
set_db timing_analysis_check_type hold
set_db timing_analysis_graph_pba_mode false
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_active_drv_views { }
set_db opt_view_pruning_hold_target_slack_auto_flow 0
eval_legacy { setOptMode -autoDrvViews {} }
set_db timing_analysis_check_type setup
reset_db opt_power_unit_total_power
eval_legacy { setPlaceMode -wireLenOpt false }
eval_legacy { refinePlace -preserveRouting true -hardFence false }
eval_legacy { setPlaceMode -wireLenOpt false }
reset_db route_design_detail_exp_eco_routing_mode
reset_db route_design_with_timing_driven
reset_db route_design_with_si_driven
set_db route_design_exp_signature_eco true
set_db route_design_exp_dirty_area_eco true
set_db route_design_with_si_post_route_fix true
route_global_detail
set_db route_design_with_eco true
set_db route_design_selected_net_only false
set_db route_design_with_timing_driven true
set_db route_design_with_si_driven true
reset_db route_design_exp_signature_eco
reset_db route_design_exp_dirty_area_eco
set_db route_design_with_si_post_route_fix false
extract_rc
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
reset_db opt_power_unit_total_power
set_db timing_analysis_check_type hold
report_timing -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_all_hold.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg_hold.tarpt.gz
report_timing -path_group default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_default_hold.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default_hold.tarpt.gz
set_db timing_analysis_check_type setup
report_timing -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_all.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg.tarpt.gz
report_timing -path_group default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_default.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default.tarpt.gz
report_length_violations -out_file ./timingReports/top_postRoute.length.gz
reset_db opt_view_pruning_active_drv_views
eval_legacy { setOptMode -reset -autoDrvViews }
reset_db opt_effort
reset_db opt_route_mode
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_delete_insts true
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
reset_db opt_power_unit_total_power
set_db -quiet flow_metrics_snapshot_uuid 2bea0a2e-fe4a-4639-a396-c95fda55360a
report_multi_bit_ffs -statistics
set_message -id IMPSP-9105 -suppress
report_congestion -hotSpot
set_message -id IMPSP-9105 -unsuppress
set_db -quiet flow_metrics_snapshot_uuid 764a5ced-2d3d-4855-a999-3af23ab3ac04
reset_db opt_power_unit_total_power
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_drv_margin 0.0
set_db route_design_exp_preserve_constraints true
set_db timing_analysis_graph_pba_mode false
set_db opt_post_route_area_reclaim none
eval_legacy { setOptMode -reset -expTATEnhancementV3 }
set_db opt_all_end_points false
set_db opt_exp_buffer_congestion_aware_extreme false
time_design -post_route -hold 
opt_design -post_route -hold
set_db opt_all_end_points true
set_db design_power_effort high
set_db design_flow_effort high
set_db design_flow_effort -help 
opt_design -post_route -hold
set_db design_flow_effort extreme
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
eval_legacy { setDelayCalMode -engine default -siAware true }
set_db opt_exp_buffer_congestion_aware_extreme false
eval_legacy { setOptMode -expTATEnhancementV3 1 }
set_db opt_exp_pre_cts_new_extreme_flow true
set_db delaycal_enable_high_fanout true
set_db opt_post_route_area_reclaim hold_and_setup_aware
set_db si_delay_separate_on_data true
set_db delaycal_socv_accuracy_mode low
set_db opt_exp_reclaim_leakage_aggressive_force_downsize true
set_db opt_skew_relaxed_skew_target true
set_db route_design_exp_signature_eco true
set_db route_design_exp_dirty_area_eco true
reset_db route_design_exp_dirty_area_eco
reset_db route_design_exp_signature_eco
eval_legacy { checkPlace -noPreplaced -ignoreOutOfCore -noHalo -preserveMaskShift -noCheckPinAccess -noHardFence }
eval_legacy { setIlmType 1 }
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
set_db opt_effort high
set_db opt_setup_target_slack 0
set_db opt_route_mode no_incremental
eval_legacy { reportVtInstCount -quiet }
extract_rc
eval_legacy { createBasicPathGroups -quiet }
set_db timing_analysis_check_type hold
set_db timing_analysis_graph_pba_mode false
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_active_drv_views { }
set_db opt_view_pruning_hold_target_slack_auto_flow 0
eval_legacy { setOptMode -autoDrvViews {} }
set_db timing_analysis_check_type setup
propagate_activity
eval_legacy { setPlaceMode -wireLenOpt false }
eval_legacy { refinePlace -preserveRouting true -hardFence false }
eval_legacy { setPlaceMode -wireLenOpt false }
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_exp_reclaim_leakage_aggressive_force_downsize false
set_db opt_skew_relaxed_skew_target false
reset_db opt_power_unit_total_power
set_db timing_analysis_check_type hold
report_timing -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_all_hold.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg_hold.tarpt.gz
report_timing -path_group default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_default_hold.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default_hold.tarpt.gz
set_db timing_analysis_check_type setup
report_timing -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_all.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg.tarpt.gz
report_timing -path_group default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_default.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default.tarpt.gz
report_length_violations -out_file ./timingReports/top_postRoute.length.gz
reset_db opt_view_pruning_active_drv_views
eval_legacy { setOptMode -reset -autoDrvViews }
reset_db opt_effort
reset_db opt_route_mode
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_delete_insts true
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
reset_db opt_power_unit_total_power
set_db -quiet flow_metrics_snapshot_uuid 87028a98-6689-4ec5-8961-5bd420a6a93d
report_multi_bit_ffs -statistics
set_message -id IMPSP-9105 -suppress
report_congestion -hotSpot
set_message -id IMPSP-9105 -unsuppress
set_db -quiet flow_metrics_snapshot_uuid 4c529d67-ccc4-47aa-8d1e-1307d2a14c7f
reset_db opt_power_unit_total_power
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_drv_margin 0.0
set_db route_design_exp_preserve_constraints true
set_db timing_analysis_graph_pba_mode false
set_db opt_post_route_area_reclaim none
eval_legacy { setOptMode -reset -expTATEnhancementV3 }
set_db opt_exp_buffer_congestion_aware_extreme false
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true
eval_legacy { setDelayCalMode -engine default -siAware true }
set_db opt_exp_buffer_congestion_aware_extreme false
eval_legacy { setOptMode -expTATEnhancementV3 1 }
set_db delaycal_enable_high_fanout true
set_db opt_post_route_area_reclaim hold_and_setup_aware
set_db si_delay_separate_on_data true
set_db delaycal_socv_accuracy_mode low
set_db opt_exp_reclaim_leakage_aggressive_force_downsize true
set_db opt_skew_relaxed_skew_target true
set_db route_design_exp_signature_eco true
set_db route_design_exp_dirty_area_eco true
reset_db route_design_exp_dirty_area_eco
reset_db route_design_exp_signature_eco
eval_legacy { checkPlace -noPreplaced -ignoreOutOfCore -noHalo -preserveMaskShift -noCheckPinAccess -noHardFence }
eval_legacy { setIlmType 1 }
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
set_db opt_effort high
set_db opt_setup_target_slack 0
set_db opt_route_mode no_incremental
eval_legacy { reportVtInstCount -quiet }
extract_rc
eval_legacy { createBasicPathGroups -quiet }
set_db timing_analysis_check_type hold
set_db timing_analysis_graph_pba_mode false
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_active_drv_views { }
set_db opt_view_pruning_hold_target_slack_auto_flow 0
eval_legacy { setOptMode -autoDrvViews {} }
set_db timing_analysis_check_type setup
propagate_activity
eval_legacy { setPlaceMode -wireLenOpt false }
eval_legacy { refinePlace -preserveRouting true -hardFence false }
eval_legacy { setPlaceMode -wireLenOpt false }
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_exp_reclaim_leakage_aggressive_force_downsize false
set_db opt_skew_relaxed_skew_target false
reset_db opt_power_unit_total_power
set_db timing_analysis_check_type hold
report_timing -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_all_hold.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg_hold.tarpt.gz
report_timing -path_group default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_default_hold.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -early -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default_hold.tarpt.gz
set_db timing_analysis_check_type setup
report_timing -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_all.tarpt.gz
report_timing -path_group reg2reg -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_reg2reg.tarpt.gz
report_timing -path_group default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_default.tarpt.gz
report_timing -path_group tdgp_reg2reg_default -max_paths 50 -path_type full_clock -net > ./timingReports/top_postRoute_tdgp_reg2reg_default.tarpt.gz
report_length_violations -out_file ./timingReports/top_postRoute.length.gz
reset_db opt_view_pruning_active_drv_views
eval_legacy { setOptMode -reset -autoDrvViews }
reset_db opt_effort
reset_db opt_route_mode
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_delete_insts true
set_db extract_rc_net_count_in_memory 100000
set_db extract_rc_post_route_no_clean_rcdb true
set_db opt_drv_margin 0.0
reset_db opt_power_unit_total_power
set_db -quiet flow_metrics_snapshot_uuid e4966e26-e257-400f-a8c6-d1f60a953861
report_multi_bit_ffs -statistics
set_message -id IMPSP-9105 -suppress
report_congestion -hotSpot
set_message -id IMPSP-9105 -unsuppress
set_db -quiet flow_metrics_snapshot_uuid ceab5a86-3ac4-4116-a3ea-d8035e567c08
reset_db opt_power_unit_total_power
set_db opt_view_pruning_setup_views_persistent_list { nangate_view_setup}
set_db opt_view_pruning_hold_views_persistent_list { nangate_view_hold}
set_db opt_view_pruning_setup_views_active_list { nangate_view_setup }
set_db opt_view_pruning_hold_views_active_list { nangate_view_hold }
set_db opt_view_pruning_tdgr_setup_views_persistent_list { nangate_view_setup}
reset_db opt_view_pruning_spatial_setup_views_persistent_list
set_db opt_view_pruning_hold_target_slack_auto_flow 0
set_db opt_drv_margin 0.0
set_db route_design_exp_preserve_constraints true
set_db timing_analysis_graph_pba_mode false
set_db opt_post_route_area_reclaim none
eval_legacy { setOptMode -reset -expTATEnhancementV3 }
set_db opt_exp_buffer_congestion_aware_extreme false
time_design -post_route -hold 
report_timing -output_format gtd -max_paths 10000 -max_slack 0.75 -path_exceptions all -early > top.btarpt
read_timing_debug_report -name default_report top.btarpt -max_path_num 10000 -update_category 0
opt_design -post_route -hold
group_path -name failing 
set_layer_preference gtdObj -color {#ffffff #ff0000 #ffc0cb #ffff00 #ffd700 #00ff00 #006400 #1dd8e6 #00008b}
set db route_selected_net_only false
set_db route_selected_net_only false
set_db timing_analysis_type ocv
set_db route_design_detail_use_multi_cut_via_effort medium
set_path_group_options -effort_level high
gui_deselect -all
gui_deselect -all
group_path -name failing -to result_reg_reg[3><0]/RN
group_path -name failing -to result_reg_reg[3]/RN
set_path_group_options failing -effort_level high
group_path -name failing -to result_reg_reg[3]
set_path_group_options failing -effort_level high
route_opt_design -opt -hold
route_opt_design -opt -hold
gui_deselect -all
exit
