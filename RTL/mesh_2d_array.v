module mesh_2d_array #(
    parameter DW = 8,
    parameter ROWS = 4,
    parameter COLS = 4,
    parameter ROW_W = 2,
    parameter COL_W = 2
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [COLS*DW-1:0] x_vector_flat,
    input  wire [1:0] global_state, 

    // Config broadcast interface
    input  wire cfg_valid,
    input  wire [ROW_W + COL_W - 1:0] cfg_addr,
    input  wire [DW-1:0] cfg_data,

    // Flattened outputs
    output wire [ROWS*2*DW-1:0] result_flat 
);

    // Unpacked x_vector
    wire [DW-1:0] x_vector [0:COLS-1];
    genvar r, c;
    generate
        for (c = 0; c < COLS; c = c + 1) begin : UNPACK_X
            assign x_vector[c] = x_vector_flat[(c+1)*DW-1 -: DW];
        end
    endgenerate

    // Mesh connections
    wire [DW-1:0]     x_in     [0:ROWS-1][0:COLS-1];
    wire [DW-1:0]     x_out    [0:ROWS-1][0:COLS-1];
    wire [2*DW-1:0]   acc_in   [0:ROWS-1][0:COLS-1];
    wire [2*DW-1:0]   acc_out  [0:ROWS-1][0:COLS-1];
    wire [2*DW-1:0]   result   [0:ROWS-1];
    wire              result_valid [0:ROWS-1];

    generate
        for (r = 0; r < ROWS; r = r + 1) begin: ROW
            for (c = 0; c < COLS; c = c + 1) begin: COL
                assign x_in[r][c]   = (global_state == 2'd1) ? (r == 0 ? x_vector[c] : x_out[r-1][c]):0;   
                assign acc_in[r][c] = (global_state == 2'd2) ? (c == 0 ? 0 : acc_out[r][c-1]):0;
                tile_pe #(
                    .DW(DW),
                    .ROW_W(ROW_W),
                    .COL_W(COL_W)
                ) PE (
                    .clk(clk),
                    .rst_n(rst_n),
                    .core_row(r[ROW_W-1:0]),
                    .core_col(c[COL_W-1:0]),
                    .cfg_addr(cfg_addr),
                    .cfg_data(cfg_data),
                    .cfg_valid(cfg_valid),
                    .global_state(global_state),
                    .x_in(x_in[r][c]),
                    .acc_in(acc_in[r][c]),
                    .x_reg_out(x_out[r][c]),
                    .acc_reg_out(acc_out[r][c]) 
                );
            end
        end
    endgenerate


    // Flatten outputs
    generate
        for (r = 0; r < ROWS; r = r + 1) begin : FLATTEN_RESULTS 
            assign result_flat[(r+1)*2*DW-1 -: 2*DW] = acc_out[r][COLS-1];  
        end
    endgenerate

endmodule

