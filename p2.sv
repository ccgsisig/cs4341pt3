module testbenchXorFourInput;
  // Define a 4-bit logic vector 'x' as input to the XOR gate
  logic [3:0] x;
  
  // Define a single-bit logic 'y' as output from the XOR gate
  logic y;
  
  // Instantiate the device under test (DUT), which is the 4-input XOR gate
  xorFourInput dut (
    .a(x), // Connect 'x' to the input port 'a' of the DUT
    .y(y)  // Connect 'y' to the output port 'y' of the DUT
  );
  
  // Apply test cases to the DUT
  initial begin
    // Monitor changes in the input 'x' and the output 'y' and display them
    $monitor("Time = %0t, x = %b, y = %b", $time, x, y);
    
    // Apply all 16 possible combinations of the 4-bit input 'x'
    // Wait for 10 simulation time units after applying each input
    x = 4'b0000; #10; // Case 0: All inputs are 0
    x = 4'b0001; #10; // Case 1: Only the LSB is 1
    x = 4'b0010; #10; // Case 2: Second bit is 1
    x = 4'b0011; #10; // Case 3: First two bits are 1
    x = 4'b0100; #10; // Case 4: Third bit is 1
    x = 4'b0101; #10; // Case 5: First and third bits are 1
    x = 4'b0110; #10; // Case 6: Second and third bits are 1
    x = 4'b0111; #10; // Case 7: First three bits are 1
    x = 4'b1000; #10; // Case 8: Fourth bit is 1
    x = 4'b1001; #10; // Case 9: First and fourth bits are 1
    x = 4'b1010; #10; // Case 10: Second and fourth bits are 1
    x = 4'b1011; #10; // Case 11: First, second, and fourth bits are 1
    x = 4'b1100; #10; // Case 12: Third and fourth bits are 1
    x = 4'b1101; #10; // Case 13: First, third, and fourth bits are 1
    x = 4'b1110; #10; // Case 14: Second, third, and fourth bits are 1
    x = 4'b1111; #10; // Case 15: All inputs are 1
    
    // End the simulation after all test cases
    $finish;
  end
endmodule
