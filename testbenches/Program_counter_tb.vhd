library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Program_counter_tb is
end Program_counter_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of Program_counter_tb is

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
	-- Declarations (optional)
	signal PC_value : std_logic_vector(31 downto 0) := X"00000000";
	signal Reset : std_logic := '0';
	signal Clk : std_logic := '0';
	signal JMP_enable : std_logic;
	signal BRANCH_enable : std_logic;
	signal PC_JMP_value : std_logic_vector(31 downto 0);
	signal Write_back_state : std_logic;
	signal SXT_for_branch : std_logic_vector(15 downto 0);
	
	
	    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin
--instantiate UUT
	uut_reg: Program_counter PORT MAP (
			I_clk => Clk,
			I_reset => Reset,
			I_JMP_enable => JMP_enable,
			I_BRANCH_enable => BRANCH_enable,
			I_PC_JMP_value => PC_JMP_value,
			I_write_back_state => Write_back_state,
			I_SXT_for_branch => SXT_for_branch,
			PC_out => PC_value
      );
		   -- Clock process definitions
   I_clk_process :process
   begin
		Clk <= '0';
		wait for I_clk_period/2;
		Clk <= '1';
		wait for I_clk_period/2;
   end process;
--	Write_back_state_process: process
--	begin
--		Write_back_state <= '0';
--		wait for 5*I_clk_period;
--		Write_back_state <= '1';
--		wait for I_clk_period;
--	end process;
		
-- Stimulus process
stim_proc: process
begin
	Reset <= '1';
	Write_back_state <= '0';
	wait for I_clk_period/2;
	Reset <= '0';
	wait for 50*I_clk_period;
	Write_back_state <= '1';
	JMP_enable <= '1';
	PC_JMP_value <= X"00000003";
	wait for I_clk_period;
	Write_back_state <= '0';
	JMP_enable <= '0';
	wait for 50*I_clk_period;
	Write_back_state <= '1';
	BRANCH_enable <= '1';
	SXT_for_branch <= X"0003";
	wait for I_clk_period;
	Write_back_state <= '0';
	BRANCH_enable <= '0';
	wait for 100ns;
	wait;
end process;
end behavioral;

