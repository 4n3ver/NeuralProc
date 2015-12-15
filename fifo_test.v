module fifo_test();
  parameter NUM_ENTRIES = 256;
  parameter ADDR_LEN = 11;
  parameter ENTRY_WIDTH = 32;
  
  reg clk, reset, enqueue, dequeue;
  reg[ENTRY_WIDTH - 1:0] data_in;
  wire[ENTRY_WIDTH - 1:0] data_out;
  wire full, empty;
  
  fifo f (clk, reset, enqueue, dequeue, data_in, data_out, full, empty);
  
  initial
  begin
    $dumpfile("fifo_test.vcd");
    $dumpvars(0, fifo_test);
  end

  initial begin
    clk = 0;
    reset = 1;
    enqueue = 0;
    dequeue = 0;
    data_in = 16'd0;
    #20
    reset = 0;
    #5 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    
    enqueue = 1;
    data_in = {16'd10, 16'd1};
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    data_in = {16'd11, 16'd1};
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    data_in = {16'd12, 16'd1};
    
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    enqueue = 0;
    dequeue = 1;
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    
    dequeue = 0;
    enqueue = 1;
    data_in = {16'd10, 16'd1};
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    data_in = {16'd11, 16'd4};
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    data_in = {16'd12, 16'd2};
    
    #10 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    dequeue = 1;
    enqueue = 0;

    #300 $display("data: %d lt: %d", data_out[31:16], data_out[15:0]);
    $stop;
  end
  
  always
    #5 clk = ~clk;

endmodule
