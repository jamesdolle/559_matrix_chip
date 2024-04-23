`timescale 1 ns / 1 ps

module simple_rtl_tb();

    reg a, CLK;
    wire S0;

    matrix x1(CLK);
    initial begin
        CLK = 0;
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    //always @(posedge CLK) begin
    //end


endmodule