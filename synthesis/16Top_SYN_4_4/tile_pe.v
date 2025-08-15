module tile_pe #(
    parameter DW = 8,
    parameter ROW_W = 4,
    parameter COL_W = 4,
    parameter ACC_W = 32
)(
    input  wire clk,
    input  wire rst_n,
    input  wire [ROW_W-1:0] core_row,
    input  wire [COL_W-1:0] core_col,
    input  wire [ROW_W + COL_W - 1:0] cfg_addr,
    input  wire signed [DW-1:0]       cfg_data,
    input  wire                       cfg_valid,
    input  wire [1:0]                 global_state,
    input  wire signed [DW-1:0]       x_in, 
    input  wire signed [ACC_W-1:0]     acc_in,// int32 
    output reg  signed [DW-1:0]       x_reg_out,
    output reg  signed [ACC_W-1:0]     acc_reg_out // int32
);

    localparam S_LOAD_W = 2'd0;
    localparam S_LOAD_X = 2'd1;
    localparam S_MAC    = 2'd2;

    reg signed [DW-1:0] weight_reg;

    wire [ROW_W + COL_W - 1:0] my_addr = {core_row, core_col};
    wire addr_match = (cfg_valid && (cfg_addr == my_addr));
    wire signed [ACC_W:0] acc_wire = acc_in + (weight_reg * x_reg_out);

    // Saturating output register logic
    localparam signed [ACC_W:0] ACC_MAX = (1<<< (ACC_W -1) ) - 1;
    localparam signed [ACC_W:0] ACC_MIN = -(1<<< (ACC_W -1) );
 

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

if (acc_wire[ACC_W:ACC_W-1] == 2'b00|acc_wire[ACC_W:ACC_W-1] ==2'b11) 
	acc_reg_out <= acc_wire[ACC_W:0];        // pass through w/o 16 MSB bits 
else if (acc_wire[ACC_W] == 1'b0)   
	acc_reg_out <= ACC_MAX; 
else                    
	acc_reg_out <= ACC_MIN;

//		if (acc_in + (weight_reg * x_reg_out) > ACC_MAX)
//                    acc_reg_out <= ACC_MAX;
//                else if (acc_in + (weight_reg * x_reg_out)< ACC_MIN)
//                    acc_reg_out<= ACC_MIN; 
//                else
//		    acc_reg_out<= acc_in + (weight_reg * x_reg_out);
		end
                default: begin
                    acc_reg_out <= 0;
                end
            endcase
        end
    end

endmodule

