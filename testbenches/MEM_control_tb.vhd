library ieee;

	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity MEM_control_tb is
end MEM_control_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of MEM_control_tb is
COMPONENT MEM_control
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		--Output ports
		O_CS_MEMORY_OUTPUT_ENABLE : out std_logic;
		O_CS_MEMORY_WRITE_ENABLE : out std_logic
	);
END COMPONENT;

	-- Declarations (optional)
	signal Clk : std_logic := '0';
	signal OPCODE : std_logic_vector(5 downto 0);
	signal Enable : std_logic := '0';
	signal CS_MEMORY_OUTPUT_ENABLE : std_logic;
	signal CS_MEMORY_WRITE_ENABLE : std_logic;
	-- Clock period definitions
	constant I_clk_period : time := 40 ns;
	
begin
	uut_MEM_control: MEM_control PORT MAP (
		I_clk => Clk,
		I_instruction_opcode => OPCODE,
		I_enable => Enable,
		O_CS_MEMORY_OUTPUT_ENABLE => CS_MEMORY_OUTPUT_ENABLE,
		O_CS_MEMORY_WRITE_ENABLE => CS_MEMORY_WRITE_ENABLE
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
	
	procedure MEMControlCheck(
	constant opcode_check : in std_logic_vector(5 downto 0);
	constant cs_mem_out_enable_check : in std_logic;
	constant cs_mem_write_enable_check : in std_logic
	) is
	begin
		Enable <= '1';
		OPCODE<=opcode_check;
		wait for I_clk_period;
		if CS_MEMORY_OUTPUT_ENABLE = cs_mem_out_enable_check then
		report "EXPECTED MEMORY OUTPUT ENABLE SIGNAL" severity error;
		end if;
		if CS_MEMORY_OUTPUT_ENABLE /= cs_mem_out_enable_check then
		report "UNEXPECTED MEMORY OUTPUT ENABLE SIGNAL" severity error;
		end if;
		if CS_MEMORY_WRITE_ENABLE = cs_mem_write_enable_check then
		report "EXPECTED MEMORY OUTPUT ENABLE SIGNAL" severity error;
		end if;
		if CS_MEMORY_WRITE_ENABLE /= cs_mem_write_enable_check then
		report "UNEXPECTED MEMORY OUTPUT ENABLE SIGNAL" severity error;
		end if;
		Enable <= '0';
	end procedure MEMControlCheck;
		
	begin
	MEMControlCheck(OPCODE_LD, '1', '0');
	wait for I_clk_period;
	
	MEMControlCheck(OPCODE_SUB, '0', '0');
	wait for I_clk_period;
	
	MEMControlCheck(OPCODE_ADD, '0', '0');

	      wait;
   end process;


end behavioral;

