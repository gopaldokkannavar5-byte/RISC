module ALU (
    input [31:0] SrcA,SrcB ,
    input [2:0] ALUControl,
    output  reg [31:0] ALUResult,
    output  wire Zero

);
  
 always @(*) 
 begin
    case(ALUControl)
       3'b000 : ALUResult = SrcA + SrcB;
       3'b001 : ALUResult = SrcA - SrcB;
      //  3'b0001 : Result = A << B[4:0];
      3'b101 : ALUResult = ($signed(SrcA) < $signed(SrcB)) ? 1 : 0 ; //signed comparison
      //  3'b0011 : Result = (A < B) ? 1 : 0 ; //Unsigned comparison 
      //  3'b0100 : Result = A ^ B ; // xor
      //  3'b0101 : Result = A >> B[4:0]; // shift right 
       3'b011 : ALUResult = SrcA | SrcB ; // or 
       3'b010 : ALUResult = SrcA & SrcB ; //and
      //  3'b1101 : Result = $signed(A) >>> B[4:0]; 
         
     default : ALUResult = 32'b0;
    endcase
 end

  assign Zero = (ALUResult == 32'b0) ? 1 : 0 ;

endmodule