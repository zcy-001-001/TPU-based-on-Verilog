`timescale 1ns/1ps

module fp16multiplier(
    input [15:0] a,
    input [15:0] b,
    output reg [15:0] z
);
    reg sign;
    reg signed [5:0] exponent;
    reg [9:0] mantissa;
    reg [10:0] fractionA, fractionB;
    reg [21:0] fraction;

    always @(*) begin
        if (a == 0 || b == 0) z = 16'b0;
        else begin
            sign = a[15] ^ b[15];
            exponent = a[14:10] + b[14:10] - 5'd15;
            fractionA = {1'b1, a[9:0]};
            fractionB = {1'b1, b[9:0]};
            fraction = fractionA * fractionB;

            if (fraction[21]) begin fraction = fraction << 1; exponent = exponent + 1; end
            else if (fraction[20]) fraction = fraction << 2;
            else if (fraction[19]) begin fraction = fraction << 3; exponent = exponent - 1; end
            else if (fraction[18]) begin fraction = fraction << 4; exponent = exponent - 2; end
            else if (fraction[17]) begin fraction = fraction << 5; exponent = exponent - 3; end
            else if (fraction[16]) begin fraction = fraction << 6; exponent = exponent - 4; end
            else if (fraction[15]) begin fraction = fraction << 7; exponent = exponent - 5; end
            else if (fraction[14]) begin fraction = fraction << 8; exponent = exponent - 6; end
            else if (fraction[13]) begin fraction = fraction << 9; exponent = exponent - 7; end
            else if (fraction[12] == 1'b0) begin fraction = fraction << 10; exponent = exponent - 8; end

            mantissa = fraction[21:12];
            z = (exponent[5] == 1'b1) ? 16'b0 : {sign, exponent[4:0], mantissa};
        end
    end


initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1, fp16multiplier);
end

endmodule
