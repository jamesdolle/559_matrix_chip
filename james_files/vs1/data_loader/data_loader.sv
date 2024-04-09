`timescale 1 ns / 1 ps

module matrix(
    input wire CLK,
    input wire [3:0] data,
    input wire ctrl_logic
);

    parameter Y_DIM = 2;
    parameter X_DIM = 2;

    reg [31:0] matrix_1 [0:Y_DIM][0:X_DIM];
    reg [31:0] matrix_2 [0:Y_DIM][0:X_DIM];

    reg [3:0] R1;
    reg [3:0] C1;

    reg [3:0] R2;
    reg [3:0] C2;


    integer count, x, y;

    initial begin
        count = 0;
        x = 0;
        y = 0;
    end

    always @(posedge CLK) begin
        //$display("Recieved a ", data);
        #0.001

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
            $display("data ", data, " ", y,x);
            matrix_1[y][x] <= data;
            //$display(matrix_1[y][x], " ", data);
            x = x + 1;
            if(x >= R1 && y < C1) begin
                x = 0;
                y = y + 1;
                //$display("change x/y");
            end else begin
                //$display("R1 = ", R1, " C1 = ", C1);
            end
        end   
    end

endmodule