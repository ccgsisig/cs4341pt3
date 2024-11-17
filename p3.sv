module FSMtrafficproblem(
    input logic clk, reset, ta, tb,         // Inputs: clk (clock), reset, ta (sensor for road A), tb (sensor for road B)
    output logic [1:0] la, lb               // Outputs: la (traffic light state for road A), lb (traffic light state for road B)
);

// Define the states of the FSM using an enumerated type
typedef enum logic [1:0] {S0, S1, S2, S3} statetype;  // Four states: S0, S1, S2, and S3
statetype [1:0] state, nextstate;                      // State register and next state logic

// Define parameters for the traffic light colors using 2-bit binary encoding
parameter green = 2'b00;      // Green light = 00
parameter yellow = 2'b01;     // Yellow light = 01
parameter red = 2'b10;        // Red light = 10

// State Register: Updates the current state on each clock edge
always_ff @(posedge clk, posedge reset)  // Triggered on rising edge of clk or reset
    if (reset) 
        state <= S0;                     // If reset is high, set state to S0 (initial state)
    else 
        state <= nextstate;              // Otherwise, transition to the next state

// Next State Logic: Defines the conditions for state transitions based on inputs (ta and tb)
always_comb  // Always block for combinational logic
    case (state)
        S0: 
            if (ta)                    // If sensor ta is active, stay in S0
                nextstate = S0;
            else                       // If sensor ta is not active, transition to S1
                nextstate = S1;
        S1: nextstate = S2;              // From S1, always transition to S2
        S2: 
            if (tb)                    // If sensor tb is active, stay in S2
                nextstate = S2;
            else                       // If sensor tb is not active, transition to S3
                nextstate = S3;
        S3: nextstate = S0;              // From S3, always transition back to S0 (cycle restarts)
    endcase

// Output Logic: Defines the traffic light signals based on the current state
always_comb
  case (state)
      S0: la = green;   // In state S0, set A to green and B to red
      S1: la = yellow;  // In state S1, set A to yellow and B to red
      S2: la = red; // In state S2, set A to red and B to green
      S3: la = red; // In state S3, set A to red and B to yellow
  endcase

always_comb
  case (state)
      S0: lb = red; // In state S0, set A to green and B to red
      S1: lb = red; // In state S1, set A to yellow and B to red
      S2: lb = green;   // In state S2, set A to red and B to green
      S3: lb = yellow;  // In state S3, set A to red and B to yellow
  endcase

endmodule
