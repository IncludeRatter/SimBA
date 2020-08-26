--This is ALU testbench

library ieee;
	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	

entity ALU_tb is
end ALU_tb;
architecture behavior of ALU_tb is

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
		O_data_result : out std_logic_vector(31 downto 0);
		Output_Status_Flags : out std_logic_vector(5 downto 0)
	);
END COMPONENT;

-- Internal signals
 signal Clk : std_logic := '0';
 signal Input_enable: std_logic := '0';
 signal DataA : std_logic_vector(31 downto 0) := (others => '0');
 signal DataB : std_logic_vector(31 downto 0) := (others => '0');
 signal Output : std_logic_vector(31 downto 0) := (others => '0');
 signal ALU_Operation : std_logic_vector(5 downto 0) := (others => '0');
 signal Status_Flags : std_logic_vector(5 downto 0) := (others => '0');
 signal PC_value : std_logic_vector(31 downto 0) := X"FEEDFEED";
 
    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin

--instantiate UUT
	uut_reg: ALU PORT MAP (
		I_clk => Clk,
		I_en_alu => Input_enable,
		I_dataA => DataA,
		I_dataB => DataB,
		I_alu_op => ALU_Operation,
		I_PC_value => PC_value,
		O_data_result => Output,
		Output_Status_Flags => Status_Flags
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
	
	--procedura wpisywania wartosci do rejestru
	procedure Check_OPERATION(
	constant ArgumentA : in std_logic_vector(31 downto 0);
	constant ArgumentB : in std_logic_vector(31 downto 0);
	constant Operation : in std_logic_vector(5 downto 0);
	constant ExpectedOutput : in std_logic_vector(31 downto 0)
	) is
	begin
		Input_enable <= '1';
		ALU_Operation <= Operation;
		DataA <= ArgumentA;
		DataB <= ArgumentB;
		wait for I_clk_period;
		if Output = ExpectedOutput then
		report "EXPECTED RESULT OF OPERATION" severity error;
		end if;
		if Output /= ExpectedOutput then
		report "UNEXPECTED RESULT OF OPERATION" severity error;
		end if;
		--Input_enable <= '0';
	end procedure Check_OPERATION;
	--procedura odczytywania wartosci z rejestru i sprawdzania czy jest ok
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
			Check_OPERATION(X"0000FEED",X"0000FEED", OPCODE_ADD,X"0001FDDA");
			wait for I_clk_period;
			Check_OPERATION(X"0000FEED",X"0000FEED", OPCODE_SUB,X"00000000");
			wait for I_clk_period;
			Check_OPERATION(X"0000FEED",X"0000FEED", OPCODE_MUL,X"FDDB2769");
			wait for I_clk_period;
			Check_OPERATION(X"0000FEED",X"0000FEED", OPCODE_DIV,X"00000001");
			wait for I_clk_period;
			--Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_CMPEQ,X"FDDBFDDA");
			--Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_CMPLE,X"FDDBFDDA");
			--Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_CMLT,X"FDDBFDDA");
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_AND,X"FEEDFEED");
			wait for I_clk_period;
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_OR,X"FEEDFEED");
			wait for I_clk_period;
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_XOR,X"00000000");
			wait for I_clk_period;
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_XNOR,X"FFFFFFFF");
			wait for I_clk_period;
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_INC,X"FEEDFEEE");
			wait for I_clk_period;
			Check_OPERATION(X"FEEDFEED",X"FEEDFEED", OPCODE_JMP,X"FEEDFEEE");
			wait for I_clk_period;
 
      wait;
   end process;
	
end behavior;
