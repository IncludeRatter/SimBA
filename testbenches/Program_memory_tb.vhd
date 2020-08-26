library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Program_memory_tb is
end Program_memory_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of Program_memory_tb is
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
	-- Declarations (optional)
signal Clk : std_logic := '0';
signal Enable : std_logic := '0';
signal Address : std_logic_vector(31 downto 0) := X"00000000";
signal Instruction : std_logic_vector(31 downto 0) := X"00000000";

	    -- Clock period definitions
constant I_clk_period : time := 10 ns;


begin
--instantiate UUT
	uut_reg: Program_memory PORT MAP (
			I_clk => Clk,
			I_en_progMEM => Enable,
			I_address => Address,
			O_instruction_from_memory => Instruction
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
	Enable <= '1';
	wait for I_clk_period;
	Address <= X"00000000";
	wait for I_clk_period;
	Address <= X"00000001";
	wait for I_clk_period;
	Address <= X"00000002";
	wait for I_clk_period;
	Address <= X"00000003";
	wait for I_clk_period;
	Address <= X"00000004";
	wait for I_clk_period;
	wait for 100ns;
end process;
end behavioral;

