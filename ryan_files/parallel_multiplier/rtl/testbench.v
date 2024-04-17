`timescale 1ns/1ps

module testbench ();

    // Inputs
    reg clk = 0;
    reg rst = 0; // Reset control
    reg load;
    reg [31:0] nums_a;
    reg [31:0] nums_b;

    // Outputs
    wire [15:0] result [1:4];
    wire [7:0] loaded_num_a0, loaded_num_a1, loaded_num_a2, loaded_num_a3;
    wire [7:0] loaded_num_b0, loaded_num_b1, loaded_num_b2, loaded_num_b3;
    wire multiplication_done;

    // Instantiate NumberLoader
    NumberLoader loader (
        .clk(clk),
        .nums_a(nums_a),                
        .nums_b(nums_b),                
        .loaded_num_a0(loaded_num_a0), 
        .loaded_num_a1(loaded_num_a1),
        .loaded_num_a2(loaded_num_a2),
        .loaded_num_a3(loaded_num_a3),
        .loaded_num_b0(loaded_num_b0), 
        .loaded_num_b1(loaded_num_b1),
        .loaded_num_b2(loaded_num_b2),
        .loaded_num_b3(loaded_num_b3),
        .load(load)                     
    );

        MatrixMultiplier multiplier (
        .clk(clk),
        .rst(rst), 
        .loaded_num_a0(loaded_num_a0),
        .loaded_num_a1(loaded_num_a1),
        .loaded_num_a2(loaded_num_a2),
        .loaded_num_a3(loaded_num_a3),
        .loaded_num_b0(loaded_num_b0),
        .loaded_num_b1(loaded_num_b1),
        .loaded_num_b2(loaded_num_b2),
        .loaded_num_b3(loaded_num_b3),
        .result1(result[1]),
        .result2(result[2]),
        .result3(result[3]),
        .result4(result[4]),
        .multiplication_done(multiplication_done)
    );

    always #0.5ns clk = ~clk;   // Generate clock

    // Testbench
    initial begin
        $dumpfile("simulation.vcd");
        $dumpvars(0, testbench);

        // Test bits
        //Row-wise:  R1C1,         R1C2,        R2C1,        R2C2
        nums_a = {8'b00000001, 8'b00000010, 8'b00000100, 8'b00001000};
        nums_b = {8'b00000001, 8'b00000011, 8'b00000101, 8'b00001011};
        
        // Start loading
        load = 1;
        #1;
        load = 0;
        #1;
        
        // Reset signal asserted
        rst = 1;
        #2;
        rst = 0;

        // End simulation
        #100;
        $finish;
    end

endmodule
