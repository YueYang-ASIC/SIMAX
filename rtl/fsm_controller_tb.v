`timescale 1ns/1ps

module fsm_controller_tb;

    // Parameters
    parameter ROWS = 4;
    parameter COLS = 4;
    //parameter CYCLE_W = 5;

    // DUT signals
    reg clk;
    reg rst_n;
    reg start;
    wire [1:0] global_state;
    //wire [CYCLE_W-1:0] cycle;

    // Instantiate the FSM
    fsm_controller #(
        .ROWS(ROWS),
        .COLS(COLS)//,
    //    .CYCLE_W(CYCLE_W)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .global_state(global_state)//,
    //    .cycle(cycle)
    );

    // Clock generation
    always #5 clk = ~clk;

    // FSM state string decoder for readability
    reg [8*12-1:0] state_str;
    always @(*) begin
        case (global_state)
            2'd0: state_str = "S_IDLE   ";
            2'd1: state_str = "S_LOAD_X ";
            2'd2: state_str = "S_MAC    ";
            2'd3: state_str = "S_STORE  ";
            default: state_str = "UNKNOWN  ";
        endcase
    end

//    // Monitor state and cycle
//    always @(posedge clk) begin
//        if (rst_n)
//            $display("Time: %0t | State: %s | Cycle: %0d", $time, state_str, cycle);
//    end

    // Test sequence
    initial begin
        $display("=== FSM Controller Testbench ===");

        clk = 0;
        rst_n = 0;
        start = 0;

        // Apply reset
        #12 rst_n = 1;

        // Wait in IDLE for a few cycles
        #30;

        // Trigger start
        $display(">>> Triggering start signal...");
        start = 1;
        @(posedge clk);
        start = 0;

        // Wait long enough to cover full FSM cycle
        repeat (ROWS + COLS + 6) @(posedge clk);

        $display("=== FSM Test Completed ===");
        $stop;
    end

endmodule

