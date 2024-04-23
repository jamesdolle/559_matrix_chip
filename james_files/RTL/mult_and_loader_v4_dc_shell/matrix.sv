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
    reg delay;

    always @(posedge CLK) begin

        if(readybit) begin
            #2
            //$display("started: ", $realtime, " ", readybit);

            matrix_1[0][0] = flat_matrix_1[63:48];
            matrix_1[0][1] = flat_matrix_1[47:32];
            matrix_1[1][0] = flat_matrix_1[31:16];
            matrix_1[1][1] = flat_matrix_1[15:0];

            matrix_2[0][0] = flat_matrix_2[63:48];
            matrix_2[0][1] = flat_matrix_2[47:32];
            matrix_2[1][0] = flat_matrix_2[31:16];
            matrix_2[1][1] = flat_matrix_2[15:0];

            // $display("matrix unflattened");
            // $display(matrix_1[0][0], matrix_1[0][1]);
            // $display(matrix_1[1][0], matrix_1[1][1]);
            // $display("matrix unflattened");
            // $display(matrix_2[0][0], matrix_2[0][1]);
            // $display(matrix_2[1][0], matrix_2[1][1]);

            // $display(" ---- Result ----");

            for (i = 0; i < X_DIM; i = i + 1) begin
                for (j = 0; j < Y_DIM; j = j + 1) begin
                    rslt[i][j] = 0;
        
                    for (k = 0; k < X_DIM; k = k + 1) begin
                        rslt[i][j] = rslt[i][j] + matrix_1[i][k] * matrix_2[k][j];
                    end
                  //  $write(rslt[i][j]);
                end
                //$write("\n");
            end

            res_mat[63:48] = rslt[0][0];
            res_mat[47:32] = rslt[0][1];
            res_mat[31:16] = rslt[1][0];
            res_mat[15:0] = rslt[1][1];
        end
    end
endmodule