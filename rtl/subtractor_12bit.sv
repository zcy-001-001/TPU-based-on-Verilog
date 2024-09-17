module subtractor_12bit(
    input [11:0] input1,   // 被减数
    input [11:0] input2,   // 减数
    output reg [11:0] result   // 结果
);

    reg [11:0] complement_input2;  // input2 的补码
    reg [11:0] one = 11'b000001;    // 用于补码加 1
    reg [11:0] add_input2;         // 计算后的补码

    // 计算减数的补码（取反加 1）
    always_comb begin
        complement_input2 = ~input2;  // 取反
        add_input2 = complement_input2 + one;  // 加 1，得到补码
    end

    // 使用无符号加法器计算 input1 - input2 = input1 + (~input2 + 1)
    adder_12bit f1(input1, add_input2, result);

endmodule