`timescale 1us/1ns
module multiplier_11bit(input1,input2,answer);
    input [10:0] input1,input2;
    output [22:0] answer;
    wire  carry_out;
    wire [22:0] ps1,ps2,ps3,ps4,ps5,ps6,ps7,ps8,ps9;
    wire [22:0] pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9,pp10,pp11;


    assign pp1 = input2[0] ? {11'b00000000000, input1} : 22'b0;
    assign pp2 = input2[1] ? {10'b0000000000, input1, 1'b0} : 22'b0;
    assign pp3 = input2[2] ? {9'b000000000, input1, 2'b00} : 22'b0;
    assign pp4 = input2[3] ? {8'b00000000, input1, 3'b000} : 22'b0;
    assign pp5 = input2[4] ? {7'b0000000, input1, 4'b0000} : 22'b0;
    assign pp6 = input2[5] ? {6'b000000, input1, 5'b00000} : 22'b0;
    assign pp7 = input2[6] ? {5'b00000, input1, 6'b000000} : 22'b0;
    assign pp8 = input2[7] ? {4'b0000, input1, 7'b0000000} : 22'b0;
    assign pp9 = input2[8] ? {3'b000, input1, 8'b00000000} : 22'b0;
    assign pp10 = input2[9] ? {2'b00, input1, 9'b000000000} : 22'b0;
    assign pp11 = input2[10] ? {1'b0, input1, 10'b0000000000} : 22'b0;

    adder_22bit f1(pp1, pp2, ps1);
    adder_22bit f2(ps1, pp3, ps2);
    adder_22bit f3(ps2, pp4, ps3);
    adder_22bit f4(ps3, pp5, ps4);
    adder_22bit f5(ps4, pp6, ps5);
    adder_22bit f6(ps5, pp7, ps6);
    adder_22bit f7(ps6, pp8, ps7);
    adder_22bit f8(ps7, pp9, ps8);
    adder_22bit f9(ps8, pp10, ps9);
    adder_22bit f10(ps9, pp11, answer);

endmodule