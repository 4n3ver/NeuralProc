module sigmoid(x, y);
    input signed [15:0] x;
    output signed [15:0] y;
  
  // HINT: >> is not the same as >>>. you want a signed shift.
    assign y = ($signed(x) - $signed(16'd4) >= $signed(16'd0)) ? 16'd1 : 
                ($signed(x) + $signed(16'd4) < $signed(16'd0)) ? 16'd0 : 
                    {x[15], x[15], x[15], x[15:3]};
  
endmodule