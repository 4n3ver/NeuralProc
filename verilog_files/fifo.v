module fifo(clk, reset, enqueue, dequeue, data_in, data_out, full, empty);
	parameter ADDR_LEN = 5;	// tried for hours, cant get it working w/ 11
	parameter DATA_WIDTH = 32;
	parameter MAX_SIZE = (1 << ADDR_LEN);
	
	input clk, reset, enqueue, dequeue;
	input [DATA_WIDTH - 1:0] data_in;
	
	output [DATA_WIDTH - 1:0] data_out;
	output full, empty;
		
	reg [DATA_WIDTH - 1:0] value[0:MAX_SIZE - 1];
	
	reg [ADDR_LEN - 1:0] head;	// point to next dequeued element
	reg [ADDR_LEN - 1:0] tail;	// point to next enqueued element
	reg [ADDR_LEN:0] size;
	
	assign data_out = (size == 0) 		? 32'd0: value[head];
	assign full 	= (size == MAX_SIZE)? 1'b1 : 1'b0;
	assign empty 	= (size == 0) 		? 1'b1 : 1'b0;
	
	always@(posedge clk) begin
		if (reset) begin
			head <= 1'b0;
			tail <= 1'b0;
			size <= 1'b0;
		end else begin
			if (enqueue && (size < MAX_SIZE)) begin
				value[tail] <= data_in;
				tail <= tail + 1'b1;
				size <= size + 1'b1;
			end
			if (dequeue && (size > 1'b0)) begin 
				value[head][15:0] <= value[head][15:0] - 16'd1;
				if (value[head][15:0] == 16'd1) begin
					head <= head + 1'b1;
					size <= size - 1'b1;
				end
			end
		end		
	end	
endmodule