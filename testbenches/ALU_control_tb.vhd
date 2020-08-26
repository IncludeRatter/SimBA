library ieee;

	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity ALU_control_tb is
end ALU_control_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of ALU_control_tb is
COMPONENT ALU_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		--Output ports
		O_ALU_operation : out std_logic_vector(5 downto 0)
	);
END COMPONENT;

	-- Declarations (optional)
	signal Clk : std_logic := '0';
	signal OPCODE : std_logic_vector(5 downto 0);
	signal Enable : std_logic := '0';
	signal ALU_Operation : std_logic_vector(5 downto 0);
	-- Clock period definitions
	constant I_clk_period : time := 40 ns;
	
begin
	uut_ALU_control: ALU_control PORT MAP (
		I_clk => Clk,
		I_instruction_opcode => OPCODE,
		I_enable => Enable,
		O_ALU_operation => ALU_Operation
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
	
	procedure ALUControlCheck(
	constant opcode_check : in std_logic_vector(5 downto 0);
	constant ALU_Operation_check : in std_logic_vector(5 downto 0)
	) is
	begin
		Enable <= '1';
		OPCODE<=opcode_check;
		wait for I_clk_period;
		if ALU_Operation = ALU_Operation_check then
		report "EXPECTED ALU OPERATION" severity error;
		end if;
		if ALU_Operation /= ALU_Operation_check then
		report "UNEXPECTED ALU OPERATION" severity error;
		end if;
		Enable <= '0';
	end procedure ALUControlCheck;
		
	begin
	wait for I_clk_period;
	ALUControlCheck(OPCODE_LD, OPCODE_ADD);
	wait for I_clk_period;
	ALUControlCheck(OPCODE_SUB, OPCODE_SUB);
	wait for I_clk_period;
	ALUControlCheck(OPCODE_ADD,OPCODE_ADD);

	      wait;
   end process;


end behavioral;

