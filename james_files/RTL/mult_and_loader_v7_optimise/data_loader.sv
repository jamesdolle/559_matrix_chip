`timescale 1 ns / 1 ps

module data_loader(
    input wire CLK,
    input wire [7:0] data,
    input wire [1:0] ctrl_logic,
    output reg [63:0] res_mat
);
    reg [63:0] matrix_1;
    reg [63:0] matrix_2;

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

    wire [3:0] y_max, x_max;

    initial begin
        count <= 0;
        x = 0;
        y = 0;
    end
    // always @(R1 or C1 or R2 or C2) begin
    //     //count <= count + 1;
    // end

    always @(posedge CLK) begin

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
                case(x)
                    8'd0: matrix_1[63:48] = data_out;
                    8'd1: matrix_1[47:32] = data_out;
                    8'd2: matrix_1[31:16] = data_out;
                    8'd3: matrix_1[15:0] = data_out;
                endcase
                //matrix_1[(15-x)*16 +: 16] = data_out;
                x = x + 1;
            end else if (y < y_max) begin 
                case(y)
                    8'd0: matrix_2[63:48] = data_out;
                    8'd1: matrix_2[47:32] = data_out;
                    8'd2: matrix_2[31:16] = data_out;
                    8'd3: matrix_2[15:0] = data_out;
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