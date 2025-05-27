
`timescale 1ns/1ps

module top_tb;

    // Parameters
    parameter DW       = 8;
    parameter ROWS     = 5;
    parameter COLS     = 5;
    parameter ROW_W    = 3;
    parameter COL_W    = 3;
    parameter CYCLE_W  = 5;

    // Signals
    reg clk;
    reg rst_n;
    reg start;

    reg preload_valid;
    reg [ROW_W+COL_W-1:0] preload_addr;
    reg [DW-1:0] preload_data;

    reg [COLS*DW-1:0] x_vector_flat;

    wire [ROWS*2*DW-1:0] result_flat;
    wire [1:0] global_state;
    //wire [CYCLE_W-1:0] cycle;

    // Instantiate DUT
    top #(
        .DW(DW),
        .ROWS(ROWS),
        .COLS(COLS),
        .ROW_W(ROW_W),
        .COL_W(COL_W),
        .CYCLE_W(CYCLE_W)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .preload_valid(preload_valid),
        .preload_addr(preload_addr),
        .preload_data(preload_data),
 	.x_vector_flat(x_vector_flat),
        .result_flat(result_flat)//,
        //.global_state(global_state)
        //.cycle(cycle)

    );

    // Clock generation
    always #5 clk = ~clk;

    // Loop vars
    integer r, c, i;

//    // FSM state display
//    reg [95:0] state_str;
//    always @(*) begin
//        case (global_state)
//            2'd0: state_str = "S_IDLE   ";
//            2'd1: state_str = "S_LOAD_X ";
//            2'd2: state_str = "S_MAC    ";
//            2'd3: state_str = "S_STORE  ";
//            default: state_str = "UNKNOWN  ";
//        endcase
//    end

//    // Display state and cycle at every clock
//    always @(posedge clk) begin
//        if (rst_n)
//            $display("Time: %0t | State: %s | Cycle: %0d", $time, state_str, cycle);
//    end

    initial begin
        $display("=== Mesh FSM Top Testbench (Verilog-2001) ===");

        clk = 0;
        rst_n = 0;
        preload_valid = 0;
        preload_addr = 0;
        preload_data = 0;
        start = 0;

        // Apply reset
        #15 rst_n = 1;

        // === Preload weights ===
        // Weights: w[r][c] = r + c + 1
        for (r = 0; r < ROWS; r = r + 1) begin
            for (c = 0; c < COLS; c = c + 1) begin
                preload_addr  = {r[ROW_W-1:0], c[COL_W-1:0]};
                preload_data  = r + c + 1;
                preload_valid = 1;
                @(posedge clk);
            end
        end
        preload_valid = 0;


        // Short delay before FSM start
        @(negedge clk); 
        $display(">>> Starting FSM computation...");
        start = 1;	
	x_vector_flat = {8'd5,8'd4, 8'd3, 8'd2, 8'd1};
        @(posedge clk); 
  	start = 0;
        // Wait long enough for computation to complete
        repeat (ROWS + COLS +5) @(posedge clk);

        // Print final results
        $display("---- Final Mesh Output ----");
        for (i = 0; i < ROWS; i = i + 1) begin
            $display("Row %0d Result = %0d", i,
                result_flat[(i+1)*2*DW-1 -: 2*DW]);
        end

        $display("=== Testbench Completed ===");
        $stop;
    end

endmodule
