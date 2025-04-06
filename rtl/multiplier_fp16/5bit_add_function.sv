
module function_lib20();
  function [4:0] add_function;
    input [4:0] x, y;  // 两个输入操作数
    reg [4:0] result;
    reg carry_in, carry_out;
    reg [4:0] complement_15;  // 存放5'd15的补码
    integer i;

    begin
        // 初始化 carry_in 为 0
        carry_in = 1'b0;
        
        // 定义 5'd15 的补码（取反加1）
        complement_15 = 5'b01111;  // 5'd15 的补码（即 5'b10001）
        
        
        for (i = 0; i < 5; i = i + 1) begin
            // 使用全加器逻辑逐位相加
            result[i] = x[i] ^ y[i] ^ carry_in;  // sum = a ^ b ^ carry_in
            carry_out = (x[i] & y[i]) | (carry_in & (x[i] ^ y[i]));  // carry_out = (a & b) | (carry_in & (a ^ b))
            carry_in = carry_out;  // carry_in赋值为进位
        end

        // 减去 5'd15（相当于加上 complement_15）
        carry_in = 1'b0;  // 重置 carry_in
        for (i = 0; i < 5; i = i + 1) begin
            // 加上 5'd15 的补码
            result[i] = result[i] ^ complement_15[i] ^ carry_in;  // sum = a ^ b ^ carry_in
            carry_out = (result[i] & complement_15[i]) | (carry_in & (result[i] ^ complement_15[i]));  // carry_out = (a & b) | (carry_in & (a ^ b))
            carry_in = carry_out;  // 更新进位
        end

        add_function = result;
    end
  endfunction
endmodule
