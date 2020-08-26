library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library work;
use work.cpu_constants.all;


entity SimBA_with_control_loop_tb is
end SimBA_with_control_loop_tb;
 
architecture Behavioral of SimBA_with_control_loop_tb is
COMPONENT Program_counter
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_reset : in std_logic;
		I_JMP_enable : in std_logic;
		I_BRANCH_enable : in std_logic;
		I_PC_JMP_value : in std_logic_vector(31 downto 0);
		I_write_back_state : in std_logic;
		I_SXT_for_branch : in std_logic_vector(15 downto 0);
		--output
		PC_out : out std_logic_vector(31 downto 0)
	);
END COMPONENT;

COMPONENT Program_memory
	PORT
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_en_progMEM : in std_logic;
		I_address : in std_logic_vector(31 downto 0);
		--output
		O_instruction_from_memory : out std_logic_vector(31 downto 0)
	);
	END COMPONENT;
COMPONENT Control_loop
  Port ( 
			I_clk : in  STD_LOGIC;
         I_reset : in  STD_LOGIC;
			I_instruction : in std_logic_vector(5 downto 0);
         O_first_state : out  STD_LOGIC;
			O_second_state : out  STD_LOGIC;
			O_third_state : out  STD_LOGIC;
			O_fourth_state : out STD_LOGIC;
			O_fifth_state : out STD_LOGIC
         );
END COMPONENT;
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
		I_ACC_Output_enable : in std_logic;
		I_64bit_acc_data : in std_logic_vector(63 downto 0);
		I_ACC_Write_enable : in std_logic;
		I_Higher_Order_Output : in std_logic;
		--output ports
		O_dataA		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataB		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataMEM		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
COMPONENT Register_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;

		--Output ports
		--O_PC_JMP_enable : out std_logic;
		O_CS_OUTPUT_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_B_SXT_SEL : out std_logic;
		O_CS_ACC_OUTPUT_ENABLE : out std_logic;
		O_CS_ACC_HIGHER_ORDER_OUTPUT : out std_logic
	);
END COMPONENT;
COMPONENT ALU
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_en_alu : in std_logic;
		I_dataA : in std_logic_vector(31 downto 0);
		I_dataB : in std_logic_vector(31 downto 0);
		I_alu_op : in std_logic_vector(5 downto 0);
		I_PC_value : in std_logic_vector(31 downto 0);

		--output
		O_should_branch : out std_logic;
		O_data_result : out std_logic_vector(31 downto 0);
		Output_Status_Flags : out std_logic_vector(6 downto 0)
	);
END COMPONENT;
COMPONENT MAC
    Port ( 
				I_clk : in  STD_LOGIC;
				I_en : in  STD_LOGIC;
				I_dataX : in  STD_LOGIC_VECTOR (31 downto 0);
				I_dataY: in  STD_LOGIC_VECTOR (31 downto 0);
				O_result: out  STD_LOGIC_VECTOR (63 downto 0)
			  );
END COMPONENT;
COMPONENT ALU_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		--Output ports
		O_ALU_operation : out std_logic_vector(5 downto 0)
		--O_next_stage_opcode : out std_logic_vector(5 downto 0)
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
	COMPONENT Data_memory_Y
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
COMPONENT MEM_control
port
	(
		-- Input ports
		I_clk						: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable 				: in std_logic;
		--Output ports
		O_CS_MEMORY_X_OUTPUT_ENABLE 	: out std_logic;
		O_CS_MEMORY_X_WRITE_ENABLE 	: out std_logic;
		O_CS_MEMORY_Y_OUTPUT_ENABLE 	: out std_logic;
		O_CS_MEMORY_Y_WRITE_ENABLE 	: out std_logic
	);
END COMPONENT;
COMPONENT MUX_MEM_OR_ALU
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_enable : in std_logic;
		I_sel_input : in std_logic_vector(1 downto 0);
		I_input_ALU : in std_logic_vector(31 downto 0);
		I_input_MEM_X : in std_logic_vector(31 downto 0);
		I_input_MEM_Y : in std_logic_vector(31 downto 0);
		I_input_PC : in std_logic_vector(31 downto 0);
		--output
		O_output_signal : out std_logic_vector(31 downto 0)
	);
END COMPONENT;
COMPONENT Write_back_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		I_should_branch : in std_logic;
		--Output ports
		O_PC_JMP_enable : out std_logic;
		O_PC_BRANCH_enable : out std_logic;
		O_ALU_MEM_SEL : out std_logic_vector(1 downto 0);
		O_CS_WRITE_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_ACC_WRITE_ENABLE : out std_logic
	);
