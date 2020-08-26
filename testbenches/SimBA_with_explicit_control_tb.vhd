library ieee;

	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity SimBA_with_explicit_control_tb is
end SimBA_with_explicit_control_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of SimBA_with_explicit_control_tb is

COMPONENT Register_file
	port
	(
		--input ports
		I_clk		:	 IN STD_LOGIC;
		I_en_reg_file		:	 IN STD_LOGIC;
		I_we_reg_file		:	 IN STD_LOGIC;
		I_selA		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selB		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selC		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_dataC		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		I_SXT_B_SEL : IN STD_LOGIC;
		I_SXT_B_DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		--output ports
		O_dataA		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataB		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataMEM		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

--COMPONENT Program_counter
--	PORT
--	(
--		-- Input ports
--		I_clk	: in  std_logic;
--		I_reset : in std_logic;
--		--output
--		PC_out : out std_logic_vector(31 downto 0)
--	);
--END COMPONENT;
--
--COMPONENT Program_memory
--	PORT
--	(
--		-- Input ports
--		I_clk	: in  std_logic;
--		I_en_progMEM : in std_logic;
--		I_address : in std_logic_vector(31 downto 0);
--		--output
--		O_instruction_from_memory : out std_logic_vector(31 downto 0)
--	);
--	END COMPONENT;
COMPONENT ALU
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_en_alu : in std_logic;
		I_dataA : in std_logic_vector(31 downto 0);
		I_dataB : in std_logic_vector(31 downto 0);
		I_alu_op : in std_logic_vector(5 downto 0);

		--output
		O_data_result : out std_logic_vector(31 downto 0);
		Output_Status_Flags : out std_logic_vector(5 downto 0)
	);
END COMPONENT;
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
COMPONENT MUX_MEM_OR_ALU
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_sel_input : in std_logic_vector(1 downto 0);
		I_input_ALU : in std_logic_vector(31 downto 0);
		I_input_MEM : in std_logic_vector(31 downto 0);
		I_input_PC : in std_logic_vector(31 downto 0);
		--output
		O_output_signal : out std_logic_vector(31 downto 0)
	);
END COMPONENT;


	-- Declarations (optional)
	signal Clk : std_logic := '0';
	--Register file signals
	signal RA : std_logic_vector(4 downto 0);
	signal RB : std_logic_vector(4 downto 0);
	signal RC : std_logic_vector(4 downto 0);
	signal SXT_DATA : std_logic_vector(15 downto 0);
	signal Output_A_register_file : std_logic_vector (31 downto 0);
	signal Output_B_register_file : std_logic_vector (31 downto 0);
	signal Output_Data_to_MEM_register_file : std_logic_vector (31 downto 0);
	--ALU signals
	signal ALU_Operation : std_logic_vector(5 downto 0);
	signal ALU_Output : std_logic_vector(31 downto 0);
	signal ALU_Status_flags : std_logic_vector(5 downto 0);
	--Data memory X signals
	signal MEM_X_Output_Data : std_logic_vector(31 downto 0);
	--Control unit
	signal Enable : std_logic := '0';
	signal Control_signals : std_logic_vector(5 downto 0);
	signal ALU_MEM_SEL : std_logic_vector(1 downto 0);
	signal OPCODE : std_logic_vector(5 downto 0);
	--MUX_MEM_OR_ALU signals
	signal MUX_MEM_OR_ALU_OUTPUT :std_logic_vector(31 downto 0);
	
	
	 	--Control unit signal
	signal CS_MEMORY_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_WRITE_ENABLE : std_logic;
	signal CS_WRITE_ENABLE_REGISTER_FILE : std_logic;
	signal CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal CS_ALU_ENABLE : std_logic;
	signal CS_B_SXT_SEL : std_logic;
	
	
	    -- Clock period definitions
constant I_clk_period : time := 40 ns;
	
