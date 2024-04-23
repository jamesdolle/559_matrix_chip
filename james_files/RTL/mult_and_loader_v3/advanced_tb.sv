`timescale 1 ns / 1 ps

module data_loader_tb();

    parameter NUM_MAT = 3; // set num of matrix to mult
    parameter MAT_SIZE = 4; // set num of matrix to mult
    parameter MAT_XxX = 2; // x by x size


    reg CLK;
    reg [1:0] ctrl_logic;
    reg [7:0] data_send;
    
    reg [7:0] load_data [0:127];
    reg [1:0] load_logic [0:255];

    wire S0;

    integer data_i, logic_i, count; // matrix indexes
    integer i, j, k;                // for loop ints

    loader loader(CLK, data_send, ctrl_logic);

    initial begin
        

        $dumpfile("waveform.vcd"); // Specifies the name of the dump file
        $dumpvars(0, data_loader_tb);   // Dumps all variables in the module "testbench" and its submodules
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

            if(i != 0)
                load_logic[i++] = 2;
                
            for(j = 0; j < 4; j++)
                load_logic[i++] = 1;
            for(j = 0; j < 2*MAT_SIZE; j++)
                load_logic[i++] = 0;
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

            // $display("size");
            // $display("R1: ", loader.R1, " C1: ", loader.C1);
            // $display("R2: ", loader.R2, " C2: ", loader.C2);

        //$display("logic: ", logic_i);
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
            8'h4: 
                data_send <= load_data[data_i++];
            8'h5: 
                data_send <= load_data[data_i++];
            8'h6: 
                data_send <= load_data[data_i++];
            8'h7: 
                data_send <= load_data[data_i++];
            8'h8: 
                data_send <= load_data[data_i++];
            8'h9:
                data_send <= load_data[data_i++];
            8'hA: 
                data_send <= load_data[data_i++];
            8'hB:
                data_send <= load_data[data_i++];
            8'hC:
                data_send <= 0;
            8'hD:
                data_send <= 0;
        endcase
        
        // || (logic_i == 14 & count == 14)
        if(count == 13) begin
            count = 0;
        end else begin
            count = count + 1;
        end

        if(logic_i == 14*NUM_MAT) begin
            #5
            $finish;
        end 
    end
endmodule



// $display("matrix loaded");
// $display(loader.matrix_1[0], loader.matrix_1[1]);
// $display(loader.matrix_1[2], loader.matrix_1[3]);
// $display("matrix loaded");
// $display(loader.matrix_2[0], loader.matrix_2[1]);
// $display(loader.matrix_2[2], loader.matrix_2[3]);
// $display("size");
// $display("R1: ", loader.R1, " C1: ", loader.C1);
// $display("R2: ", loader.R2, " C2: ", loader.C2);

//    case(count)
//             4'h0: begin
//                 data_send <= MAT_XxX;
//                 ctrl_logic <= ;
//             end
//             4'h1: begin
//                 data_send <= 2;
//                 ctrl_logic <= 1;
//             end
//             4'h2: begin
//                 data_send <= 2;
//                 ctrl_logic <= 1;
//             end
//             4'h3: begin
//                 data_send <= 8;
//                 ctrl_logic <= 1;
//             end
//             4'h4: begin
//                 data_send <= 1;
//                 ctrl_logic <= 0;
//             end
//             4'h5: begin
//                 data_send <= 15;
//                 ctrl_logic <= 0; 
//             end
//             4'h6: begin
//                 data_send <= 2;
//                 ctrl_logic <= 0; 
//             end
//             4'h7: begin
//                 data_send <= 2;
//                 ctrl_logic <= 0;
//             end
//             4'h8: begin
//                 data_send <= 1;
//                 ctrl_logic <= 0;
//             end
//             4'h9: begin
//                 data_send <= 9;
//                 ctrl_logic <= 0;
//             end
//             4'hA: begin
//                 data_send <= 2;
//                 ctrl_logic <= 0;
//             end
//             4'hB: begin
//                 data_send <= x;
//                 ctrl_logic <= 0;
//             end
//             8'hC: begin
//                 data_send <= 2;
//                 ctrl_logic <= 2;
//             end
//             8'hD: begin
//                 data_send <= 2;
//                 ctrl_logic <= 1;
//             end
//         endcase