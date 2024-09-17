`timescale 1us/1ns
module adder_3bit(input1,input2,answer);
    input [3:0] input1,input2;
    output [3:0] answer;
    wire  carry_out;
    wire [3:0] carry;
    half_adder f1(input1[0],input2[0],answer[0],carry[0]);
    full_adder f2(input1[1],input2[1],carry[0],answer[1],carry[1]);
    full_adder f3(input1[2],input2[2],carry[1],answer[2],carry[2]);
    full_adder f4(input1[3],input2[3],carry[2],answer[3],carry[3]);
endmodule