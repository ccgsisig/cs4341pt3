module four_input_xor (
    input [3:0] a,  // 4-bit input vector a[3:0]
    output y        // XOR output
);
    assign y = a[3] ^ a[2] ^ a[1] ^ a[0];  // XOR all four inputs
endmodule
