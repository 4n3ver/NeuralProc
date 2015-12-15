module counter(clk, reset, en, pc_out);
  input clk, reset, en;
  reg[0:9] pc = 0;
  reg[0:9] start = 0;
  output[0:9] pc_out;
  
  always @(posedge clk) begin
    if (reset)
      pc <= start;
    else if (en)
      pc <= pc - 10'b1;
  end
  
  assign pc_out = pc;
endmodule