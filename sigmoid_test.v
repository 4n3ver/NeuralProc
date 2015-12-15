module sigmoid_test();
  reg signed [15:0] x;
  wire signed [15:0] y;
  
  sigmoid sig(x, y);
  
  initial begin
    x = 10;
    #5
	 $display("x = %d, y = %d", x, y);
    
    x = 5;
    #5
	 $display("x = %d, y = %d", x, y);
    
    x = -1;
	 #5
	 $display("x = %d, y = %d", x, y);
	 
	 x = -4;
	 #5
	 $display("x = %d, y = %d", x, y);
	 
	 x = 0;
    #100
	 $display("x = %d, y = %d", x, y);
    $stop;
  
  end
endmodule