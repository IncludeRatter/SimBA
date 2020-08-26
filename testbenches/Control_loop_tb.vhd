library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_loop_tb is
end Control_loop_tb;
 
architecture Behavioral of Control_loop_tb is
COMPONENT Control_loop
  Port ( 
			I_clk : in  STD_LOGIC;
         I_reset : in  STD_LOGIC;
         O_first_state : out  STD_LOGIC;
			O_second_state : out  STD_LOGIC;
			O_third_state : out  STD_LOGIC;
			O_fourth_state : out  STD_LOGIC;
			O_fifth_state : out STD_LOGIC
         );
END COMPONENT;
  signal First_state: std_logic;
  signal Second_state: std_logic;
  signal Third_state: std_logic;
  signal Fourth_state: std_logic;
  signal Fifth_state: std_logic;
  signal Clk : std_logic := '0';
  signal Reset : std_logic := '0';
  constant I_clk_period : time := 10 ns;
begin
	uut_reg: Control_loop PORT MAP ( 
			I_clk => Clk,
         I_reset => Reset,
         O_first_state => First_state,
			O_second_state => Second_state,
			O_third_state => Third_state,
			O_fourth_state => Fourth_state,
			O_fifth_state => Fifth_state
         );
   -- Clock process definitions
   I_clk_process :process
   begin
		Clk <= '0';
		wait for I_clk_period/2;
		Clk <= '1';
		wait for I_clk_period/2;
   end process;
  stim_proc: process
  begin
  Reset <= '0';
  wait;
  end process;
end Behavioral;