module controller(opcode, imm, input_fifo_empty,
    macc_en, macc_de, work_en, work_de, input_de,
    input_en);
    
    parameter INSTR_I = 2'b00;
    parameter INSTR_M = 2'b01;
    parameter INSTR_A = 2'b10;
    parameter INSTR_F = 2'b11;

    input[1:0] opcode;
    input[15:0] imm;
    input input_fifo_empty;
    output macc_en, macc_de, work_en, work_de, input_de, input_en;
    
    reg macc_en;
    reg macc_de;
    reg work_en;
    reg work_de;
    reg input_de;
    reg input_en;
  
    always @(*) begin
        macc_en = 0;
        macc_de = 0;
        work_en = 0;
        work_de = 0;
        input_de = 0;
        input_en = 0;

        case (opcode)
            INSTR_I: begin
                macc_en = 1;
            end
            INSTR_M: begin
                if (input_fifo_empty) begin
                    work_de = 1;
                end else begin
                    input_de = 1;
                end
                macc_de = 1;
                macc_en = 1;
            end
            INSTR_A: begin
                if (imm != 16'b0) begin
                    work_en = 1;
                end
                macc_de = 1;
            end
        endcase
    end

endmodule