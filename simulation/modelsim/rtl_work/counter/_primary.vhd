library verilog;
use verilog.vl_types.all;
entity counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        en              : in     vl_logic;
        pc_out          : out    vl_logic_vector(0 to 9)
    );
end counter;
