library ieee;

	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity SimBA_tb is
end SimBA_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of SimBA_tb is

COMPONENT Data_memory_X
	PORT
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_MEM_output_enable : in std_logic;
		I_MEM_write_enable : in std_logic;
		I_address : in std_logic_vector(31 downto 0);
		I_data : in std_logic_vector(31 downto 0);
		--output
		O_data_from_memory : out std_logic_vector(31 downto 0)
	);
	END COMPONENT;



	-- Declarations (optional)
	signal Clk : std_logic := '0';
	--Register file signals
	signal Output_A_register_file : std_logic_vector (31 downto 0);
	signal Output_B_register_file : std_logic_vector (31 downto 0);
	signal Output_Data_to_MEM_register_file : std_logic_vector (31 downto 0);
	--ALU signals
	signal ALU_Operation : std_logic_vector(5 downto 0);
	signal ALU_Output : std_logic_vector(31 downto 0);
	signal ALU_Status_flags : std_logic_vector(5 downto 0);
	--Data memory X signals
	signal MEM_X_Output_Data : std_logic_vector(31 downto 0);
	--Program counter signals
	signal PC_reset : std_logic := '0';
	signal PC_value : std_logic_vector(31 downto 0) := (others => '0');
	--Program memory
	signal Prog_Mem_enable : std_logic := '0';
	signal Prog_mem_instruction : std_logic_vector(31 downto 0);
	--Control unit
	signal ALU_MEM_SEL : std_logic_vector(1 downto 0);
	--MUX_MEM_OR_ALU signals
	signal MUX_MEM_OR_ALU_OUTPUT :std_logic_vector(31 downto 0);
	--Control loop signals
	signal State : std_logic_vector(1 downto 0) := (others => '0');
	signal Control_unit_status : std_logic_vector(1 downto 0) := (others => '0');
	signal END_CYCLE_CONTROL_UNIT : std_logic := '0';
	
	signal CS_MEMORY_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_WRITE_ENABLE : std_logic;
	signal CS_WRITE_ENABLE_REGISTER_FILE : std_logic;
	signal CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal CS_ALU_ENABLE : std_logic;
	signal CS_B_SXT_SEL : std_logic;
	
	
	    -- Clock period definitions
constant I_clk_period : time := 40 ns;
	
begin

	uut_MEMX: Data_memory_X PORT MAP (
			I_clk => Clk,
			I_MEM_output_enable => CS_MEMORY_OUTPUT_ENABLE,
			I_MEM_write_enable => CS_MEMORY_WRITE_ENABLE,
			I_address => ALU_Output,
			I_data => Output_Data_to_MEM_register_file,
			O_data_from_memory => MEM_X_Output_Data
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
	begin
	      wait;
   end process;


end behavioral;

