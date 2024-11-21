module testbenchXorFourInput;
  logic [3:0] x;
  logic y;
  
  // instantiate device under test
  xorFourInput dut(
    .a(x),
    .y(y)
  );
  
  // test cases
  initial begin
   	// monitor changes in input and output and display
    $monitor("Time = %0t, x = %b, y = %b", $time, x, y);
    
    x = 4'b0000; #10;
	x = 4'b0001; #10;
    x = 4'b0010; #10;
    x = 4'b0011; #10;
    x = 4'b0100; #10;
    x = 4'b0101; #10;
    x = 4'b0110; #10;
    x = 4'b0111; #10;
    x = 4'b1000; #10;
    x = 4'b1001; #10;
    x = 4'b1010; #10;
    x = 4'b1011; #10;
    x = 4'b1100; #10;
    x = 4'b1101; #10;
    x = 4'b1110; #10;
    x = 4'b1111; #10;
   
    $finish;
    end
endmodule