`timescale 1 ns / 1 ps

module loader(
    input wire CLK,
    input wire [7:0] data,
    input wire [1:0] ctrl_logic
);

    parameter Y_DIM = 2;
    parameter X_DIM = 2;

    reg [31:0] matrix_1 [0:3];
    reg [31:0] matrix_2 [0:3];

    reg [3:0] R1;
    reg [3:0] C1;

    reg [3:0] R2;
    reg [3:0] C2;

    reg [7:0] data_out;

    reg testFlop;
    reg readybit;
    reg startbit;

    reg skip;


    DflopX4 data_flop(CLK, data, data_out);
    matrix mult(CLK, matrix_1, matrix_2, R1, C1, R2, C2, readybit, startbit);

    integer count, x, y, testclock;

    initial begin
        count = 0;
        x = 0;
        y = 0;
        readybit = 0;
        testclock = -1;

        skip = 1;
    end

    always @(posedge startbit) begin
        readybit = 0;
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
            count++;
        end else if(ctrl_logic == 0) begin // matrix data
            if(x < C1*R1) begin
                matrix_1[x] = data_out;
                x = x + 1;
            end else if (y < C2*R2) begin 
                
                matrix_2[y] = data_out;
                y = y + 1;
            end

            //$display("ckock: ", testclock, " t/f: ", (x==R1*C1) && (y==R2*C2), " logic: ", ctrl_logic, " xy: ", x,y);
            if ((x==R1*C1) && (y==R2*C2))
                //$display("mult now");
                readybit = 1;
        end else if (ctrl_logic == 2) begin
            
            //$display("here");
            readybit <= 0;
            x <= 0;
            y <= 0;
            count <= 0;
        end
       // end
        skip = 0;
    end

endmodule