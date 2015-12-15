module fifo(
  clk,
  reset,
  enqueue,
  dequeue,
  data_in,
  data_out,
  full,
  empty
);
    parameter ADDR_LEN = 8;
    parameter DATA_WIDTH = 32;

    input clk, reset, enqueue, dequeue;
    input[DATA_WIDTH - 1:0] data_in;
    output[DATA_WIDTH - 1:0] data_out;
    output full, empty;

    reg[ADDR_LEN - 1:0] head;
    reg[ADDR_LEN - 1:0] tail;

    reg[DATA_WIDTH - 1:0] data_array[0:(1 << ADDR_LEN) - 1];
	
	assign data_out = data_array[head];
	assign full 	= (head == tail && data_array[tail][15:0] != 0) ? 1'b1 : 1'b0;
	assign empty 	= (head == tail && data_array[head][15:0] == 0) ? 1'b1 : 1'b0;
	
    integer i;
    
	always@(posedge clk) begin
		if (reset) begin
			head <= 1'b0;
			tail <= 1'b0;
            for (i = 0; i < (1 << ADDR_LEN); i = i + 1)
                data_array[i] = 0;
		end else begin
            if (enqueue && dequeue && (empty || full)) begin
                if (empty) begin
                    if (data_in[15:0] == 16'b1) begin
                        data_array[tail][31:16] = data_in[31:16];
                    end else if (data_in[15:0] > 16'b1) begin
                        data_array[tail][31:16] = data_in[31:16];
                        data_array[tail][15:0] = data_in[15:0] - 16'b1;
                        tail <= tail + 1'b1;
                    end
                end else if (full) begin
                    data_array[head][15:0] = data_array[head][15:0] - 16'd1;
                    if (data_array[head][15:0] < 1) begin
                        data_array[tail] <= data_in;
                        head <= head + 1'b1;
                        if (data_in > 0) begin
                            tail <= tail + 1'b1;
                        end
                    end
                end
            end else begin
                if (enqueue && ~full) begin
                    data_array[tail] <= data_in;
                    if (data_in > 0) begin
                        tail <= tail + 1'b1;
                    end
                end
                if (dequeue && ~empty) begin 
                    data_array[head][15:0] = data_array[head][15:0] - 16'd1;
                    if (data_array[head][15:0] < 16'd1) begin
                        head <= head + 1'b1;
                    end
                end
            end
		end		
	end	

endmodule
