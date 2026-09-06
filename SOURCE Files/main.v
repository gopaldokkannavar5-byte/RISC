module main_module (
   input CLK,
   output [31:0] ALU_out 
);
    wire [31:0] PC, PCNext, PCPlus4, Instr; 
    wire MemWrite, ALUSrc, RegWrite, PCSrc;
    wire [1:0] ResultSrc; 
    wire [1:0] ALUOp;
    wire [1:0] ImmSrc;    
    wire [31:0] RD1, RD2, ImmExt;
    wire [2:0] ALUControl; 
    wire [31:0] SrcB;      
    wire [31:0] ALUResult; 
    wire [31:0] PCTarget;  
    wire Zero; 
    wire [31:0] read_data, Result; 

   pc_next_decider pc_mux( 
      .PCPlus4(PCPlus4), 
      .PCTarget(PCTarget), 
      .PCSrc(PCSrc), 
      .PCNext(PCNext)
    );

    program_counter pc_value( 
      .PCNext(PCNext),
      .CLK(CLK),
      .PC(PC) // Reset removed here
    );
   
   adder_32bit pc_Adder ( 
      .PC(PC),
      .PCPlus4(PCPlus4)
   );

   instruction_memory IMM_Mem ( 
      .A(PC),
      .RD(Instr)
   );

   main_control_unit Control_unit ( 
      .op(Instr[6:0]),
      .Zero(Zero),
      .RegWrite(RegWrite),
      .MemWrite(MemWrite),
      .ALUSrc(ALUSrc),
      .ResultSrc(ResultSrc),
      .PCSrc(PCSrc),
      .ImmSrc(ImmSrc),
      .ALUOp(ALUOp) 
   );

   register_file RF(
      .CLK(CLK),
      .WE3(RegWrite),
      .A1(Instr[19:15]),
      .A2(Instr[24:20]),
      .A3(Instr[11:7]),
      .WD(Result),
      .RD1(RD1),
      .RD2(RD2)
   );
   
   immediate_gen imm_gen (
      .Instr(Instr),
      .ImmSrc(ImmSrc),
      .ImmExt(ImmExt)
   );

   pc_target PCTarget_adder ( 
      .PC(PC),
      .ImmExt(ImmExt),
      .PCTarget(PCTarget)
   );

   ALU_mux src_b_mux ( 
      .RD2(RD2),
      .ImmExt(ImmExt),
      .ALUSrc(ALUSrc),
      .SrcB(SrcB)
   );

   Alu_control_unit alu_ctrl(
      .ALUOp(ALUOp),
      .funct3(Instr[14:12]),
      .funct7(Instr[30]),
      .op(Instr[5]), 
      .ALUControl(ALUControl)
   );

   ALU alu_main (
      .SrcA(RD1), 
      .SrcB(SrcB),
      .ALUControl(ALUControl),
      .ALUResult(ALUResult),
      .Zero(Zero)
   );

   Data_memory data_memory(
      .CLK(CLK),
      .WE(MemWrite),
      .A(ALUResult), 
      .WD(RD2),      
      .RD(read_data)
   );

   write_back wb(
      .ALUResult(ALUResult),
      .ReadData(read_data), 
      .PCPlus4(PCPlus4),    
      .ResultSrc(ResultSrc),
      .Result(Result)
   );

   assign ALU_out = ALUResult;

endmodule