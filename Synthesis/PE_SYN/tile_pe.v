module tile_pe #(
    parameter DW = 8,
    parameter ROW_W = 4,
    parameter COL_W = 4
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [ROW_W-1:0] core_row,
    input  wire [COL_W-1:0] core_col,
    input  wire [ROW_W + COL_W - 1:0] cfg_addr,
    input  wire [DW-1:0]              cfg_data,
    input  wire                       cfg_valid,
    input  wire [1:0]                 global_state,
    input  wire [DW-1:0]              x_in,
    input  wire [2*DW-1:0]            acc_in,
    output reg  [DW-1:0]              x_reg_out,
    output reg  [2*DW-1:0]            acc_reg_out
);

    localparam S_LOAD_W = 2'd0;
    localparam S_LOAD_X = 2'd1;
    localparam S_MAC    = 2'd2;

    reg [DW-1:0] weight_reg;

    wire [ROW_W + COL_W - 1:0] my_addr = {core_row, core_col};
    wire addr_match = (cfg_valid && (cfg_addr == my_addr));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            weight_reg   <= 0;
            x_reg_out    <= 0;
            acc_reg_out  <= 0;
        end else begin
            case (global_state)
                S_LOAD_W: begin
                    if (addr_match)
                        weight_reg <= cfg_data;
                end
                S_LOAD_X: begin
                    x_reg_out <= x_in;
                end
                S_MAC: begin
                    acc_reg_out <= acc_in + (weight_reg * x_reg_out);
                end
                default: begin
                    acc_reg_out <= 0;
                end
            endcase
        end
    end

endmodule

