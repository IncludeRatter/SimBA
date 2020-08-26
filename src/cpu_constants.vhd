library IEEE;
use IEEE.STD_LOGIC_1164.all;

package cpu_constants is
--Two class of instructions:
--1) OPCODE(6-bit);Rc(5-bit);Ra(5-bit);Rb(5-bit);UNUSED(11-bit)     Reg[Rc] <- Reg[Ra] op Reg[Rb]
--2) OPCODE(6-bit);Rc(5-bit);Ra(5-bit); Signde literal const (16-bit) Reg[Rc] <- Reg[Ra] op SXT(C) and for memory operations


--OPCODES
constant OPCODE_ADD: 			std_logic_vector(5 downto 0) := "000000"; --ADD
constant OPCODE_SUB:    		std_logic_vector(5 downto 0) := "000001";	-- SUB 
constant OPCODE_MUL:     		std_logic_vector(5 downto 0) := "000010";	-- MUL 
constant OPCODE_DIV:    		std_logic_vector(5 downto 0) := "000011";	-- DIV 
constant OPCODE_CMPEQ:    		std_logic_vector(5 downto 0) := "000100";	--  
constant OPCODE_CMPLE:    		std_logic_vector(5 downto 0) := "000101";	--  
constant OPCODE_CMLT:   		std_logic_vector(5 downto 0) := "000110";	--  
constant OPCODE_AND:  			std_logic_vector(5 downto 0) := "000111";	--  
constant OPCODE_OR:   			std_logic_vector(5 downto 0) := "001000";	--  
constant OPCODE_XOR:    		std_logic_vector(5 downto 0) := "001001";	--  
constant OPCODE_XNOR:    		std_logic_vector(5 downto 0) := "001010";	--  
constant OPCODE_SHL:    		std_logic_vector(5 downto 0) := "001011";  --  
constant OPCODE_SHR:   			std_logic_vector(5 downto 0) := "001100";	--   
constant OPCODE_LD: 				std_logic_vector(5 downto 0) := "001101";	-- Reg[Rc] <- Mem[Reg[Ra]+SXT(C)] 
constant OPCODE_ST:   			std_logic_vector(5 downto 0) := "001110";	-- Reg[Rc] -> Mem[Reg[Ra]+SXT(C)] 
constant OPCODE_LDR:   			std_logic_vector(5 downto 0) := "001111";  -- Reg[Rc] <- Mem[PC + 1 + SXT(C)]  
constant OPCODE_BEQ:				std_logic_vector(5 downto 0) := "010000";  -- Reg[Rc] <- PC+4; if Reg[Ra] = 0 then PC <- PC + 1 + SXT(C)
constant OPCODE_BNE:				std_logic_vector(5 downto 0) := "010001";  -- Reg[Rc] <- PC+4; if Reg[Ra] != 0 then PC <- PC + 1 + SXT(C)
constant OPCODE_JMP:				std_logic_vector(5 downto 0) := "010010";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_INC:				std_logic_vector(5 downto 0) := "010011";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_BALB:			std_logic_vector(5 downto 0) := "010100";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_BALEB:			std_logic_vector(5 downto 0) := "010101";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_BZB:				std_logic_vector(5 downto 0) := "010110";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_BZA:				std_logic_vector(5 downto 0) := "010111";  -- Reg[Rc] <- PC+4; PC <- Reg[Ra]
constant OPCODE_LD_Y:			std_logic_vector(5 downto 0) := "011000";  -- 
constant OPCODE_ST_Y:			std_logic_vector(5 downto 0) := "011001";  --
constant OPCODE_MAC: 			std_logic_vector(5 downto 0) := "011010";
constant OPCODE_ACC_HIGH_OUT:	std_logic_vector(5 downto 0) := "011011";
constant OPCODE_ACC_LOW_OUT:	std_logic_vector(5 downto 0) := "011100";
constant OPCODE_MAC_REP:		std_logic_vector(5 downto 0) := "011101";
--cmp flags
constant CMP_BIT_EQ: 	integer := 0;
constant CMP_BIT_ALEB: 	integer := 1;
constant CMP_BIT_ALB: 	integer := 2;
constant CMP_BIT_AZ: 	integer := 3;
constant CMP_BIT_BZ: 	integer := 4;
constant CMP_BIT_NEQ : 	integer := 5;


end cpu_constants;

package body cpu_constants is
 
end cpu_constants;