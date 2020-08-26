library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	--use ieee.numeric_std.all;
	
	use ieee.std_logic_arith.all; 
	
entity Program_counter is
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_reset : in std_logic;
		I_JMP_enable : in std_logic;
		I_BRANCH_enable : in std_logic;
		I_REP_OPERATION : in std_logic;
		I_PC_JMP_value : in std_logic_vector(31 downto 0);
		I_write_back_state : in std_logic;
		I_SXT_for_branch : in std_logic_vector(15 downto 0);
		--output
		PC_out : out std_logic_vector(31 downto 0)
	);
end Program_counter;

architecture behavioral of Program_counter is
	signal s_PC_value : std_logic_vector(31 downto 0) := X"00000000";
	signal s_temp : std_logic_vector(32 downto 0);
begin
process(I_clk)
begin
	if rising_edge(I_clk) then
		if I_write_back_state = '1' then
			s_PC_value <= (unsigned(s_PC_value)+1);
		end if;
		if I_JMP_enable='1' and I_write_back_state = '1' then
			s_PC_value <= I_PC_JMP_value;
		elsif I_BRANCH_enable='1' and I_write_back_state = '1' then
			s_PC_value <= I_PC_JMP_value;
		elsif I_REP_OPERATION = '1' then
			--DO NOTHING (WAIT)
		elsif I_reset = '1' then
			s_PC_value <=  X"00000000";
		end if;
	end if;
end process;
PC_out <= s_PC_value;
end behavioral;

