module Adder_Subtractor(a,b,res,underflow,overflow,exception);
  input [31:0]a;
  input [31:0]b;
  output reg [31:0] res;
  output reg underflow;
  output reg overflow;
  output reg exception;

  reg [23:0] mant_a,mant_b;
  reg [23:0] mant_temp;
  reg [22:0] mant;
  reg [7:0] exp;
  reg sign;
  reg [7:0] exp_a,exp_b,exp_temp,exp_diff;
  reg sign_a,sign_b,sign_temp;
  reg [32:0] temp;
  reg carry;
  reg compare;
  reg [7:0] exp_adjust;

  always @(*)
    begin
      if (a[30:23] >= b[30:23])
        begin
          compare = 1'b1;
        end
      else
        begin
          compare = 1'b0;
        end
    end
  always @(*)
    begin
      if (compare)
        begin
          mant_a = {1'b1,a[22:0]};
          exp_a = a[30:23];
          sign_a = a[31];

          mant_b = {1'b1,b[22:0]};
          exp_b = b[30:23];
          sign_b = b[31];
        end
      else
        begin
          mant_a = {1'b1,b[22:0]};
          exp_a = b[30:23];
          sign_a = b[31];

          mant_b = {1'b1,a[22:0]};
          exp_b = a[30:23];
          sign_b = a[31];
        end
    end
  always @(*)
    begin
      if ((mant_a!=23'b0 & exp_a==8'b1)|(mant_b!=23'b0 & exp_b==8'b1))
        begin
          assign exception = 1'b1;
        end
      else
        begin
          assign exception = 1'b0;
        end
    end
  //
  always @(*)
    begin
      if (exception)
        begin
          assign underflow = 1'b0;
          assign overflow = 1'b0;
          //result is set to all bits zeros
          assign res = 32'b0;
        end
      else if (!exception)
        begin
          //mantissa of smaller no to be shifted by difference of exponents to make exponents equal to that of larger one

          exp_diff = exp_a - exp_b;
          mant_b = (mant_b >> exp_diff);

          {carry,mant_temp} =  (sign_a ~^ sign_b)? mant_a + mant_b : mant_a - mant_b ; 
          exp_adjust = exp_a;

          //if carry generated to noramlize mantissa, shift  point to left and increase exp by one

          if(carry)
            begin
              mant_temp = mant_temp>>1;
              exp_adjust = exp_adjust + 1'b1;
            end
          else
            begin
              while(!mant_temp[23])
                begin
                  mant_temp = mant_temp<<1;
                  exp_adjust =  exp_adjust-1'b1;
                end
            end
          sign = sign_a;
          mant = mant_temp[22:0];
          exp = exp_adjust;
          //overflow(infinity check)
          if (mant==23'b0 & exp==8'b1)
            begin
              assign overflow = 1'b1;
            end
          else
            begin
              assign overflow = 1'b0;
            end
          //underflow(denormal check)
          if (mant!=23'b0 & exp==8'b0)
            begin
              assign underflow = 1'b1;
            end
          else
            begin
              assign underflow = 1'b0;
            end
          res = {sign,exp,mant};
        end
    end
endmodule
