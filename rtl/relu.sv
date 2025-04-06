// Finish the design of ReLU activation function
// ReLU activation function: relu(x) = max(x,0)

`timescale 1ns/1ns

module relu(enable, i, z);

    input enable;       // 启用 relu 模块，仅当 enable 为高时计算 relu
    input [15:0] i;     // relu 激活函数的输入，FP16 格式
    output reg [15:0] z;    // relu 激活函数的输出，FP16 格式

    always @(*) begin
        if (enable) begin
            // 检查输入的符号位，FP16 格式下符号位是最高位
            if (i[15] == 1'b0) begin
                z = i;  // 如果符号位为 0，说明输入是非负数，直接输出 i
            end else begin
                z = 16'b0;  // 如果符号位为 1，说明输入是负数，输出 0
            end
        end else begin
            z = i;  // 如果 enable 为低电平，输出 0
        end
    end

endmodule

