module fifoTestBench;
	reg clk, rst, enq, deq;
	wire full, empty;
	reg [15:0] val_in, life_in;
	wire [15:0] val_out, life_out;
	
	fifo #(.ADDR_LEN(2)) q(clk, rst, enq, deq, {val_in, life_in}, 
							{val_out, life_out}, full, empty);
		
	initial begin
		clk = 0;
		rst = 1;
		enq = 0;
		deq = 0;
		
		$display("---begin test---");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d empty:%d val_out:%d life_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;
		rst = 0;
		enq = 1;
		deq = 0;
		val_in = 42;
		life_in = 3;
		$display("ENQUEUE: 42, 3");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 1;
		deq = 0;
		val_in = 27;
		life_in = 1;
		$display("ENQUEUE: 27, 1");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 42, 2");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 1;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("ENQUEUE: 3, 4 DEQUEUE: 42, 1");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 42, 0");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 1;
		deq = 0;
		val_in = 667;
		life_in = 1;
		$display("ENQUEUE: 667, 1");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 1;
		deq = 0;
		val_in = 26;
		life_in = 1;
		$display("ENQUEUE: 26, 1");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
				
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 27, 0");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 3, 3");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 3, 2");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 3, 1");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 3, 0");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 667, 0");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 1;
		val_in = 3;
		life_in = 4;
		$display("DEQUEUE: 26, 0");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		$display();
		
		clk = ~clk;			
		rst = 0;
		enq = 0;
		deq = 0;
		val_in = 3;
		life_in = 4;
		$display("--finish test--");
		#5 $display("input(rst:%d\tenq:%d\tdeq:%d\tval_in:%d\tlife_in:%d)",
					rst, enq, deq, val_in, life_in);
		clk = ~clk;
		#5 $display("output(full:%d\tempty:%d\tval_out:%d\tlife_out:%d)",
					full, empty, val_out, life_out);
		
	end
endmodule	