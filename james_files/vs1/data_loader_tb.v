`timescale 1 ns / 1 ps

module data_loader_tb.v();

    reg CLK, data_send, ctrl_logic;
    integer count;
    wire S0;

    matrix x1(CLK, data_send, ctrl_logic);
    initial begin
        CLK = 0;
        count = 0;
        data_send = 0;
        ctrl_logic = 0;

        
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        case(count)
            4'h0: data_send = 2;
            4'h1: data_send = 2;
            4'h2: data_send = 2;
            4'h3: data_send = 2;
            4'h4: data_send = 1;
            4'h5: data_send = 2;
            4'h6: data_send = 3;
            4'h7: data_send = 4;
        endcase
    end


endmodule