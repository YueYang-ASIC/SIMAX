set_db route_special_via_connect_to_shape { stripe }
route_special -connect {core_pin} -layer_change_range { metal1(1) metal10(10) } -block_pin_target {nearest_target} -core_pin_target {first_after_row_end} -allow_jogging 1 -crossover_via_layer_range { metal1(1) metal10(10) } -nets { VDD VSS } -allow_layer_change 1 -target_via_layer_range { metal1(1) metal10(10) } 

