`timescale 1ns/1ns

module input_setup(
    input wire clk,
    input wire reset,
    input wire valid,

    input wire [15:0] a00, a01, a02, a03, a04, a05, a06, a07,
    input wire [15:0] a10, a11, a12, a13, a14, a15, a16, a17,
    input wire [15:0] a20, a21, a22, a23, a24, a25, a26, a27,
    input wire [15:0] a30, a31, a32, a33, a34, a35, a36, a37,
    input wire [15:0] a40, a41, a42, a43, a44, a45, a46, a47,
    input wire [15:0] a50, a51, a52, a53, a54, a55, a56, a57,
    input wire [15:0] a60, a61, a62, a63, a64, a65, a66, a67,
    input wire [15:0] a70, a71, a72, a73, a74, a75, a76, a77,

    output reg [15:0] a_in_0,
    output reg [15:0] a_in_1,
    output reg [15:0] a_in_2,
    output reg [15:0] a_in_3,
    output reg [15:0] a_in_4,
    output reg [15:0] a_in_5,
    output reg [15:0] a_in_6,
    output reg [15:0] a_in_7
    // 如需其他端口，可在此添加
);

    // 内部计数器，用于跟踪时钟周期
    reg [2:0] counter;           // 计数范围0-7
    reg [5:0] clock_counter;     // 计数范围0-14，需要4位

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 5'd0;
            clock_counter <= 4'd0;
            // 重置输出
            a_in_0 <= 16'd0;
            a_in_1 <= 16'd0;
            a_in_2 <= 16'd0;
            a_in_3 <= 16'd0;
            a_in_4 <= 16'd0;
            a_in_5 <= 16'd0;
            a_in_6 <= 16'd0;
            a_in_7 <= 16'd0;
        end else if (valid) begin
            // 当'valid'为高电平时，每个时钟周期增加clock_counter
            if (clock_counter < 5'd15) begin
                clock_counter <= clock_counter + 1;
            end else begin
                clock_counter <= 4'd0;
                // 每隔15个时钟周期增加一次counter
                if (counter < 3'd7) begin
                    counter <= counter + 1;
                end else begin
                    counter <= counter; // 当达到7时，保持不变
                end
            end

            // 根据counter的值更新输出
            case (counter)
                3'd0: begin
                    a_in_0 <= a00;
                    a_in_1 <= a01;
                    a_in_2 <= a02;
                    a_in_3 <= a03;
                    a_in_4 <= a04;
                    a_in_5 <= a05;
                    a_in_6 <= a06;
                    a_in_7 <= a07;
                end
                3'd1: begin
                    a_in_0 <= a10;
                    a_in_1 <= a11;
                    a_in_2 <= a12;
                    a_in_3 <= a13;
                    a_in_4 <= a14;
                    a_in_5 <= a15;
                    a_in_6 <= a16;
                    a_in_7 <= a17;
                end
                3'd2: begin
                    a_in_0 <= a20;
                    a_in_1 <= a21;
                    a_in_2 <= a22;
                    a_in_3 <= a23;
                    a_in_4 <= a24;
                    a_in_5 <= a25;
                    a_in_6 <= a26;
                    a_in_7 <= a27;
                end
                3'd3: begin
                    a_in_0 <= a30;
                    a_in_1 <= a31;
                    a_in_2 <= a32;
                    a_in_3 <= a33;
                    a_in_4 <= a34;
                    a_in_5 <= a35;
                    a_in_6 <= a36;
                    a_in_7 <= a37;
                end
                3'd4: begin
                    a_in_0 <= a40;
                    a_in_1 <= a41;
                    a_in_2 <= a42;
                    a_in_3 <= a43;
                    a_in_4 <= a44;
                    a_in_5 <= a45;
                    a_in_6 <= a46;
                    a_in_7 <= a47;
                end
                3'd5: begin
                    a_in_0 <= a50;
                    a_in_1 <= a51;
                    a_in_2 <= a52;
                    a_in_3 <= a53;
                    a_in_4 <= a54;
                    a_in_5 <= a55;
                    a_in_6 <= a56;
                    a_in_7 <= a57;
                end
                3'd6: begin
                    a_in_0 <= a60;
                    a_in_1 <= a61;
                    a_in_2 <= a62;
                    a_in_3 <= a63;
                    a_in_4 <= a64;
                    a_in_5 <= a65;
                    a_in_6 <= a66;
                    a_in_7 <= a67;
                end
                3'd7: begin
                    a_in_0 <= a70;
                    a_in_1 <= a71;
                    a_in_2 <= a72;
                    a_in_3 <= a73;
                    a_in_4 <= a74;
                    a_in_5 <= a75;
                    a_in_6 <= a76;
                    a_in_7 <= a77;
                end
                default: begin
                    // 默认情况下，将输出置零
                    a_in_0 <= 16'd0;
                    a_in_1 <= 16'd0;
                    a_in_2 <= 16'd0;
                    a_in_3 <= 16'd0;
                    a_in_4 <= 16'd0;
                    a_in_5 <= 16'd0;
                    a_in_6 <= 16'd0;
                    a_in_7 <= 16'd0;
                end
            endcase
        end else begin
            // 当'valid'为低电平时，重置计数器和输出
            counter <= 3'd0;
            clock_counter <= 4'd0;
            a_in_0 <= 16'd0;
            a_in_1 <= 16'd0;
            a_in_2 <= 16'd0;
            a_in_3 <= 16'd0;
            a_in_4 <= 16'd0;
            a_in_5 <= 16'd0;
            a_in_6 <= 16'd0;
            a_in_7 <= 16'd0;
        end
    end

endmodule
