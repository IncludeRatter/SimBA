library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	--use ieee.numeric_std.all;
	
	use ieee.std_logic_arith.all; 

entity Register_file is
	port
	(
		--input ports
		I_clk		:	 IN STD_LOGIC;
		I_en_reg_file		:	 IN STD_LOGIC;
		I_we_reg_file		:	 IN STD_LOGIC;
		I_selA		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selB		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selC		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_dataC		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		I_SXT_B_SEL : IN STD_LOGIC;
		I_SXT_B_DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		I_ACC_Output_enable : in std_logic;
		I_64bit_acc_data : in std_logic_vector(63 downto 0);
		I_ACC_Write_enable : in std_logic;
		I_Higher_Order_Output : in std_logic;
		--output ports
		O_dataA		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataB		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataMEM		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
end Register_file;

architecture behavioral of Register_file is
    type store_32bit is array (31 downto 0) of std_logic_vector(31 downto 0);
	signal Registers : store_32bit := (others => X"00000000");
--	 (
--	 X"00000001",
--	 X"00000002",
--	 X"00000003",
--	 X"00000004",
--	 X"00000005",
--	 X"00000006",
--	 X"00000007",
--	 X"00000008",
--	 X"00000009",
--	 X"0000000A",
--	 X"0000000B",
--	 X"0000000C",
--	 X"0000000D",
--	 X"0000000F",
--	 X"00000010",
--	 X"00000011",
--	 X"00000012",
--	 X"00000013",
--	 X"00000014",
--	 X"00000015",
--	 X"00000016",
--	 X"00000017",
--	 X"00000018",
--	 X"00000019",
--	 X"0000001A",
--	 X"0000001B",
--	 X"0000001C",
--	 X"0000001D",
--	 X"0000001E",
--	 X"0000001F",
--	 X"00000020",
--	 X"00000021"
--	 );
	type store_64bit is array (1 downto 0) of std_logic_vector(63 downto 0);
	 signal Accumulators : store_64bit := 
	 (
	 X"EEEEEEEEEFFFFFFF",
	 X"CCCCCCCCCCCCDDDD"
	 );
	 --(others => X"0000000000000000");
	 signal s_OutputA : STD_LOGIC_VECTOR(31 DOWNTO 0);
	 signal s_OutputB : STD_LOGIC_VECTOR(31 DOWNTO 0);
	 signal acc_value : std_logic_vector(63 downto 0) := (others => '0');
begin
    process (I_clk)
    begin
		--READING FROM REGISTERS
        if rising_edge(I_clk) and I_en_reg_file = '1' and I_SXT_B_SEL = '0' and I_ACC_Output_enable = '0'then
			s_OutputA <= Registers(CONV_INTEGER(unsigned(I_selA(4 downto 0))));
			s_OutputB <= Registers(CONV_INTEGER(unsigned(I_selB(4 downto 0))));	
		end if;
		  --SIGN EXTENSION
		if rising_edge(I_clk) and I_SXT_B_SEL = '1' and I_en_reg_file = '1' and I_ACC_Output_enable = '0' then
			s_OutputA <= Registers(CONV_INTEGER(unsigned(I_selA(4 downto 0))));
			s_OutputB <= SXT(I_SXT_B_DATA,s_OutputB'length);
		end if;
		--WRITING TO REGISTERS
		if rising_edge(I_clk) and (I_we_reg_file = '1') and I_ACC_Output_enable = '0' then
			Registers(CONV_INTEGER(unsigned(I_selC(4 downto 0)))) <=  I_dataC;
		end if;
		--READING FROM ACCUMULATOR REGISTERS
		if rising_edge(I_clk) and I_en_reg_file = '1' and I_SXT_B_SEL = '0' and I_ACC_Output_enable = '1' then
			if I_Higher_Order_Output = '1' then
				s_OutputA <= Accumulators(CONV_INTEGER(unsigned(I_selA(1 downto 0))))(63 downto 32);
			elsif I_Higher_Order_Output = '0' then
				s_OutputA <= Accumulators(CONV_INTEGER(unsigned(I_selA(1 downto 0))))(31 downto 0);
			end if;
		end if;
		--WRITING TO ACCUMULATOR REGISTERS
		if rising_edge(I_clk) and (I_we_reg_file = '0') and I_ACC_Write_enable = '1' then
			acc_value <= Accumulators(CONV_INTEGER(unsigned(I_selC(1 downto 0))));
			Accumulators(CONV_INTEGER(unsigned(I_selC(1 downto 0)))) <= (unsigned(acc_value)+unsigned(I_64bit_acc_data));
		end if;
		--INCREMENTING AND DECREMENTING ADDRESS REGISTER FOR MAC INSTRUCTION
		if rising_edge(I_clk) and I_en_reg_file = '1' and I_SXT_B_SEL = '0' and I_ACC_Output_enable = '1' then
			Registers(CONV_INTEGER(unsigned(I_selA(4 downto 0)))) <= (unsigned(Registers(CONV_INTEGER(unsigned(I_selA(4 downto 0)))))+'1');
			Registers(CONV_INTEGER(unsigned(I_selB(4 downto 0)))) <= (unsigned(Registers(CONV_INTEGER(unsigned(I_selB(4 downto 0)))))-'1');
		end if;
    end process;
	O_dataA<=s_OutputA;
	O_dataB<=s_OutputB;
end behavioral;