library verilog;
use verilog.vl_types.all;
entity sigmoid is
    port(
        x               : in     vl_logic_vector(15 downto 0);
        y               : out    vl_logic_vector(15 downto 0)
    );
end sigmoid;
