module MatrixMultiplier (
    input wire clk,        // Clock signal
    input wire rst,        // Reset signal
    input wire [7:0] loaded_num_a1, loaded_num_a2, loaded_num_a3, loaded_num_a4,  // Input matrix A
    input wire [7:0] loaded_num_b1, loaded_num_b2, loaded_num_b3, loaded_num_b4,  // Input matrix B
    output reg [15:0] result1, result2, result3, result4,       // Output matrix C
    output reg multiplication_done        // Multiplication done signal
);

    // Reset and initialization
    integer i; // Declare loop variable inside the procedural block
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 1; i <= 4; i = i + 1) // Correct loop syntax
                case(i)
                    1: result1 <= 0;
                    2: result2 <= 0;
                    3: result3 <= 0;
                    4: result4 <= 0;
                endcase
            multiplication_done <= 0;
        end else if (multiplication_done == 0) begin
            result1 <= loaded_num_a1 * loaded_num_b1 + loaded_num_a2 * loaded_num_b3;
            result2 <= loaded_num_a1 * loaded_num_b2 + loaded_num_a2 * loaded_num_b4;
            result3 <= loaded_num_a3 * loaded_num_b1 + loaded_num_a4 * loaded_num_b3;
            result4 <= loaded_num_a3 * loaded_num_b2 + loaded_num_a4 * loaded_num_b4;
            multiplication_done <= 1;
        end
    end

endmodule


