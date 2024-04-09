module matrix(
    input wire CLK,
    input wire data,
    input wire ctrl_logic
);

    parameter Y_DIM = 2;
    parameter X_DIM = 2;

    reg [127:0] matrix_1 [0:Y_DIM][0:X_DIM];
    reg [127:0] matrix_2 [0:Y_DIM][0:X_DIM];

    reg R1;
    reg C1;

    reg R2;
    reg C2;


    integer count, x, y;

    initial begin
        count = 0;
    end

    always @(posedge) begin

        // size of matrix
        if (ctrl_logic == 1) begin
            case(count)
                2'b00: R1 <= data;
                2'b01: C1 <= data;
                2'b10: R2 <= data;
                2'b11: C2 <= data;
            endcase
            count++;
        end else begin // matrix data
            matrix_1[y][x++] = data;
            if(x > R1 && y < C1) begin
                x = 0;
                y = y + 1;
            end else begin
                $finish
            end
        end



        
    end


endmodule