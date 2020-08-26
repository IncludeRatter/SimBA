library ieee;

	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Register_control_tb is
end Register_control_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of Register_control_tb is
COMPONENT Register_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;

		--Output ports
		O_CS_OUTPUT_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_B_SXT_SEL : out std_logic
	);
END COMPONENT;

	-- Declarations (optional)
	signal Clk : std_logic := '0';
	signal OPCODE : std_logic_vector(5 downto 0);
	signal Enable : std_logic := '0';
	signal CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal CS_B_SXT_SEL : std_logic;
	-- Clock period definitions
	constant I_clk_period : time := 40 ns;
	
begin
	uut_Register_control: Register_control PORT MAP (
		I_clk => Clk,
		I_instruction_opcode => OPCODE,
		I_enable => Enable,
		O_CS_OUTPUT_ENABLE_REGISTER_FILE => CS_OUTPUT_ENABLE_REGISTER_FILE,
		O_CS_B_SXT_SEL => CS_B_SXT_SEL
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
	procedure ControlCheck(
	constant opcode_check : in std_logic_vector(5 downto 0);
	constant cs_out_enable_reg_file_check : in std_logic;
	constant cs_b_sxt_sel_check : in std_logic
	) is
	begin
		Enable <= '1';
		OPCODE<=opcode_check;
		wait for I_clk_period;
		if CS_OUTPUT_ENABLE_REGISTER_FILE = cs_out_enable_reg_file_check then
		report "EXPECTED OUTPUT ENABLE REGISTER FILE SIGNAL" severity error;
		end if;
		if CS_OUTPUT_ENABLE_REGISTER_FILE /= cs_out_enable_reg_file_check then
		report "UNEXPECTED OUTPUT ENABLE REGISTER FILE SIGNAL" severity error;
		end if;
		if CS_B_SXT_SEL = cs_b_sxt_sel_check then
		report "EXPECTED SXT SIGNAL" severity error;
		end if;
		if CS_B_SXT_SEL /= cs_b_sxt_sel_check then
		report "UNEXPECTED SXT SIGNAL" severity error;
		end if;
		Enable <= '0';
	end procedure ControlCheck;	
	begin
	ControlCheck(OPCODE_LD, '1','1');
	wait for I_clk_period;
	ControlCheck(OPCODE_SUB,'1','0');
	wait for I_clk_period;
	ControlCheck(OPCODE_ADD, '1','0');
	wait;
   end process;
end behavioral;

