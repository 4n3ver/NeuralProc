library verilog;
use verilog.vl_types.all;
entity controller is
    generic(
        INSTR_I         : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        INSTR_M         : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        INSTR_A         : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        INSTR_F         : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        opcode          : in     vl_logic_vector(1 downto 0);
        imm             : in     vl_logic_vector(15 downto 0);
        input_fifo_empty: in     vl_logic;
        macc_en         : out    vl_logic;
        macc_de         : out    vl_logic;
        work_en         : out    vl_logic;
        work_de         : out    vl_logic;
        input_de        : out    vl_logic;
        input_en        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INSTR_I : constant is 1;
    attribute mti_svvh_generic_type of INSTR_M : constant is 1;
    attribute mti_svvh_generic_type of INSTR_A : constant is 1;
    attribute mti_svvh_generic_type of INSTR_F : constant is 1;
end controller;
