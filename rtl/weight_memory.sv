`timescale 1ns/1ns

module weight_memory (
  input wire fetch_w, 
  input wire [15:0] ui_in, 
  input wire [5:0] dma_address,

  input wire clk,
  input wire reset,
  input wire load_weight, 
  input wire [5:0] addr, // 6-bit address to address 64 cells.

  output reg [15:0] weight_00,  // Weight for PE(0,0)
  output reg [15:0] weight_01,  // Weight for PE(0,1)
  output reg [15:0] weight_02,  // Weight for PE(0,2)
  output reg [15:0] weight_03,  // Weight for PE(0,3)
  output reg [15:0] weight_04,  // Weight for PE(0,4)
  output reg [15:0] weight_05,  // Weight for PE(0,5)
  output reg [15:0] weight_06,  // Weight for PE(0,6)
  output reg [15:0] weight_07,  // Weight for PE(0,7)

  output reg [15:0] weight_10,  // Weight for PE(1,0)
  output reg [15:0] weight_11,  // Weight for PE(1,1)
  output reg [15:0] weight_12,  // Weight for PE(1,2)
  output reg [15:0] weight_13,  // Weight for PE(1,3)
  output reg [15:0] weight_14,  // Weight for PE(1,4)
  output reg [15:0] weight_15,  // Weight for PE(1,5)
  output reg [15:0] weight_16,  // Weight for PE(1,6)
  output reg [15:0] weight_17,  // Weight for PE(1,7)

  output reg [15:0] weight_20,  // Weight for PE(2,0)
  output reg [15:0] weight_21,  // Weight for PE(2,1)
  output reg [15:0] weight_22,  // Weight for PE(2,2)
  output reg [15:0] weight_23,  // Weight for PE(2,3)
  output reg [15:0] weight_24,  // Weight for PE(2,4)
  output reg [15:0] weight_25,  // Weight for PE(2,5)
  output reg [15:0] weight_26,  // Weight for PE(2,6)
  output reg [15:0] weight_27,  // Weight for PE(2,7)

  output reg [15:0] weight_30,  // Weight for PE(3,0)
  output reg [15:0] weight_31,  // Weight for PE(3,1)
  output reg [15:0] weight_32,  // Weight for PE(3,2)
  output reg [15:0] weight_33,  // Weight for PE(3,3)
  output reg [15:0] weight_34,  // Weight for PE(3,4)
  output reg [15:0] weight_35,  // Weight for PE(3,5)
  output reg [15:0] weight_36,  // Weight for PE(3,6)
  output reg [15:0] weight_37,  // Weight for PE(3,7)

  output reg [15:0] weight_40,  // Weight for PE(4,0)
  output reg [15:0] weight_41,  // Weight for PE(4,1)
  output reg [15:0] weight_42,  // Weight for PE(4,2)
  output reg [15:0] weight_43,  // Weight for PE(4,3)
  output reg [15:0] weight_44,  // Weight for PE(4,4)
  output reg [15:0] weight_45,  // Weight for PE(4,5)
  output reg [15:0] weight_46,  // Weight for PE(4,6)
  output reg [15:0] weight_47,  // Weight for PE(4,7)

  output reg [15:0] weight_50,  // Weight for PE(5,0)
  output reg [15:0] weight_51,  // Weight for PE(5,1)
  output reg [15:0] weight_52,  // Weight for PE(5,2)
  output reg [15:0] weight_53,  // Weight for PE(5,3)
  output reg [15:0] weight_54,  // Weight for PE(5,4)
  output reg [15:0] weight_55,  // Weight for PE(5,5)
  output reg [15:0] weight_56,  // Weight for PE(5,6)
  output reg [15:0] weight_57,  // Weight for PE(5,7)

  output reg [15:0] weight_60,  // Weight for PE(6,0)
  output reg [15:0] weight_61,  // Weight for PE(6,1)
  output reg [15:0] weight_62,  // Weight for PE(6,2)
  output reg [15:0] weight_63,  // Weight for PE(6,3)
  output reg [15:0] weight_64,  // Weight for PE(6,4)
  output reg [15:0] weight_65,  // Weight for PE(6,5)
  output reg [15:0] weight_66,  // Weight for PE(6,6)
  output reg [15:0] weight_67,  // Weight for PE(6,7)

  output reg [15:0] weight_70,  // Weight for PE(7,0)
  output reg [15:0] weight_71,  // Weight for PE(7,1)
  output reg [15:0] weight_72,  // Weight for PE(7,2)
  output reg [15:0] weight_73,  // Weight for PE(7,3)
  output reg [15:0] weight_74,  // Weight for PE(7,4)
  output reg [15:0] weight_75,  // Weight for PE(7,5)
  output reg [15:0] weight_76,  // Weight for PE(7,6)
  output reg [15:0] weight_77   // Weight for PE(7,7)
);

  // 内部寄存器数组，用于存储权重数据
  reg [15:0] weight_mem [0:63];

  // 赋值指令
  integer i;
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // 重置输出端口
      for (i = 0; i < 64; i = i + 1) begin
        weight_mem[i] <= 16'd0;
      end
    end else if (fetch_w) begin
      // 加载权重数据到权重存储器
      weight_mem[dma_address] <= ui_in;
    end else if (load_weight) begin
      // 从存储器中读取数据并输出到权重端口
      {weight_00, weight_01, weight_02, weight_03, weight_04, weight_05, weight_06, weight_07,
       weight_10, weight_11, weight_12, weight_13, weight_14, weight_15, weight_16, weight_17,
       weight_20, weight_21, weight_22, weight_23, weight_24, weight_25, weight_26, weight_27,
       weight_30, weight_31, weight_32, weight_33, weight_34, weight_35, weight_36, weight_37,
       weight_40, weight_41, weight_42, weight_43, weight_44, weight_45, weight_46, weight_47,
       weight_50, weight_51, weight_52, weight_53, weight_54, weight_55, weight_56, weight_57,
       weight_60, weight_61, weight_62, weight_63, weight_64, weight_65, weight_66, weight_67,
       weight_70, weight_71, weight_72, weight_73, weight_74, weight_75, weight_76, weight_77}
      <= {weight_mem[addr], weight_mem[addr+1], weight_mem[addr+2], weight_mem[addr+3],
          weight_mem[addr+4], weight_mem[addr+5], weight_mem[addr+6], weight_mem[addr+7],
          weight_mem[addr+8], weight_mem[addr+9], weight_mem[addr+10], weight_mem[addr+11],
          weight_mem[addr+12], weight_mem[addr+13], weight_mem[addr+14], weight_mem[addr+15],
          weight_mem[addr+16], weight_mem[addr+17], weight_mem[addr+18], weight_mem[addr+19],
          weight_mem[addr+20], weight_mem[addr+21], weight_mem[addr+22], weight_mem[addr+23],
          weight_mem[addr+24], weight_mem[addr+25], weight_mem[addr+26], weight_mem[addr+27],
          weight_mem[addr+28], weight_mem[addr+29], weight_mem[addr+30], weight_mem[addr+31],
          weight_mem[addr+32], weight_mem[addr+33], weight_mem[addr+34], weight_mem[addr+35],
          weight_mem[addr+36], weight_mem[addr+37], weight_mem[addr+38], weight_mem[addr+39],
          weight_mem[addr+40], weight_mem[addr+41], weight_mem[addr+42], weight_mem[addr+43],
          weight_mem[addr+44], weight_mem[addr+45], weight_mem[addr+46], weight_mem[addr+47],
          weight_mem[addr+48], weight_mem[addr+49], weight_mem[addr+50], weight_mem[addr+51],
          weight_mem[addr+52], weight_mem[addr+53], weight_mem[addr+54], weight_mem[addr+55],
          weight_mem[addr+56], weight_mem[addr+57], weight_mem[addr+58], weight_mem[addr+59],
          weight_mem[addr+60], weight_mem[addr+61], weight_mem[addr+62], weight_mem[addr+63]};
    end else begin 
      // If load_weight is low, outputs can be zero or hold previous values
      weight_00 = 16'd0;
      weight_01 = 16'd0;
      weight_02 = 16'd0;
      weight_03 = 16'd0;
      weight_04 = 16'd0;
      weight_05 = 16'd0;
      weight_06 = 16'd0;
      weight_07 = 16'd0;
      weight_10 = 16'd0;
      weight_11 = 16'd0;
      weight_12 = 16'd0;
      weight_13 = 16'd0;
      weight_14 = 16'd0;
      weight_15 = 16'd0;
      weight_16 = 16'd0;
      weight_17 = 16'd0;
      weight_20 = 16'd0;
      weight_21 = 16'd0;
      weight_22 = 16'd0;
      weight_23 = 16'd0;
      weight_24 = 16'd0;
      weight_25 = 16'd0;
      weight_26 = 16'd0;
      weight_27 = 16'd0;
      weight_30 = 16'd0;
      weight_31 = 16'd0;
      weight_32 = 16'd0;
      weight_33 = 16'd0;
      weight_34 = 16'd0;
      weight_35 = 16'd0;
      weight_36 = 16'd0;
      weight_37 = 16'd0;
      weight_40 = 16'd0;
      weight_41 = 16'd0;
      weight_42 = 16'd0;
      weight_43 = 16'd0;
      weight_44 = 16'd0;
      weight_45 = 16'd0;
      weight_46 = 16'd0;
      weight_47 = 16'd0;
      weight_50 = 16'd0;
      weight_51 = 16'd0;
      weight_52 = 16'd0;
      weight_53 = 16'd0;
      weight_54 = 16'd0;
      weight_55 = 16'd0;
      weight_56 = 16'd0;
      weight_57 = 16'd0;
      weight_60 = 16'd0;
      weight_61 = 16'd0;
      weight_62 = 16'd0;
      weight_63 = 16'd0;
      weight_64 = 16'd0;
      weight_65 = 16'd0;
      weight_66 = 16'd0;
      weight_67 = 16'd0;
      weight_70 = 16'd0;
      weight_71 = 16'd0;
      weight_72 = 16'd0;
      weight_73 = 16'd0;
      weight_74 = 16'd0;
      weight_75 = 16'd0;
      weight_76 = 16'd0;
      weight_77 = 16'd0;
    end
  end

endmodule
