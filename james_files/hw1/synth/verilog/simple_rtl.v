module simple_rtl(
    input wire a, 
    input wire clk,
    output reg S0
    );

    always @(posedge clk) begin
        S0 <= a;
    end

endmodule
