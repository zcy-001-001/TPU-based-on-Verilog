    // 实现加减法函数（全加器 + 补码）
module function_lib3();
    function_lib1 function_lib_ut1();
    function automatic [5:0] add_sub_exponent(input [5:0] exp1, input [5:0] exp2, input op); // op=0 -> 加法, op=1 -> 减法
        reg [5:0] result;
        reg carry;
        integer i;
        reg [5:0] operand_b;
        begin
            carry = op; // 如果是减法，carry初始化为1
            operand_b = exp2 ^ {6{op}}; // 如果是减法，将第二个操作数取反 (使用补码实现减法)

            for (i = 0; i < 6; i = i + 1) begin
                {carry, result[i]} = function_lib_ut1.full_adder(exp1[i], operand_b[i], carry);
            end

            add_sub_exponent = result;  // 返回结果
        end
    endfunction
endmodule
