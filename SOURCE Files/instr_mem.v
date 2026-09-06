module instruction_memory(
    input [31:0] A,
    output [31:0] RD

);

   reg [31:0] instr_memory [0:31] ;

    initial begin
        // 1. Initial immediate loads
         instr_memory[0] = 32'h00500093;  // pc = 0:  addi x1, x0, 5    (x1 = 5)
         instr_memory[1] = 32'h00A00113;  // pc = 4:  addi x2, x0, 10   (x2 = 10)
         
         // 2. Arithmetic operations
         instr_memory[2] = 32'h002081B3;  // pc = 8:  add x3, x1, x2    (x3 = 5 + 10 = 15)
         instr_memory[3] = 32'h40110233;  // pc = 12: sub x4, x2, x1    (x4 = 10 - 5 = 5)
         
         // 3. Logical operations
         instr_memory[4] = 32'h0020F2B3;  // pc = 16: and x5, x1, x2    (x5 = 5 & 10 = 0)
         instr_memory[5] = 32'h0020E333;  // pc = 20: or  x6, x1, x2    (x6 = 5 | 10 = 15)
         
         // 4. Memory operations
         instr_memory[6] = 32'h00302223;  // pc = 24: sw x3, 4(x0)      (Store 15 at memory address 4)
         instr_memory[7] = 32'h00402383;  // pc = 28: lw x7, 4(x0)      (Load memory address 4 into x7; x7 = 15)
    end

    assign RD = instr_memory[A[7:2]];

endmodule