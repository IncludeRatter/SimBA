library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

	library work;
use work.cpu_constants.all;


entity Control_loop is
  Port ( 
			I_clk : in  STD_LOGIC;
         I_reset : in  STD_LOGIC;
			I_instruction : in std_logic_vector(5 downto 0);
			O_PC_wait : out std_logic;
         O_first_state : out  STD_LOGIC;
			O_second_state : out  STD_LOGIC;
			O_third_state : out  STD_LOGIC;
			O_fourth_state : out STD_LOGIC;
			O_fifth_state : out STD_LOGIC
         );
end Control_loop;
 
architecture Behavioral of Control_loop is
  signal s_state: integer := 0;
  signal s_rep_counter: integer := 0;
  signal s_first_state: std_logic;
  signal s_second_state: std_logic;
  signal s_third_state: std_logic;
  signal s_fourth_state: std_logic;
  signal s_fifth_state: std_logic;
begin
  process(I_clk)
  begin
    if rising_edge(I_clk) then
      if I_reset = '1' then
        s_state <= 0;
      else
			case I_instruction is
				when OPCODE_MAC_REP =>
					O_PC_wait <= '1';
					case s_state is
						when 0 =>
							s_rep_counter <= s_rep_counter + 1;
							s_first_state <= '0';
							s_second_state <= '1';--regread
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 1 =>
							s_rep_counter <= s_rep_counter + 1;
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '1';--mem_access (DATA TO MAC
							s_fifth_state <= '0';
						when 2 =>
							s_rep_counter <= s_rep_counter + 1;
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '1';--MAC execute
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 3 =>
							s_rep_counter <= s_rep_counter + 1;
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';	
							s_fifth_state <= '1';--MAC output witeback
						when others =>
				  end case;
					if I_reset = '0' then
						s_state <= s_state + 1;
					end if;
					if s_state = 3 then
						s_state <= 0;
						s_first_state <= '0';
						s_second_state <= '0';
						s_third_state <= '0';
						s_fourth_state <= '0';	
						s_fifth_state <= '1';--MAC output witeback
					end if;
					if s_rep_counter = 9 then
					O_PC_wait <= '0';
					end if;
				when OPCODE_MAC =>
					case s_state is
						when 0 =>
							s_first_state <= '1';--fetch
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 1 =>
							s_first_state <= '0';
							s_second_state <= '1';--regread
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 2 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '1';--mem access (DATA TO MAC)
							s_fifth_state <= '0';
						when 3 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '1';--MAC execute
							s_fourth_state <= '0';	
							s_fifth_state <= '0';
						when 4 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';	
							s_fifth_state <= '1';--MAC output witeback
						when others =>
				  end case;
					if I_reset = '0' then
						s_state <= s_state + 1;
					end if;
					if s_state = 4 then
						s_state <= 0;
						s_first_state <= '0';
						s_second_state <= '0';
						s_third_state <= '0';
						s_fourth_state <= '0';	
						s_fifth_state <= '1';--MAC output witeback
					end if;
				when OPCODE_ADD =>
					case s_state is
						when 0 =>
							s_first_state <= '1';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 1 =>
							s_first_state <= '0';
							s_second_state <= '1';
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 2 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '1';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 3 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';	
							s_fifth_state <= '1';
						when others =>
				  end case;
					if I_reset = '0' then
						s_state <= s_state + 1;
					end if;
					if s_state = 3 then
						s_state <= 0;
						s_first_state <= '0';
						s_second_state <= '0';
						s_third_state <= '0';
						s_fourth_state <= '0';
						s_fifth_state <= '1';
					end if;
				when others =>
					case s_state is
						when 0 =>
							s_first_state <= '1';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 1 =>
							s_first_state <= '0';
							s_second_state <= '1';
							s_third_state <= '0';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 2 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '1';
							s_fourth_state <= '0';
							s_fifth_state <= '0';
						when 3 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '1';	
							s_fifth_state <= '0';
						when 4 =>
							s_first_state <= '0';
							s_second_state <= '0';
							s_third_state <= '0';
							s_fourth_state <= '0';	
							s_fifth_state <= '1';
						when others =>
					end case;
					if I_reset = '0' then
						s_state <= s_state + 1;
					end if;
					if s_state = 4 then
						s_state <= 0;
						s_first_state <= '0';
						s_second_state <= '0';
						s_third_state <= '0';
						s_fourth_state <= '0';
						s_fifth_state <= '1';
					end if;
			end case;
		end if;
	end if;	
  end process;
  O_first_state <= s_first_state;
  O_second_state <= s_second_state;
  O_third_state <= s_third_state;
  O_fourth_state <= s_fourth_state;
  O_fifth_state <= s_fifth_state;
end Behavioral;