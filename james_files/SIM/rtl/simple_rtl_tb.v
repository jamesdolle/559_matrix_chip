`timescale 1 ns / 1 ps

module simple_rtl_tb();

    reg a, CLK;
    wire S0;

    simple_rtl x1(a, CLK, S0);
    initial begin
	$dumpfile("sim.vcd");
	$dumpvars(0, simple_rtl_tb);	

        a = 0;
        CLK = 0;

        #10
        $finish;  //how long to run before stopping   
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        #0.4 a=~a;

        $display("boop register = ", S0, " a ", x1.a);
    end


endmodule
