# Version 1.0 Yue Yang 8-15-2025
# CTS + Fix hold

# Buffer information
set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32}  

# CTS OPT : ccopt
create_clock_tree_spec
ccopt_design
set_db opt_drv_fix_max_cap true
set_db opt_drv_fix_max_tran true
set_db opt_fix_fanout_load true

# Fix -hold
opt_design -post_cts -hold

# Check timing 
time_design -post_cts -hold

