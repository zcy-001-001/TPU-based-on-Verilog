
 module function_lib22();
 function_lib21 function_lib_ut21();
    // 乘法器的实现（使用全加器），不使用乘法运算符
function automatic [21:0] binary_multiplier(input [10:0] a, input [10:0] b);
        reg [21:0] product;             // 存储结果
        reg [10:0] temp_a;              // 存储被乘数
        reg [10:0] temp_b;              // 存储乘数
        reg carry;
        integer i, j;

        begin
            product = 22'b0;            // 初始化乘积为0
            carry = 0;
            temp_a = a;
            temp_b = b;
            
            // 移位加法实现乘法
            for (i = 0; i < 11; i = i + 1) begin
                if (temp_b[i] == 1'b1) begin
                    for (j = 0; j < 11; j = j + 1) begin
                        // 逐位进行部分和的累加
                        {carry, product[i + j]} = function_lib_ut21.full_adder(product[i + j], temp_a[j], carry);
                    end
                end
            end
            
            binary_multiplier = product; // 返回最终的乘积
        end
endfunction
endmodule
