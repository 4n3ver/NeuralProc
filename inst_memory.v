module inst_memory(addr, out);
	parameter ADDR_LEN = 10;
	parameter ENTRY_WIDTH = 32;

	input[ADDR_LEN - 1: 0] addr;
	output[ENTRY_WIDTH - 1: 0] out;
  
	reg[ENTRY_WIDTH - 1: 0] data_array[0: (1 << ADDR_LEN) - 1];
	
	assign out = data_array[addr];
endmodule