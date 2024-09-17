// The IEEE 754 standard specifies a binary16 (X[15:0]) as having the following format:
// Sign bit: 1 bit (X[15])
// Exponent width: 5 bits (X[14:10])
// Significand precision: 11 bits (10 explicitly stored) (X[9:0])

`timescale 1us/1ns
module multiplier_fp16(a, b, z);
    input [15:0] a, b;
    output reg [15:0] z;
    reg sign_a, sign_b, sign_z;
    reg [4:0] exp_a, exp_b, exp_z;
    reg [5:0] ex_in1,ex_in2,shift;
    reg [10:0] mantissa_a, mantissa_b;
    reg [9:0] mantissa_z;
    reg [21:0] mantissa_product;
    
    assign sign_a       = a[15];
    assign sign_b       = b[15];
    assign exp_a        = a[14:10];
    assign exp_b        = b[14:10];
    assign mantissa_a   = {1'b1, a[9:0]}; 
    assign mantissa_b   = {1'b1, b[9:0]}; 

    // Decide Sign:
    assign sign_z = sign_a ^ sign_b;

    // Multiply Mantissa:
    multiplier_11bit mul_11(mantissa_a, mantissa_b, mantissa_product);
            
    // Add Exponent:
    adder_6bit f1({1'b0, exp_a},{1'b0, exp_b},ex_in1);
    adder_6bit f2(ex_in1,6'b110001,ex_in2);

    // Normalization & Round:
    adder_6bit f3(ex_in2, shift, exp_z);

    always @(mantissa_product) begin
        if(mantissa_product[21] == 1'b1) begin
            mantissa_z = mantissa_product[20:11];
            shift = 6'b000001;
        end else if (mantissa_product[20] == 1'b1) begin
            mantissa_z = mantissa_product[19:10];
            shift = 6'b000000;
        end else if (mantissa_product[19] == 1'b1) begin
            mantissa_z = mantissa_product[18:9];
            shift = 6'b111111;
        end else if (mantissa_product[18] == 1'b1) begin
            mantissa_z = mantissa_product[17:8];
            shift = 6'b111110;
        end else if (mantissa_product[17] == 1'b1) begin
            mantissa_z = mantissa_product[16:7];
            shift = 6'b111101;
        end else if (mantissa_product[16] == 1'b1) begin
            mantissa_z = mantissa_product[15:6];
            shift = 6'b111100;
        end else if (mantissa_product[15] == 1'b1) begin
            mantissa_z = mantissa_product[14:5];
            shift = 6'b111011;
        end else if (mantissa_product[14] == 1'b1) begin
            mantissa_z = mantissa_product[13:4];
            shift = 6'b111010;
        end else if (mantissa_product[13] == 1'b1) begin
            mantissa_z = mantissa_product[12:3];
            shift = 6'b111001;
        end else if (mantissa_product[12] == 1'b1) begin
            mantissa_z = mantissa_product[11:2];
            shift = 6'b111000;
        end else if (mantissa_product[11] == 1'b1) begin
            mantissa_z = mantissa_product[10:1];
            shift = 6'b110111;
        end else if (mantissa_product[10] == 1'b1) begin
            mantissa_z = mantissa_product[9:0];
            shift = 6'b110110;
        end
    end    
    
    assign z = {sign_z, exp_z[4:0], mantissa_z};

endmodule
