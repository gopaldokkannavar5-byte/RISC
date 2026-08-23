// memory.sv

module memory #(
    parameter WORDS = 64
) (
    input  clk,
    input [31:0] address,
    input  [31:0] write_data,
    input  write_enable,
    input  rst_n,

    output [31:0] read_data
);

/*
* This memory is byte addressed
* But have no support for mis-aligned write nor reads.
*/

reg [31:0] mem [0:WORDS-1];  // Memory array of words (32-bits)

always @(posedge clk) begin
    // reset logic
    if (rst_n == 1'b0) begin
        for (int i = 0; i < WORDS; i++) begin
            mem[i] <= 32'b0;  
        end
    end
    else if (write_enable) begin
        // Ensure the address is aligned to a word boundary
        // If not, we ignore the write
        if (address[1:0] == 2'b00) begin 
            //here, address[31:2] is the word index
            mem[address[31:2]] <= write_data;
        end
    end
end

// Read logic
  always@(*) begin
    //here, address[31:2] is the word index
    read_data = mem[address[31:2]]; 
end

endmodule
