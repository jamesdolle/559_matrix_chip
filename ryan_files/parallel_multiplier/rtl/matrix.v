module MatrixMultiplier (
    input wire clk,        // Clock signal
    input wire rst,        // Reset signal
    input wire [7:0] loaded_num_a0, loaded_num_a1, loaded_num_a2, loaded_num_a3,  // Input matrix A
    input wire [7:0] loaded_num_b0, loaded_num_b1, loaded_num_b2, loaded_num_b3,  // Input matrix B
    output reg [15:0] result1, result2, result3, result4,       // Output matrix C
    output reg multiplication_done        // Multiplication done signal
);

// Declare reg outputs
reg [15:0] result1_reg, result2_reg, result3_reg, result4_reg; // internal to MatrixMultiplier

// Reset and initialization
always @(posedge clk or posedge rst) begin
    if (rst) begin
        result1_reg <= 0;
        result2_reg <= 0;
        result3_reg <= 0;
        result4_reg <= 0;
        multiplication_done <= 0;
    end else begin
        if (multiplication_done == 0) begin
            // Perform multiplication when multiplication_done is not asserted
            result1_reg <= loaded_num_a0 * loaded_num_b0 + loaded_num_a1 * loaded_num_b2;
            result2_reg <= loaded_num_a0 * loaded_num_b1 + loaded_num_a1 * loaded_num_b3;
            result3_reg <= loaded_num_a2 * loaded_num_b0 + loaded_num_a3 * loaded_num_b2;
            result4_reg <= loaded_num_a2 * loaded_num_b1 + loaded_num_a3 * loaded_num_b3;
            multiplication_done <= 1;
        end
    end
end

// assign reg outputs to output ports
always @* begin // sensitivity list that updates whenever resultX_reg values change... might not be good for computation 
    result1 = result1_reg; // assigns the output reg with the values on internal result_reg's 
    result2 = result2_reg;
    result3 = result3_reg;
    result4 = result4_reg;
end

endmodule


