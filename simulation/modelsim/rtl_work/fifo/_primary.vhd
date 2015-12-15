library verilog;
use verilog.vl_types.all;
entity fifo is
    generic(
        ADDR_LEN        : integer := 8;
        DATA_WIDTH      : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        enqueue         : in     vl_logic;
        dequeue         : in     vl_logic;
        data_in         : in     vl_logic_vector;
        data_out        : out    vl_logic_vector;
        full            : out    vl_logic;
        empty           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_LEN : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end fifo;
