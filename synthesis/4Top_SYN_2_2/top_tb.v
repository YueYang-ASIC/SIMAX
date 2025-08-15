`timescale 1ns/1ps

module top_tb;

    // Parameters
    parameter DW       = 8;
    parameter ROWS     = 40;
    parameter COLS     = 40;
    parameter ROW_W    = 7; // log2(ROWS)
    parameter COL_W    = 7; // log2(COLS)
    parameter CYCLE_W  = 9;
    parameter ACC_W    = 16;

    // Signals
    reg clk;
    reg rst_n;
    reg start;

    reg preload_valid;
    reg [ROW_W+COL_W-1:0] preload_addr;
    reg signed [DW-1:0] preload_data;

    reg signed [COLS*DW-1:0] x_vector_flat;

    wire signed [ROWS*ACC_W-1:0] result_flat;
    wire [1:0] global_state;
    // wire [CYCLE_W-1:0] cycle;

    // Instantiate DUT
    top #(
        .DW(DW),
        .ROWS(ROWS),
        .COLS(COLS),
        .ROW_W(ROW_W),
        .COL_W(COL_W),
        .CYCLE_W(CYCLE_W),
	.ACC_W(ACC_W)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .preload_valid(preload_valid),
        .preload_addr(preload_addr),
        .preload_data(preload_data),
        .x_vector_flat(x_vector_flat),
        .result_flat(result_flat)
        // .global_state(global_state)
        // .cycle(cycle)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Loop variables
    integer r, c, i, y;

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
                preload_data  = r + c ;
                preload_valid = 1;
                @(posedge clk);
            end
        end
        preload_valid = 0;

        // Short delay before FSM start
        @(negedge clk);
        $display(">>> Starting FSM computation...");
        start = 1;

        // Initialize x_vector_flat: x[c] = COLS - c
        x_vector_flat = 32'sb0; // signed zero initialization
        for (y = 0; y < COLS; y = y + 1) begin
            x_vector_flat[(COLS-1-y)*DW +: DW] =  $signed(COLS-y );
	   $display("x_vector_ %0d Result = %0d", COLS-1-y,   $signed(COLS -y));
        end

        @(posedge clk);
        start = 0;

        // Wait long enough for computation to complete
        repeat (ROWS + COLS + 5) @(posedge clk);

        // Print final results
        $display("---- Final Mesh Output ----");
        for (i = 0; i < ROWS; i = i + 1) begin
            $display("Row %0d Result = %0d", i,
                $signed(result_flat[(i+1)*ACC_W-1 -: ACC_W]));
        end

        $display("=== Testbench Completed ===");
        $stop;
    end

endmodule

