library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Data_memory_X_tb is
end Data_memory_X_tb;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of Data_memory_X_tb is
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
signal O_Enable : std_logic := '0';
signal W_Enable : std_logic := '0';
signal Address : std_logic_vector(31 downto 0) := X"00000000";
signal I_DATA : std_logic_vector(31 downto 0) := X"00000000";
signal O_DATA : std_logic_vector(31 downto 0) := X"00000000";

	    -- Clock period definitions
constant I_clk_period : time := 10 ns;


begin
--instantiate UUT
	uut_reg: Data_memory_X PORT MAP (
			I_clk => Clk,
			I_MEM_output_enable => O_Enable,
			I_MEM_write_enable => W_Enable,
			I_address => Address,
			I_data => I_DATA,
			O_data_from_memory => O_DATA
			
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
procedure WriteMemory(
	constant Address_in : in std_logic_vector(31 downto 0);
	constant Data_to_Write : in std_logic_vector(31 downto 0)
	) is
	begin
		W_Enable <= '1';
		O_Enable <= '0';
		Address <= Address_in;
		I_DATA <= Data_to_Write;
		wait for I_clk_period;
	end procedure WriteMemory;
procedure Check_Read_Memory(
	constant Address_in : in std_logic_vector(31 downto 0);
	constant ExpectedOutput : in std_logic_vector(31 downto 0)
	) is
	begin
		W_Enable <= '0';
		O_Enable <= '1';
		Address <= Address_in;
		wait for I_clk_period;
		if O_DATA = ExpectedOutput then
		report "EXPECTED RESULT OF OPERATION" severity error;
		end if;
		if O_DATA /= ExpectedOutput then
		report "UNEXPECTED RESULT OF OPERATION" severity error;
		end if;
		--Input_enable <= '0';
	end procedure Check_Read_Memory;
begin
	--Write to memory
--	W_Enable <= '1';
--	O_Enable <= '0';
--	Address <= X"00000000";
--	I_DATA <= X"FFFFFFFF";
	WriteMemory(X"00000000",X"FFFFFFFF");
	wait for I_clk_period;
--	Address <= X"00000001";
--	I_DATA <= X"EEEEEEEE";
	WriteMemory(X"00000001",X"EEEEEEEE");
	wait for I_clk_period;
--	Address <= X"00000002";
--	I_DATA <= X"DDDDDDDD";
	WriteMemory(X"00000002",X"DDDDDDDD");
	wait for I_clk_period;
	--Read from memory
	Check_Read_Memory(X"00000000",X"FFFFFFFF");
	wait for I_clk_period;
	Check_Read_Memory(X"00000001",X"EEEEEEEE");
	wait for I_clk_period;
	Check_Read_Memory(X"00000002",X"DDDDDDDD");
	wait for I_clk_period;
	wait;
end process;
end behavioral;

