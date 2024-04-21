//Integrating the scanflop with the matrix_mult module requires a few steps to modify the existing testbench and design instantiation. 
//The goal is to replace the direct assignment of matrices A and B with a mechanism that serially scans these matrices into the matrix_mult module through the scanflop. 

//1. Instantiate the Scanflop Module: Add the scanflop module instantiation in testbench, connecting its outputs A_out and B_out to the inputs A and B of the matrix_mult module.
//Modify the Testbench to Use Scan Enable and Scan Input: Instead of directly setting the A and B matrices, we will now shift the matrix values into the scanflop module serially 
//using the scan_in and scan_enable signals.
//2. Generating Scan Data: we need to convert the matrix data into a serial bitstream that matches the order in which the scanflop module shifts the data into the matrices. 
//The bitstream will consist of the concatenated bits of matrices A and B.
//3. Scan in the Data: Use a loop in testbench to shift this bitstream into the scanflop module, making sure to toggle the scan_enable appropriately.
//Suggested Modifications
//Instantiate the Scanflop in the Testbench:
//Add the scanflop instantiation in tb_matrix_mult.v:

//verilog code

scanflop matrix_scanflop (
    .Clock(Clock), 
    .reset(reset), 
    .scan_enable(scan_enable), // This signal needs to be declared in the testbench
    .scan_in(scan_in),         // This signal also needs to be declared in the testbench
    .A_out(A),                 // Connected to the matrix_mult A input
    .B_out(B),                 // Connected to the matrix_mult B input
    .scan_out()                // Not used in this example
);
//Modify the Testbench for Scanning Data:
//Declare scan_enable and scan_in in testbench module:

***verilog code
reg scan_enable, scan_in;
//Generate the serial bitstream for matrices A and B. Since Verilog doesn't support dynamic strings or arrays in this manner, 
  //we will need to manually create the serial stream or write a function to do so based on matrix data.

//For the sake of illustration, let's assume we have a function or method to generate serial_data (a packed array or a series of assignments that simulate serial data for A and B matrices).

//Scanning in the Data: Use a loop to shift in the data. This replaces the direct assignment of A and B:

***verilog code
initial begin
    Clock = 1;
    reset = 1;
    scan_enable = 0;
    #100;
    reset = 0;
    scan_enable = 1;
    #Clock_period;

    // Assume serial_data contains the bitstream for A and B matrices
    for (int i = 0; i < serial_data.length(); i++) begin
        scan_in = serial_data[i]; // Assign the current bit to scan_in
        #Clock_period; // Advance time to capture this bit
    end
    scan_enable = 0;
    Enable = 1; // Now enable the matrix multiplication
    // The rest of testbench as before
end
