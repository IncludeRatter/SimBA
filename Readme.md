# SimBA CPU written in VHDL
SimBA (Simple Bio Accelerator) is project for 32-bit processor designed for biomedical signal processing as a project on bachelor thesis.

# Main features
- Harvard memory architecture
- RISC instruction set with extension for digital signal processing
- MAC unit and modulo adressing for filtering operations
- Pipelined architecture for all RISC instructions and signal processing extensions

# Project structure
- src - VHDL source files for CPU
- testbenches - tests for each functional unit
- docs - block diagrams, wave simulations

# Available instructions
Following instructions are supported:
| Instruction |  Operation |
| ----------- |  --------- |
| ADD |  Reg[Rc] ← Reg[Ra] +  Reg[Rb] |
| SUB |  Reg[Rc] ← Reg[Ra] -  Reg[Rb] |
| CMPEQ |  If Reg[Ra] == Reg[Rb] then EQ_FLAG ← 1 else EQ_FLAG ← 0 |
| CMPLE |  If Reg[Ra] <= Reg[Rb] then LE_FLAG ← 1 else LE_FLAG ← 0 |
| AND |  Reg[Rc] ← Reg[Ra] AND Reg[Rb] |
| OR |  Reg[Rc] ← Reg[Ra] OR Reg[Rb] |
| XOR |  Reg[Rc] ← Reg[Ra] XOR Reg[Rb] |
| XNOR |  Reg[Rc] ← Reg[Ra] XNOR Reg[Rb] |
| LD_X |  MemX[Reg[Ra]] → Reg[Rc] |
| ST_X |  MemX[Reg[Ra]] ← Reg[Rb] |
| LD_Y |  MemY[Reg[Rb]] → Reg[Rc] |
| ST_Y |  MemY[Reg[Rb]] ← Reg[Ra] |
| BEQ |  If Reg[Ra] == Reg[Rb] then EQ_FLAG ← 1, PC ← PC + branch_address else EQ_FLAG ← 0 |
| BNE |  If Reg[Ra] != Reg[Rb] then NEQ_FLAG← 1, PC ← PC + branch_address else 
NEQ_FLAG ← 0 |
| BALB |  If Reg[Ra] < Reg[Rb] then ALB_FLAG←1, PC ← PC + branch_address else ALB_FLAG←0 |
| BALEB | If Reg[Ra] <= Reg[Rb] then ALEB_FLAG←1, PC ← PC + branch_address else
ALEB_FLAG←0 |
| BZB | If Reg[Rb] == 0 then BZ_FLAG←1, PC ← PC + branch_address else BZ_FLAG←0 |
| BZA | If Reg[Ra] == 0 then AZ_FLAG←1, PC ← PC + branch_address else AZ_FLAG←0 |
| MAC | ACC_reg ←MemX[Reg[Ra]] * MemX[Reg[Rb]], Reg[Ra]← Reg[Ra]+1, Reg[Rb]←Reg[Rb]-1|
| ACC_HIGH_OUT | Reg[Rc] ← ACC_reg(63:32)|
| ACC_LOW_OUT | Reg[Rc] ← ACC_reg(31:0)|
| ACC_CLEAR | ACC_reg ← 0|
| MAC_REP | ACC_reg ← MemX[Reg[Ra]] * MemX[Reg[Rb]], Reg[Ra]← Reg[Ra]+1, Reg[Rb]←Reg Rb]-1|
| CALL | MemX[SP]← PC, PC ← const, SP←SP+1|
| RET | SP←SP-1, PC ← MemX[SP]|
| PUSH | MemX[SP] ← Reg[Rb], SP←SP+1|
| POP | SP←SP-1, MemX[SP] → Reg[Rc]|
| ADDI | Reg[Rc] ← Reg[Ra] + const|
| SUBI | Reg[Rc] ← Reg[Ra] - const|
| CMPEQI | If Reg[Ra] == const then EQ_FLAG ← 1 else EQ_FLAG ← 0 |
| CMPLEI | If Reg[Ra] <= const then EQ_FLAG ← 1 else EQ_FLAG ← 0 |
| ANDI | Reg[Rc] ← Reg[Ra] AND const |
| ORI | Reg[Rc] ← Reg[Ra] OR const |
| XORI | Reg[Rc] ← Reg[Ra] XOR const |
| XNORI | Reg[Rc] ← Reg[Ra] XNOR const |
| JMP | PC ← Reg[Ra] |
| JMPI | PC ← const |
| STI_X | MemX[Reg[Ra]] ← const |
| STI_Y | MemY[Reg[Rb]] ← cosnt |

# CPU design diagram

Block diagrams are available in [documentation](docs/block_diagrams).

# Waveforms

Waveform simulations are available in [documentation](docs/wave_diagrams).

# Notes
This project has been developed with Quartus Prime software on Altera MAX10 FPGA.
RTL simulations has been done with Modelsim software.

Currently source for this CPU is undergoing some changes to support ghdl as primary method of compilation.