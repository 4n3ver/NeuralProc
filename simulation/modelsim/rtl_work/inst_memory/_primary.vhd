library verilog;
use verilog.vl_types.all;
entity inst_memory is
    generic(
        ADDR_LEN        : integer := 10;
        ENTRY_WIDTH     : integer := 32
    );
    port(
        addr            : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_LEN : constant is 1;
    attribute mti_svvh_generic_type of ENTRY_WIDTH : constant is 1;
end inst_memory;
