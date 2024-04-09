`timescale 1 ns / 1 ps

module DflopX4(
    input wire CLK,
    input wire [3:0] a,
    output reg [3:0] x
);

always @(posedge clk) begin
    x <= a;
end

endmodule