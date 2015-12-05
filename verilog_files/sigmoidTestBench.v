module sigmoidTestBench; // 16'b543210123456789(10)
	reg [15:0] x;
	wire signed [15:0] y;
	
	sigmoid mod(x, y);
		
	initial begin
		x = 16'b0001000000000001;	// 4.0009765625/1-9
		#5 $display("f(4.0009765625) = %b.%b", y[15:10], y[9:0]);
		$display();
		
		x = 16'b1110111111111111;	// -4.0009765625/0-7
		#5 $display("f(-4.0009765625) = %b.%b",y[15:10], y[9:0]);
		$display();
		
		x = 16'b0001000000000000;	// 4.0/1-9
		#5 $display("f(4.0) = %b.%b", y[15:10], y[9:0]);
		$display();
		
		x = 16'b1111000000000000;	// -4.0/0-7
		#5 $display("f(-4.0) = %b.%b", y[15:10], y[9:0]);
		$display();
		
		x = 16'b0000111111111111;	// 3.9990234375*-8
		#5 $display("f(3.9990234375) = %b.%b", y[15:10], y[9:0]);
		$display();
		
		x = 16'b1111000000000001;	// -3.9990234375*-8
		#5 $display("f(-3.9990234375) = %b.%b", y[15:10], y[9:0]);
		$display();
			  //0000101000000000
		x = 16'b1111011000000000;	// -2.5*-8
		#5 $display("f(-2.5) = %b.%b", y[15:10], y[9:0]);
		$display();			
	end
endmodule	