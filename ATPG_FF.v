// flip flop with ATPG test ports 
// Will need to let synth tool know to use this FF instead of standard flipflop
//These scan flops are designed to be loaded with test data or to capture test results during scan testing, 
//which is part of Design for Test (DFT) strategies. For your matrix multiplication module, we can design a simple scanflop module that captures 
//the matrix elements for A and B from an external test interface and loads them into your matrix multiplication module.

//The scanflop for the matrix multiplication will be designed to load data serially into the 72-bit registers A and B of the matrix multiplier. 
//The data is shifted in serially, making it possible to inject test vectors without having to present them all in parallel, 
//which can significantly reduce the number of pins required for testing.

module scanflop
    (
        input wire Clock,
        input wire reset, // active high reset
        input wire scan_enable, // Enable scanning/loading of data
        input wire scan_in, // Serial data input
        output reg [71:0] A_out, // Output to matrix A
        output reg [71:0] B_out, // Output to matrix B
        output wire scan_out // Serial data output for daisy chaining
    );

    reg [143:0] shift_register; // Combined shift register for both matrices A and B
    assign scan_out = shift_register[143]; // The last bit is used as scan_out

    always @(posedge Clock or posedge reset)
    begin
        if (reset) begin
            shift_register <= 144'd0;
        end
        else if (scan_enable) begin
            // Shift in the new bit at scan_in and shift everything else to the right
            shift_register <= {scan_in, shift_register[143:1]};
        end
    end

    always @(negedge Clock) begin
        if (!reset) begin
            // Update the output registers at the negative edge of the clock
            // This is to ensure stability of the inputs to the matrix multiplier module
            // when its inputs are sampled at the positive edge of the clock.
            A_out <= shift_register[71:0];
            B_out <= shift_register[143:72];
        end
    end

endmodule
