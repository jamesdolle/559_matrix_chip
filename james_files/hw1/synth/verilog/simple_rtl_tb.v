`timescale 1 ns / 1 ps

module simple_rtl_tb;

    reg a, CLK;

    simple_rtl x1(a, CLK);
    initial begin
        a = 0;
        CLK = 0;

        #10
        $finish;  //how long to run before stopping   
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        #0.4 a=~a;

        $display("register = ", x1.S0, " a ", x1.a);
    end


endmodule
