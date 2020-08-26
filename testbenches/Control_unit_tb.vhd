--This is ALU testbench

library ieee;
	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	

entity Control_unit_tb is
end Control_unit_tb;
architecture behavior of Control_unit_tb is

	COMPONENT Control_unit
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : std_logic;

		--Output ports
		O_ALU_operation : out std_logic_vector(5 downto 0);
		O_ALU_MEM_SEL : out std_logic_vector(1 downto 0);
		O_CS_MEMORY_OUTPUT_ENABLE : out std_logic;
		O_CS_MEMORY_WRITE_ENABLE : out std_logic;
		O_CS_WRITE_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_OUTPUT_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_ALU_ENABLE : out std_logic;
		O_CS_B_SXT_SEL : out std_logic;
		O_Control_signals : out std_logic_vector(0 to 5)
	);
END COMPONENT;

-- Internal signals
 signal Clk : std_logic := '0';
 signal Instruction_opcode : std_logic_vector(5 downto 0) := (others => '0');
 signal ALU_operation : std_logic_vector(5 downto 0) := (others => '0');
 signal ALU_MEM_SEL : std_logic_vector(1 downto 0) := (others => '0');
 signal Control_signals : std_logic_vector(0 to 5) := (others => '0');
 signal Enable : std_logic := '0';
 
 	--Control unit signal
	signal CS_MEMORY_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_WRITE_ENABLE : std_logic;
	signal CS_WRITE_ENABLE_REGISTER_FILE : std_logic;
	signal CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal CS_ALU_ENABLE : std_logic;
	signal CS_B_SXT_SEL : std_logic;
 
    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin

--instantiate UUT
	uut_reg: Control_unit PORT MAP (
			I_clk => Clk,
			I_instruction_opcode => Instruction_opcode,
			I_enable => Enable,
			O_ALU_operation => ALU_operation,
			O_ALU_MEM_SEL => ALU_MEM_SEL,
			O_CS_MEMORY_OUTPUT_ENABLE => CS_MEMORY_OUTPUT_ENABLE,
			O_CS_MEMORY_WRITE_ENABLE => CS_MEMORY_WRITE_ENABLE,
			O_CS_WRITE_ENABLE_REGISTER_FILE => CS_WRITE_ENABLE_REGISTER_FILE,
			O_CS_OUTPUT_ENABLE_REGISTER_FILE => CS_OUTPUT_ENABLE_REGISTER_FILE,
			O_CS_ALU_ENABLE => CS_ALU_ENABLE,
			O_CS_B_SXT_SEL => CS_B_SXT_SEL,
			O_Control_signals => Control_signals
      );
		
   -- Clock process definitions
   I_clk_process :process
   begin
		Clk <= '0';
		wait for I_clk_period/2;
		Clk <= '1';
		wait for I_clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
	
	--procedura wpisywania wartosci do rejestru
	procedure Check_OPCODE(
	constant OPCODE : in std_logic_vector(5 downto 0);
	constant EXPECTED_ALU_signals : in std_logic_vector(5 downto 0);
	constant EXPECTED_CONTROL_SIGNALS_FIRST_STAGE : in std_logic_vector(0 to 5);
--	constant EXPECTED_CONTROL_SIGNALS_SECOND_STAGE : in std_logic_vector(5 downto 0);
--	constant EXPECTED_CONTROL_SIGNALS_THIRD_STAGE : in std_logic_vector(5 downto 0);
	constant EXPECTED_ALU_MEM_SEL_SIGNAL : in std_logic_vector(1 downto 0)
	) is
	begin
		Enable <= '1';
		Instruction_opcode <= OPCODE;
		wait for I_clk_period;
		--FIRST STAGE CHECK
		if Control_signals = EXPECTED_CONTROL_SIGNALS_FIRST_STAGE then
		report "EXPECTED FIRST STAGE CONTROL SIGNALS" severity error;
		end if;
		if Control_signals /= EXPECTED_CONTROL_SIGNALS_FIRST_STAGE then
		report "UNEXPECTED FIRST STAGE CONTROL SIGNALS" severity error;
		end if;
--		--SECOND STAGE CHECK
--		if Control_signals = EXPECTED_CONTROL_SIGNALS_SECOND_STAGE then
--		report "EXPECTED SECOND STAGE CONTROL SIGNALS" severity error;
--		end if;
--		if Control_signals /= EXPECTED_CONTROL_SIGNALS_SECOND_STAGE then
--		report "UNEXPECTED SECOND STAGE CONTROL SIGNALS" severity error;
--		end if;
--		if ALU_operation = EXPECTED_ALU_signals then
--		report "EXPECTED ALU CONTROL SIGNALS" severity error;
--		end if;
--		if ALU_operation /= EXPECTED_ALU_signals then
--		report "UNEXPECTED ALU CONTROL SIGNALS" severity error;
--		end if;
--		wait for I_clk_period;
--		--THIRD STAGE CHECK
--		if Control_signals = EXPECTED_CONTROL_SIGNALS_THIRD_STAGE then
--		report "EXPECTED THIRD STAGE CONTROL SIGNALS" severity error;
--		end if;
--		if Control_signals /= EXPECTED_CONTROL_SIGNALS_THIRD_STAGE then
--		report "UNEXPECTED THIRD STAGE CONTROL SIGNALS" severity error;
--		end if;
--		if ALU_MEM_SEL = EXPECTED_ALU_MEM_SEL_SIGNAL then
--		report "EXPECTED ALU_MEM_SEL CONTROL SIGNALS" severity error;
--		end if;
--		if ALU_MEM_SEL /= EXPECTED_ALU_MEM_SEL_SIGNAL then
--		report "UNEXPECTED ALU_MEM_SEL CONTROL SIGNALS" severity error;
--		end if;
		wait for I_clk_period;
	end procedure Check_OPCODE;
	--procedura odczytywania wartosci z rejestru i sprawdzania czy jest ok
   begin		
      -- hold reset state for 100 ns.
		
      wait for 100 ns;
		   Check_OPCODE(OPCODE_LD,OPCODE_ADD, "101111","01");--"000010","001000"
			Check_OPCODE(OPCODE_ADD,OPCODE_ADD, "001110","00");--"000010","001000"
			Check_OPCODE(OPCODE_LD,OPCODE_ADD, "101111","01");--"000010","101000"
			Check_OPCODE(OPCODE_ADD,OPCODE_ADD, "001110","00");--"000010","001000"
      wait;
   end process;
	
end behavior;
