module testbench2();
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

		neural_proc.instr_mem.data_array[13]= 32'h00000002; // i 2
		neural_proc.instr_mem.data_array[12]= 32'h40000003; // m 3
		neural_proc.instr_mem.data_array[11]= 32'h40000005; // m 5
		neural_proc.instr_mem.data_array[10]= 32'h40000007; // m 7
		neural_proc.instr_mem.data_array[9] = 32'h40000009; // m 9
		neural_proc.instr_mem.data_array[8] = 32'h4000000B; // m 11
		neural_proc.instr_mem.data_array[7] = 32'h4000000D; // m 13
		neural_proc.instr_mem.data_array[6] = 32'h80000001; // a 1
		neural_proc.instr_mem.data_array[5] = 32'h80000001; // a 1
		neural_proc.instr_mem.data_array[4] = 32'h00000001; // i 1
		neural_proc.instr_mem.data_array[3] = 32'h4000000F; // m 15
		neural_proc.instr_mem.data_array[2] = 32'h40000001; // m 1
		neural_proc.instr_mem.data_array[1] = 32'h80000000; // a 0
		neural_proc.instr_mem.data_array[0] = 32'hc0000000; // f

      // initialize pc to last instr
      neural_proc.pc.start = 13;

      counter = 0;
      clk = 0;
      reset = 1;
      $display("time\t clk  reset");
      $monitor("%g\t   %b    %b", $time, clk, reset);
      #20
      reset = 0;

      neural_proc.input_fifo.data_array[0] = 32'h00040002; // 4 with lifetime 2
	  neural_proc.input_fifo.data_array[1] = 32'h00040002; // 4 with lifetime 2
	  neural_proc.input_fifo.data_array[2] = 32'h00050002; // 5 with lifetiem 2
      neural_proc.input_fifo.tail = 3; // set tail to 3 manually
      neural_proc.input_fifo.head = 0;
  end

  always@(posedge clk) begin
        $display("cycle = %d", counter);

        // print PC
        $display("opcode: %b", neural_proc.neural_controller.opcode);
        $display("PC = %d", neural_proc.pc_out);
        $display("instr = %h", neural_proc.instr_mem.data_array[neural_proc.pc_out]);
        $display("macc %d * %d + %d = %d", neural_proc.multadd.in0, neural_proc.multadd.in1, neural_proc.multadd.in_acc, neural_proc.multadd.out);
        $display("sigmoid(%d)=%d", neural_proc.transfer_function.x, neural_proc.transfer_function.y);
      
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
        );$display("\n");

      counter = counter + 1;

      if (counter == 15)
        $stop;
  end
endmodule
