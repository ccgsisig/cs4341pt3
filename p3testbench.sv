module trafficLightTB;

  // Inputs
  logic clk;
  logic reset;
  logic ta;
  logic tb;

  // Outputs
  logic [1:0] la;
  logic [1:0] lb;

  // Instantiate the TrafficLightMachine
  trafficLightFSM uut (
    .clk(clk),
    .reset(reset),
    .ta(ta),
    .tb(tb),
    .la(la),
    .lb(lb)
  );

  // Generate a clock signal
  always #5 clk = ~clk;  // Toggle clk every 5 time units

  // Initialize inputs and simulate the behavior
  initial begin
    // Initialize signals
    clk = 0;
    reset = 0;
    ta = 0;
    tb = 0;

    // Apply reset
    reset = 1;
    #10; // Wait for 10 time units
    reset = 0;
    
    // Test the state machine behavior
    // Set different values for ta and tb
    ta = 0; tb = 0;
    #20;
    ta = 1; tb = 0;
    #20;
    ta = 0; tb = 1;
    #20;
    ta = 0; tb = 0;
    #20;
    
    // End the simulation
    $finish;
  end

  // Monitor the outputs
  initial begin
    $monitor("Time = %0t, la = %b, lb = %b, ta = %b, tb = %b", $time, la, lb, ta, tb);
  end

endmodule
