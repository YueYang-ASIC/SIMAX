`timescale 1ns/1ps

module tile_tb;

    // Parameters
    parameter DW = 8;
    parameter ROW_W = 4;
    parameter COL_W = 4;
    parameter ADDR_W = ROW_W + COL_W;

    // DUT ports
    reg clk;
    reg rst_n;

    reg  [ROW_W-1:0] core_row;
    reg  [COL_W-1:0] core_col;

    reg  [ADDR_W-1:0] cfg_addr;
    reg  [DW-1:0]     cfg_data;
    reg               cfg_valid;

    reg  [1:0]        global_state;

    reg  [DW-1:0]     x_in;
    reg  [2*DW-1:0]   acc_in;
    wire [DW-1:0]     x_out;
    wire [2*DW-1:0]   acc_out;
 

    // Instantiate DUT
    tile_pe #(
        .DW(DW),
        .ROW_W(ROW_W),
        .COL_W(COL_W)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .core_row(core_row),
        .core_col(core_col),
        .cfg_addr(cfg_addr),
        .cfg_data(cfg_data),
        .cfg_valid(cfg_valid),
        .global_state(global_state),
        .x_in(x_in),
        .acc_in(acc_in),
        .x_reg_out(x_out),
        .acc_reg_out(acc_out)  
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test procedure
    initial begin
        $display("===== tile_pe Testbench Start =====");
        clk = 0;
        rst_n = 0;

        // Defaults
        cfg_valid = 0;
        cfg_addr  = 0;
        cfg_data  = 0;
        global_state = 2'd0;
        x_in     = 0;
        acc_in   = 0;

        // Tile address
        core_row = 4'd1;
        core_col = 4'd2;

        // Reset
        #20;
        rst_n = 1;
        #10;

        // 1. LOAD_W ? configure weight
        $display("[TB] Loading weight W[1][2] = 5");
        cfg_valid = 1;
        cfg_addr  = {core_row, core_col};
        cfg_data  = 8'd5;
        global_state = 2'd0; // S_LOAD_W
        #10;
        cfg_valid = 0;

        // 2. LOAD_X ? provide input value
        $display("[TB] Loading X = 3");
        x_in = 8'd3;
        global_state = 2'd1; // S_LOAD_X
        #10;

        // 3. MAC ? provide acc_in and perform multiply-add
        $display("[TB] Performing MAC: acc_in = 10, expect acc_out = 10 + 5*3 = 25");
        acc_in = 16'd10;
        global_state = 2'd2; // S_MAC
        #10;

       

        // Display result
        
            $display("[TB] Result: %0d", acc_out);
            if (acc_out == 25)
                $display("[TB] PASS: Correct result_out = 25");
            else
                $display("[TB] FAIL: Incorrect result_out = %0d", acc_out);
        

        $display("===== tile_pe Testbench End =====");
        $stop;
    end

endmodule

