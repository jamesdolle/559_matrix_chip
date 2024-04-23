`timescale 1 ns / 1 ps

module data_loader(
    input wire CLK,
    input wire [7:0] data,
    input wire [1:0] ctrl_logic,
    output reg [63:0] res_mat
);

    parameter Y_DIM = 2;
    parameter X_DIM = 2;

    reg [63:0] matrix_1;
    reg [63:0] matrix_2;

    reg [3:0] R1;
    reg [3:0] C1;

    reg [3:0] R2;
    reg [3:0] C2;

    reg [7:0] data_out;

    reg testFlop;
    reg readybit;

    reg skip;


    DflopX4 data_flop(CLK, data, data_out);
    matrix mult(CLK, matrix_1, matrix_2, R1, C1, R2, C2, readybit, res_mat);

    integer count, testclock;

    integer xS, x, yS, y;


    initial begin
        count <= 0;
        xS = 63;
        x = 0;
        yS = 63;
        y = 0;
        readybit <= 0;
        testclock = -1;

        skip = 1;
    end

    always @(posedge CLK) begin
       // if(skip != 1) begin
    //$display("data: ", data_out, " logic: ", ctrl_logic);

    // size of matrix
        if (ctrl_logic == 1) begin
            //$display("count: ",count, " data: ", data_out);
            case(count)
                3'h1: R1 <= data_out;
                3'h2: C1 <= data_out;
                3'h3: R2 <= data_out;
                3'h4: C2 <= data_out;
            endcase
            count <= count + 1;;
        end else if(ctrl_logic == 0) begin // matrix data
            if(x < C1*R1) begin
                case(x)
                    8'd0:
                        matrix_1[63:48] = data_out;
                    8'd1:
                        matrix_1[47:32] = data_out;
                    8'd2:
                        matrix_1[31:16] = data_out;
                    8'd3:
                        matrix_1[15:0] = data_out;
                endcase
                x = x + 1;
            end else if (y < C2*R2) begin 

                case(y)
                    8'd0:
                        matrix_2[63:48] = data_out;
                    8'd1:
                        matrix_2[47:32] = data_out;
                    8'd2:
                        matrix_2[31:16] = data_out;
                    8'd3:
                        matrix_2[15:0] = data_out;
                endcase
                y = y + 1;  
            end

            //$display("ckock: ", testclock, " t/f: ", (x==R1*C1) && (y==R2*C2), " logic: ", ctrl_logic, " xy: ", x,y);
            if ((x==R1*C1) && (y==R2*C2))
                //$display("mult now");
                readybit <= 1;
        end else if (ctrl_logic == 2) begin
            
            //$display("here");
            readybit <= 0;
            x = 0;
            y = 0;
            count <= 0;
        end
        skip = 0;
    end

endmodule