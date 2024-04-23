`timescale 1 ns / 1 ps

module advanced_tb();

    parameter NUM_MAT = 3; // set num of matrix to mult
    parameter MAT_SIZE = 4; // set num of matrix to mult
    parameter MAT_XxX = 2; // x by x size

    reg CLK;
    reg [1:0] ctrl_logic;
    reg [7:0] data_send;
    
    reg [7:0] load_data [0:127];
    reg [1:0] load_logic [0:255];

    reg [63:0] res_mat;

    wire S0;

    integer data_i, logic_i, count; // matrix indexes
    integer i, j, k;                // for loop ints

    reg testo;

    data_loader loader(CLK, data_send, ctrl_logic, res_mat);

    initial begin
        

        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, advanced_tb);   // Dumps all variables in the module "testbench" and its submodules
        CLK = 0;
        count = 1;
        logic_i = 0;
        data_i  = 0;

        ctrl_logic = 1;
        data_send = 2;

        // load data for NUM_MAT of MAT_SIZE * 2, (*2 for 2 matrix per mult)
        for(i = 0; i < NUM_MAT * MAT_SIZE * 2; i++ ) begin
            load_data[i] = $random;
        end

        // load ctrl logic,
        for(i = 0; i < NUM_MAT*14; i++ ) begin

            if(i != 0) begin
                load_logic[i] = 2;
                i = i + 1;
            end
                
            for(j = 0; j < 4; j++) begin
                load_logic[i] = 1;
                i = i + 1;
            end
            for(j = 0; j < 2*MAT_SIZE; j++) begin
                load_logic[i] = 0;
                i = i + 1;
            end
            load_logic[i] = 2;
        end

        // for(i = 0; i < NUM_MAT*8; i++)
        //     $display(load_data[i]);
        // $display("---------------------------------------------------------");
        //  for(i = 0; i < NUM_MAT*14; i++)
        //      $display(load_logic[i]);

        forever #0.5 CLK = ~CLK;
    end

    //always #5 CLK=~CLK; //clock toggle every 0.5 ns

    always @(posedge CLK) begin

        ctrl_logic <= load_logic[logic_i++];
        case(count)
            8'h0:
                data_send <= MAT_XxX;
            8'h1:
                data_send <= MAT_XxX;
            8'h2:
                data_send <= MAT_XxX;
            8'h3: 
                data_send <= MAT_XxX;
            8'h4: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'h5: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'h6: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'h7: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'h8: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'h9: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'hA: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'hB: begin
                data_send <= load_data[data_i];
                data_i = data_i + 1;
            end
            8'hC:
                data_send <= 0;
            8'hD:
                data_send <= 0;
        endcase
        
        // || (logic_i == 14 & count == 14)
        if(count == 13) begin
            count = 0;
            #5

            // rslt_tb[0][0] = loader.mult.rslt[0][0];
            // rslt_tb[0][1] = loader.mult.rslt[0][1];
            // rslt_tb[1][0] = loader.mult.rslt[1][0];
            // rslt_tb[1][1] = loader.mult.rslt[1][1];
            
            // $display("--- result ---");
            // $display(rslt_tb[0][0]," ", rslt_tb[0][1]);
            // $display(rslt_tb[1][0]," ", rslt_tb[1][1]);

            $display("--- result ---");
            $display(res_mat[63:48]," ", res_mat[47:32]);
            $display(res_mat[31:16]," ", res_mat[15:0]);
        end else begin
            count = count + 1;
        end

        if(logic_i == 14*NUM_MAT) begin
            #10
            $finish;
        end 
    end
endmodule