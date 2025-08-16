# Version 1.0 Yue Yang 8-15-2025
set_db design_cong_effort high
set_db design_early_clock_flow true

# Placement
place_opt_design 

check_place 

# Early global router
set_db route_early_global_bottom_routing_layer 2
set_db route_early_global_top_routing_layer 8
set_db route_early_global_honor_power_domain false 
set_db route_early_global_honor_partition_pin_guide true
route_early_global 

report_congestion -overflow

# Timing
reset_parasitics 
set_db extract_rc_effort_level high
set_db extract_rc_engine pre_route
extract_rc
set_db opt_drv_fix_max_cap true ; set_db opt_drv_fix_max_tran true ; set_db opt_fix_fanout_load true
# fix setup
opt_design -pre_cts
# report pre_cts timing
time_design -pre_cts -path_report -drv_report -slack_report -num_paths 50 -report_prefix top_preCTS -report_dir timingReports

# check point
write_db top_Pre_CTS 

