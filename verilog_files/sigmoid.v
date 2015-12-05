module sigmoid(x, y);
	parameter 	intLen 		= 6,
			floatLen 	= 10;

	parameter [15:0] 	hi	= 16'b0001000000000000,	// 4.0
				low 	= 16'b1111000000000000, // -4.0
				m	= 16'b0000000010000000,	// 0.125, 2^-3
				c	= 16'b0000001000000000;	// 0.5  , 2^-1
				
	input  [15:0] x;
	output [15:0] y;
	
	wire signed [15:0]	signX,
				signHi,
				signLo,
				signM,
				signC,
				zero;
						
	assign signX 	= x;
	assign signHi 	= hi;
	assign signLo 	= low;
	assign signM 	= m;
	assign signC 	= c;
	assign zero	= 0;
	
	reg [15:0] y;
	always@(*) begin
		if (signX - signHi >= zero) begin	//4.1
			y = 16'b0000010000000000;	// 1.0
		end else if (signX - signLo <= zero) begin 	//-4.1
			y = 16'b0;
		end else begin
			y = (signX >>> 3) + signC;
		end
	end
endmodule
