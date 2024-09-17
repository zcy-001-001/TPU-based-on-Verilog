
module subtractor_6bit(
    input [5:0] input1,   // 被减数
    input [5:0] input2,   // 减数
    output reg [5:0] result   // 结果
);

    reg [5:0] complement_input2;  // input2 的补码
    reg [5:0] one = 6'b000001;    // 用于补码加 1
    reg [5:0] add_input2;         // 计算后的补码

    // 计算减数的补码（取反加 1）
    always_comb begin
        complement_input2 = ~input2;  // 取反
        add_input2 = complement_input2 + one;  // 加 1，得到补码
    end

    // 使用无符号加法器计算 input1 - input2 = input1 + (~input2 + 1)
    adder_6bit f1(input1, add_input2, result);

endmodule