begin

	uut_reg_file: Register_file PORT MAP (
		I_clk => Clk,
		I_en_reg_file => CS_OUTPUT_ENABLE_REGISTER_FILE,
		I_we_reg_file => CS_WRITE_ENABLE_REGISTER_FILE,
		I_selA => RA,
		I_selB => RB,
		I_selC => RC,
		I_SXT_B_SEL => CS_B_SXT_SEL,
		I_SXT_B_DATA =>SXT_DATA,
		I_dataC => MUX_MEM_OR_ALU_OUTPUT,
		O_dataA => Output_A_register_file,
		O_dataB => Output_B_register_file,
		O_dataMEM => Output_Data_to_MEM_register_file
      );
	uut_MEMX: Data_memory_X PORT MAP (
			I_clk => Clk,
			I_MEM_output_enable => CS_MEMORY_OUTPUT_ENABLE,
			I_MEM_write_enable => CS_MEMORY_WRITE_ENABLE,
			I_address => ALU_Output,
			I_data => Output_Data_to_MEM_register_file,
			O_data_from_memory => MEM_X_Output_Data
      );
	uut_ALU: ALU PORT MAP (
		I_clk => Clk,
		I_en_alu => CS_ALU_ENABLE,
		I_dataA => Output_A_register_file,
		I_dataB => Output_B_register_file,
		I_alu_op => ALU_Operation,
		O_data_result => ALU_Output,
		Output_Status_Flags => ALU_Status_flags
      );
	uut_CONTROL_UNIT: Control_unit PORT MAP (
			I_clk => Clk,
			I_instruction_opcode => OPCODE,
			I_enable => Enable,
			O_ALU_operation => ALU_Operation,
			O_ALU_MEM_SEL => ALU_MEM_SEL,
			O_CS_MEMORY_OUTPUT_ENABLE => CS_MEMORY_OUTPUT_ENABLE,
			O_CS_MEMORY_WRITE_ENABLE => CS_MEMORY_WRITE_ENABLE,
			O_CS_WRITE_ENABLE_REGISTER_FILE => CS_WRITE_ENABLE_REGISTER_FILE,
			O_CS_OUTPUT_ENABLE_REGISTER_FILE => CS_OUTPUT_ENABLE_REGISTER_FILE,
			O_CS_ALU_ENABLE => CS_ALU_ENABLE,
			O_CS_B_SXT_SEL => CS_B_SXT_SEL,
			O_Control_signals => Control_signals
      );
	uut_MUX_MEM_ALU_OUT: MUX_MEM_OR_ALU PORT MAP (
		I_clk => Clk,
		I_sel_input => ALU_MEM_SEL,
		I_input_ALU => ALU_Output,
		I_input_MEM => MEM_X_Output_Data,
		I_input_PC => ALU_Output,
		O_output_signal => MUX_MEM_OR_ALU_OUTPUT
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
	--RESET
	RC <= "00000";
	RA <= "00000";
	RB <= "00000";

	wait for I_clk_period/2;

	Enable <= '1';
	OPCODE<=OPCODE_LD;
	RC <= "11111";
	RA <= "00001";
	SXT_DATA <= X"001B";
	wait for I_clk_period;wait for I_clk_period;
	--OPCODE_LD & "00111" & "00011" & X"001A",
--	RC <= "00111";
--	RA <= "00011";
--	SXT_DATA <= X"001A";
--	Control_signals(B_SXT_SEL) <= '1';
--	Control_signals(OUTPUT_ENABLE_REGISTER_FILE) <= '1';
--	wait for I_clk_period;
--	ALU_operation <= OPCODE_ADD;
--	Control_signals(ALU_ENABLE) <= '1';
--	wait for I_clk_period;
--	Control_signals(MEMORY_OUTPUT_ENABLE) <= '1';
--	Control_signals(MEMORY_WRITE_ENABLE) <= '0';
--	ALU_MEM_SEL <= "01" ; --use MEMORY as source of data to register write bus
--	Control_signals(WRITE_ENABLE_REGISTER_FILE) <= '1';
--	wait for I_clk_period;wait for I_clk_period;wait for I_clk_period;
	OPCODE<=OPCODE_LD;
	RC <= "00111";
	RA <= "00011";
	SXT_DATA <= X"001A";
	
	wait for I_clk_period;wait for I_clk_period;
	 --OPCODE_ADD & "00011" & "11111" & "00111"&"00000000000",
--	Control_signals(B_SXT_SEL) <= '0';
--	Control_signals(OUTPUT_ENABLE_REGISTER_FILE) <= '1';
--	RC <= "00011";
--	RA <= "11111";
--	RB <= "00111";
--	ALU_operation <= OPCODE_ADD;
--	Control_signals(ALU_ENABLE) <= '1';
--	Control_signals(WRITE_ENABLE_REGISTER_FILE) <= '1';
--	ALU_MEM_SEL <= "00" ;  --use ALU as source of data to register write bus
--	wait for I_clk_period;--wait for I_clk_period;wait for I_clk_period;
	OPCODE<=OPCODE_ADD;
	RC <= "00011";
	RA <= "11111";
	RB <= "00111";
	wait for I_clk_period;
	      wait;
   end process;


end behavioral;

