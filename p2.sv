module testbench4_4();
    // Declare inputs and outputs for the testbench
    logic clk, reset;                    // Clock and reset signals
    logic [3:0] a;                       // 4-bit input vector 'a' for the DUT (Device Under Test)
    logic y, yexpected;                  // Output signal from the DUT (y) and the expected output (yexpected)
    logic [31:0] vectornum, errors;     // Counter for test vectors and error count
    logic [4:0] testvectors[10000:0];   // Array to store test vectors (each test vector has 5 bits)

    // Instantiate the Device Under Test (DUT)
    fourInputXor dut (
        .a(a),    // Connect input 'a' to the DUT
        .y(y)     // Connect output 'y' from the DUT
    );

    // Generate a clock signal with a period of 10 time units (5 high, 5 low)
    always begin
        clk = 1; #5; clk = 0; #5;  // Toggle the clock every 5 time units
    end

    // Initialize the testbench: Load test vectors, pulse reset, and start the simulation
    initial begin
        $readmemb("vector.tv", testvectors);  // Load the test vectors from a file (vector.tv)
        vectornum = 0;  // Initialize the vector number (index) to 0
        errors = 0;     // Initialize the error counter to 0
        reset = 1;      // Assert reset at the start
        #27;            // Wait for 27 time units to simulate reset pulse duration
        reset = 0;      // Deassert reset after waiting
    end

    // Apply test vectors on the rising edge of the clock
    always @(posedge clk) begin
        #1;  // Small delay to ensure stable propagation of signals
        {a, yexpected} = testvectors[vectornum];  // Load current test vector (a, expected output yexpected)
    end

    // Check the DUT output on the falling edge of the clock
    always @(negedge clk) begin
        if (~reset) begin  // Skip the checks during reset
            // Check if the output matches the expected value
            if (y != yexpected) begin  // If actual output doesn't match expected output
                // Display error details
                $display("Error: inputs = %b", {a[3], a[2], a[1], a[0]});  // Print the input vector
                $display("        outputs = %b (%b expected)", y, yexpected);  // Print the actual and expected outputs
                errors = errors + 1;  // Increment the error counter
            end
            vectornum = vectornum + 1;  // Move to the next test vector
            // Check if all test vectors have been applied
            if (testvectors[vectornum] === 5'bx) begin  // If the next test vector is undefined (5'bx)
                // Print test completion status and number of errors
                $display("%d tests completed with %d errors", vectornum, errors);
                $finish;  // End the simulation
            end
        end
    end

    // Optional: Save the waveform signals to a VCD (Value Change Dump) file for further analysis in tools like EDAplayground
    initial begin
        $dumpfile("dump.vcd");  // Specify the output file for the waveform dump
        $dumpvars(1);           // Dump all variables at level 1 of the hierarchy
    end

endmodule
