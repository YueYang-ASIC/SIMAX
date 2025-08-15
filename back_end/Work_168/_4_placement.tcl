place_opt_design 
set_db route_early_global_bottom_routing_layer 2 ; set_db route_early_global_top_routing_layer 10 ; set_db route_early_global_honor_power_domain false ; set_db route_early_global_honor_partition_pin_guide true
route_early_global 
reset_parasitics 
extract_rc
time_design -pre_cts -path_report -drv_report -slack_report -num_paths 50 -report_prefix top_preCTS -report_dir timingReports
