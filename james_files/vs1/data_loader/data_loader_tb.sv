`timescale 1 ns / 1 ps

module data_loader_tb();

    reg CLK, ctrl_logic;
    reg [3:0] data_send;
    integer count;
    wire S0;

    matrix x1(CLK, data_send, ctrl_logic);
    initial begin

        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, data_loader_tb);   // Dumps all variables in the module "testbench" and its submodules
        //$dumpvars(1, data_loader_tb.x1); // For a specific submodule
        //$dumpvars(0, matrix);   // Dumps all variables in the module "testbench" and its submodules
        CLK = 0;
        count = 0;
        data_send = 0;
        ctrl_logic = 0;

        
    end

    always #0.5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        case(count)
            4'h0: begin
                data_send = 2;
                ctrl_logic = 1;
            end
            4'h1: begin
                data_send = 3;
                ctrl_logic = 1;
            end
            4'h2: begin
                data_send = 2;
                ctrl_logic = 1;
            end
            4'h3: begin
                data_send = 1;
                ctrl_logic = 1;
            end
            4'h4: begin
                data_send = 0;
                ctrl_logic = 0;
            end
            4'h5: begin
                data_send = 9;
                ctrl_logic = 0;
            end
            4'h6: begin
                data_send = 7;
                ctrl_logic = 0;
            end
            4'h7: begin
                data_send = 4;
                ctrl_logic = 0;
            end
            4'h8: begin

                $display("matrix loaded");
                $display(x1.matrix_1[0][0], x1.matrix_1[0][1]);
                $display(x1.matrix_1[1][0], x1.matrix_1[1][1],);
                $display("size");
                $display("R1: ", x1.R1, " C1: ", x1.C1);
                $display("R2: ", x1.R2, " C2: ", x1.C2);
                $finish;

            end
        endcase
        count++;
    end


endmodule