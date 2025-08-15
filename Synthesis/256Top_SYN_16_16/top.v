module top #(
    parameter DW       = 8,
    parameter ROWS     = 16,
    parameter COLS     = 16,
    parameter ROW_W    = 4,
    parameter COL_W    = 4,
    parameter CYCLE_W  = 6,
    parameter ACC_W = 16
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    input  wire preload_valid,
    input  wire [ROW_W+COL_W-1:0] preload_addr,
    input  wire signed [DW-1:0] preload_data,
    input  wire signed [COLS*DW-1:0] x_vector_flat,
    output wire signed [ROWS*ACC_W-1:0] result_flat
    // output wire [1:0] global_state,
    // output wire [CYCLE_W-1:0] cycle 
);

    wire [1:0] global_state;

    fsm_controller #(
        .ROWS(ROWS),
        .COLS(COLS),
        .CYCLE_W(CYCLE_W)
    ) fsm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .global_state(global_state) 
        // .cycle(cycle)
    );

    mesh_2d_array #(
        .DW(DW),
        .ROWS(ROWS),
        .COLS(COLS),
        .ROW_W(ROW_W),
        .COL_W(COL_W),
	.ACC_W(ACC_W)
    ) mesh_inst (
        .clk(clk),
        .rst_n(rst_n),
        .x_vector_flat(x_vector_flat),
        .global_state(global_state),
        .cfg_valid(preload_valid),
        .cfg_addr(preload_addr),
        .cfg_data(preload_data),
        .result_flat(result_flat)
    );

endmodule

