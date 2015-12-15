module macc(in0, in1, in_acc, out);
  input signed [15:0] in0, in1, in_acc;
  output signed [15:0] out;
  
  assign out = in0 * in1 + in_acc;
endmodule