library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	library work;
use work.cpu_constants.all;

entity MEM_control is
	port
	(
		-- Input ports
		I_clk						: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable 				: in std_logic;
		--Output ports
		O_CS_MEMORY_X_OUTPUT_ENABLE 	: out std_logic;
		O_CS_MEMORY_X_WRITE_ENABLE 	: out std_logic;
		O_CS_MEMORY_Y_OUTPUT_ENABLE 	: out std_logic;
		O_CS_MEMORY_Y_WRITE_ENABLE 	: out std_logic
	);
end MEM_control;

architecture behavioral of MEM_control is
	signal s_CS_MEMORY_X_OUTPUT_ENABLE 	: std_logic;
	signal s_CS_MEMORY_X_WRITE_ENABLE 	: std_logic;
	signal s_CS_MEMORY_Y_OUTPUT_ENABLE 	: std_logic;
	signal s_CS_MEMORY_Y_WRITE_ENABLE 	: std_logic;
begin
    process (I_enable)
    begin
        if I_enable = '1' then
					case I_instruction_opcode(5 downto 0) is
						--INSTRUCTION
					when OPCODE_ADD =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_SUB =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_MUL =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_DIV =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_CMPEQ =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_CMPLE =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_CMLT =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_AND =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_OR =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_XOR =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_XNOR =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_SHL =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_SHR =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_JMP =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_INC =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BEQ =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BNE =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BALB =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BALEB =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BZB =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_BZA =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_LD =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'1';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					--Do dorobienia
					when OPCODE_ST =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'1';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					when OPCODE_LD_Y =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'1';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';
					--Do dorobienia
					when OPCODE_ST_Y =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'0';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'1';
					when OPCODE_MAC =>
						s_CS_MEMORY_X_OUTPUT_ENABLE <= 	'1';
						s_CS_MEMORY_X_WRITE_ENABLE  <= 	'0';
						s_CS_MEMORY_Y_OUTPUT_ENABLE <= 	'1';
						s_CS_MEMORY_Y_WRITE_ENABLE  <= 	'0';	
					when others =>
					--DO NOTHING
					end case;
        end if;
    end process;
	 O_CS_MEMORY_X_OUTPUT_ENABLE 	<= s_CS_MEMORY_X_OUTPUT_ENABLE;
	 O_CS_MEMORY_X_WRITE_ENABLE 	<= s_CS_MEMORY_X_WRITE_ENABLE;
	 O_CS_MEMORY_Y_OUTPUT_ENABLE 	<= s_CS_MEMORY_Y_OUTPUT_ENABLE;
	 O_CS_MEMORY_Y_WRITE_ENABLE 	<= s_CS_MEMORY_Y_WRITE_ENABLE;
end behavioral;