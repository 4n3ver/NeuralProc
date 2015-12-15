module testbench1();
  reg clk, reset;
  integer i, counter;

  always #10 clk = ~clk;

  neural_processor neural_proc(
      .clk    (clk),
      .reset  (reset)
  );

  initial begin
      // Initialize instructions
      for(i=0; i < 1024; i=i+1) begin
          neural_proc.instr_mem.data_array[i] = 32'b0;
      end

      // Initialize input fifo
      for(i=0; i < 1024; i=i+1) begin
          neural_proc.input_fifo.data_array[i] = 32'b0;
      end

      neural_proc.instr_mem.data_array[6] = 32'h00000001; // i 1
      neural_proc.instr_mem.data_array[5] = 32'h40000005; // m 5
      neural_proc.instr_mem.data_array[4] = 32'h80000001; // a 1
      neural_proc.instr_mem.data_array[3] = 32'h00000001; // i 1
      neural_proc.instr_mem.data_array[2] = 32'h40000001; // m 1
      neural_proc.instr_mem.data_array[1] = 32'h80000000; // a 0
      neural_proc.instr_mem.data_array[0] = 32'hc0000000; // f

      // initialize pc to last instr
      neural_proc.pc.start = 6;
      
      counter = 0;
      clk = 0;
      reset = 1;
      $display("time\t clk  reset");
      $monitor("%g\t   %b    %b", $time, clk, reset);
      #20
      reset = 0;
      
      neural_proc.input_fifo.data_array[0] = 32'hfffe0001; // -2 with lifetime 1
      neural_proc.input_fifo.tail = 1; // manually set tail to 1
      neural_proc.input_fifo.head = 0;
  end

    always@(posedge clk) begin
        $display("macc_en: %d, macc_de: %d, work_en: %d, work_de: %d, input_en: %d, input_de: %d",
                    neural_proc.neural_controller.macc_en, neural_proc.neural_controller.macc_de,
                    neural_proc.neural_controller.work_en, neural_proc.neural_controller.work_de,
                    neural_proc.neural_controller.input_en, neural_proc.neural_controller.input_de
                );
        $display("opcode: %b", neural_proc.neural_controller.opcode);
        $display("input_mux: %d", neural_proc.input_mux.dOut);
        $display("macc %d * %d + %d = %d", neural_proc.multadd.in0, neural_proc.multadd.in1, neural_proc.multadd.in_acc, neural_proc.multadd.out);
        $display("macc_fifo_dIn: %d lt: %d", neural_proc.macc_fifo.data_in[31:16], neural_proc.macc_fifo.data_in[15:0]);
        $display("work_fifo_dIn: %d lt: %d", neural_proc.work_fifo.data_in[31:16], neural_proc.work_fifo.data_in[15:0]);

        $display("cycle = %d", counter);

        // print PC
        $display("PC = %d", neural_proc.pc_out);
        $display("instr = %h", neural_proc.instr_mem.data_array[neural_proc.pc_out]);

        $display("input_fifo head = %d, lt = %d, empty = %d, full = %d", 
            neural_proc.input_fifo.data_out[31:16], 
            neural_proc.input_fifo.data_out[15:0], 
            neural_proc.input_fifo.empty, 
            neural_proc.input_fifo.full
        );
        $display("macc_fifo head = %d, lt = %d, empty = %d, full = %d", 
            neural_proc.macc_fifo.data_out[31:16], 
            neural_proc.macc_fifo.data_out[15:0], 
            neural_proc.macc_fifo.empty, 
            neural_proc.macc_fifo.full
        );
        $display("work_fifo head = %d, lt = %d, empty = %d, full = %d", 
            neural_proc.work_fifo.data_out[31:16], 
            neural_proc.work_fifo.data_out[15:0], 
            neural_proc.work_fifo.empty, 
            neural_proc.work_fifo.full
        );
        $display("output_fifo head = %d, lt = %d, empty = %d, full = %d", 
            neural_proc.output_fifo.data_out[31:16], 
            neural_proc.output_fifo.data_out[15:0],
            neural_proc.output_fifo.empty,
            neural_proc.output_fifo.full
        );
        $display("\n");

        counter = counter + 1;

        if (counter == 8)
        $stop;
    end
endmodule
