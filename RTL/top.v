
`timescale 1ns/1ps

module top #(
    parameter DW       = 8,
    parameter ROWS     = 2,
    parameter COLS     = 4,
    parameter ROW_W    = 1,
    parameter COL_W    = 2,
    parameter CYCLE_W  = 5
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,

    // Preload config interface
    input  wire preload_valid,
    input  wire [ROW_W+COL_W-1:0] preload_addr,
    input  wire [DW-1:0] preload_data,

    // Output
    output wire [ROWS*2*DW-1:0] result_flat,
    output wire [1:0] global_state,
    output wire [CYCLE_W-1:0] cycle,
    output wire done
);

    // FSM instance
    fsm_controller #(
        .ROWS(ROWS),
        .COLS(COLS),
        .CYCLE_W(CYCLE_W)
    ) fsm_inst (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .global_state(global_state),
        .cycle(cycle),
        .done(done)
    );

    // Input vector: X = {1, 2, 3, 4}
    wire [COLS*DW-1:0] x_vector_flat;
    assign x_vector_flat = {8'd4, 8'd3, 8'd2, 8'd1};

    // Connect config from preload interface
    wire cfg_valid;
    wire [ROW_W+COL_W-1:0] cfg_addr;
    wire [DW-1:0] cfg_data;

    assign cfg_valid = preload_valid;
    assign cfg_addr  = preload_addr;
    assign cfg_data  = preload_data;

    // Mesh instance
    mesh_2d_array #(
        .DW(DW),
        .ROWS(ROWS),
        .COLS(COLS),
        .ROW_W(ROW_W),
        .COL_W(COL_W)
    ) mesh_inst (
        .clk(clk),
        .rst_n(rst_n),
        .x_vector_flat(x_vector_flat),
        .global_state(global_state),
        .cfg_valid(cfg_valid),
        .cfg_addr(cfg_addr),
        .cfg_data(cfg_data),
        .result_flat(result_flat)
    );

endmodule
