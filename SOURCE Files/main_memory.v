module Data_memory(
    input CLK,WE,
    input [31:0] A,WD,
    output [31:0] RD
);
    
   reg [31:0] data_memory [0:63];
   integer i ;

   initial 
     begin
        data_memory [0] = 32'd100;
        data_memory [1] = 32'd250;
        data_memory [2] = 32'd500; 

        for(i = 3 ; i<64 ; i = i + 1)
          begin
            data_memory[i] = 32'b0 ;
          end
      end

    always @ (posedge CLK)
    begin 
        if(WE)
        begin
            data_memory[A[7:2]] <= WD ;
        end
    end

     assign RD = data_memory[A[7:2]] ;
        
endmodule