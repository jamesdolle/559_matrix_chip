module testbench ();

    // Inputs
    reg clk = 0;
    reg rst = 0; // Reset control
    reg load;
    reg [31:0] nums_a;
    reg [31:0] nums_b;

    // Outputs
    wire [15:0] result [1:4];
    wire [7:0] loaded_num_a [1:4];
    wire [7:0] loaded_num_b [1:4];
    reg multiplication_done;

    // Instantiate NumberLoader
    NumberLoader loader (
        .clk(clk),
        .nums_a(nums_a),                // input from testbench 
        .nums_b(nums_b),                // input from testbench 
        .loaded_num_a(loaded_num_a),    // output from loader
        .loaded_num_b(loaded_num_b),    // output from loader
        .load(load)                     // control signal
    );

    // Instantiate MatrixMultiplier
    MatrixMultiplier multiplier (
        .clk(clk),
        .rst(rst), // Connect reset signal
        .loaded_num_a(loaded_num_a),    // input from loader matrix A
        .loaded_num_b(loaded_num_b),    // input from loader matrix B
        .result(result),                 // output from multiplier matrix C
        .multiplication_done(multiplication_done)
    );

    always #5ns clk = ~clk;   // Generate clock

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
        #10;
        load = 0;
        #20;
        
        // Reset signal asserted
        rst = 1;
        #10;
        rst = 0;

        // End simulation
        #500;
        $finish;
    end

endmodule
