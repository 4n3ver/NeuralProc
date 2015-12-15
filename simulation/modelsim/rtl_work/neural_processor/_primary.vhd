library verilog;
use verilog.vl_types.all;
entity neural_processor is
    generic(
        NUM_ENTRIES     : integer := 256;
        ADDR_LEN        : integer := 11;
        DATA_WIDTH      : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_ENTRIES : constant is 1;
    attribute mti_svvh_generic_type of ADDR_LEN : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end neural_processor;
