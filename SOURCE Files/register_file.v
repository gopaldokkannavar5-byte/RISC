module register_file(
    input CLK,
    input [4:0] A1,A2,A3,
    input [31:0] WD,
    input WE3,
    output [31:0] RD1,RD2
);
    reg [31:0] register_file [0:31];

    //initialising memory to zero
    integer i;
    initial begin
        for(i=0 ; i<32 ; i = i + 1) 
           begin
            if ( i == 0)
            register_file [i] = 32'b0;
            else
             register_file[i] = 32'b0;
           end
    end
    // reading
     assign RD1  = (A1 != 5'b0) ? register_file[A1] : 32'b0 ;   
     assign RD2  = (A2 != 5'b0) ? register_file[A2] : 32'b0 ;
     // writing 
     always @(posedge CLK )
       begin 
        if(WE3 && (A3 != 5'b0))
        begin
            register_file[A3] <= WD;
        end
       end

endmodule