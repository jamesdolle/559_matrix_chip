`timescale 1 ns / 1 ps

module matrix(
    input CLK,
    input [255:0] flat_matrix_1,
    input [255:0] flat_matrix_2,
    input [3:0] R1,
    input [3:0] C1,
    input [3:0] R2,
    input [3:0] C2,
    input readybit,
    output reg [255:0] res_mat
);

    //parameter X_DIM = 2;
    //parameter Y_DIM = 2;
    //reg [31:0] x, y, z, i, j, k, index;

    wire [15:0] num0a, num1a, num2a, num3a, num4a, num5a, num6a, num7a, num8a, num9a, num10a, num11a, num12a, num13a, num14a, num15a;
    wire [15:0] num0b, num1b, num2b, num3b, num4b, num5b, num6b, num7b, num8b, num9b, num10b, num11b, num12b, num13b, num14b, num15b;

    wire [7:0] size;

    reg delay;

    // always @(readybit) begin
    //     $display("--- mult matrix ---");
    //     $display("[ %d %d %d ", num0a, num1a, num2a);
    //     $display(" %d %d %d ", num3a, num4a, num5a);
    //     $display(" %d %d %d ]", num6a, num7a, num8a);

    //     $display("--- mult matrix ---");
    //     $display("[ %d %d %d ", num0b, num1b, num2b);
    //     $display(" %d %d %d ", num3b, num4b, num5b);
    //     $display(" %d %d %d ]", num6b, num7b, num8b);
    // end

    always @(readybit) begin

        if(size == 4) begin
            //$display("size: ", R1," " ,C1);
            //$display("---------------------------------------------------------------");
            res_mat[63:48] <= num0a * num0b + num1a * num2b;
            res_mat[47:32] <= num0a * num1b + num1a * num3b;
            res_mat[31:16] <= num2a * num0b + num3a * num2b;
            res_mat[15:0]  <= num2a * num1b + num3a * num3b;
        end

        if(size == 9) begin
            //$display("size: ", R1," " ,C1);
            //$display("---------------------------------------------------------------");
            res_mat[143:128] <= num0a * num0b + num1a * num3b + num2a * num6b; // Row 1, Column 1
            res_mat[127:112] <= num0a * num1b + num1a * num4b + num2a * num7b; // Row 1, Column 2
            res_mat[111:96]  <= num0a * num2b + num1a * num5b + num2a * num8b; // Row 1, Column 3

            res_mat[95:80]   <= num3a * num0b + num4a * num3b + num5a * num6b; // Row 2, Column 1
            res_mat[79:64]   <= num3a * num1b + num4a * num4b + num5a * num7b; // Row 2, Column 2
            res_mat[63:48]   <= num3a * num2b + num4a * num5b + num5a * num8b; // Row 2, Column 3

            res_mat[47:32]   <= num6a * num0b + num7a * num3b + num8a * num6b; // Row 3, Column 1
            res_mat[31:16]   <= num6a * num1b + num7a * num4b + num8a * num7b; // Row 3, Column 2
            res_mat[15:0]    <= num6a * num2b + num7a * num5b + num8a * num8b; // Row 3, Column 3

        end

        if(size == 16) begin
            res_mat[255:240] <= num0a * num0b + num1a * num4b + num2a * num8b + num3a * num12b;
            res_mat[239:224] <= num0a * num1b + num1a * num5b + num2a * num9b + num3a * num13b;
            res_mat[223:208] <= num0a * num2b + num1a * num6b + num2a * num10b + num3a * num14b;
            res_mat[207:192] <= num0a * num3b + num1a * num7b + num2a * num11b + num3a * num15b;

            res_mat[191:176] <= num4a * num0b + num5a * num4b + num6a * num8b + num7a * num12b;
            res_mat[175:160] <= num4a * num1b + num5a * num5b + num6a * num9b + num7a * num13b;
            res_mat[159:144] <= num4a * num2b + num5a * num6b + num6a * num10b + num7a * num14b;
            res_mat[143:128] <= num4a * num3b + num5a * num7b + num6a * num11b + num7a * num15b;

            res_mat[127:112] <= num8a * num0b + num9a * num4b + num10a * num8b + num11a * num12b;
            res_mat[111:96]  <= num8a * num1b + num9a * num5b + num10a * num9b + num11a * num13b;
            res_mat[95:80]   <= num8a * num2b + num9a * num6b + num10a * num10b + num11a * num14b;
            res_mat[79:64]   <= num8a * num3b + num9a * num7b + num10a * num11b + num11a * num15b;

            res_mat[63:48]   <= num12a * num0b + num13a * num4b + num14a * num8b + num15a * num12b;
            res_mat[47:32]   <= num12a * num1b + num13a * num5b + num14a * num9b + num15a * num13b;
            res_mat[31:16]   <= num12a * num2b + num13a * num6b + num14a * num10b + num15a * num14b;
            res_mat[15:0]    <= num12a * num3b + num13a * num7b + num14a * num11b + num15a * num15b;
        end
    end

    assign num0a = flat_matrix_1[255:240];
    assign num1a = flat_matrix_1[239:224];
    assign num2a = flat_matrix_1[223:208];
    assign num3a = flat_matrix_1[207:192];

    assign num4a = flat_matrix_1[191:176];
    assign num5a = flat_matrix_1[175:160];
    assign num6a = flat_matrix_1[159:144];
    assign num7a = flat_matrix_1[143:128];
    assign num8a = flat_matrix_1[127:112];
    assign num9a = flat_matrix_1[111:96];

    assign num10a = flat_matrix_1[95:80];
    assign num11a = flat_matrix_1[79:64];
    assign num12a = flat_matrix_1[63:48];
    assign num13a = flat_matrix_1[47:32];
    assign num14a = flat_matrix_1[31:16];
    assign num15a = flat_matrix_1[15:0];


    assign num0b = flat_matrix_2[255:240];
    assign num1b = flat_matrix_2[239:224];
    assign num2b = flat_matrix_2[223:208];
    assign num3b = flat_matrix_2[207:192];
    assign num4b = flat_matrix_2[191:176];
    assign num5b = flat_matrix_2[175:160];
    assign num6b = flat_matrix_2[159:144];
    assign num7b = flat_matrix_2[143:128];
    assign num8b = flat_matrix_2[127:112];
    assign num9b = flat_matrix_2[111:96];
    assign num10b = flat_matrix_2[95:80];
    assign num11b = flat_matrix_2[79:64];
    assign num12b = flat_matrix_2[63:48];
    assign num13b = flat_matrix_2[47:32];
    assign num14b = flat_matrix_2[31:16];
    assign num15b = flat_matrix_2[15:0];

    assign size = R1*C1;

endmodule