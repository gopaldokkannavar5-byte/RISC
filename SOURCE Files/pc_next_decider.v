module pc_next_decider(
    input [31:0] PCPlus4,PCTarget,
    input PCSrc,
    output [31:0] PCNext  
);

  assign PCNext= (PCSrc) ? PCTarget : PCPlus4 ;

endmodule