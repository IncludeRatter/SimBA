-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.cpu_constants.all;

entity MAC_tb is
end MAC_tb;
 
architecture Behavioral of MAC_tb is
COMPONENT MAC
    Port ( 
				I_clk : in  STD_LOGIC;
				I_en : in  STD_LOGIC;
				I_dataX : in  STD_LOGIC_VECTOR (31 downto 0);
				I_dataY: in  STD_LOGIC_VECTOR (31 downto 0);
				O_result: out  STD_LOGIC_VECTOR (63 downto 0)
			  );
END COMPONENT;
--sygnaly
signal Clk : std_logic;
signal Enable : std_logic;
signal DataX : std_logic_vector(31 downto 0);
signal DataY : std_logic_vector(31 downto 0);
signal Result : std_logic_vector(63 downto 0);
    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin
	uut_MAC: MAC PORT MAP (
	I_clk => Clk,
	I_en => Enable,
	I_dataX => DataX,
	I_dataY => DataY,
	O_result => Result
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
	procedure Check_MAC(
	constant DATA_X : in std_logic_vector(31 downto 0);
	constant DATA_Y : in std_logic_vector(31 downto 0);
	constant Expected_output : in std_logic_vector(63 downto 0)
	) is

	begin
			Enable <= '1';
			DataX <= DATA_X;
			DataY <= DATA_Y;
			wait for I_clk_period;
			--Check output against expected result
			if Result = Expected_output then
			report "EXPECTED RESULT" severity error;
			end if;
			if Result /= Expected_output then
			report "UNEXPECTED RESULT" severity error;
			end if;
			Enable <= '0';
			wait for I_clk_period;
	end procedure Check_MAC;
	begin
	Check_MAC(X"FBDACEFF",X"DBACEFDA",X"D81E520EF7E85626");
	Check_MAC(X"FFFFFFFF",X"FFFFFFFF",X"FFFFFFFE00000001");
	Check_MAC(X"ADFCBDEA",X"ECADEFBD",X"A0DB35CF7807ABC2");
	wait;
	end process;
	
	
end Behavioral;