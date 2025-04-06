`ifndef MULT_FP16_SV
`define MULT_FP16_SV
// The IEEE 754 standard specifies a binary16 (X[15:0]) as having the following format: 
// Sign bit: 1 bit (X[15])
// Exponent width: 5 bits (X[14:10])
// Significand precision: 11 bits (10 explicitly stored) (X[9:0])
`include "./rtl/multiplier_fp16/5bit_add_function.sv" 
`include "./rtl/multiplier_fp16/full_adder_function.sv" 
`include "./rtl/multiplier_fp16/mul_11bit_function.sv" 
`include "./rtl/multiplier_fp16/sub_5bit_function.sv"  

module function_lib_fp16_mult();  

function_lib20 function_lib_ut20();
function_lib22 function_lib_ut22();
function_lib23 function_lib_ut23();

function [15:0] fp16_mult(input [15:0] floatA, input [15:0] floatB);

reg [9:0] mantissa;
reg [10:0] fractionA, fractionB;	//fraction = {1,mantissa}
reg signed [5:0] exponent;
reg [21:0] fraction;
reg sign;
reg [15:0] product;
  begin
	if (floatA == 0 || floatB == 0) begin
		product = 0;
	end else begin
		sign = floatA[15] ^ floatB[15];
    	exponent = function_lib_ut20.add_function(floatA[14:10],floatB[14:10]); 
		
		fractionA = {1'b1,floatA[9:0]};
		fractionB = {1'b1,floatB[9:0]};
		fraction = function_lib_ut22.binary_multiplier(fractionA, fractionB);

		if (fraction[21] == 1'b1) begin
			fraction = fraction << 1;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 1, 0); 
		end else if (fraction[20] == 1'b1) begin
			fraction = fraction << 2;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 0, 0);
		end else if (fraction[19] == 1'b1) begin
			fraction = fraction << 3;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 1, 1);
		end else if (fraction[18] == 1'b1) begin
			fraction = fraction << 4;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 2, 1);
		end else if (fraction[17] == 1'b1) begin
			fraction = fraction << 5;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 3, 1);
		end else if (fraction[16] == 1'b1) begin
			fraction = fraction << 6;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 4, 1);
		end else if (fraction[15] == 1'b1) begin
			fraction = fraction << 7;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 5, 1);
		end else if (fraction[14] == 1'b1) begin
			fraction = fraction << 8;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 6, 1);
		end else if (fraction[13] == 1'b1) begin
			fraction = fraction << 9;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 7, 1);
		end else if (fraction[12] == 1'b1) begin
			fraction = fraction << 10;
			exponent = function_lib_ut23.add_sub_exponent(exponent, 8, 1);
		end 
	
		mantissa = fraction[21:12];
		if(exponent[5]==1'b1) begin 
			product=16'b0000000000000000;
		end
		else begin
			product = {sign,exponent[4:0],mantissa};
		end
	end
fp16_mult=product;
  end
endfunction
 
endmodule

`endif
