module NumberLoader (
    input wire clk,
    input wire [31:0] nums_a,
    input wire [31:0] nums_b,
    output reg [7:0] loaded_num_a0,
    output reg [7:0] loaded_num_a1,
    output reg [7:0] loaded_num_a2,
    output reg [7:0] loaded_num_a3,
    output reg [7:0] loaded_num_b0,
    output reg [7:0] loaded_num_b1,
    output reg [7:0] loaded_num_b2,
    output reg [7:0] loaded_num_b3,
    input wire load
);

    always @(posedge clk) begin
        if (load) begin // load enable control bit
            loaded_num_a0 <= nums_a[31:24];
            loaded_num_a1 <= nums_a[23:16];
            loaded_num_a2 <= nums_a[15:8];
            loaded_num_a3 <= nums_a[7:0];

            loaded_num_b0 <= nums_b[31:24];
            loaded_num_b1 <= nums_b[23:16];
            loaded_num_b2 <= nums_b[15:8];
            loaded_num_b3 <= nums_b[7:0];
        end
    end

endmodule


