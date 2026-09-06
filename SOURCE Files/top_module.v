module basys3_connector(
    input clk_100Mhz,
    input reset, // Kept the input port, but it is no longer wired to the CPU
    output [15:0] led 
);

    reg [25:0] counter = 0; // Initialized to prevent 'X' states
    
    always @(posedge clk_100Mhz) begin
        counter <= counter + 1;
    end

    wire slow_clk = counter[25];
    wire [31:0] proccesor_out;

    main_module my_cpu (
        .CLK(slow_clk),
        .ALU_out(proccesor_out) // Reset wiring removed
    );

    assign led = proccesor_out[15:0];

endmodule