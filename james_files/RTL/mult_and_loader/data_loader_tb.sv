`timescale 1 ns / 1 ps

module data_loader_tb();

    reg CLK, ctrl_logic;
    reg [3:0] data_send;
    integer count;
    wire S0;

    loader loader(CLK, data_send, ctrl_logic);
    initial begin

        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, data_loader_tb);   // Dumps all variables in the module "testbench" and its submodules
        CLK = 0;
        count = 0;
        data_send = 2;
        ctrl_logic = 1;
        forever #0.5 CLK = ~CLK;
    end

    //always #5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin
        case(count)
            4'h0: begin
                data_send <= 2;
                ctrl_logic <= 1;
            end
            4'h1: begin
                data_send <= 2;
                ctrl_logic <= 1;
            end
            4'h2: begin
                data_send <= 2;
                ctrl_logic <= 1;
            end
            4'h3: begin
                data_send <= 8;
                ctrl_logic <= 1;
            end
            4'h4: begin
                data_send <= 1;
                ctrl_logic <= 0;
            end
            4'h5: begin
                data_send <= 15;
                ctrl_logic <= 0;
            end
            4'h6: begin
                data_send <= 2;
                ctrl_logic <= 0;
            end
            4'h7: begin
                data_send <= 2;
                ctrl_logic <= 0;
            end
            4'h8: begin
                data_send <= 1;
                ctrl_logic <= 0;
            end
            4'h9: begin
                data_send <= 9;
                ctrl_logic <= 0;
            end
            4'hA: begin
                data_send <= 2;
                ctrl_logic <= 0;
            end
            4'hB: begin
                $display("matrix loaded");
                $display(loader.matrix_1[0], loader.matrix_1[1]);
                $display(loader.matrix_1[2], loader.matrix_1[3]);
                $display("matrix loaded");
                $display(loader.matrix_2[0], loader.matrix_2[1]);
                $display(loader.matrix_2[2], loader.matrix_2[3]);
                $display("size");
                $display("R1: ", loader.R1, " C1: ", loader.C1);
                $display("R2: ", loader.R2, " C2: ", loader.C2);
                //$finish;
            end
        endcase
        count++;
    end


endmodule