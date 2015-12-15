module macc_test();
  reg signed[15:0] in0, in1, in_acc;
  wire signed[15:0] out;
  
  macc m(in0, in1, in_acc, out);
  
  initial begin
  
    in0 = 10;
    in1 = 15;
    in_acc = 0;
    #5
	 $display("in0 = %d, in1 = %d, in_acc = %d, out = %d", in0, in1, in_acc, out);
    
    in0 = 70;
    in1 = 8;
    in_acc = 100;
    #5
	 $display("in0 = %d, in1 = %d, in_acc = %d, out = %d", in0, in1, in_acc, out);
    
    in0 = -7;
    in1 = 5;
    in_acc = 1;
	 $display("in0 = %d, in1 = %d, in_acc = %d, out = %d", in0, in1, in_acc, out);
    
    #100
    $stop;
  
  end
endmodule