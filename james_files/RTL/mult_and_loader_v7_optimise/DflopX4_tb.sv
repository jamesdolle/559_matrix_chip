`timescale 1 ns / 1 ps

module DflopX4_tb();

    reg [7:0] a;
    reg CLK;
    reg [7:0] S0;

    DflopX4 x1(CLK, a, S0);
    initial begin
        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, DflopX4_tb);   // Dumps all variables in the module "testbench" and its submodules
        
        a = 0;
        CLK = 0;

        #10
        $finish;  //how long to run before stopping   
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        #0.4 a=~a;

        $display("register = ", S0, " a ", x1.a);
    end

endmodule