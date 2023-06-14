module Adder_Subtractor_tb();
  reg [31:0] a,b;
  reg clk;
  wire [31:0] res;
  wire underflow,overflow,exception; 
  Adder_Subtractor add_sub (.a(a),.b(b),.res(res),.underflow(underflow),.overflow(overflow),.exception(exception));

  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(1);
    end
  initial  
    begin
      a = 32'b0_00100111_10001000100001001010110;  // 4.95427682601e-27
      b = 32'b0_00000000_01101010101100100101010;  // 4.89926733512e-39
      #20;
      a = 32'b1_10000101_01101000010110011011101;  // -90.08762
      b = 32'b0_10000100_11000010101111011001011;  // 56.342571
      #20;
      a = 32'b0_10001100_10000101001001111110010;  // 12452.9862
      b = 32'b1_10001000_11101100100111100110001;  // -985.23739
      #20;
      $finish;
    end
endmodule