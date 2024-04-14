module matrix(
    input wire CLK,
    input reg [31:0] flat_matrix_1 [0:7],
    input reg [31:0] flat_matrix_2 [0:7],
    input reg [3:0] R1,
    input reg [3:0] C1,
    input reg [3:0] R2,
    input reg [3:0] C2,
    input wire readybit
);

    parameter X_DIM = 2;
    parameter Y_DIM = 2;

    reg [127:0] matrix_1 [0:Y_DIM][0:X_DIM];
    reg [127:0] matrix_2 [0:Y_DIM][0:X_DIM];
    reg [127:0] rslt [0:Y_DIM][0:X_DIM];

    integer x, y, z;
    integer i, j, k;
    integer index;

    always @(posedge CLK) begin

        if(readybit) begin
            index = 0;
            for(i = 0; i < R1; i++) begin
                for(j = 0; j < C1; j++) begin
                    matrix_1[i][j] = flat_matrix_1[index++];
                end
            end

            index = 0;
            for(i = 0; i < R2; i++) begin
                for(j = 0; j < C2; j++) begin
                    matrix_2[i][j] = flat_matrix_2[index++];
                end
            end

            $display("matrix unflattened");
            $display(matrix_1[0][0], matrix_1[0][1]);
            $display(matrix_1[1][0], matrix_1[1][1]);
            $display("matrix unflattened");
            $display(matrix_2[0][0], matrix_2[0][1]);
            $display(matrix_2[1][0], matrix_2[1][1]);

            $display(" ---- Result ----");

            for (int i = 0; i < X_DIM; i++) begin
                for (int j = 0; j < Y_DIM; j++) begin
                    rslt[i][j] = 0;
        
                    for (int k = 0; k < X_DIM; k++) begin
                        rslt[i][j] += matrix_1[i][k] * matrix_2[k][j];
                    end
        
                    $write(rslt[i][j]);
                end
                $write("\n");
            end
                $finish;  //how long to run before stopping   
        end
    end

endmodule