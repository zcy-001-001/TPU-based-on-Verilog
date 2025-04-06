`timescale 1ns/1ns

module accumulator (
  input wire clk,
  input wire reset,
  input wire valid,
  input wire [15:0] acc_in,
  input wire output_valid, 
  output reg [15:0] acc_mem_0, // Output for the 1st memory location
  output reg [15:0] acc_mem_1, // Output for the 2nd memory location
  output reg [15:0] acc_mem_2, // Output for the 3rd memory location
  output reg [15:0] acc_mem_3, // Output for the 4th memory location
  output reg [15:0] acc_mem_4, // Output for the 5th memory location
  output reg [15:0] acc_mem_5, // Output for the 6th memory location
  output reg [15:0] acc_mem_6, // Output for the 7th memory location
  output reg [15:0] acc_mem_7, // Output for the 8th memory location

  output reg full // Flag to indicate when the accumulator is full
);

  // Define a register array to store multiple accumulated values
  reg [15:0] acc_mem [0:7];
  reg [3:0] index; // Index to manage storage locations
  integer i; // Declare integer outside of the always block

//可能不存在上升沿，前后两信号值相同
// reg [15:0] acc_in1;
// reg pos_acc;

// always @(posedge clk or posedge reset) begin
//   if (reset) begin
//     acc_in1 <= 16'b0;
//     pos_acc <= 1'b0;
//   end else begin
//     // 比较当前的 acc_in 和前一个时钟周期的 acc_in1
//     if (acc_in != acc_in1)
//       pos_acc <= 1'b1;
//     else
//       pos_acc <= 1'b0;
    
//     // 更新 acc_in1 为当前的 acc_in，用于下一个时钟周期的比较
//     acc_in1 <= acc_in;
//   end
// end
reg output_valid_delay1;
reg output_valid_delay2;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      for (i = 0; i < 8; i = i + 1) begin
          acc_mem[i] <= 0;
      end

      index <= 0;
      full <= 0;
      acc_mem_0 <= 0;
      acc_mem_1 <= 0; 
      acc_mem_2 <= 0;
      acc_mem_3 <= 0; 
      acc_mem_4 <= 0;
      acc_mem_5 <= 0; 
      acc_mem_6 <= 0;
      acc_mem_7 <= 0;       
    
    end else begin
      // Nothing starts until valid (compute) flag is set.
      // Valid flag must be held high for compute to finish.
      //错误原因在脉动阵列的输出上，把中间计算的结果输出，应该等一次计算完后整体输出
      //增加判断条件：当前acc_in和上一acc_in不一样时才写入，利用上升沿作为出发条件，否则
      //会导致一个相同的值重复写多次 可能不存在上升沿，前后两信号值相同
      //在这里output_valid==1时直接赋值会导致0写入，
      //因为同时会进行acc_in的赋值，必须延时一个周期来满足acc_in的赋值成功
      output_valid_delay1<=output_valid;
      output_valid_delay2<=output_valid_delay1;
      if ((valid && output_valid_delay2)||(valid && (index==8))) begin

        if (index < 8) begin
          acc_mem[index] <= acc_in;
          index <= index + 1;
        end else begin
          acc_mem_0 <= acc_mem[0]; 
          acc_mem_1 <= acc_mem[1];
          acc_mem_2 <= acc_mem[2]; 
          acc_mem_3 <= acc_mem[3];
          acc_mem_4 <= acc_mem[4]; 
          acc_mem_5 <= acc_mem[5];
          acc_mem_6 <= acc_mem[6]; 
          acc_mem_7 <= acc_mem[7];
          full <= 1; 
        end

      end 
    end
  end

endmodule