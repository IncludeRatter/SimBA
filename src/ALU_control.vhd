library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	library work;
use work.cpu_constants.all;


entity ALU_control is
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_instruction_opcode : in std_logic_vector(5 downto 0);
		I_enable : in std_logic;
		--Output ports
		O_ALU_operation : out std_logic_vector(5 downto 0)
	);
end ALU_control;

architecture behavioral of ALU_control is
	signal s_ALU_operation: STD_LOGIC_VECTOR(5 downto 0);
begin

    process (I_enable)
    begin
        if I_enable = '1' then
					case I_instruction_opcode(5 downto 0) is
						--INSTRUCTION
					when OPCODE_ADD =>
						s_ALU_operation <= OPCODE_ADD;
					when OPCODE_SUB =>
						s_ALU_operation <= OPCODE_SUB;
					when OPCODE_MUL =>
						s_ALU_operation <= OPCODE_MUL;
					when OPCODE_DIV =>
						s_ALU_operation <= OPCODE_DIV;
					when OPCODE_CMPEQ =>
						s_ALU_operation <= OPCODE_CMPEQ;
					when OPCODE_CMPLE =>
						s_ALU_operation <= OPCODE_CMPLE;
					when OPCODE_CMLT =>
						s_ALU_operation <= OPCODE_CMLT;
					when OPCODE_AND =>
						s_ALU_operation <= OPCODE_AND;
					when OPCODE_OR =>
						s_ALU_operation <= OPCODE_OR;
					when OPCODE_XOR =>
						s_ALU_operation <= OPCODE_XOR;
					when OPCODE_XNOR =>
						s_ALU_operation <= OPCODE_XNOR;
					when OPCODE_SHL =>
						s_ALU_operation <= OPCODE_SHL;
					when OPCODE_SHR =>
						s_ALU_operation <= OPCODE_SHR;
					when OPCODE_JMP =>
						s_ALU_operation <= OPCODE_JMP;
					when OPCODE_INC =>
						s_ALU_operation <= OPCODE_INC;
					when OPCODE_BEQ =>
						s_ALU_operation <= OPCODE_BEQ;
					when OPCODE_BNE =>
						s_ALU_operation <= OPCODE_BNE;
					when OPCODE_BALB =>
						s_ALU_operation <= OPCODE_BALB;
					when OPCODE_BALEB =>
						s_ALU_operation <= OPCODE_BALEB;
					when OPCODE_BZB =>
						s_ALU_operation <= OPCODE_BZB;
					when OPCODE_BZA =>
						s_ALU_operation <= OPCODE_BZA;
					when OPCODE_LD =>
						s_ALU_operation <= OPCODE_ADD;
					when OPCODE_ST =>
						s_ALU_operation <= OPCODE_ADD;
					when OPCODE_LD_Y =>
						s_ALU_operation <= OPCODE_ADD;
					when OPCODE_ST_Y =>
						s_ALU_operation <= OPCODE_ADD;
					when OPCODE_MAC =>
						--NOTHING TO DO!!! 
					when OPCODE_ACC_HIGH_OUT =>
						s_ALU_operation <= OPCODE_ACC_HIGH_OUT;
					when OPCODE_ACC_LOW_OUT =>
						s_ALU_operation <= OPCODE_ACC_LOW_OUT;
					when others =>
					-- DEBUG signal
					--s_Control_signals <= "111111";
					end case;
        end if;
    end process;
	 O_ALU_operation <= s_ALU_operation;
end behavioral;