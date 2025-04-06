 `include "./rtl/adder_fp16.sv"
 `include "./rtl/multiplier_fp16.sv"
module block(inp_data, inp_weight,inp_mac, clk, reset, outp_data, outp_mac);
	input [15:0] inp_data, inp_weight,inp_mac;
	output reg [15:0] outp_data, outp_mac;
	input clk, reset;
	wire [15:0]outp_mac1;
	wire [15:0]outp_mac2;
    function_lib_fp16_add  function_lib_ut_fp16_add();
    function_lib_fp16_mult function_lib_ut_fp16_mult();
    //assign outp_mac1=function_lib_ut_fp16_mult.fp16_mult(inp_data,inp_weight); 
	assign outp_mac1=float_mult_function(inp_data,inp_weight);
	assign outp_mac2=function_lib_ut_fp16_add.fp16_add(outp_mac1,inp_mac);

	always @(posedge reset or posedge clk) begin 
		if(reset) begin
			outp_data <= 0;
			outp_mac <= 0;
		end
		else begin
			outp_data <= inp_data;
			outp_mac <=outp_mac2;
		end
	end
endmodule




    // 定义浮点数乘法 function
    function [15:0] float_mult_function(input [15:0] floatA, input [15:0] floatB);
        reg sign;
        reg signed [5:0] exponent; // 第 6 位是符号位
        reg [9:0] mantissa;
        reg [10:0] fractionA, fractionB;
        reg [21:0] fraction;
        reg [15:0] product_out;

        begin
            if (floatA == 16'b0 || floatB == 16'b0) begin
                product_out = 16'b0;
            end else begin
                // 计算符号位
                sign = floatA[15] ^ floatB[15]; // 异或，相异为 1
                
                // 计算指数并进行偏移调整
                exponent = floatA[14:10] + floatB[14:10] - 5'd15;

                // 处理尾数部分，显示隐藏位 1
                fractionA = {1'b1, floatA[9:0]};
                fractionB = {1'b1, floatB[9:0]};
                fraction = fractionA * fractionB;

                // 规格化处理
                if (fraction[21] == 1'b1) begin
                    fraction = fraction << 1;
                    exponent = exponent + 1;
                end else if (fraction[20] == 1'b1) begin
                    fraction = fraction << 2;
                    exponent = exponent + 0;
                end else if (fraction[19] == 1'b1) begin
                    fraction = fraction << 3;
                    exponent = exponent - 1;
                end else if (fraction[18] == 1'b1) begin
                    fraction = fraction << 4;
                    exponent = exponent - 2;
                end else if (fraction[17] == 1'b1) begin
                    fraction = fraction << 5;
                    exponent = exponent - 3;
                end else if (fraction[16] == 1'b1) begin
                    fraction = fraction << 6;
                    exponent = exponent - 4;
                end else if (fraction[15] == 1'b1) begin
                    fraction = fraction << 7;
                    exponent = exponent - 5;
                end else if (fraction[14] == 1'b1) begin
                    fraction = fraction << 8;
                    exponent = exponent - 6;
                end else if (fraction[13] == 1'b1) begin
                    fraction = fraction << 9;
                    exponent = exponent - 7;
                end else if (fraction[12] == 1'b1) begin
                    fraction = fraction << 10;
                    exponent = exponent - 8;
                end

                // 截取尾数部分
                mantissa = fraction[21:12];

                // 检查指数是否溢出或过小
                if (exponent[5] == 1'b1) begin
                    product_out = 16'b0000000000000000;
                end else begin
                    product_out = {sign, exponent[4:0], mantissa};
                end
            end

            float_mult_function = product_out; // 返回结果
        end
    endfunction


