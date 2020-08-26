library ieee;
library work;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;
	
	

entity Register_file_tb is
end Register_file_tb;
architecture behavior of Register_file_tb is

COMPONENT Register_file
	PORT
	(
		--Input ports
		I_clk		:	 IN STD_LOGIC;
		I_en_reg_file		:	 IN STD_LOGIC;
		I_we_reg_file		:	 IN STD_LOGIC;
		I_selA		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selB		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_selC		:	 IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		I_dataC		:	 IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		I_SXT_B_SEL : IN STD_LOGIC;
		I_SXT_B_DATA : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		--Output ports
		O_dataA		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataB		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		O_dataMEM		:	 OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

-- Internal signals
 signal Clk : std_logic := '0';
 signal Input_enable: std_logic;
 signal Write_enable : std_logic;
 signal Ra : std_logic_vector(4 downto 0);
 signal Rb : std_logic_vector(4 downto 0);
 signal Rc : std_logic_vector(4 downto 0);
 signal WriteData : std_logic_vector(31 downto 0);
 signal OutputA : std_logic_vector(31 downto 0);
 signal OutputB : std_logic_vector(31 downto 0);
 --accumulator signals
 
 --sign extension
  signal SXT : std_logic := '0';
  signal SXT_DATA : std_logic_vector(15 downto 0);
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
		I_SXT_B_SEL => SXT,
		I_SXT_B_DATA =>SXT_DATA,
		I_dataC => WriteData,
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
	procedure WriteRegister(
	constant Rc_destination : in std_logic_vector(4 downto 0);
	constant Data_to_Write : in std_logic_vector(31 downto 0)
	) is
	begin
		Write_enable <= '1';
		Rc <= Rc_destination;
		WriteData <= Data_to_Write;
		wait for I_clk_period;
	end procedure WriteRegister;
	--procedura odczytywania wartosci z rejestru i sprawdzania czy jest ok
	procedure CheckReadRegister(
	constant Ra_read_register : in std_logic_vector(4 downto 0);
	constant Rb_read_register : in std_logic_vector(4 downto 0);
	constant Ra_data_expected : in std_logic_vector(31 downto 0);
	constant Rb_data_expected : in std_logic_vector(31 downto 0)
	) is
	begin
		Input_enable <= '1';
		Write_enable <= '0';
		Ra <= Ra_read_register;
		Rb <= Rb_read_register;
		wait for I_clk_period;
		if OutputA = Ra_data_expected then
		report "EXPECTED RESULT ON OUTPUT A" severity error;
		end if;
		if OutputA /= Ra_data_expected then
		report "UNEXPECTED RESULT ON OUTPUT A" severity error;
		end if;
		if OutputB = Rb_data_expected then
		report "EXPECTED RESULT ON OUTPUT B" severity error;
		end if;
		if OutputB /= Rb_data_expected then
		report "UNEXPECTED RESULT ON OUTPUT B" severity error;
		end if;
	end procedure CheckReadRegister;
   begin		

      wait for 100 ns;  

		WriteRegister("00000",X"FAB5FAB5");
		wait for I_clk_period;
		WriteRegister("00010",X"22222222");
		wait for I_clk_period;
		WriteRegister("00011",X"33333333");
		wait for I_clk_period;
		WriteRegister("00100",X"44444444");
		wait for I_clk_period;
		CheckReadRegister("00000","00010",X"FAB5FAB5",X"22222222");
		wait for I_clk_period;
		CheckReadRegister("00011","00100",X"33333333",X"44444444");
		wait for I_clk_period;

 
      wait;
   end process;
	
end behavior;
