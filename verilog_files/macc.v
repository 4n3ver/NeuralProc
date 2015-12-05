module macc(a, b, c, o);
	input [15:0] a, b, c;
	output [15:0] o;
	
	assign o = a * b + c;
endmodule