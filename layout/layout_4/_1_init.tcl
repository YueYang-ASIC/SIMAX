set_db init_power_nets VDD
set_db init_ground_nets VSS
read_mmmc top.mmmc
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

