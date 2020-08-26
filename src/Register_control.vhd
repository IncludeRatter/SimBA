library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	library work;
use work.cpu_constants.all;


entity Register_control is
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;

		--Output ports
		--O_PC_JMP_enable : out std_logic;
		O_CS_OUTPUT_ENABLE_REGISTER_FILE : out std_logic;
		O_CS_B_SXT_SEL : out std_logic;
		O_CS_ACC_OUTPUT_ENABLE : out std_logic;
		O_CS_ACC_HIGHER_ORDER_OUTPUT : out std_logic
	);
end Register_control;

architecture behavioral of Register_control is
	signal s_CS_OUTPUT_ENABLE_REGISTER_FILE : std_logic;
	signal s_CS_B_SXT_SEL : std_logic;
	signal s_CS_ACC_OUTPUT_ENABLE : std_logic;
	signal s_CS_ACC_HIGHER_ORDER_OUTPUT : std_logic;
begin
    process (I_enable)
    begin
        if I_enable = '1' then
					case I_instruction_opcode(5 downto 0) is
						--INSTRUCTION
					when OPCODE_ADD =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_SUB =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_MUL =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_DIV =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_CMPEQ =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_CMPLE =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_CMLT =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_AND =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_OR =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_XOR =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_XNOR =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
						--s_PC_JMP_enable <= '0';
					when OPCODE_SHL =>
					--s_data_result <= I_dataA sll I_dataB;
					when OPCODE_SHR =>
					--s_data_result <= I_dataA srl I_dataB;
					when OPCODE_JMP =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when	OPCODE_INC =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BEQ =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BNE =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BALB =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BALEB =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BZB =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_BZA =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_LD =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '1';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_ST =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '1';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_LD_Y =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '1';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_ST_Y =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '1';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_MAC =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_ACC_HIGH_OUT =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '1';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '1';
					when OPCODE_ACC_LOW_OUT =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '1';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when OPCODE_MAC_REP =>
						s_CS_OUTPUT_ENABLE_REGISTER_FILE <= '1';
						s_CS_B_SXT_SEL <= '0';
						s_CS_ACC_OUTPUT_ENABLE <= '0';
						s_CS_ACC_HIGHER_ORDER_OUTPUT <= '0';
					when others =>
					end case;
        end if;
    end process;
	O_CS_OUTPUT_ENABLE_REGISTER_FILE <= s_CS_OUTPUT_ENABLE_REGISTER_FILE;
	O_CS_B_SXT_SEL <= s_CS_B_SXT_SEL;
	O_CS_ACC_OUTPUT_ENABLE <= s_CS_ACC_OUTPUT_ENABLE;
	O_CS_ACC_HIGHER_ORDER_OUTPUT <= s_CS_ACC_HIGHER_ORDER_OUTPUT;
end behavioral;