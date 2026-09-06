module write_back (
    input [31:0] ALUResult, ReadData, PCPlus4,
    input  ResultSrc,
    output wire [31:0] Result
);
   assign Result = (ResultSrc == 1'b1) ? ReadData : PCPlus4;
endmodule