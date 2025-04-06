module function_lib4();
    function_lib1 function_lib_ut1();
    // 11位加法器函数，逐位调用全加器
    function automatic [11:0] add_11bit(input [10:0] fractionA, input [10:0] fractionB);
        reg [10:0] result;
        reg carry_in, carry_out;
        integer i;
        
        carry_in = 0; // 初始进位为0
        for (i = 0; i < 11; i = i + 1) begin
            {carry_out, result[i]} = function_lib_ut1.full_adder(fractionA[i], fractionB[i], carry_in);
            carry_in = carry_out; // 将当前进位作为下次加法的输入
        end
        add_11bit = {carry_out, result}; // 返回最后的进位和结果
    endfunction
endmodule