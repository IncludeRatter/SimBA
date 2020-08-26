-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.cpu_constants.all;

entity MAC is
    Port ( 
				I_clk : in  STD_LOGIC;
				I_en : in  STD_LOGIC;
				I_dataX : in  STD_LOGIC_VECTOR (31 downto 0);
				I_dataY: in  STD_LOGIC_VECTOR (31 downto 0);
				O_result: out  STD_LOGIC_VECTOR (63 downto 0)
			  );
end MAC;
 
architecture Behavioral of MAC is
	signal s_result : std_logic_vector(63 downto 0);
    begin
	 -- Process Statement (optional)
	process(I_dataX,I_dataY, I_clk) is
		begin
		-- Sequential Statement(s)
		if I_en='1' and rising_edge(I_clk)  then
			s_result <= std_logic_vector(unsigned(I_dataX) * unsigned(I_dataY));
		end if;
	end process;
	O_result <= s_result;
end Behavioral;