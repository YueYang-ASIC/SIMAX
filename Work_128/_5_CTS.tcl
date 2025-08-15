set_db cts_buffer_cells {BUF_X1 BUF_X2 BUF_X4 BUF_X8 BUF_X16 BUF_X32 CLKBUF_X1 CLKBUF_X2 CLKBUF_X3}
set_db cts_inverter_cells {INV_X1 INV_X2 INV_X4 INV_X8 INV_X16 INV_X32} 
ccopt_design
time_design -post_cts
time_design -post_cts -hold