END COMPONENT;




  signal Clk : std_logic := '0';
  signal Reset : std_logic := '0';
  signal Fetch_state : std_logic := '0';
  signal Reg_read_state : std_logic := '0';
  signal Execute_state : std_logic := '0';
  signal MEM_Access_state : std_logic := '0';
  signal Write_back_state : std_logic := '0';
  
  --OPCODE and instruction from program memory
  --signal OPCODE : std_logic_vector(5 downto 0);
  signal Instruction : std_logic_vector(31 downto 0);
  
  
	
	
	-- Declarations (optional)
	--Register file signals
	--signal RA : std_logic_vector(4 downto 0);
	--signal RB : std_logic_vector(4 downto 0);
	--signal RC : std_logic_vector(4 downto 0);
	--signal SXT_DATA : std_logic_vector(15 downto 0);
	signal Output_A_register_file : std_logic_vector (31 downto 0);
	signal Output_B_register_file : std_logic_vector (31 downto 0);
	signal Output_Data_to_MEM_register_file : std_logic_vector (31 downto 0);
	--ALU signals
	signal ALU_Operation : std_logic_vector(5 downto 0);
	signal ALU_Output : std_logic_vector(31 downto 0);
	signal ALU_Status_flags : std_logic_vector(6 downto 0);
	--MAC signals
	signal MAC_Result : std_logic_vector(63 downto 0) := X"0000000000000000";
	--Data memory X signals
	signal MEM_X_Output_Data : std_logic_vector(31 downto 0) := (others => '0');
	signal MEM_Y_Output_Data : std_logic_vector(31 downto 0) := (others => '0');
	--MUX_MEM_OR_ALU signals
	signal MUX_MEM_OR_ALU_OUTPUT :std_logic_vector(31 downto 0):= (others => '0');
	
	--Control signals
	signal CS_MEMORY_X_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_X_WRITE_ENABLE : std_logic;
	signal CS_MEMORY_Y_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_Y_WRITE_ENABLE : std_logic;
	signal CS_WRITE_ENABLE_REGISTER_FILE : std_logic;
	signal CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal CS_ALU_ENABLE : std_logic;
	signal CS_B_SXT_SEL : std_logic;
	signal CS_ACC_OUTPUT_ENABLE : std_logic;
	signal CS_ACC_WRITE_ENABLE : std_logic;
	signal CS_ACC_HIGHER_ORDER_OUTPUT : std_logic;
	
		--Control units
	--signal Control_signals : std_logic_vector(0 to 5) := (others => '0');
	--signal ALU_stage_control_signals : std_logic_vector(0 to 5) := (others => '0');
	--signal MEM_stage_control_signals : std_logic_vector(0 to 5) := (others => '0');
	signal ALU_MEM_SEL : std_logic_vector(1 downto 0):= (others => '0');
	
	--Program memory and Program counter
	signal PC_value : std_logic_vector(31 downto 0);
	signal PC_JMP_enable : std_logic;
	signal PC_BRANCH_enable : std_logic;
	--BRANCH
	signal Should_branch : std_logic;
--  
  constant I_clk_period : time := 10 ns;
