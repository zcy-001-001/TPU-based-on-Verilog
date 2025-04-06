`ifndef ADDER_FP16_SV
`define ADDER_FP16_SV
// The IEEE 754 standard specifies a binary16 (X[15:0]) as having the following format:
// Sign bit: 1 bit (X[15])
// Exponent width: 5 bits (X[14:10])
// Significand precision: 11 bits (10 explicitly stored) (X[9:0])
`include "./rtl/adder_fp16/11bit_adder_function.sv"
`include "./rtl/adder_fp16/11bit_sub_function.sv"
`include "./rtl/adder_fp16/full_adder_function.sv"
`include "./rtl/adder_fp16/sub_5bit_function.sv"
module function_lib_fp16_add(); 

function_lib5 function_lib_ut5();
function_lib4 function_lib_ut4();
function_lib3 function_lib_ut3();

function [15:0] fp16_add(input [15:0] floatA, input [15:0] floatB);
    reg sign;
    reg signed [5:0] exponent; // 第 5 位是符号位
    reg [9:0] mantissa;
    reg [4:0] exponentA, exponentB;
    reg [10:0] fractionA, fractionB, fraction; // 尾数 = {1,mantissa}
	reg [11:0] fraction1,fraction2,fraction3;
    reg [7:0] shiftAmount;
    reg cout;
    reg [15:0] sum;


begin
	exponentA = floatA[14:10];
	exponentB = floatB[14:10];
	fractionA = {1'b1,floatA[9:0]};
	fractionB = {1'b1,floatB[9:0]}; 
	
	exponent = exponentA;
 
	if (floatA == 0) begin						
		sum = floatB;
	end else if (floatB == 0) begin					
		sum = floatA;
	end else if (floatA[14:0] == floatB[14:0] && floatA[15]^floatB[15]==1'b1) begin
		sum=0;
	end else begin
		if (exponentB > exponentA) begin
			shiftAmount = function_lib_ut3.add_sub_exponent(exponentB,exponentA,1);
			fractionA = fractionA >> (shiftAmount);
			exponent = exponentB;
		end else if (exponentA > exponentB) begin 
			shiftAmount = function_lib_ut3.add_sub_exponent(exponentA,exponentB,1);
			fractionB = fractionB >> (shiftAmount);
			exponent = exponentA;
		end
		if (floatA[15] == floatB[15]) begin			
			//{cout,fraction} = function_lib_ut2.add_11bit(fractionA ,fractionB);
			fraction1 = function_lib_ut4.add_11bit(fractionA ,fractionB);
		    {cout,fraction} = fraction1;	
			if (cout == 1'b1) begin
				{cout,fraction} = {cout,fraction} >> 1;
				exponent = function_lib_ut3.add_sub_exponent(exponent,1,0);
			end
			sign = floatA[15];
		end else begin						//different signs
			if (floatA[15] == 1'b1) begin
				{cout,fraction}=function_lib_ut5.sub_11bit(fractionB ,fractionA);//如果B比A小，则相减后得到补码，cout为符号位
			end else begin
				{cout,fraction} = function_lib_ut5.sub_11bit(fractionA ,fractionB);//同理
			end
			sign = cout;
			if (cout == 1'b1) begin
				fraction = -fraction;
			end else begin
			end
			if (fraction [10] == 0) begin
				if (fraction[9] == 1'b1) begin
					fraction = fraction << 1;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 1, 1);
				end else if (fraction[8] == 1'b1) begin
					fraction = fraction << 2;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 2, 1);
				end else if (fraction[7] == 1'b1) begin
					fraction = fraction << 3;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 3, 1);
				end else if (fraction[6] == 1'b1) begin
					fraction = fraction << 4;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 4, 1);
				end else if (fraction[5] == 1'b1) begin
					fraction = fraction << 5;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 5, 1);
				end else if (fraction[4] == 1'b1) begin
					fraction = fraction << 6;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 6, 1);
				end else if (fraction[3] == 1'b1) begin
					fraction = fraction << 7;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 7, 1);
				end else if (fraction[2] == 1'b1) begin
					fraction = fraction << 8;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 8, 1);
				end else if (fraction[1] == 1'b1) begin
					fraction = fraction << 9;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 9, 1);
				end else if (fraction[0] == 1'b1) begin
					fraction = fraction << 10;
					exponent = function_lib_ut3.add_sub_exponent(exponent, 10, 1);
				end 
			end
		end
		mantissa = fraction[9:0];
		if(exponent[5]==1'b1) begin 
			sum = 16'b0000000000000000;
		end
		else begin
			sum = {sign,exponent[4:0],mantissa};
		end		
	end	
	fp16_add=sum;	
end
 endfunction
endmodule
`endif