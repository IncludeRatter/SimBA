library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

entity MUX_MEM_OR_ALU is
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_enable : in std_logic;
		I_sel_input : in std_logic_vector(1 downto 0);
		I_input_ALU : in std_logic_vector(31 downto 0);
		I_input_MEM_X : in std_logic_vector(31 downto 0);
		I_input_MEM_Y : in std_logic_vector(31 downto 0);
		I_input_PC : in std_logic_vector(31 downto 0);
		--output
		O_output_signal : out std_logic_vector(31 downto 0)
	);
end MUX_MEM_OR_ALU;

architecture behavioral of MUX_MEM_OR_ALU is
	signal s_Output : std_logic_vector(31 downto 0);
begin
--I_input_ALU, I_input_MEM, I_input_PC, I_input_ALU, I_sel_input
    process (I_input_ALU, I_input_MEM_X,I_input_MEM_Y, I_input_PC, I_sel_input,I_clk)
    begin
		if I_enable = '1' then
				case I_sel_input is
					when "00" =>
						s_Output <= I_input_ALU;
					when "01" =>
						s_Output <= I_input_MEM_X;
					when "10" =>
						s_Output <= I_input_PC;
					when "11" =>
						s_Output <= I_input_MEM_Y;
					when others =>
						s_Output <= I_input_ALU;
				end case;
		end if;
    end process;
	 O_output_signal <= s_Output;
end behavioral;

