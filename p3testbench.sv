module testbenchFSMTrafficProblem;

  // Declare inputs to the FSM traffic light controller
  logic clk;     // Clock signal
  logic reset;   // Reset signal to initialize the state machine
  logic ta;      // Traffic sensor for road A
  logic tb;      // Traffic sensor for road B

  // Declare outputs from the FSM traffic light controller
  logic [1:0] la; // Light signal for road A (00: Red, 01: Yellow, 10: Green)
  logic [1:0] lb; // Light signal for road B (00: Red, 01: Yellow, 10: Green)

  // Instantiate the FSM traffic light controller (DUT: Device Under Test)
  trafficProblemFSM uut (
    .clk(clk),     // Connect the clock input
    .reset(reset), // Connect the reset input
    .ta(ta),       // Connect the traffic sensor input for road A
    .tb(tb),       // Connect the traffic sensor input for road B
    .la(la),       // Connect the light output for road A
    .lb(lb)        // Connect the light output for road B
  );

  // Generate a periodic clock signal
  always #5 clk = ~clk;  // Toggle clk every 5 time units to simulate a clock signal

  // Initialize inputs and define the test scenarios
  initial begin
    // Initialize all input signals to default values
    clk = 0;    // Initialize the clock to 0
    reset = 0;  // Ensure reset is inactive
    ta = 0;     // No traffic on road A initially
    tb = 0;     // No traffic on road B initially

    // Apply reset to initialize the state machine
    reset = 1;   // Activate reset
    #10;         // Wait for 10 time units
    reset = 0;   // Deactivate reset
    
    // Test case 1: No traffic on either road
    ta = 0; tb = 0;
    #20; // Wait for 20 time units

    // Test case 2: Traffic on road A but not on road B
    ta = 1; tb = 0;
    #20; // Wait for 20 time units

    // Test case 3: Traffic on road B but not on road A
    ta = 0; tb = 1;
    #20; // Wait for 20 time units

    // Test case 4: No traffic on either road again
    ta = 0; tb = 0;
    #20; // Wait for 20 time units
    
    // End the simulation
    $finish; // Terminate simulation after all test cases
  end

  // Monitor and display the values of inputs and outputs during simulation
  initial begin
    $monitor("Time = %0t, la = %b, lb = %b, ta = %b, tb = %b", $time, la, lb, ta, tb);
    // Outputs include:
    // la - Light for road A
    // lb - Light for road B
    // ta - Traffic presence on road A
    // tb - Traffic presence on road B
  end

endmodule
