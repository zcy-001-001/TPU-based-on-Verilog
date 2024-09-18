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
            shift = 6'b000001; // 指数 +1
        end else if (mantissa_product[20] == 1'b1) begin
            mantissa_z = mantissa_product[19:10];
            shift = 6'b000000;
        end else if (mantissa_product[19] == 1'b1) begin
            mantissa_z = mantissa_product[18:9];
            shift = 6'b111111; // 指数 -1
        end else if (mantissa_product[18] == 1'b1) begin
            mantissa_z = mantissa_product[17:8];
            shift = 6'b111110; // 指数 -2
        end else if (mantissa_product[17] == 1'b1) begin
            mantissa_z = mantissa_product[16:7];
            shift = 6'b111101; // 指数 -3
        end else if (mantissa_product[16] == 1'b1) begin
            mantissa_z = mantissa_product[15:6];
            shift = 6'b111100; // 指数 -4
        end else if (mantissa_product[15] == 1'b1) begin
            mantissa_z = mantissa_product[14:5];
            shift = 6'b111011; // 指数 -5
        end else if (mantissa_product[14] == 1'b1) begin
            mantissa_z = mantissa_product[13:4];
            shift = 6'b111010; // 指数 -6
        end else if (mantissa_product[13] == 1'b1) begin
            mantissa_z = mantissa_product[12:3];
            shift = 6'b111001; // 指数 -7
        end else if (mantissa_product[12] == 1'b1) begin
            mantissa_z = mantissa_product[11:2];
            shift = 6'b111000; // 指数 -8
        end else if (mantissa_product[11] == 1'b1) begin
            mantissa_z = mantissa_product[10:1];
            shift = 6'b110111; // 指数 -9
        end else if (mantissa_product[10] == 1'b1) begin
            mantissa_z = mantissa_product[9:0];
            shift = 6'b110110; // 指数 -10
        end else if (mantissa_product[9] == 1'b1) begin
            mantissa_z = mantissa_product[8:0] << 1; // 保留高9位
            shift = 6'b110101;  // 指数-11
        end else if (mantissa_product[8] == 1'b1) begin
            mantissa_z = mantissa_product[7:0] << 2; // 保留高8位
            shift = 6'b110100;  // 指数-12
        end else if (mantissa_product[7] == 1'b1) begin
            mantissa_z = mantissa_product[6:0] << 3; // 保留高7位
            shift = 6'b110011;  // 指数-13
        end else if (mantissa_product[6] == 1'b1) begin
            mantissa_z = mantissa_product[5:0] << 4; // 保留高6位
            shift = 6'b110010;  // 指数-14
        end else if (mantissa_product[5] == 1'b1) begin
            mantissa_z = mantissa_product[4:0] << 5; // 保留高5位
            shift = 6'b110001;  // 指数-15
        end else if (mantissa_product[4] == 1'b1) begin
            mantissa_z = mantissa_product[3:0] << 6; // 保留高4位
            shift = 6'b110000;  // 指数-16
        end else if (mantissa_product[3] == 1'b1) begin
            mantissa_z = mantissa_product[2:0] << 7; // 保留高3位
            shift = 6'b101111;  // 指数-17
        end else if (mantissa_product[2] == 1'b1) begin
            mantissa_z = mantissa_product[1:0] << 8; // 保留高2位
            shift = 6'b101110;  // 指数-18
        end else if (mantissa_product[1] == 1'b1) begin
            mantissa_z = {9'b0, mantissa_product[0]} << 9; // 仅保留最低位
            shift = 6'b101101;  // 指数-19
        end else begin
            mantissa_z = 10'b0; // 结果为0
            shift = 6'b000000;  // 不改变指数
        end
    end    
    
    assign z = {sign_z, exp_z[4:0], mantissa_z};

endmodule
