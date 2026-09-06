module program_counter(
input CLK,
input [31:0] PCNext,
output reg [31:0] PC
);
initial begin
        PC = 32'b0;
    end

    
always @ (posedge CLK) begin

        begin
            PC <= PCNext;
        end
    
end 
  

endmodule