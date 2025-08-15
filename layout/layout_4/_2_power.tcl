delete_global_net_connections
connect_global_net VDD -type pg_pin -pin_base_name VDD -inst_base_name * -hinst {}
connect_global_net VSS -type pg_pin -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VSS -type tie_lo -pin_base_name VSS -inst_base_name * -hinst {}
connect_global_net VDD -type tie_hi -pin_base_name VDD -inst_base_name * -hinst {}
set_db add_rings_target default ; set_db add_rings_extend_over_row 0 ; set_db add_rings_ignore_rows 0 ; set_db add_rings_avoid_short 0 ; set_db add_rings_skip_shared_inner_ring none ; set_db add_rings_stacked_via_top_layer metal10 ; set_db add_rings_stacked_via_bottom_layer metal1 ; set_db add_rings_via_using_exact_crossover_size 1 ; set_db add_rings_orthogonal_only true ; set_db add_rings_skip_via_on_pin {  standardcell } ; set_db add_rings_skip_via_on_wire_shape {  noshape }
add_rings -nets {VSS VDD} -type core_rings -follow core -layer {top metal9 bottom metal9 left metal10 right metal10} -width {top 1.8 bottom 1.8 left 1.8 right 1.8} -spacing {top 1.5 bottom 1.5 left 1.5 right 1.5} -offset {top 1.8 bottom 1.8 left 1.8 right 1.8} -center 0 -threshold 0 -jog_distance 0 -snap_wire_center_to_grid none
set_db add_stripes_ignore_drc 1
set_db generate_special_via_ignore_drc 1
# change -number_of_sets, start_offset, -stop_offset
add_stripes -nets {VDD VSS} -layer metal10 -direction vertical -width 1.8 -spacing 1.5 -number_of_sets 3 -start_from left -start_offset 11.25 -stop_offset 11.25 -switch_layer_over_obs false -max_same_layer_jog_length 2 -pad_core_ring_top_layer_limit metal10 -pad_core_ring_bottom_layer_limit metal1 -block_ring_top_layer_limit metal10 -block_ring_bottom_layer_limit metal1 -use_wire_group 0 -snap_wire_center_to_grid none

