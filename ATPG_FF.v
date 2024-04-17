// flip flop with ATPG test ports 
// Will need to let synth tool know to use this FF instead of standard flipflop

module custom_ff (
    input wire clk,        // Clock input
    input wire d,          // Data input
    output reg q,          // Output
    input wire si,         // Scan in
    input wire se          // Scan enable
);

    // Flip-flop functionality
    always @(posedge clk) begin
        if (se)             // Only update q when scan enable is high
            q <= si;
        else
            q <= d;         // Assign input to output on positive clock edge
    end

endmodule
