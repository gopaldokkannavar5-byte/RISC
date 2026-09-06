# RISC-V Single-Cycle Processor in Verilog

A 32-bit RISC-V (RV32I) single-cycle processor implemented in Verilog, targeting the Digilent Basys 3 FPGA (Artix-7).

---

## Table of Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Important Implementation Notes](#important-implementation-notes)
- [Prerequisites](#prerequisites)
- [Simulation Guide](#simulation-guide)
- [FPGA Implementation Guide](#fpga-implementation-guide)
- [License](#license)

---

## Features

- **Architecture:** 32-bit single-cycle data path and control unit
- **Hardware Description Language:** Verilog
- **Target FPGA:** Digilent Basys 3 (Artix-7)
- **Supported Instructions:**

  | Category | Instructions |
  |---|---|
  | Arithmetic | `add`, `sub`, `addi` |
  | Logical | `and`, `or` |
  | Memory Access | `lw` (Load Word), `sw` (Store Word) |
  | Control Flow | `beq` (Branch if Equal), `jal` (Jump and Link) |

---

## Project Structure

| File | Description |
|---|---|
| `main_module.v` | Top-level CPU wrapper connecting the datapath and control unit |
| `PC.v` | Program counter register |
| `pc_adder.v` | Sequential PC update (PC + 4) |
| `pc_target.v` | Branch target address calculation |
| `pc_next_decider.v` | Selects next PC source (sequential vs. branch/jump) |
| `ALU_main.v` | Arithmetic Logic Unit |
| `Alu_control_unit.v` | Decodes ALU operation from instruction fields |
| `ALU_mux.v` | Selects ALU operand sources |
| `main_control_unit.v` | Generates mux-select and write-enable signals from the opcode |
| `register_file.v` | 32x32-bit integer register file |
| `immediate_gen.v` | Sign-extension for I, S, B, and J instruction formats |
| `instr_mem.v` | Instruction memory |
| `main_memory.v` | Data memory |
| `write_back.v` | Routes data back to the register file (standard ops and JAL) |
| `basys3_connector.v` | Top module for FPGA implementation, including the clock divider |
| `basys3_constraints.xdc` | Xilinx physical constraint file mapping I/O to the Basys 3 board |
| `tb_main_module.v` | Testbench for behavioral simulation |

---

## Important Implementation Notes

### Program Counter Initialization

To prevent simulation from getting stuck in an unknown state (`XXXXXXXX`), the `program_counter` module uses an inline `initial` block to force the PC to start at `32'b0`. This lets instruction memory fetch the first valid instruction on startup without requiring an external hardware reset signal.

### Clock Divider & Simulation

The top-level FPGA connector (`basys3_connector.v`) includes a 25-bit counter that divides the 100 MHz board clock down to a slow clock for the CPU.

> **Do not simulate `basys3_connector.v` directly** — it would take millions of simulated cycles to produce a single CPU clock tick. Always use `tb_main_module.v` as the top module for simulation; it bypasses the divider and feeds a clock directly to the CPU.

---

## Prerequisites

- [Xilinx Vivado](https://www.xilinx.com/products/design-tools/vivado.html) (WebPACK / ML Standard Edition is free)
- (Optional) A Digilent Basys 3 FPGA board for physical hardware testing

---

## Simulation Guide

1. **Clone this repository:**

   ```bash
   git clone https://github.com/Nithish-Reddy360/riscv-single-cycle-core.git
   ```

2. Open Vivado and create a new project.
3. Add all `.v` files to **Design Sources**.
4. Add `basys3_constraints.xdc` to **Constraints**.
5. Add `tb_main_module.v` to **Simulation Sources**.
6. **Crucial step:** right-click `tb_main_module.v` in the Sources pane and select **Set as Top**.
7. Click **Run Simulation → Run Behavioral Simulation**.
8. In the waveform window, expand the `uut` scope and drag internal signals (e.g. `PC`, `Instr`, `SrcA`, `SrcB`, `ALUResult`) into the viewer to verify execution.

---

## FPGA Implementation Guide

1. In Vivado, set `basys3_connector.v` as the **Top Module** for synthesis.
2. Click **Generate Bitstream**.
3. Open the **Hardware Manager**, connect your Basys 3 board, and click **Program Device**.

The processor's lower 16 bits of ALU output are mapped directly to the 16 on-board LEDs.

---

## License

Add a license (e.g. MIT) here if you intend for others to reuse this code.
