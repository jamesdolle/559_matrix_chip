`timescale 1 ns / 1 ps

module loader(
    input wire CLK,
    input wire [3:0] data,
    input wire ctrl_logic
);

    parameter Y_DIM = 2;
    parameter X_DIM = 2;

    reg [31:0] matrix_1 [0:4];
    reg [31:0] matrix_2 [0:4];

    reg [3:0] R1;
    reg [3:0] C1;

    reg [3:0] R2;
    reg [3:0] C2;

    reg [3:0] data_out;

    reg testFlop;
    reg readybit;


    DflopX4 data_flop(CLK, data, data_out);
    matrix mult(CLK, matrix_1, matrix_2, R1, C1, R2, C2, readybit);

    integer count, x, y;

    initial begin
        count = 0;
        x = 0;
        y = 0;
        readybit = 0;
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
        if(x < C1*R1) begin
            matrix_1[x] = data_out;
            x = x + 1;
        end else if (y < C2*R2) begin 
            matrix_2[y] = data_out;
            y = y + 1;
        end

        if ((x==R1*C1) && (y==R2*C2))
            readybit = 1;
        end   
    end

endmodule