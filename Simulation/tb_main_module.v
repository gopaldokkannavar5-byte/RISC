`timescale 1ns / 1ps

module tb_main_module();

    // Testbench signals
    reg CLK;
    wire [31:0] ALU_out;

    // Instantiate the Unit Under Test (UUT)
    main_module uut (
        .CLK(CLK),
        .ALU_out(ALU_out)
    );

    // Clock Generation
    // Toggles the clock every 5 time units (10ns period -> 100 MHz frequency)
    always begin
        #5 CLK = ~CLK;
    end

    // Test Sequence and Monitoring
    initial begin
        // Initialize the clock
        CLK = 0;

        // Display a header for the simulation output
        $display("Time (ns) | PC       | Instruction | ALU_out (Decimal)");
        $display("------------------------------------------------------");

        // Monitor internal signals to watch the processor execute
        // Note: Using dot notation (uut.PC) allows us to peek inside the main_module
        $monitor("%9d | %8h | %11h | %17d", 
                 $time, uut.PC, uut.Instr, ALU_out);

        // Allow enough time for all instructions in your instruction_memory to execute.
        // Cycle 1: addi x1, x0, 5
        // Cycle 2: addi x2, x0, 10
        // Cycle 3: add x3, x1, x2 (ALU_out should become 15)
        #50;

        // End the simulation
        $display("Simulation complete.");
        $finish;
    end

endmodule