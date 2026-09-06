module Alu_control_unit(
    input[1:0] ALUOp,
    input [2:0]funct3,
    input funct7,
    input op ,
    output reg [2:0] ALUControl
);

   always @(*)
   begin
    case(ALUOp)
      2'b00 : ALUControl = 3'b000; // load or store
      2'b01 : ALUControl = 3'b001; // branch 
      2'b10 :     // R or I type 
          begin
            case(funct3)
                3'b000 : ALUControl = (op&funct7) ? 3'b001 : 3'b000;    // subraction or additon
                // 3'b001 : ALUControl = 3'b0001 ; // shift less logical  
                3'b010 : ALUControl = 3'b101 ; // set less than
                // 3'b011 : ALUControl = 4'b0011 ; // set less than unsigned 
                // 3'b100 : ALUControl = 3'b0100 ; // xor 
                // 3'b101 : ALUControl = (funct7) ? 4'b1101 : 4'b0101 ; // SRA or SLA 
                3'b110 : ALUControl = 3'b011 ; //or
                3'b111 : ALUControl = 3'b010 ; //and
                
            default : ALUControl = 3'b000;
            endcase
          end 
      default : ALUControl = 3'b000;
    endcase
   end

endmodule