`timescale 1ns/1ns 

module tpu (
  input wire clk,
  input wire reset,
  input wire [15:0] ui_in,
  input wire [15:0] uio_in, 
  output wire [15:0] uo_out
);

  // DMA module
  wire fetch_w;
  wire fetch_inp;
  wire fetch_ins;
  wire start;
  wire [5:0] dma_address;

  dma dma_inst (
      .clk(clk),
      .reset(reset),
      .uio_in(uio_in),
      .fetch_w(fetch_w),
      .fetch_inp(fetch_inp),
      .fetch_ins(fetch_ins),
      .start(start),
      .dma_address(dma_address)
  );

  // Control Unit
  wire [5:0] base_address;
  wire load_weight;
  wire load_input;
  wire valid;
  wire store;
  wire ext;

  control_unit ctrl_unit_inst (
      .fetch_ins(fetch_ins),
      .ui_in(ui_in),
      .dma_address(dma_address),

      .clk(clk),
      .reset(reset),
      .start(start),
      .base_address(base_address),
      .load_weight(load_weight),
      .load_input(load_input),
      .valid(valid),
      .store(store),
      .ext(ext)
  );

  // Weight Memory
  wire [15:0] weight_00, weight_01, weight_02, weight_03, weight_04, weight_05, weight_06, weight_07;
  wire [15:0] weight_10, weight_11, weight_12, weight_13, weight_14, weight_15, weight_16, weight_17;
  wire [15:0] weight_20, weight_21, weight_22, weight_23, weight_24, weight_25, weight_26, weight_27;
  wire [15:0] weight_30, weight_31, weight_32, weight_33, weight_34, weight_35, weight_36, weight_37;
  wire [15:0] weight_40, weight_41, weight_42, weight_43, weight_44, weight_45, weight_46, weight_47;
  wire [15:0] weight_50, weight_51, weight_52, weight_53, weight_54, weight_55, weight_56, weight_57;
  wire [15:0] weight_60, weight_61, weight_62, weight_63, weight_64, weight_65, weight_66, weight_67;
  wire [15:0] weight_70, weight_71, weight_72, weight_73, weight_74, weight_75, weight_76, weight_77;

  weight_memory we (
      .fetch_w(fetch_w),
      .ui_in(ui_in),
      .dma_address(dma_address),

      .clk(clk),
      .reset(reset),
      .load_weight(load_weight),
      .addr(base_address),

      .weight_00(weight_00),
      .weight_01(weight_01),
      .weight_02(weight_02),
      .weight_03(weight_03),
      .weight_04(weight_04),
      .weight_05(weight_05),
      .weight_06(weight_06),
      .weight_07(weight_07),
      .weight_10(weight_10),
      .weight_11(weight_11),
      .weight_12(weight_12),
      .weight_13(weight_13),
      .weight_14(weight_14),
      .weight_15(weight_15),
      .weight_16(weight_16),
      .weight_17(weight_17),
      .weight_20(weight_20),
      .weight_21(weight_21),
      .weight_22(weight_22),
      .weight_23(weight_23),
      .weight_24(weight_24),
      .weight_25(weight_25),
      .weight_26(weight_26),
      .weight_27(weight_27),
      .weight_30(weight_30),
      .weight_31(weight_31),
      .weight_32(weight_32),
      .weight_33(weight_33),
      .weight_34(weight_34),
      .weight_35(weight_35),
      .weight_36(weight_36),
      .weight_37(weight_37),
      .weight_40(weight_40),
      .weight_41(weight_41),
      .weight_42(weight_42),
      .weight_43(weight_43),
      .weight_44(weight_44),
      .weight_45(weight_45),
      .weight_46(weight_46),
      .weight_47(weight_47),
      .weight_50(weight_50),
      .weight_51(weight_51),
      .weight_52(weight_52),
      .weight_53(weight_53),
      .weight_54(weight_54),
      .weight_55(weight_55),
      .weight_56(weight_56),
      .weight_57(weight_57),
      .weight_60(weight_60),
      .weight_61(weight_61),
      .weight_62(weight_62),
      .weight_63(weight_63),
      .weight_64(weight_64),
      .weight_65(weight_65),
      .weight_66(weight_66),
      .weight_67(weight_67),
      .weight_70(weight_70),
      .weight_71(weight_71),
      .weight_72(weight_72),
      .weight_73(weight_73),
      .weight_74(weight_74),
      .weight_75(weight_75),
      .weight_76(weight_76),
      .weight_77(weight_77)
  );

  // Unified Buffer
  wire [15:0] out_ub_00, out_ub_01, out_ub_02, out_ub_03, out_ub_04, out_ub_05, out_ub_06, out_ub_07;
  wire [15:0] out_ub_10, out_ub_11, out_ub_12, out_ub_13, out_ub_14, out_ub_15, out_ub_16, out_ub_17;
  wire [15:0] out_ub_20, out_ub_21, out_ub_22, out_ub_23, out_ub_24, out_ub_25, out_ub_26, out_ub_27;
  wire [15:0] out_ub_30, out_ub_31, out_ub_32, out_ub_33, out_ub_34, out_ub_35, out_ub_36, out_ub_37;
  wire [15:0] out_ub_40, out_ub_41, out_ub_42, out_ub_43, out_ub_44, out_ub_45, out_ub_46, out_ub_47;
  wire [15:0] out_ub_50, out_ub_51, out_ub_52, out_ub_53, out_ub_54, out_ub_55, out_ub_56, out_ub_57;
  wire [15:0] out_ub_60, out_ub_61, out_ub_62, out_ub_63, out_ub_64, out_ub_65, out_ub_66, out_ub_67;
  wire [15:0] out_ub_70, out_ub_71, out_ub_72, out_ub_73, out_ub_74, out_ub_75, out_ub_76, out_ub_77;

  wire [15:0] final_out;

  // Wires for accumulators

  // Wires for activation inputs to unified_buffer
  wire [15:0] activation_00, activation_01, activation_02, activation_03, activation_04, activation_05, activation_06, activation_07;
  wire [15:0] activation_10, activation_11, activation_12, activation_13, activation_14, activation_15, activation_16, activation_17;
  wire [15:0] activation_20, activation_21, activation_22, activation_23, activation_24, activation_25, activation_26, activation_27;
  wire [15:0] activation_30, activation_31, activation_32, activation_33, activation_34, activation_35, activation_36, activation_37;
  wire [15:0] activation_40, activation_41, activation_42, activation_43, activation_44, activation_45, activation_46, activation_47;
  wire [15:0] activation_50, activation_51, activation_52, activation_53, activation_54, activation_55, activation_56, activation_57;
  wire [15:0] activation_60, activation_61, activation_62, activation_63, activation_64, activation_65, activation_66, activation_67;
  wire [15:0] activation_70, activation_71, activation_72, activation_73, activation_74, activation_75, activation_76, activation_77;

  unified_buffer ub (
      .fetch_inp(fetch_inp),
      .ui_in(ui_in),
      .dma_address(dma_address),

      .clk(clk),
      .reset(reset),

      .full_acc0(full_acc0),
      .full_acc1(full_acc1),
      .full_acc2(full_acc2),
      .full_acc3(full_acc3),
      .full_acc4(full_acc4),
      .full_acc5(full_acc5),
      .full_acc6(full_acc6),
      .full_acc7(full_acc7),

      .addr(base_address),
      .load_input(load_input),

      .store(store),
      .ext(ext),

      .activation_00(activation_00),
      .activation_01(activation_01),
      .activation_02(activation_02),
      .activation_03(activation_03),
      .activation_04(activation_04),
      .activation_05(activation_05),
      .activation_06(activation_06),
      .activation_07(activation_07),
      .activation_10(activation_10),
      .activation_11(activation_11),
      .activation_12(activation_12),
      .activation_13(activation_13),
      .activation_14(activation_14),
      .activation_15(activation_15),
      .activation_16(activation_16),
      .activation_17(activation_17),
      .activation_20(activation_20),
      .activation_21(activation_21),
      .activation_22(activation_22),
      .activation_23(activation_23),
      .activation_24(activation_24),
      .activation_25(activation_25),
      .activation_26(activation_26),
      .activation_27(activation_27),
      .activation_30(activation_30),
      .activation_31(activation_31),
      .activation_32(activation_32),
      .activation_33(activation_33),
      .activation_34(activation_34),
      .activation_35(activation_35),
      .activation_36(activation_36),
      .activation_37(activation_37),
      .activation_40(activation_40),
      .activation_41(activation_41),
      .activation_42(activation_42),
      .activation_43(activation_43),
      .activation_44(activation_44),
      .activation_45(activation_45),
      .activation_46(activation_46),
      .activation_47(activation_47),
      .activation_50(activation_50),
      .activation_51(activation_51),
      .activation_52(activation_52),
      .activation_53(activation_53),
      .activation_54(activation_54),
      .activation_55(activation_55),
      .activation_56(activation_56),
      .activation_57(activation_57),
      .activation_60(activation_60),
      .activation_61(activation_61),
      .activation_62(activation_62),
      .activation_63(activation_63),
      .activation_64(activation_64),
      .activation_65(activation_65),
      .activation_66(activation_66),
      .activation_67(activation_67),
      .activation_70(activation_70),
      .activation_71(activation_71),
      .activation_72(activation_72),
      .activation_73(activation_73),
      .activation_74(activation_74),
      .activation_75(activation_75),
      .activation_76(activation_76),
      .activation_77(activation_77),
      .out_ub_00(out_ub_00),
      .out_ub_01(out_ub_01),
      .out_ub_02(out_ub_02),
      .out_ub_03(out_ub_03),
      .out_ub_04(out_ub_04),
      .out_ub_05(out_ub_05),
      .out_ub_06(out_ub_06),
      .out_ub_07(out_ub_07),
      .out_ub_10(out_ub_10),
      .out_ub_11(out_ub_11),
      .out_ub_12(out_ub_12),
      .out_ub_13(out_ub_13),
      .out_ub_14(out_ub_14),
      .out_ub_15(out_ub_15),
      .out_ub_16(out_ub_16),
      .out_ub_17(out_ub_17),
      .out_ub_20(out_ub_20),
      .out_ub_21(out_ub_21),
      .out_ub_22(out_ub_22),
      .out_ub_23(out_ub_23),
      .out_ub_24(out_ub_24),
      .out_ub_25(out_ub_25),
      .out_ub_26(out_ub_26),
      .out_ub_27(out_ub_27),
      .out_ub_30(out_ub_30),
      .out_ub_31(out_ub_31),
      .out_ub_32(out_ub_32),
      .out_ub_33(out_ub_33),
      .out_ub_34(out_ub_34),
      .out_ub_35(out_ub_35),
      .out_ub_36(out_ub_36),
      .out_ub_37(out_ub_37),
      .out_ub_40(out_ub_40),
      .out_ub_41(out_ub_41),
      .out_ub_42(out_ub_42),
      .out_ub_43(out_ub_43),
      .out_ub_44(out_ub_44),
      .out_ub_45(out_ub_45),
      .out_ub_46(out_ub_46),
      .out_ub_47(out_ub_47),
      .out_ub_50(out_ub_50),
      .out_ub_51(out_ub_51),
      .out_ub_52(out_ub_52),
      .out_ub_53(out_ub_53),
      .out_ub_54(out_ub_54),
      .out_ub_55(out_ub_55),
      .out_ub_56(out_ub_56),
      .out_ub_57(out_ub_57),
      .out_ub_60(out_ub_60),
      .out_ub_61(out_ub_61),
      .out_ub_62(out_ub_62),
      .out_ub_63(out_ub_63),
      .out_ub_64(out_ub_64),
      .out_ub_65(out_ub_65),
      .out_ub_66(out_ub_66),
      .out_ub_67(out_ub_67),
      .out_ub_70(out_ub_70),
      .out_ub_71(out_ub_71),
      .out_ub_72(out_ub_72),
      .out_ub_73(out_ub_73),
      .out_ub_74(out_ub_74),
      .out_ub_75(out_ub_75),
      .out_ub_76(out_ub_76),
      .out_ub_77(out_ub_77),
      .final_out(uo_out)
  );

  // Input Setup
  wire [15:0] a_in_0, a_in_1, a_in_2, a_in_3, a_in_4, a_in_5, a_in_6, a_in_7;

  input_setup ii (
      .clk(clk),
      .reset(reset),
      .valid(valid),

      .a00(out_ub_00),
      .a01(out_ub_01),
      .a02(out_ub_02),
      .a03(out_ub_03),
      .a04(out_ub_04),
      .a05(out_ub_05),
      .a06(out_ub_06),
      .a07(out_ub_07),
      .a10(out_ub_10),
      .a11(out_ub_11),
      .a12(out_ub_12),
      .a13(out_ub_13),
      .a14(out_ub_14),
      .a15(out_ub_15),
      .a16(out_ub_16),
      .a17(out_ub_17),
      .a20(out_ub_20),
      .a21(out_ub_21),
      .a22(out_ub_22),
      .a23(out_ub_23),
      .a24(out_ub_24),
      .a25(out_ub_25),
      .a26(out_ub_26),
      .a27(out_ub_27),
      .a30(out_ub_30),
      .a31(out_ub_31),
      .a32(out_ub_32),
      .a33(out_ub_33),
      .a34(out_ub_34),
      .a35(out_ub_35),
      .a36(out_ub_36),
      .a37(out_ub_37),
      .a40(out_ub_40),
      .a41(out_ub_41),
      .a42(out_ub_42),
      .a43(out_ub_43),
      .a44(out_ub_44),
      .a45(out_ub_45),
      .a46(out_ub_46),
      .a47(out_ub_47),
      .a50(out_ub_50),
      .a51(out_ub_51),
      .a52(out_ub_52),
      .a53(out_ub_53),
      .a54(out_ub_54),
      .a55(out_ub_55),
      .a56(out_ub_56),
      .a57(out_ub_57),
      .a60(out_ub_60),
      .a61(out_ub_61),
      .a62(out_ub_62),
      .a63(out_ub_63),
      .a64(out_ub_64),
      .a65(out_ub_65),
      .a66(out_ub_66),
      .a67(out_ub_67),
      .a70(out_ub_70),
      .a71(out_ub_71),
      .a72(out_ub_72),
      .a73(out_ub_73),
      .a74(out_ub_74),
      .a75(out_ub_75),
      .a76(out_ub_76),
      .a77(out_ub_77),
      .a_in_0(a_in_0),
      .a_in_1(a_in_1),
      .a_in_2(a_in_2),
      .a_in_3(a_in_3),
      .a_in_4(a_in_4),
      .a_in_5(a_in_5),
      .a_in_6(a_in_6),
      .a_in_7(a_in_7)
  );

  // Systolic Array
  wire [15:0] acc_out_0, acc_out_1, acc_out_2, acc_out_3, acc_out_4, acc_out_5, acc_out_6, acc_out_7;
  wire output_valid;
  systolic_array tolic (
      .clk(clk),
      .reset(reset),
      .load_weight(load_weight),
      .valid(valid),

      .a_in_0(a_in_0),
      .a_in_1(a_in_1),
      .a_in_2(a_in_2),
      .a_in_3(a_in_3),
      .a_in_4(a_in_4),
      .a_in_5(a_in_5),
      .a_in_6(a_in_6),
      .a_in_7(a_in_7),

      .weight_00(weight_00),
      .weight_01(weight_01),
      .weight_02(weight_02),
      .weight_03(weight_03),
      .weight_04(weight_04),
      .weight_05(weight_05),
      .weight_06(weight_06),
      .weight_07(weight_07),
      .weight_10(weight_10),
      .weight_11(weight_11),
      .weight_12(weight_12),
      .weight_13(weight_13),
      .weight_14(weight_14),
      .weight_15(weight_15),
      .weight_16(weight_16),
      .weight_17(weight_17),
      .weight_20(weight_20),
      .weight_21(weight_21),
      .weight_22(weight_22),
      .weight_23(weight_23),
      .weight_24(weight_24),
      .weight_25(weight_25),
      .weight_26(weight_26),
      .weight_27(weight_27),
      .weight_30(weight_30),
      .weight_31(weight_31),
      .weight_32(weight_32),
      .weight_33(weight_33),
      .weight_34(weight_34),
      .weight_35(weight_35),
      .weight_36(weight_36),
      .weight_37(weight_37),
      .weight_40(weight_40),
      .weight_41(weight_41),
      .weight_42(weight_42),
      .weight_43(weight_43),
      .weight_44(weight_44),
      .weight_45(weight_45),
      .weight_46(weight_46),
      .weight_47(weight_47),
      .weight_50(weight_50),
      .weight_51(weight_51),
      .weight_52(weight_52),
      .weight_53(weight_53),
      .weight_54(weight_54),
      .weight_55(weight_55),
      .weight_56(weight_56),
      .weight_57(weight_57),
      .weight_60(weight_60),
      .weight_61(weight_61),
      .weight_62(weight_62),
      .weight_63(weight_63),
      .weight_64(weight_64),
      .weight_65(weight_65),
      .weight_66(weight_66),
      .weight_67(weight_67),
      .weight_70(weight_70),
      .weight_71(weight_71),
      .weight_72(weight_72),
      .weight_73(weight_73),
      .weight_74(weight_74),
      .weight_75(weight_75),
      .weight_76(weight_76),
      .weight_77(weight_77),
      .acc_out_0(acc_out_0),
      .acc_out_1(acc_out_1),
      .acc_out_2(acc_out_2),
      .acc_out_3(acc_out_3),
      .acc_out_4(acc_out_4),
      .acc_out_5(acc_out_5),
      .acc_out_6(acc_out_6),
      .acc_out_7(acc_out_7),
      .output_valid(output_valid)//the signal of output change 
  );


  // Accumulators
  wire full_acc0, full_acc1, full_acc2, full_acc3, full_acc4, full_acc5, full_acc6, full_acc7;
  wire [15:0] acc0_mem_0, acc0_mem_1, acc0_mem_2, acc0_mem_3, acc0_mem_4, acc0_mem_5, acc0_mem_6, acc0_mem_7;
  wire [15:0] acc1_mem_0, acc1_mem_1, acc1_mem_2, acc1_mem_3, acc1_mem_4, acc1_mem_5, acc1_mem_6, acc1_mem_7;
  wire [15:0] acc2_mem_0, acc2_mem_1, acc2_mem_2, acc2_mem_3, acc2_mem_4, acc2_mem_5, acc2_mem_6, acc2_mem_7;
  wire [15:0] acc3_mem_0, acc3_mem_1, acc3_mem_2, acc3_mem_3, acc3_mem_4, acc3_mem_5, acc3_mem_6, acc3_mem_7;
  wire [15:0] acc4_mem_0, acc4_mem_1, acc4_mem_2, acc4_mem_3, acc4_mem_4, acc4_mem_5, acc4_mem_6, acc4_mem_7;
  wire [15:0] acc5_mem_0, acc5_mem_1, acc5_mem_2, acc5_mem_3, acc5_mem_4, acc5_mem_5, acc5_mem_6, acc5_mem_7;
  wire [15:0] acc6_mem_0, acc6_mem_1, acc6_mem_2, acc6_mem_3, acc6_mem_4, acc6_mem_5, acc6_mem_6, acc6_mem_7;
  wire [15:0] acc7_mem_0, acc7_mem_1, acc7_mem_2, acc7_mem_3, acc7_mem_4, acc7_mem_5, acc7_mem_6, acc7_mem_7;
  // Accumulator 0
  accumulator acc0 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_0),
      .output_valid(output_valid), 

      .acc_mem_0(acc0_mem_0),
      .acc_mem_1(acc0_mem_1),
      .acc_mem_2(acc0_mem_2),
      .acc_mem_3(acc0_mem_3),
      .acc_mem_4(acc0_mem_4),
      .acc_mem_5(acc0_mem_5),
      .acc_mem_6(acc0_mem_6),
      .acc_mem_7(acc0_mem_7),
      .full(full_acc0)
  );
  // ReLU activation module0
  wire [15:0] relu_out_00, relu_out_01, relu_out_02, relu_out_03, relu_out_04, relu_out_05, relu_out_06, relu_out_07;

  relu relu00 (.enable(1'b1), .i(acc0_mem_0), .z(relu_out_00));
  relu relu01 (.enable(1'b1), .i(acc0_mem_1), .z(relu_out_01));
  relu relu02 (.enable(1'b1), .i(acc0_mem_2), .z(relu_out_02));
  relu relu03 (.enable(1'b1), .i(acc0_mem_3), .z(relu_out_03));
  relu relu04 (.enable(1'b1), .i(acc0_mem_4), .z(relu_out_04));
  relu relu05 (.enable(1'b1), .i(acc0_mem_5), .z(relu_out_05));
  relu relu06 (.enable(1'b1), .i(acc0_mem_6), .z(relu_out_06));
  relu relu07 (.enable(1'b1), .i(acc0_mem_7), .z(relu_out_07));

  // Accumulator 1
  accumulator acc1 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_1),
      .output_valid(output_valid), 
      .acc_mem_0(acc1_mem_0),
      .acc_mem_1(acc1_mem_1),
      .acc_mem_2(acc1_mem_2),
      .acc_mem_3(acc1_mem_3),
      .acc_mem_4(acc1_mem_4),
      .acc_mem_5(acc1_mem_5),
      .acc_mem_6(acc1_mem_6),
      .acc_mem_7(acc1_mem_7),
      .full(full_acc1)
  );

  // ReLU activation module1
  wire [15:0] relu_out_10, relu_out_11, relu_out_12, relu_out_13, relu_out_14, relu_out_15, relu_out_16, relu_out_17;

  relu relu10 (.enable(1'b1), .i(acc1_mem_0), .z(relu_out_10));
  relu relu11 (.enable(1'b1), .i(acc1_mem_1), .z(relu_out_11));
  relu relu12 (.enable(1'b1), .i(acc1_mem_2), .z(relu_out_12));
  relu relu13 (.enable(1'b1), .i(acc1_mem_3), .z(relu_out_13));
  relu relu14 (.enable(1'b1), .i(acc1_mem_4), .z(relu_out_14));
  relu relu15 (.enable(1'b1), .i(acc1_mem_5), .z(relu_out_15));
  relu relu16 (.enable(1'b1), .i(acc1_mem_6), .z(relu_out_16));
  relu relu17 (.enable(1'b1), .i(acc1_mem_7), .z(relu_out_17));

  // Accumulator 2
  accumulator acc2 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_2),
      .output_valid(output_valid), 
      .acc_mem_0(acc2_mem_0),
      .acc_mem_1(acc2_mem_1),
      .acc_mem_2(acc2_mem_2),
      .acc_mem_3(acc2_mem_3),
      .acc_mem_4(acc2_mem_4),
      .acc_mem_5(acc2_mem_5),
      .acc_mem_6(acc2_mem_6),
      .acc_mem_7(acc2_mem_7),
      .full(full_acc2)
  );

  // ReLU activation module2
  wire [15:0] relu_out_20, relu_out_21, relu_out_22, relu_out_23, relu_out_24, relu_out_25, relu_out_26, relu_out_27;

  relu relu20 (.enable(1'b1), .i(acc2_mem_0), .z(relu_out_20));
  relu relu21 (.enable(1'b1), .i(acc2_mem_1), .z(relu_out_21));
  relu relu22 (.enable(1'b1), .i(acc2_mem_2), .z(relu_out_22));
  relu relu23 (.enable(1'b1), .i(acc2_mem_3), .z(relu_out_23));
  relu relu24 (.enable(1'b1), .i(acc2_mem_4), .z(relu_out_24));
  relu relu25 (.enable(1'b1), .i(acc2_mem_5), .z(relu_out_25));
  relu relu26 (.enable(1'b1), .i(acc2_mem_6), .z(relu_out_26));
  relu relu27 (.enable(1'b1), .i(acc2_mem_7), .z(relu_out_27));

  // Accumulator 3
  accumulator acc3 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_3),
      .output_valid(output_valid), 
      .acc_mem_0(acc3_mem_0),
      .acc_mem_1(acc3_mem_1),
      .acc_mem_2(acc3_mem_2),
      .acc_mem_3(acc3_mem_3),
      .acc_mem_4(acc3_mem_4),
      .acc_mem_5(acc3_mem_5),
      .acc_mem_6(acc3_mem_6),
      .acc_mem_7(acc3_mem_7),
      .full(full_acc3)
  );

  // ReLU activation module3
  wire [15:0] relu_out_30, relu_out_31, relu_out_32, relu_out_33, relu_out_34, relu_out_35, relu_out_36, relu_out_37;

  relu relu30 (.enable(1'b1), .i(acc3_mem_0), .z(relu_out_30));
  relu relu31 (.enable(1'b1), .i(acc3_mem_1), .z(relu_out_31));
  relu relu32 (.enable(1'b1), .i(acc3_mem_2), .z(relu_out_32));
  relu relu33 (.enable(1'b1), .i(acc3_mem_3), .z(relu_out_33));
  relu relu34 (.enable(1'b1), .i(acc3_mem_4), .z(relu_out_34));
  relu relu35 (.enable(1'b1), .i(acc3_mem_5), .z(relu_out_35));
  relu relu36 (.enable(1'b1), .i(acc3_mem_6), .z(relu_out_36));
  relu relu37 (.enable(1'b1), .i(acc3_mem_7), .z(relu_out_37));

  // Accumulator 4
  accumulator acc4 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_4),
      .output_valid(output_valid), 
      .acc_mem_0(acc4_mem_0),
      .acc_mem_1(acc4_mem_1),
      .acc_mem_2(acc4_mem_2),
      .acc_mem_3(acc4_mem_3),
      .acc_mem_4(acc4_mem_4),
      .acc_mem_5(acc4_mem_5),
      .acc_mem_6(acc4_mem_6),
      .acc_mem_7(acc4_mem_7),
      .full(full_acc4)
  );

  // ReLU activation module4
  wire [15:0] relu_out_40, relu_out_41, relu_out_42, relu_out_43, relu_out_44, relu_out_45, relu_out_46, relu_out_47;

  relu relu40 (.enable(1'b1), .i(acc4_mem_0), .z(relu_out_40));
  relu relu41 (.enable(1'b1), .i(acc4_mem_1), .z(relu_out_41));
  relu relu42 (.enable(1'b1), .i(acc4_mem_2), .z(relu_out_42));
  relu relu43 (.enable(1'b1), .i(acc4_mem_3), .z(relu_out_43));
  relu relu44 (.enable(1'b1), .i(acc4_mem_4), .z(relu_out_44));
  relu relu45 (.enable(1'b1), .i(acc4_mem_5), .z(relu_out_45));
  relu relu46 (.enable(1'b1), .i(acc4_mem_6), .z(relu_out_46));
  relu relu47 (.enable(1'b1), .i(acc4_mem_7), .z(relu_out_47));


  // Accumulator 5
  accumulator acc5 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_5),
      .output_valid(output_valid), 
      .acc_mem_0(acc5_mem_0),
      .acc_mem_1(acc5_mem_1),
      .acc_mem_2(acc5_mem_2),
      .acc_mem_3(acc5_mem_3),
      .acc_mem_4(acc5_mem_4),
      .acc_mem_5(acc5_mem_5),
      .acc_mem_6(acc5_mem_6),
      .acc_mem_7(acc5_mem_7),
      .full(full_acc5)
  );
  // ReLU activation module5
  wire [15:0] relu_out_50, relu_out_51, relu_out_52, relu_out_53, relu_out_54, relu_out_55, relu_out_56, relu_out_57;

  relu relu50 (.enable(1'b1), .i(acc5_mem_0), .z(relu_out_50));
  relu relu51 (.enable(1'b1), .i(acc5_mem_1), .z(relu_out_51));
  relu relu52 (.enable(1'b1), .i(acc5_mem_2), .z(relu_out_52));
  relu relu53 (.enable(1'b1), .i(acc5_mem_3), .z(relu_out_53));
  relu relu54 (.enable(1'b1), .i(acc5_mem_4), .z(relu_out_54));
  relu relu55 (.enable(1'b1), .i(acc5_mem_5), .z(relu_out_55));
  relu relu56 (.enable(1'b1), .i(acc5_mem_6), .z(relu_out_56));
  relu relu57 (.enable(1'b1), .i(acc5_mem_7), .z(relu_out_57));

  // Accumulator 6
  accumulator acc6 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_6),
      .output_valid(output_valid), 
      .acc_mem_0(acc6_mem_0),
      .acc_mem_1(acc6_mem_1),
      .acc_mem_2(acc6_mem_2),
      .acc_mem_3(acc6_mem_3),
      .acc_mem_4(acc6_mem_4),
      .acc_mem_5(acc6_mem_5),
      .acc_mem_6(acc6_mem_6),
      .acc_mem_7(acc6_mem_7),
      .full(full_acc6)
  );

  // ReLU activation module6
  wire [15:0] relu_out_60, relu_out_61, relu_out_62, relu_out_63, relu_out_64, relu_out_65, relu_out_66, relu_out_67;

  relu relu60 (.enable(1'b1), .i(acc6_mem_0), .z(relu_out_60));
  relu relu61 (.enable(1'b1), .i(acc6_mem_1), .z(relu_out_61));
  relu relu62 (.enable(1'b1), .i(acc6_mem_2), .z(relu_out_62));
  relu relu63 (.enable(1'b1), .i(acc6_mem_3), .z(relu_out_63));
  relu relu64 (.enable(1'b1), .i(acc6_mem_4), .z(relu_out_64));
  relu relu65 (.enable(1'b1), .i(acc6_mem_5), .z(relu_out_65));
  relu relu66 (.enable(1'b1), .i(acc6_mem_6), .z(relu_out_66));
  relu relu67 (.enable(1'b1), .i(acc6_mem_7), .z(relu_out_67));


  // Accumulator 7
  accumulator acc7 (
      .clk(clk),
      .reset(reset),
      .valid(valid),
      .acc_in(acc_out_7),
      .output_valid(output_valid), 
      .acc_mem_0(acc7_mem_0),
      .acc_mem_1(acc7_mem_1),
      .acc_mem_2(acc7_mem_2),
      .acc_mem_3(acc7_mem_3),
      .acc_mem_4(acc7_mem_4),
      .acc_mem_5(acc7_mem_5),
      .acc_mem_6(acc7_mem_6),
      .acc_mem_7(acc7_mem_7),
      .full(full_acc7)
  );

  // ReLU activation module7
  wire [15:0] relu_out_70, relu_out_71, relu_out_72, relu_out_73, relu_out_74, relu_out_75, relu_out_76, relu_out_77;

  relu relu70 (.enable(1'b1), .i(acc7_mem_0), .z(relu_out_70));
  relu relu71 (.enable(1'b1), .i(acc7_mem_1), .z(relu_out_71));
  relu relu72 (.enable(1'b1), .i(acc7_mem_2), .z(relu_out_72));
  relu relu73 (.enable(1'b1), .i(acc7_mem_3), .z(relu_out_73));
  relu relu74 (.enable(1'b1), .i(acc7_mem_4), .z(relu_out_74));
  relu relu75 (.enable(1'b1), .i(acc7_mem_5), .z(relu_out_75));
  relu relu76 (.enable(1'b1), .i(acc7_mem_6), .z(relu_out_76));
  relu relu77 (.enable(1'b1), .i(acc7_mem_7), .z(relu_out_77));

  // Map accumulator outputs to activation_XY inputs of unified_buffer
  // Accumulator 0
  assign activation_00 = relu_out_00;
  assign activation_01 = relu_out_10;
  assign activation_02 = relu_out_20;
  assign activation_03 = relu_out_30;
  assign activation_04 = relu_out_40;
  assign activation_05 = relu_out_50;
  assign activation_06 = relu_out_60;
  assign activation_07 = relu_out_70;

  // Accumulator 1
  assign activation_10 = relu_out_01;
  assign activation_11 = relu_out_11;
  assign activation_12 = relu_out_21;
  assign activation_13 = relu_out_31;
  assign activation_14 = relu_out_41;
  assign activation_15 = relu_out_51;
  assign activation_16 = relu_out_61;
  assign activation_17 = relu_out_71;

  // Accumulator 2
  assign activation_20 = relu_out_02;
  assign activation_21 = relu_out_12;
  assign activation_22 = relu_out_22;
  assign activation_23 = relu_out_32;
  assign activation_24 = relu_out_42;
  assign activation_25 = relu_out_52;
  assign activation_26 = relu_out_62;
  assign activation_27 = relu_out_72;

  // Accumulator 3
  assign activation_30 = relu_out_03;
  assign activation_31 = relu_out_13;
  assign activation_32 = relu_out_23;
  assign activation_33 = relu_out_33;
  assign activation_34 = relu_out_43;
  assign activation_35 = relu_out_53;
  assign activation_36 = relu_out_63;
  assign activation_37 = relu_out_73;

  // Accumulator 4
  assign activation_40 = relu_out_04;
  assign activation_41 = relu_out_14;
  assign activation_42 = relu_out_24;
  assign activation_43 = relu_out_34;
  assign activation_44 = relu_out_44;
  assign activation_45 = relu_out_54;
  assign activation_46 = relu_out_64;
  assign activation_47 = relu_out_74;

  // Accumulator 5
  assign activation_50 = relu_out_05;
  assign activation_51 = relu_out_15;
  assign activation_52 = relu_out_25;
  assign activation_53 = relu_out_35;
  assign activation_54 = relu_out_45;
  assign activation_55 = relu_out_55;
  assign activation_56 = relu_out_65;
  assign activation_57 = relu_out_75;

  // Accumulator 6
  assign activation_60 = relu_out_06;
  assign activation_61 = relu_out_16;
  assign activation_62 = relu_out_26;
  assign activation_63 = relu_out_36;
  assign activation_64 = relu_out_46;
  assign activation_65 = relu_out_56;
  assign activation_66 = relu_out_66;
  assign activation_67 = relu_out_76;

  // Accumulator 7
  assign activation_70 = relu_out_07;
  assign activation_71 = relu_out_17;
  assign activation_72 = relu_out_27;
  assign activation_73 = relu_out_37;
  assign activation_74 = relu_out_47;
  assign activation_75 = relu_out_57;
  assign activation_76 = relu_out_67;
  assign activation_77 = relu_out_77;

endmodule
