module Register(out, in, wren, clk, rst);
	input [31:0] in;
	input wren, clk, rst;
	
	output [31:0] out;
	
	reg [31:0] out;	
	always@(posedge clk) begin
		if (wren) begin
			out <= in;
		end
		if (rst) begin
			out <= 32'd0;
		end
	end 
endmodule