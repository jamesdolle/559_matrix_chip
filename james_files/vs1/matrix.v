module matrix(
    input wire CLK
);

    parameter X_DIM = 2;
    parameter Y_DIM = 2;

    reg [127:0] matrix_1 [0:Y_DIM][0:X_DIM];
    reg [127:0] matrix_2 [0:Y_DIM][0:X_DIM];
    reg [127:0] rslt [0:Y_DIM][0:X_DIM];



    integer x, y, z;
    integer i, j, k;

    initial begin

        $display(" ---- MATRIX 1 ----");

        for(x = 0; x < Y_DIM; x++) begin
            for(y = 0; y < X_DIM; y++) begin

                matrix_1[x][y] = $random & 8'hFF;
                $write(matrix_1[x][y]);
            end
            $write("\n");
        end

        $display(" ---- MATRIX 2 ----");

        for(x = 0; x < Y_DIM; x++) begin
            for(y = 0; y < X_DIM; y++) begin

                matrix_2[x][y] = $random & 8'hFF;
                
                $write(matrix_2[x][y]);
            end
           $write("\n");
        end

    end

    always @(posedge CLK) begin

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

endmodule