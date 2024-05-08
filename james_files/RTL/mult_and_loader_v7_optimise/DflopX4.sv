`timescale 1 ns / 1 ps

module DflopX4(
    input wire CLK,
    input wire [7:0] a,
    output reg [7:0] x
    );

    always @(posedge CLK) begin
        x <= a;
    end

endmodule