module main_control_unit(
    input [6:0] op,
    input Zero,
    output reg ResultSrc,MemWrite,ALUSrc,RegWrite,PCSrc,
    output reg [1:0] ALUOp,
    output reg [1:0] ImmSrc
);

 reg Branch ,Jump; 

always @ (*) 
begin 
    Jump = 1'b0;
    Branch = 1'b0;
    RegWrite = 1'b0;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    RegWrite = 1'b0;
    ALUOp = 2'b00;
    ImmSrc = 3'b000;

    case(op)
        //R-type
       7'b011011: 
        begin
            RegWrite = 1'b1;
            ALUSrc = 1'b0; 
            MemWrite = 1'b0;
            ResultSrc = 2'b00 ; 
            Branch = 1'b0;
            ALUOp = 2'b10;
            Jump = 1'b0 ;
        end
       // I-type
       7'b0010011 : 
         begin 
            RegWrite = 1'b1;
            ImmSrc = 2'b00;
            ALUSrc = 1'b1 ; 
            MemWrite = 1'b0;
            ResultSrc = 2'b00 ; 
            Branch = 1'b0;
            ALUOp = 2'b10;
            Jump = 1'b0 ;
         end

        // Load (lw)
        7'b0000011: begin
            RegWrite = 1'b1;
            ImmSrc = 2'b00;
            ALUSrc = 1'b1 ; 
            MemWrite = 1'b0;
            ResultSrc = 2'b01 ; 
            Branch = 1'b0;
            ALUOp = 2'b00;
            Jump = 1'b0 ;
        end

        // Store (sw)
        7'b0100011: begin
            RegWrite = 1'b0;
            ImmSrc = 2'b01;
            ALUSrc = 1'b1 ; 
            MemWrite = 1'b1;
            Branch = 1'b0;
            ALUOp = 2'b00;
            Jump = 1'b0 ;
        end

        // Branch (beq)
        7'b1100011: begin
            RegWrite = 1'b0;
            ImmSrc = 2'b10;
            ALUSrc = 1'b0 ; 
            MemWrite = 1'b0;
            Branch = 1'b1;
            ALUOp = 2'b01;
            Jump = 1'b0 ;
        end

        //jal
        7'b1101111: begin 
            RegWrite = 1'b1;
            ImmSrc = 2'b11;
            MemWrite = 1'b0;
            ResultSrc = 2'b10 ; 
            Branch = 1'b0;
            Jump = 1'b1 ;
            end
         
        default : ;
    endcase

end

endmodule