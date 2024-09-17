`timescale 1us/1ns

module adder_fp16(a, b, z);
    input [15:0] a, b;
    output reg [15:0] z;
    
    // 定义变量
    reg sign_a, sign_b, sign_z;
    reg [10:0] mantissa_a, mantissa_b, mantissa_z;
    reg [4:0] exp_a, exp_b;
    reg [5:0] exp_l, exp_s, shift1, shift2,ex_in1,ex_in2;
    reg [11:0] mantissa_sum;

    reg [11:0] add_result,mantissa_l,mantissa_s, sub_result;

    // 分解输入
    assign sign_a       = a[15];
    assign sign_b       = b[15];
    assign exp_a        = a[14:10];
    assign exp_b        = b[14:10];
    

    // 比较指数并右移较小的尾数
    subtractor_6bit f1(exp_l, exp_s, shift1);  // 执行指数减法

    // 实例化加法器和减法器
    adder_12bit f2({1'b0, mantissa_a}, {1'b0, mantissa_b}, add_result);
    subtractor_12bit f3(mantissa_l,  mantissa_s, sub_result);

    // 调整指数
    adder_6bit f4(ex_in1, shift2, ex_in2); 

    always @(*) begin
        
        mantissa_a   = {1'b1, a[9:0]};  // 隐含位
        mantissa_b   = {1'b1, b[9:0]};  // 隐含位
        $display("Input A: %b, Input B: %b", a, b); // 打印输入
        $display("Before exponent comparison: mantissa_a = %b, mantissa_b = %b", mantissa_a, mantissa_b);
        
        if (a == 16'b0) z = b;
        else if (b == 16'b0) z = a;
        else if (a[14:0] == b[14:0] && a[15] ^ b[15] == 1'b1) z = 16'b0;
        else begin
            if (exp_b > exp_a) begin
                exp_l = {1'b0, exp_b};  // 扩展无符号
                exp_s = {1'b0, exp_a};
                mantissa_a = mantissa_a >> shift1;  // 右移较小尾数
                ex_in1 = {1'b0, exp_b};
            end else if (exp_a > exp_b) begin
                exp_l = {1'b0, exp_a};  // 扩展无符号
                exp_s = {1'b0, exp_b};
                mantissa_b = mantissa_b >> shift1;  // 右移较小尾数
                ex_in1 = {1'b0, exp_a};
            end else begin
                // shift1 = 6'b000000;  // 不需要位移
                exp_l = {1'b0, exp_b};  // 扩展无符号
                exp_s = {1'b0, exp_a};
                ex_in1 = {1'b0, exp_b};
            end
            // $display("At time %0t: exp_a = %d,exp_b = %d,{1'b1, a[9:0]}=%b, mantissa_a = %b", $time, exp_a,exp_b, {1'b1, a[9:0]},mantissa_a);
            $display("After exponent comparison: mantissa_a = %b, mantissa_b = %b", mantissa_a, mantissa_b);
            if (sign_a == sign_b) begin
                // 同号相加
                mantissa_sum = add_result;
                sign_z = sign_a;
                //  $display("At time %0t: mantissa_a = %b,mantissa_sum = %b", $time, mantissa_a,mantissa_sum);
            end else begin
                // 异号相减
                if (mantissa_a > mantissa_b) begin
                    mantissa_l = {1'b0, mantissa_a};
                    mantissa_s = {1'b0, mantissa_b};
                    mantissa_sum = sub_result;
                    sign_z = sign_a;
                end else begin
                    mantissa_l = {1'b0, mantissa_b};
                    mantissa_s = {1'b0, mantissa_a};
                    mantissa_sum = sub_result;
                    sign_z = sign_b;
                end
            end

            $display("After mantissa sum: mantissa_sum = %b", mantissa_sum);

            if (mantissa_sum[11] == 1'b1) begin
                // 无需移位，最高位是1
                mantissa_z = mantissa_sum[10:1]; 
                shift2 = 6'b000001;  // 指数+1
            end else if (mantissa_sum[10] == 1'b1) begin
                mantissa_z = mantissa_sum[9:0];
                shift2 = 6'b000000;  // 指数不变
            end else if (mantissa_sum[9] == 1'b1) begin
                mantissa_z = mantissa_sum[8:0] << 1;
                shift2 = 6'b111111;  // 指数-1
            end else if (mantissa_sum[8] == 1'b1) begin
                mantissa_z = mantissa_sum[7:0] << 2;
                shift2 = 6'b111110;  // 指数-2
            end else if (mantissa_sum[7] == 1'b1) begin
                mantissa_z = mantissa_sum[6:0] << 3;
                shift2 = 6'b111101;  // 指数-3
            end else if (mantissa_sum[6] == 1'b1) begin
                mantissa_z = mantissa_sum[5:0] << 4;
                shift2 = 6'b111100;  // 指数-4
            end else if (mantissa_sum[5] == 1'b1) begin
                mantissa_z = mantissa_sum[4:0] << 5;
                shift2 = 6'b111011;  // 指数-5
            end else if (mantissa_sum[4] == 1'b1) begin
                mantissa_z = mantissa_sum[3:0] << 6;
                shift2 = 6'b111010;  // 指数-6
            end else if (mantissa_sum[3] == 1'b1) begin
                mantissa_z = mantissa_sum[2:0] << 7;
                shift2 = 6'b111001;  // 指数-7
            end else if (mantissa_sum[2] == 1'b1) begin
                mantissa_z = mantissa_sum[1:0] << 8;
                shift2 = 6'b111000;  // 指数-8
            end else if (mantissa_sum[1] == 1'b1) begin
                mantissa_z = mantissa_sum[0] << 9;
                shift2 = 6'b110111;  // 指数-9
            end else if (mantissa_sum[0] == 1'b1) begin
                mantissa_z = mantissa_sum[0];  // 仅保留最低位
                shift2 = 6'b110110;  // 指数-10
            end 
            $display("At time %0t:mantissa_sum = %b,mantissa_z=%b,ex_in1 =%b,shift2=%b,ex_in2[4:0]=%b,exp_b = %d", $time,mantissa_sum,mantissa_z,ex_in1,shift2,ex_in2[4:0],exp_b);
            z = {sign_z, ex_in2[4:0], mantissa_z[9:0]};
        end
    end


endmodule
