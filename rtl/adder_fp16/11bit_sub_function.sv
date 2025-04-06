module function_lib5();
function [11:0] sub_11bit(
    input [10:0] fractionB,
    input [10:0] fractionA
);
    reg [10:0] A_inverted;
    reg [10:0] sum;
    reg [11:0] carry;
    integer i;

begin
    // 对 fractionA 取反，得到其补码的低 11 位
    A_inverted = ~fractionA;
    carry[0] = 1'b1; // 加上 1，完成二进制补码的操作

    // 使用全加器逻辑计算 fractionB + (~fractionA + 1)
    for (i = 0; i < 11; i = i + 1) begin
        sum[i] = fractionB[i] ^ A_inverted[i] ^ carry[i];
        carry[i+1] = (fractionB[i] & A_inverted[i]) | (fractionB[i] & carry[i]) | (A_inverted[i] & carry[i]);
    end

    // 根据最终的进位位计算 cout，作为符号位
    // 当 carry[11] 为 1 时，表示没有借位，结果为正数；当 carry[11] 为 0 时，表示发生借位，结果为负数
    sub_11bit = {~carry[11], sum};
end
endfunction


endmodule