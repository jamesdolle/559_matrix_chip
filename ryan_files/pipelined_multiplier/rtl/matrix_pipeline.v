module MatrixMultiplier (
    input wire clk,        // Clock signal
    input wire rst,        // Reset signal
    input wire [7:0] loaded_num_a0, loaded_num_a1, loaded_num_a2, loaded_num_a3,  // Input matrix A
    input wire [7:0] loaded_num_b0, loaded_num_b1, loaded_num_b2, loaded_num_b3,  // Input matrix B
    
    output reg [15:0] result1, result2, result3, result4,         // Output matrix C
    output reg matrix_multiplication_done                         // Multiplication done signal
);
reg [3:0] i;

// Declare reg outputs
//reg [15:0] result1_reg, result2_reg, result3_reg, result4_reg;

// Intermediate signals
reg [15:0] intermediate_result_0;
reg [15:0] intermediate_result_1;
reg [15:0] intermediate_result_2;
reg [15:0] intermediate_result_3;
reg [15:0] intermediate_result_4;
reg [15:0] intermediate_result_5;
reg [15:0] intermediate_result_6;
reg [15:0] intermediate_result_7;

// Pipeline stage control signals
reg [3:0] pipeline_stage;

// Reset and initialization
always @(posedge clk or posedge rst) begin
     if (rst) begin
          // Reset registers
          result1 <= 0;
          result2 <= 0;
          result3 <= 0;
          result4 <= 0;

          // Reset intermediate result
          intermediate_result_0 <= 0;
          intermediate_result_1 <= 0;
          intermediate_result_2 <= 0;
          intermediate_result_3 <= 0;
          intermediate_result_4 <= 0;
          intermediate_result_5 <= 0;
          intermediate_result_6 <= 0;
          intermediate_result_7 <= 0;

          // Reset pipeline stage control & matrix_multiplication_done signal
          pipeline_stage <= 4'b0000;
          matrix_multiplication_done <= 0;

    end else begin
          // start of multiplication and accumulation pipeline
          case(pipeline_stage)
               4'b0000: begin // Stage 0
                    intermediate_result_0 <= loaded_num_a0 * loaded_num_b0;
                    intermediate_result_1 <= loaded_num_a1 * loaded_num_b2;   
                    pipeline_stage <= 4'b0001; 
               end
               4'b0001: begin // Stage 1
                    intermediate_result_2 <= loaded_num_a0 * loaded_num_b1;
                    intermediate_result_3 <= loaded_num_a1 * loaded_num_b3;                    
                    pipeline_stage <= 4'b0010; 
               end
               4'b0010: begin // Stage 2
                    intermediate_result_4 <= loaded_num_a2 * loaded_num_b0;
                    intermediate_result_5 <= loaded_num_a3 * loaded_num_b2;
                    pipeline_stage <= 4'b0011; 
               end
               4'b0011: begin // Stage 3
                    intermediate_result_6 <= loaded_num_a2 * loaded_num_b1;
                    intermediate_result_7 <= loaded_num_a3 * loaded_num_b3;
                    pipeline_stage <= 4'b0100; 
               end
               4'b0100: begin // Stage 4
                    result1 <= intermediate_result_0 + intermediate_result_1;
                    result2 <= intermediate_result_2 + intermediate_result_3;
                    result3 <= intermediate_result_4 + intermediate_result_5;
                    result4 <= intermediate_result_6 + intermediate_result_7;
                    pipeline_stage <= 4'b0101; 
               end
          endcase
     end
end

endmodule
