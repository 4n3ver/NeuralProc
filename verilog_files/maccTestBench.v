module maccTestBench;
	reg [15:0] a, b, c;
	wire [15:0] o;
	
	reg [31:0] i;
	reg [31:0] temp;
	
	macc mod(a, b, c, o);
		
	initial begin
		a = 0;
		b = 0;
		c = 0;
		i = 0;

		for (i = 0; i < 32'd10; i = i + 1) begin
			temp = $random;
			a = temp[7:0];
			b = temp[15:8];
			c = temp[31:16];
			#5 $display("%d * %d + %d = %d", a, b, c, o);
		end
	end
endmodule	