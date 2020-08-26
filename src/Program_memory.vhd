library ieee;

-- Commonly imported packages:
	library work;
use work.cpu_constants.all;

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Program_memory is
	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_en_progMEM : in std_logic;
		I_address : in std_logic_vector(31 downto 0);
		--output
		O_instruction_from_memory : out std_logic_vector(31 downto 0)
	);
end Program_memory;

architecture behavioral of Program_memory is
    type store_t is array (0 to 7) of std_logic_vector(31 downto 0);
	signal Memory : store_t := (
	--TEST FOR BRANCHING, USING SECOND MEMORY
--	 OPCODE_LD_Y & "00010" & "11111" & X"001B",
--	 OPCODE_LD_Y & "00001" & "11111" & X"001A",
--	 OPCODE_ADD & "00011" & "00010" & "00001"&"00000000000",
--	 --OPCODE_JMP & "00101" & "11111" & "00010"&"00000000000",
--	 OPCODE_BZA & "00101" & "11111" & "00010"&"00000000000",
--	 OPCODE_ADD & "00100" & "00010" & "00001"&"00000000000",
--	 OPCODE_ADD & "00101" & "00010" & "00001"&"00000000000",
--	 OPCODE_ADD & "00110" & "00010" & "00001"&"00000000000",
--	 OPCODE_ADD & "00111" & "00010" & "00001"&"00000000000"
		--TEST FOR MAC INSTRUCTION
	OPCODE_LD_Y & "00010" & "11111" & X"001B",
	OPCODE_LD_Y & "00001" & "11111" & X"001A",
	OPCODE_MAC & "00000" & "00010" & "00001"&"00000000000",
	--OPCODE_JMP & "00101" & "11111" & "00010"&"00000000000",
	OPCODE_BZA & "00101" & "11111" & "00010"&"00000000000",
	OPCODE_ADD & "00100" & "00010" & "00001"&"00000000000",
	OPCODE_ADD & "00101" & "00010" & "00001"&"00000000000",
	OPCODE_ADD & "00110" & "00010" & "00001"&"00000000000",
	OPCODE_ADD & "00111" & "00010" & "00001"&"00000000000"
	);

begin
   process (I_clk)
   begin
      if rising_edge(I_clk) then
         if (I_en_progMEM = '1') then
            O_instruction_from_memory <= Memory(to_integer(unsigned(I_address(2 downto 0))));
         end if;
      end if;
   end process;
end behavioral;

