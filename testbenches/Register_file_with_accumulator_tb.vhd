library ieee;
library work;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	

entity Register_file_with_accumulators_tb is
end Register_file_with_accumulators_tb;
architecture behavior of Register_file_with_accumulators_tb is
	
COMPONENT Register_file
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
END COMPONENT;

-- Internal signals
 signal Clk : std_logic := '0';
 signal Input_enable: std_logic := '0';
 signal Write_enable : std_logic := '0';
 signal Ra : std_logic_vector(4 downto 0) := (others => '0');
 signal Rb : std_logic_vector(4 downto 0) := (others => '0');
 signal Rc : std_logic_vector(4 downto 0) := (others => '0');
 signal WriteData : std_logic_vector(31 downto 0) := (others => '0');
 signal OutputA : std_logic_vector(31 downto 0) := (others => '0');
 signal OutputB : std_logic_vector(31 downto 0) := (others => '0');
 --accumulator signals
 signal Acc_enable : std_logic := '0';
 signal Acc_write_enable : std_logic := '0';
 signal ACC_data_to_write : std_logic_vector(63 downto 0) := X"0000000000000000";
 signal Higher_order_output : std_logic := '0';
 --sign extension signal
  signal SXT_Enable : std_logic := '0';
  signal SXT_DATA : std_logic_vector(15 downto 0):= (others => '0');
    -- Clock period definitions
constant I_clk_period : time := 10 ns;

begin

--instantiate UUT
	uut_reg: Register_file PORT MAP (
		I_clk => Clk,
		I_en_reg_file => Input_enable,
		I_we_reg_file => Write_enable,
		I_selA => Ra,
		I_selB => Rb,
		I_selC => Rc,
		I_SXT_B_SEL => SXT_Enable,
		I_SXT_B_DATA =>SXT_DATA,
		I_ACC_Write_enable => Acc_write_enable,
		I_64bit_acc_data => ACC_data_to_write,
		I_dataC => WriteData,
		I_ACC_Output_enable => Acc_enable,
		I_Higher_Order_Output => Higher_order_output,
		O_dataA => OutputA,
		O_dataB => OutputB
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
	--procedura wpisywania wartosci do rejestru
   procedure Write_ACC(
	constant Rc_destination : in std_logic_vector(4 downto 0);
	constant Data_to_Accumulate : in std_logic_vector(63 downto 0)
	) is
	begin
			Acc_enable <= '1';
			Acc_write_enable <= '1'; 
			Write_enable <= '0';
			Rc <= Rc_destination;
			ACC_data_to_write <= Data_to_Accumulate;
			wait for I_clk_period;
			Acc_enable <= '0';
			Acc_write_enable <= '0'; 
			Write_enable <= '0';
			wait for I_clk_period;
	end procedure Write_ACC;
	
	--procedura odczytywania i sprawdzania wartosci rejestru
	procedure Check_Read_ACC(
	constant Ra_read : in std_logic_vector(4 downto 0);
	constant Higher_Order_Read : in std_logic;
	constant Ra_Data_expected : in std_logic_vector(31 downto 0)
	) is

	begin
			Input_enable <= '1';
			Acc_enable <= '1';
			Write_enable <= '0';
			Higher_order_output <= Higher_Order_Read;
			Ra <= Ra_read;
			wait for I_clk_period;
			--Check output against expected result
			if OutputA = Ra_Data_expected then
			report "EXPECTED MAC RESULT ON OUTPUT A" severity error;
			end if;
			if OutputA /= Ra_Data_expected then
			report "UNEXPECTED MAC RESULT ON OUTPUT A" severity error;
			end if;
			Acc_enable <= '0';
			Write_enable <= '0';
			Input_enable <= '0';
			wait for I_clk_period;
	end procedure Check_Read_ACC;
	--Check read for normal registers
	procedure Check_Read(
	constant Ra_read : in std_logic_vector(4 downto 0);
	constant Rb_read : in std_logic_vector(4 downto 0);
	constant Ra_Data_expected : in std_logic_vector(31 downto 0);
	constant Rb_Data_expected : in std_logic_vector(31 downto 0)
	) is

	begin
			Input_enable <= '1';
			Acc_enable <= '0';
			Write_enable <= '0';
			Ra <= Ra_read;
			Rb <= Rb_read;
			wait for I_clk_period;
			--Check output against expected result
			if OutputA = Ra_Data_expected then
			report "EXPECTED INCREMENT/DECREMENT RESULT ON OUTPUT A" severity error;
			end if;
			if OutputA /= Ra_Data_expected then
			report "UNEXPECTED INCREMENT/DECREMENT RESULT ON OUTPUT A" severity error;
			end if;
			if OutputB = Rb_Data_expected then
			report "EXPECTED INCREMENT/DECREMENT RESULT ON OUTPUT B" severity error;
			end if;
			if OutputB /= Rb_Data_expected then
			report "UNEXPECTED INCREMENT/DECREMENT RESULT ON OUTPUT B" severity error;
			end if;
			Acc_enable <= '0';
			Write_enable <= '0';
			Input_enable <= '0';
			wait for I_clk_period;
	end procedure Check_Read;
	
	
	begin		
		wait for I_clk_period/2;
		--Check for override
		Write_ACC("00000", X"0000000000000000");
		Check_Read_ACC("00000",'1',X"CCCCCCCC");
		Check_Read_ACC("00000",'0',X"CCCCDDDD");
		Check_Read_ACC("00001",'1',X"EEEEEEEE");
		Check_Read_ACC("00001",'0',X"EFFFFFFF");
		--Check for Accumulation
		Write_ACC("00000", X"1111111111111111");
		Check_Read_ACC("00000",'1',X"DDDDDDDD");
		Check_Read_ACC("00000",'0',X"DDDDEEEE");
		--Check for Register incrementation and decrementation
		Check_Read("00000", "00001", X"FFFFFFFA",X"00000002");
 
      wait;
   end process;
	
end behavior;
