--This is ALU testbench

library ieee;
	library work;
use work.cpu_constants.all;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	

entity MUX_MEM_OR_ALU_tb is
end MUX_MEM_OR_ALU_tb;
architecture behavior of MUX_MEM_OR_ALU_tb is

	COMPONENT MUX_MEM_OR_ALU
port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_sel_input : in std_logic_vector(1 downto 0);
		I_input_ALU : in std_logic_vector(31 downto 0);
		I_input_MEM : in std_logic_vector(31 downto 0);
		I_input_PC : in std_logic_vector(31 downto 0);
		--output
		O_output_signal : out std_logic_vector(31 downto 0)
	);
END COMPONENT;

-- Internal signals
 signal Clk : std_logic := '0';
 signal Sel_input : std_logic_vector(1 downto 0) := (others => '0');
 signal Input_ALU : std_logic_vector(31 downto 0) := (others => '0');
 signal Input_MEM : std_logic_vector(31 downto 0) := (others => '0');
 signal Input_PC : std_logic_vector(31 downto 0) := (others => '0');
 signal Output_signal : std_logic_vector(31 downto 0) := (others => '0');
 
    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin

--instantiate UUT
	uut_reg: MUX_MEM_OR_ALU PORT MAP (
		I_clk => Clk,
		I_sel_input => Sel_input,
		I_input_ALU => Input_ALU,
		I_input_MEM => Input_MEM,
		I_input_PC => Input_PC,
		O_output_signal => Output_signal
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
	

	--procedura odczytywania wartosci z rejestru i sprawdzania czy jest ok
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;
		Input_ALU <= X"FEFEFEFE";
		Input_MEM <= X"DEDEDEDE";
		Input_PC <= X"ADADADAD";
		Sel_input <= "00";
		wait for I_clk_period;
		Sel_input <= "01";
		wait for I_clk_period;
		Sel_input <= "10";
		wait for I_clk_period;
 
      wait;
   end process;
	
end behavior;
