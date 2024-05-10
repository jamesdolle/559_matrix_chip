
// ----------------------
// Only need to change  MAT_XxX and NUM_MAT
// ----------------------

`timescale 1 ns / 1 ps

module advanced_tb();

    parameter MAT_XxX = 4; // x by x size; options, 2, 3, 4
    parameter NUM_MAT = 1; // set num of matrix to mult,

    parameter MAT_SIZE = 4; // dont change

    parameter CYCLE_LEN = (6 +  MAT_XxX*MAT_XxX * 2);

    reg CLK;
    reg [1:0] ctrl_logic;
    reg [7:0] data_send;
    
    reg [7:0] load_data [0:1270];
    reg [1:0] load_logic [0:2550];

    reg [255:0] res_mat;

    wire S0;

    integer data_i, logic_i, count; // matrix indexes
    integer i, j, k;                // for loop ints

    reg testo;

    data_loader loader(CLK, data_send, ctrl_logic, res_mat);

    initial begin
        
        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, advanced_tb);   // Dumps all variables in the module "testbench" and its submodules
        CLK = 0;
        count = 0;
        logic_i = 0;
        data_i  = 0;

        ctrl_logic = 1;
        data_send = 2;

        // load data for NUM_MAT of MAT_SIZE * 2, (*2 for 2 matrix per mult)
        for(i = 0; i < NUM_MAT * MAT_XxX*MAT_XxX * 2; i++ ) begin
            load_data[i] = $random;
        end
        // load ctrl logic,
        for(i = 0; i < NUM_MAT*CYCLE_LEN; i++ ) begin

            load_logic[i] = 2;
            i = i + 1;
                
            for(j = 0; j < 4; j++) begin
                load_logic[i] = 1;
                i = i + 1;
            end
            for(j = 0; j < 2*MAT_XxX*MAT_XxX; j++) begin
                load_logic[i] = 0;
                i = i + 1;
            end
            load_logic[i] = 2;
        end

        // for(i = 0; i < MAT_XxX*MAT_XxX*2; i++)
        //     $display(i,": ", load_data[i]);
        // $display("---------------------------------------------------------");
        //  for(i = 0; i < NUM_MAT*14; i++)
        //      $display(load_logic[i]);

        forever #0.5 CLK = ~CLK;
    end

    //always #5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin

        ctrl_logic <= load_logic[logic_i++];

        if(count <= 3) begin
            data_send <= MAT_XxX;
        end else if((count > 3) && (count <= MAT_XxX*MAT_XxX*2+3)) begin
            data_send <= load_data[data_i];
            data_i = data_i + 1;
        end else if(count > MAT_XxX*MAT_XxX*2+3) begin
            data_send <= 0;
        end
        
        if(count == (CYCLE_LEN-1)) begin
            count = 0;
            #10
            if(MAT_XxX*MAT_XxX == 4) begin
                $display("--- result ---");
                $display(res_mat[63:48]," ", res_mat[47:32]);
                $display(res_mat[31:16]," ", res_mat[15:0]);
            end

            if(MAT_XxX*MAT_XxX == 9) begin
                $display("--- result ---");
                $display("%d %d %d", res_mat[143:128], res_mat[127:112], res_mat[111:96]);
                $display("%d %d %d", res_mat[95:80], res_mat[79:64], res_mat[63:48]);
                $display("%d %d %d", res_mat[47:32], res_mat[31:16], res_mat[15:0]);
            end

            if(MAT_XxX*MAT_XxX == 16) begin
                $display("--- result ---");
                $display("[ %d %d %d %d ]", res_mat[255:240], res_mat[239:224], res_mat[223:208], res_mat[207:192]);
                $display("[ %d %d %d %d ]", res_mat[191:176], res_mat[175:160], res_mat[159:144], res_mat[143:128]);
                $display("[ %d %d %d %d ]", res_mat[127:112], res_mat[111:96], res_mat[95:80], res_mat[79:64]);
                $display("[ %d %d %d %d ]", res_mat[63:48], res_mat[47:32], res_mat[31:16], res_mat[15:0]);
            end

        end else begin
            count = count + 1;
        end

        if(logic_i == CYCLE_LEN*NUM_MAT) begin
            #10
            $finish;
        end 
    end
endmodule