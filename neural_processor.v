module neural_processor(
  input clk,
  input reset);

    parameter NUM_ENTRIES = 256;
    parameter ADDR_LEN = 11;
    parameter DATA_WIDTH = 32;

    wire[DATA_WIDTH - 1:0] input_di, input_do, work_di, work_do, macc_di, macc_do, output_di, output_do;
    wire macc_en, macc_de, work_en, work_de, input_de, input_en, output_en, output_de;
    wire input_f, input_e, work_f, work_e, macc_f, macc_e, output_f, output_e;

    wire[15:0] macc_in1, macc_in2, macc_inacc, macc_out;
    wire[15:0] sig_in, sig_out;

    wire[DATA_WIDTH - 1:0] instr;
    wire[9:0] pc_out;
    wire pc_en;

    assign pc_en = instr[31:30] == 2'b11 ? 1'b0 : 1'b1;

    counter pc(clk, reset, pc_en, pc_out);
    inst_memory instr_mem(pc_out, instr);
    
    controller 
        neural_controller(
            .opcode(instr[31:30]), 
            .imm(instr[15:0]),
            .input_fifo_empty(input_e),
            .macc_en(macc_en),
            .macc_de(macc_de),
            .work_en(work_en),
            .work_de(work_de),
            .input_de(input_de),
            .input_en(input_en)
        ); 

    fifo #(8, DATA_WIDTH) 
        input_fifo(
            .clk(clk), 
            .reset(reset), 
            .enqueue(input_en), 
            .dequeue(input_de), 
            .data_in(input_di), 
            .data_out(input_do), 
            .full(input_f), 
            .empty(input_e)
        );

    assign work_di = {sig_out, instr[15:0]};
    fifo #(8, DATA_WIDTH) 
        work_fifo(
            .clk(clk), 
            .reset(reset), 
            .enqueue(work_en), 
            .dequeue(work_de), 
            .data_in(work_di), 
            .data_out(work_do), 
            .full(work_f), 
            .empty(work_e)
        );
        
    wire [15:0] inputMux_wire;
    Mux2to1 #(16)
        input_mux(
            .sel(input_e ? 1'b1 : 1'b0),
            .dInSrc1(input_do[31:16]),
            .dInSrc2(work_do[31:16]),
            
            .dOut(inputMux_wire)
        );
    
    assign macc_in1     = instr[15:0];
    assign macc_in2     = inputMux_wire;
    assign macc_inacc   = macc_do[31:16];
    macc 
        multadd(
            .in0(macc_in1), 
            .in1(macc_in2), 
            .in_acc(macc_inacc), 
            .out(macc_out)
        );
  
    Mux2to1 #(16)
        macc_mux(
            .sel(instr[31:30] == 2'b00 ? 1'b1 : 1'b0),
            .dInSrc1(macc_out),
            .dInSrc2(16'b0),
            
            .dOut(macc_di[31:16])
        );
    
    assign macc_di[15:0] = instr[31:30] == 2'b00 ? instr[15:0] : 16'b1;
    fifo #(7, DATA_WIDTH) 
        macc_fifo(
            .clk(clk), 
            .reset(reset), 
            .enqueue(macc_en), 
            .dequeue(macc_de),
            .data_in(macc_di), 
            .data_out(macc_do), 
            .full(macc_f), 
            .empty(macc_e)
        );

    assign sig_in = macc_do[31:16];       
    sigmoid 
        transfer_function(
            .x(sig_in), 
            .y(sig_out)
        );
    
    assign output_en = instr[31:30] == 2'b10 && instr[15:0] == 16'b0 ? 1'b1 : 1'b0;
    assign output_di = {sig_out, 16'b1};
    fifo #(8, DATA_WIDTH) 
        output_fifo(
            .clk(clk), 
            .reset(reset), 
            .enqueue(output_en), 
            .dequeue(output_de), 
            .data_in(output_di), 
            .data_out(output_do), 
            .full(output_f), 
            .empty(output_e)
        );
    

endmodule
