library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	--use ieee.numeric_std.all;
	
	use ieee.std_logic_arith.all; 
	
	library work;
use work.cpu_constants.all;




entity ALU is
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
		O_should_branch : out std_logic;
		O_data_result : out std_logic_vector(31 downto 0);
		Output_Status_Flags : out std_logic_vector(6 downto 0)
	);
end ALU;

architecture behavioral of ALU is
	signal s_data_result: STD_LOGIC_VECTOR(31 downto 0);
	signal s_Status_FLags: STD_LOGIC_VECTOR(6 downto 0);
	signal temp_mul :  STD_LOGIC_VECTOR(63 downto 0);
	signal s_should_branch : std_logic;
begin
    process (I_alu_op,I_dataA, I_dataB)
    begin
		  if I_en_alu = '1'  then
					case I_alu_op(5 downto 0) is
						--INSTRUCTION
					when OPCODE_ADD =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_dataA) + unsigned(I_dataB));
						s_should_branch <= '0';
					when OPCODE_SUB =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_dataA) - unsigned(I_dataB));
						s_should_branch <= '0';
					when OPCODE_MUL =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						temp_mul <= (unsigned(I_dataA) * unsigned(I_dataB));
						s_data_result <= temp_mul(31 downto 0);
						s_should_branch <= '0';
					when OPCODE_DIV =>
					--WARNING STD_LOGIC_ARITH DOES NOT SUPPORT DIVISION
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						--s_data_result <= (unsigned(I_dataA) / unsigned(I_dataB));
						s_should_branch <= '0';
					when OPCODE_CMPEQ =>
						if I_dataA = I_dataB then
							s_Status_FLags(CMP_BIT_EQ) <= '1';
						elsif I_dataA /= I_dataB then
							s_Status_FLags(CMP_BIT_EQ) <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_should_branch <= '0';
					when OPCODE_CMPLE =>
						if I_dataA <= I_dataB then
							s_Status_FLags(CMP_BIT_ALEB) <= '1';
						elsif I_dataA > I_dataB then
							s_Status_FLags(CMP_BIT_ALEB) <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_should_branch <= '0';
					when OPCODE_CMLT =>
						if I_dataA < I_dataB then
							s_Status_FLags(CMP_BIT_ALB) <= '1';
						elsif I_dataA >= I_dataB then
							s_Status_FLags(CMP_BIT_ALB) <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_should_branch <= '0';
					when OPCODE_AND =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA and I_dataB;
						s_should_branch <= '0';
					when OPCODE_OR =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA or I_dataB;
						s_should_branch <= '0';
					when OPCODE_XOR =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA xor I_dataB;
						s_should_branch <= '0';
					when OPCODE_XNOR =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA xnor I_dataB;
						s_should_branch <= '0';
					when OPCODE_SHL =>
						s_data_result <= CONV_STD_LOGIC_VECTOR(SHL(unsigned(I_dataA), unsigned(I_dataB)),s_data_result'length);
					when OPCODE_SHR =>
						s_data_result <= CONV_STD_LOGIC_VECTOR(SHR(unsigned(I_dataA), unsigned(I_dataB)),s_data_result'length);
					when OPCODE_JMP =>
						s_data_result <= (unsigned(I_PC_value) + 1);
						s_should_branch <= '1';
					when OPCODE_INC =>
						s_data_result <= (unsigned(I_dataB) + 1);
					when OPCODE_BEQ =>
						if I_dataA = I_dataB then
							s_Status_FLags(CMP_BIT_EQ) <= '1';
							s_should_branch <= '1';
						elsif I_dataA /= I_dataB then
							s_Status_FLags(CMP_BIT_EQ) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_BNE =>
						if I_dataA /= I_dataB then
							s_Status_FLags(CMP_BIT_NEQ) <= '1';
							s_should_branch <= '1';
						elsif I_dataA = I_dataB then
							s_Status_FLags(CMP_BIT_NEQ) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_BALB =>
						if I_dataA < I_dataB then
							s_Status_FLags(CMP_BIT_ALB) <= '1';
							s_should_branch <= '1';
						elsif I_dataA >= I_dataB then
							s_Status_FLags(CMP_BIT_ALB) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_BALEB =>
						if I_dataA <= I_dataB then
							s_Status_FLags(CMP_BIT_ALEB) <= '1';
							s_should_branch <= '1';
						elsif I_dataA > I_dataB then
							s_Status_FLags(CMP_BIT_ALEB) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_BZB =>
						if X"00000000" = I_dataB then
							s_Status_FLags(CMP_BIT_BZ) <= '1';
							s_should_branch <= '1';
						elsif X"00000000" /= I_dataB then
							s_Status_FLags(CMP_BIT_BZ) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_BZA =>
						if X"00000000" = I_dataA then
							s_Status_FLags(CMP_BIT_AZ) <= '1';
							s_should_branch <= '1';
						elsif X"00000000" /= I_dataA then
							s_Status_FLags(CMP_BIT_AZ) <= '0';
							s_should_branch <= '0';
						end if;
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= (unsigned(I_PC_value) + 1);
					when OPCODE_LD =>
					-- LD uses ADD, nothing to do
					when OPCODE_ST =>
					-- ST uses ADD, nothing to do
					when OPCODE_ACC_HIGH_OUT =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA;
						s_should_branch <= '0';
					when OPCODE_ACC_LOW_OUT =>
						s_Status_FLags(CMP_BIT_ALEB) <= '0';
						s_Status_FLags(CMP_BIT_ALB) <= '0';
						s_Status_FLags(CMP_BIT_AZ) <= '0';
						s_Status_FLags(CMP_BIT_BZ) <= '0';
						s_Status_FLags(CMP_BIT_NEQ) <= '0';
						s_Status_FLags(CMP_BIT_EQ) <= '0';
						s_data_result <= I_dataA;
						s_should_branch <= '0';
					when others =>
					-- DEBUG signal
					--s_data_result <= X"FEFEFEFE";
					end case;
        end if;
    end process;
	 O_data_result <= s_data_result;
	 Output_Status_Flags <= s_Status_FLags;
	 O_should_branch <= s_should_branch;
end behavioral;