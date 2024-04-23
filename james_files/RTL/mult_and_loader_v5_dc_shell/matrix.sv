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

    parameter X_DIM = 2;
    parameter Y_DIM = 2;

    reg [127:0] matrix_1 [0:Y_DIM][0:X_DIM];
    reg [127:0] matrix_2 [0:Y_DIM][0:X_DIM];
    reg [127:0] rslt [0:Y_DIM][0:X_DIM];

    reg [31:0] x, y, z, i, j, k, index;

    reg [15:0] num0a, num1a, num2a, num3a;
    reg [15:0] num0b, num1b, num2b, num3b;

    reg delay;

    always @(posedge CLK) begin

        if(readybit) begin
            num0a = flat_matrix_1[63:48];
            num1a = flat_matrix_1[47:32];
            num2a = flat_matrix_1[31:16];
            num3a = flat_matrix_1[15:0];

            num0b = flat_matrix_2[63:48];
            num1b = flat_matrix_2[47:32];
            num2b = flat_matrix_2[31:16];
            num3b = flat_matrix_2[15:0];

            res_mat[63:48] = num0a * num0b + num1a * num2b;
            res_mat[47:32] = num0a * num1b + num1a * num3b;
            res_mat[31:16] = num2a * num0b + num3a * num2b;
            res_mat[15:0] = num2a * num1b + num3a * num3b;
        end
    end
endmodule