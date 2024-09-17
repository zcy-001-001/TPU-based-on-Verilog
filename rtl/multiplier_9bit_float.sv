`timescale 1us/1ns
module multiplier_9bit_float(a, b, z,man);
    input [8:0] a, b;
    output [8:0] z;
    wire [3:0] ex_in1,ex_in2,exp;
    reg [3:0] off;
    reg [5:0] temp;
    output [11:0] man;
    reg sel;

    //sign bit generation
    assign z[8] = a[8]^b[8];

    //exponent calculation
    adder_3bit f1({1'b0,a[7:5]},{1'b0,b[7:5]},ex_in1);
    adder_3bit f2(ex_in1,4'b1100,ex_in2);

    //Mantissa calculation
    multiplier_6bit f3({1'b1,a[4:0]},{1'b1,b[4:0]},man);



    //Normalization

    adder_3bit f4(ex_in2,off,exp);
    assign z[4:0] = temp ;
    assign z[7:5] = exp[2:0] ;
    always @ (man) begin
        if(man[11]==1'b1) begin
            assign temp=man[10:6];
            assign off = 4'b0001;
        end

        if (man[11]==0 && man[10]==1) begin
            assign temp=man[9:5];
            assign off = 4'b0000;
        end

        if (man[11:10]==2'b00 && man[9]==1) begin
            assign temp=man[8:4];
            assign off = 4'b1111;
        end

        if (man[11:9]==0 && man[8]==1) begin
            assign temp=man[7:3];
            assign off = 4'b1110;
        end

        if (man[11:8]==0 && man[7]==1) begin
            assign temp=man[6:2];
            assign off = 4'b1101;
        end

        if (man[11:7]==0 && man[6]==1) begin
            assign temp=man[5:1];
            assign off = 4'b1100;
        end

        if (man[11:6]==0 && man[5]==1) begin
            assign temp=man[4:0];
            assign off = 4'b1011;
        end

    end

endmodule









