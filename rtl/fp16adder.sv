`timescale 1ns/1ps

module fp16adder(a, b, z);

input [15:0] a, b;
output reg [15:0] z;

reg sign;
reg signed [5:0] exponent;
reg [9:0] mantissa;
reg [4:0] exponentA, exponentB;
reg [10:0] fractionA, fractionB, fraction;
reg [7:0] shiftAmount;
reg cout;

always @ (a or b) begin
    exponentA = a[14:10];
    exponentB = b[14:10];
    fractionA = {1'b1, a[9:0]};
    fractionB = {1'b1, b[9:0]};
    exponent = exponentA;

    if (a == 16'b0) z = b;
    else if (b == 16'b0) z = a;
    else if (a[14:0] == b[14:0] && a[15] ^ b[15] == 1'b1) z = 16'b0;
    else begin
        if (exponentB > exponentA) begin
            shiftAmount = exponentB - exponentA;
            fractionA = fractionA >> shiftAmount;
            exponent = exponentB;
        end else if (exponentA > exponentB) begin
            shiftAmount = exponentA - exponentB;
            fractionB = fractionB >> shiftAmount;
            exponent = exponentA;
        end
        if (a[15] == b[15]) begin
            {cout, fraction} = fractionA + fractionB;
            if (cout) begin
                {cout, fraction} = {cout, fraction} >> 1;
                exponent = exponent + 1;
            end
            sign = a[15];
        end else begin
            if (fractionA > fractionB) {cout, fraction} = fractionA - fractionB;
            else {cout, fraction} = fractionB - fractionA;
            sign = (fractionA >= fractionB) ? a[15] : b[15];
            if (!fraction[10]) begin
                if (fraction[9]) begin fraction = fraction << 1; exponent = exponent - 1; end
                else if (fraction[8]) begin fraction = fraction << 2; exponent = exponent - 2; end
                else if (fraction[7]) begin fraction = fraction << 3; exponent = exponent - 3; end
                else if (fraction[6]) begin fraction = fraction << 4; exponent = exponent - 4; end
                else if (fraction[5]) begin fraction = fraction << 5; exponent = exponent - 5; end
                else if (fraction[4]) begin fraction = fraction << 6; exponent = exponent - 6; end
                else if (fraction[3]) begin fraction = fraction << 7; exponent = exponent - 7; end
                else if (fraction[2]) begin fraction = fraction << 8; exponent = exponent - 8; end
                else if (fraction[1]) begin fraction = fraction << 9; exponent = exponent - 9; end
                else if (fraction[0]) begin fraction = fraction << 10; exponent = exponent - 10; end
            end
        end
        mantissa = fraction[9:0];
        z = (exponent[5]) ? 16'b0000000000000000 : {sign, exponent[4:0], mantissa};
    end
end

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(1, fp16adder);
end

endmodule