begin
	uut_Prog_mem: Program_memory PORT MAP (
			I_clk 							=> Clk,
			I_en_progMEM 					=> Fetch_state,
			I_address 						=> PC_value,
			O_instruction_from_memory 	=> Instruction
      );
	uut_Prog_count: Program_counter PORT MAP (
			I_clk 					=> Clk,
			I_write_back_state 	=> Write_back_state,
			I_reset 					=> Reset,
			I_JMP_enable 			=> PC_JMP_enable,
			I_BRANCH_enable 		=> PC_BRANCH_enable,
			I_PC_JMP_value 		=> Output_A_register_file,
			I_SXT_for_branch 		=> Instruction(15 downto 0),
			PC_out 					=> PC_value
      );
	uut_reg: Control_loop PORT MAP ( 
			I_clk 			=> Clk,
         I_reset 			=> Reset,
			I_instruction	=> Instruction(31 downto 26),
         O_first_state 	=> Fetch_state,
			O_second_state => Reg_read_state,
			O_third_state 	=> Execute_state,
			O_fourth_state => MEM_Access_state,
			O_fifth_state 	=> Write_back_state
         );
	uut_reg_file: Register_file PORT MAP (
		I_clk 						=> Clk,
		I_en_reg_file 				=> Reg_read_state,
		I_we_reg_file 				=> CS_WRITE_ENABLE_REGISTER_FILE,
		I_selA 						=> Instruction(20 downto 16),
		I_selB 						=> Instruction(15 downto 11),
		I_selC 						=> Instruction(25 downto 21),
		I_SXT_B_SEL 				=> CS_B_SXT_SEL,
		I_SXT_B_DATA 				=> Instruction(15 downto 0),
		I_ACC_Output_enable 		=> CS_ACC_OUTPUT_ENABLE,
		I_64bit_acc_data 			=> MAC_Result,
		I_ACC_Write_enable 		=> CS_ACC_WRITE_ENABLE,
		I_Higher_Order_Output 	=> CS_ACC_HIGHER_ORDER_OUTPUT,
		I_dataC 						=> MUX_MEM_OR_ALU_OUTPUT,
		O_dataA 						=> Output_A_register_file,
		O_dataB 						=> Output_B_register_file,
		O_dataMEM 					=> Output_Data_to_MEM_register_file
      );
	uut_Register_control: Register_control PORT MAP (
		I_clk 									=> Clk,
		I_instruction_opcode 				=> Instruction(31 downto 26),
		I_enable 								=> Reg_read_state,
		O_CS_OUTPUT_ENABLE_REGISTER_FILE => CS_OUTPUT_ENABLE_REGISTER_FILE,
		O_CS_B_SXT_SEL 						=> CS_B_SXT_SEL,
		O_CS_ACC_OUTPUT_ENABLE 				=> CS_ACC_OUTPUT_ENABLE,
		O_CS_ACC_HIGHER_ORDER_OUTPUT 		=> CS_ACC_HIGHER_ORDER_OUTPUT
      );
	uut_ALU: ALU PORT MAP (
		I_clk 					=> Clk,
		I_en_alu 				=> Execute_state,
		I_dataA 					=> Output_A_register_file,
		I_dataB 					=> Output_B_register_file,
		I_alu_op 				=> ALU_Operation,
		I_PC_value 				=> PC_value,
		O_should_branch 		=> Should_branch,
		O_data_result 			=> ALU_Output,
		Output_Status_Flags 	=> ALU_Status_flags
      );
	uut_MAC: MAC PORT MAP( 
		I_clk 	=> Clk,
		I_en 		=> Execute_state,
		I_dataX 	=> MEM_X_Output_Data,
		I_dataY 	=> MEM_Y_Output_Data,
		O_result => MAC_Result
		);
	uut_ALU_control: ALU_control PORT MAP (
		I_clk 					=> Clk,
		I_instruction_opcode => Instruction(31 downto 26),
		I_enable 				=> Execute_state,
		O_ALU_operation 		=> ALU_Operation
      );
	uut_MEMX: Data_memory_X PORT MAP (
		I_clk 					=> Clk,
		I_MEM_output_enable 	=> CS_MEMORY_X_OUTPUT_ENABLE,
		I_MEM_write_enable 	=> CS_MEMORY_X_WRITE_ENABLE,
		I_address 				=> ALU_Output,
		I_data 					=> Output_Data_to_MEM_register_file,
		O_data_from_memory 	=> MEM_X_Output_Data
      );
	uut_MEMY: Data_memory_Y PORT MAP (
		I_clk 					=> Clk,
		I_MEM_output_enable 	=> CS_MEMORY_Y_OUTPUT_ENABLE,
		I_MEM_write_enable 	=> CS_MEMORY_Y_WRITE_ENABLE,
		I_address 				=> ALU_Output,
		I_data 					=> Output_Data_to_MEM_register_file,
		O_data_from_memory 	=> MEM_Y_Output_Data
      );
	uut_MUX_MEM_ALU_OUT: MUX_MEM_OR_ALU PORT MAP (
		I_clk 				=> Clk,
		I_enable 			=> Write_back_state,
		I_sel_input 		=> ALU_MEM_SEL,
		I_input_ALU 		=> ALU_Output,
		I_input_MEM_X 		=> MEM_X_Output_Data,
		I_input_MEM_Y 		=> MEM_Y_Output_Data,
		I_input_PC 			=> ALU_Output,
		O_output_signal 	=> MUX_MEM_OR_ALU_OUTPUT
      );
	uut_MEM_control: MEM_control PORT MAP (
		I_clk 								=> Clk,
		I_instruction_opcode 			=> Instruction(31 downto 26),
		I_enable 							=> MEM_Access_state,
		O_CS_MEMORY_X_OUTPUT_ENABLE 	=> CS_MEMORY_X_OUTPUT_ENABLE,
		O_CS_MEMORY_X_WRITE_ENABLE 	=> CS_MEMORY_X_WRITE_ENABLE,
		O_CS_MEMORY_Y_OUTPUT_ENABLE 	=> CS_MEMORY_Y_OUTPUT_ENABLE,
		O_CS_MEMORY_Y_WRITE_ENABLE 	=> CS_MEMORY_Y_WRITE_ENABLE
      );
		uut_Write_back_control: Write_back_control PORT MAP (
		I_clk 									=> Clk,
		I_instruction_opcode 				=> Instruction(31 downto 26),
		I_enable 								=> Write_back_state,
		I_should_branch 						=> Should_branch,
		O_PC_JMP_enable 						=> PC_JMP_enable,
		O_PC_BRANCH_enable					=> PC_BRANCH_enable,
		O_ALU_MEM_SEL 							=> ALU_MEM_SEL,
		O_CS_WRITE_ENABLE_REGISTER_FILE 	=> CS_WRITE_ENABLE_REGISTER_FILE,
		O_CS_ACC_WRITE_ENABLE				=> CS_ACC_WRITE_ENABLE
      );		
   -- Clock process definitions
   I_clk_process :process
   begin
		Clk <= '0';
		wait for I_clk_period/2;
		Clk <= '1';
		wait for I_clk_period/2;
   end process;

  stim_proc: process
  begin
  --zerowanie
	Reset <= '1';
	wait for I_clk_period;wait for I_clk_period/2;
	Reset <= '0';
  wait;
  end process;
end Behavioral;