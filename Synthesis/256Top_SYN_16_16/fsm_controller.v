module fsm_controller #(
    parameter ROWS = 2,
    parameter COLS = 4,
    parameter CYCLE_W = 5
)(
    input  wire clk,
    input  wire rst_n,
    input  wire start,
    output reg  [1:0] global_state//,
    
);

    localparam S_IDLE   = 2'd0;
    localparam S_LOAD_X = 2'd1;
    localparam S_MAC    = 2'd2;
    localparam S_STORE  = 2'd3;

    reg  [CYCLE_W-1:0] cycle; 
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            global_state <= S_IDLE;
            cycle        <= 0;
        end else begin
            case (global_state)
                S_IDLE: begin
                    if (start) begin
                        global_state <= S_LOAD_X;
                        cycle <= 1;
                    end
                end

                S_LOAD_X: begin
                    if (cycle == ROWS)
                        global_state <= S_MAC;
                    cycle <= cycle + 1;
                end

                S_MAC: begin
                    if (cycle == ROWS + COLS)
                        global_state <= S_STORE;
                    cycle <= cycle + 1;
                end

                S_STORE: begin
                    if (cycle == ROWS + COLS + 1)
                        global_state <= S_IDLE;
                    cycle <= cycle + 1;
                end

                default: begin
                    global_state <= S_IDLE;
                    cycle <= 0;
                end
            endcase
        end
    end
 

endmodule

