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

    reg [3:0] data_out;

    reg testFlop;


    DflopX4 data_flop(CLK, data, data_out);

    integer count, x, y;

    initial begin
        count = 0;
        x = 0;
        y = 0;
    end
    
    always @(posedge CLK) begin
        //$display(testFlop , "<=", data[0]);

       // $display("recieved ", data, " Flopped to ", data_out, " logic: ", ctrl_logic);

        // size of matrix
        if (ctrl_logic == 1) begin
            case(count)
                3'h1: R1 <= data_out;
                3'h2: C1 <= data_out;
                3'h3: R2 <= data_out;
                3'h4: C2 <= data_out;
            endcase
            count++;
        end else begin // matrix data
            //$display("data_out: ", data_out, " yx: ", y,x);
            matrix_1[y][x] = data_out;
            //$display("matrix val: ", matrix_1[y][x]);
            x = x + 1;
            if(x >= R1 && y < C1) begin
                x = 0;
                y = y + 1;
            end
        end   
    end

endmodule