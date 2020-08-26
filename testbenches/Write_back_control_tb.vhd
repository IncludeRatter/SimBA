library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	library work;
use work.cpu_constants.all;


entity Write_back_control_tb is
end Write_back_control_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)
architecture behavioral of Write_back_control_tb is
COMPONENT Write_back_control
  port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		--Output ports
		O_ALU_MEM_SEL : out std_logic_vector(1 downto 0);
		O_CS_WRITE_ENABLE_REGISTER_FILE : out std_logic
	);
END COMPONENT;
	signal Clk : std_logic := '0';
	signal OPCODE : std_logic_vector(5 downto 0);
	signal Enable : std_logic := '0';
	signal ALU_MEM_SEL : std_logic_vector(1 downto 0);
	signal CS_WRITE_ENABLE_REGISTER_FILE : std_logic;
	
	constant I_clk_period : time := 40 ns;
begin
	uut_Write_back_control: Write_back_control PORT MAP (
		I_clk => Clk,
		I_instruction_opcode => OPCODE,
		I_enable => Enable,
		O_ALU_MEM_SEL => ALU_MEM_SEL,
		O_CS_WRITE_ENABLE_REGISTER_FILE => CS_WRITE_ENABLE_REGISTER_FILE
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
	
	procedure WriteBackControlCheck(
	constant opcode_check : in std_logic_vector(5 downto 0);
	constant cs_write_enable_reg_file_check : in std_logic;
	constant ALU_MEM_SEL_check : in std_logic_vector(1 downto 0)
	) is
	begin
	Enable <= '1';
		OPCODE<=opcode_check;
		wait for I_clk_period;
		if CS_WRITE_ENABLE_REGISTER_FILE = cs_write_enable_reg_file_check then
		report "EXPECTED WERF SIGNALS" severity error;
		end if;
		if CS_WRITE_ENABLE_REGISTER_FILE /= cs_write_enable_reg_file_check then
		report "UNEXPECTED WERF SIGNALS" severity error;
		end if;
		if ALU_MEM_SEL = ALU_MEM_SEL_check then
		report "EXPECTED ALU_MEM_SEL signals" severity error;
		end if;
		if ALU_MEM_SEL /= ALU_MEM_SEL_check then
		report "UNEXPECTED ALU_MEM_SEL signals" severity error;
		end if;
	Enable <= '0';
	end procedure WriteBackControlCheck;
		
	begin
	WriteBackControlCheck(OPCODE_LD, '1', "01");
	wait for I_clk_period;
	WriteBackControlCheck(OPCODE_SUB, '1', "10");
	wait for I_clk_period;
	WriteBackControlCheck(OPCODE_ADD, '1', "10");

	      wait;
   end process;
end behavioral;