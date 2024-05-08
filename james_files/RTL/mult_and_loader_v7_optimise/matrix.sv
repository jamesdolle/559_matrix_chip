`timescale 1 ns / 1 ps

module matrix(
    input CLK,
    input [63:0] flat_matrix_1,
    input [63:0] flat_matrix_2,
    input [3:0] R1,
    input [3:0] C1,
    input [3:0] R2,
    input [3:0] C2,
    input readybit,
    output reg [63:0] res_mat
);

    //parameter X_DIM = 2;
    //parameter Y_DIM = 2;
    //reg [31:0] x, y, z, i, j, k, index;

    wire [15:0] num0a, num1a, num2a, num3a;
    wire [15:0] num0b, num1b, num2b, num3b;

    reg delay;

    always @(readybit) begin
        res_mat[63:48] = num0a * num0b + num1a * num2b;
        res_mat[47:32] = num0a * num1b + num1a * num3b;
        res_mat[31:16] = num2a * num0b + num3a * num2b;
        res_mat[15:0]  = num2a * num1b + num3a * num3b;
    end

    assign num0a = flat_matrix_1[63:48];
    assign num1a = flat_matrix_1[47:32];
    assign num2a = flat_matrix_1[31:16];
    assign num3a = flat_matrix_1[15:0];

    assign num0b = flat_matrix_2[63:48];
    assign num1b = flat_matrix_2[47:32];
    assign num2b = flat_matrix_2[31:16];
    assign num3b = flat_matrix_2[15:0];

endmodule