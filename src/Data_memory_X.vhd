library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
entity Data_memory_X is


	port
	(
		-- Input ports
		I_clk	: in  std_logic;
		I_MEM_output_enable : in std_logic;
		I_MEM_write_enable : in std_logic;
		I_address : in std_logic_vector(31 downto 0);
		I_data : in std_logic_vector(31 downto 0);
		--output
		O_data_from_memory : out std_logic_vector(31 downto 0)
	);
end Data_memory_X;

-- Library Clause(s) (optional)
-- Use Clause(s) (optional)

architecture behavioral of Data_memory_X is

	-- Declarations (optional)
	signal s_data_from_memory :std_logic_vector(31 downto 0);
    type store_t is array (0 to 31) of std_logic_vector(31 downto 0);
	 signal Memory : store_t := (
	 X"00000000",
	 X"00000001",
	 X"00000002",
	 X"00000003",
	 X"00000004",
	 X"00000005",
	 X"00000006",
	 X"00000007",
	 X"00000008",
	 X"00000009",
	 X"0000000A",
	 X"0000000B",
	 X"0000000C",
	 X"0000000D",
	 X"0000000E",
	 X"0000000F",
	 X"00000010",
	 X"00000011",
	 X"00000012",
	 X"00000013",
	 X"00000014",
	 X"00000015",
	 X"00000016",
	 X"00000017",
	 X"00000018",
	 X"00000019",
	 X"0000001A",
	 X"0000001B",
	 X"0000001C",
	 X"0000001D",
	 X"0000001E",
	 X"0000001F"
	 );

begin

    process (I_clk)
    begin
        if rising_edge(I_clk) then
            if (I_MEM_output_enable = '1') then
                s_data_from_memory <= Memory(to_integer(unsigned(I_address(4 downto 0))));
            end if;
				if (I_MEM_write_enable = '1') then
                Memory(to_integer(unsigned(I_address(7 downto 0)))) <= I_data;
            end if;
        end if;
    end process;
	 O_data_from_memory <= s_data_from_memory;
end behavioral;

