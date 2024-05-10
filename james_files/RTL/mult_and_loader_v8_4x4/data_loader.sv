`timescale 1 ns / 1 ps

module data_loader(
    input wire CLK,
    input wire [7:0] data,
    input wire [1:0] ctrl_logic,
    output reg [255:0] res_mat
);
    reg [255:0] matrix_1;
    reg [255:0] matrix_2;

    reg [3:0] R1;
    reg [3:0] C1;

    reg [3:0] R2;
    reg [3:0] C2;

    reg [7:0] data_out;

    wire readybit;

    DflopX4 data_flop(CLK, data, data_out);
    matrix mult(CLK, matrix_1, matrix_2, R1, C1, R2, C2, readybit, res_mat);

    reg [1:0] count;
    reg [7:0] x, y;

    wire [4:0] y_max, x_max;

    initial begin
        count <= 0;
        x = 0;
        y = 0;
    end


    // always @* begin
    //     $display("Row 1: %d %d %d", matrix_1[255:240], matrix_1[239:224], matrix_1[223:208]);
    //     $display("Row 2: %d %d %d", matrix_1[207:192], matrix_1[191:176], matrix_1[175:160]);
    //     $display("Row 3: %d %d %d", matrix_1[159:144], matrix_1[143:128], matrix_1[127:112]);
    // end

    always @(posedge CLK) begin

        //$display( "R-C", R1, " ", C1, " ", R2, " ", C2 );

    // size of matrix
        if (ctrl_logic == 1) begin
            case(count)
                3'h0: R1 <= data_out;
                3'h1: C1 <= data_out;
                3'h2: R2 <= data_out;
                3'h3: C2 <= data_out;
            endcase
            count <= count + 1;
        end else if(ctrl_logic == 0) begin // matrix data

            if(x < x_max) begin
                //$display("x: ", x, "data_out: ", data_out);
                case(x)
                    8'd0: matrix_1[255:240] = data_out;
                    8'd1: matrix_1[239:224] = data_out;
                    8'd2: matrix_1[223:208] = data_out;
                    8'd3: matrix_1[207:192] = data_out;

                    8'd4: matrix_1[191:176] = data_out;
                    8'd5: matrix_1[175:160] = data_out;
                    8'd6: matrix_1[159:144] = data_out;
                    8'd7: matrix_1[143:128] = data_out;
                    8'd8: matrix_1[127:112] = data_out;

                    8'd9:  matrix_1[111:96] = data_out;
                    8'd10: matrix_1[95:80] = data_out;
                    8'd11: matrix_1[79:64] = data_out;
                    8'd12: matrix_1[63:48] = data_out;
                    8'd13: matrix_1[47:32] = data_out;
                    8'd14: matrix_1[31:16] = data_out;
                    8'd15: matrix_1[15:0] = data_out;
                endcase
                //$display("num5: ", matrix_1[143:128]);
                x = x + 1;
            end else if (y < y_max) begin 
                case(y)
                    8'd0: matrix_2[255:240] = data_out;
                    8'd1: matrix_2[239:224] = data_out;
                    8'd2: matrix_2[223:208] = data_out;
                    8'd3: matrix_2[207:192] = data_out;

                    8'd4: matrix_2[191:176] = data_out;
                    8'd5: matrix_2[175:160] = data_out;
                    8'd6: matrix_2[159:144] = data_out;
                    8'd7: matrix_2[143:128] = data_out;
                    8'd8: matrix_2[127:112] = data_out;

                    8'd9:  matrix_2[111:96] = data_out;
                    8'd10: matrix_2[95:80]  = data_out;
                    8'd11: matrix_2[79:64]  = data_out;
                    8'd12: matrix_2[63:48]  = data_out;
                    8'd13: matrix_2[47:32]  = data_out;
                    8'd14: matrix_2[31:16]  = data_out;
                    8'd15: matrix_2[15:0]   = data_out;
                endcase
                y = y + 1;
            end
        end else if (ctrl_logic == 2) begin
            x = 0;
            y = 0;
            count <= 0;
        end
    end

    assign x_max = R1*C1;
    assign y_max = R2*C2;
    assign readybit = (x == x_max && y == y_max) ? 1'b1 : 1'b0;
endmodule

//matrix_4x4[(15-x)*16 +: 16] = data_out;  // Dynamic bit slicing
//x = x + 1;  // Increment x to fill the next element