`default_nettype none
`timescale 1ns/1ns

module unified_buffer (
    input wire fetch_inp,
    input wire [15:0] ui_in, 
    input wire [5:0] dma_address,

    input wire clk,
    input wire reset,

    input wire full_acc0, // full flag from accumulator 0
    input wire full_acc1, // full flag from accumulator 1
    input wire full_acc2, // full flag from accumulator 2
    input wire full_acc3, // full flag from accumulator 3
    input wire full_acc4, // full flag from accumulator 4
    input wire full_acc5, // full flag from accumulator 5
    input wire full_acc6, // full flag from accumulator 6
    input wire full_acc7, // full flag from accumulator 7

    input wire [5:0] addr, // address to input to
    input wire load_input, // flag for loading input from own memory to input_setup buffer

    input wire store, // flag for storing data from accumulators to unified buffer
    input wire ext, // flag for output to host computer

    input wire [15:0] activation_00,
    input wire [15:0] activation_01,
    input wire [15:0] activation_02,
    input wire [15:0] activation_03,
    input wire [15:0] activation_04,
    input wire [15:0] activation_05,
    input wire [15:0] activation_06,
    input wire [15:0] activation_07,

    input wire [15:0] activation_10,
    input wire [15:0] activation_11,
    input wire [15:0] activation_12,
    input wire [15:0] activation_13,
    input wire [15:0] activation_14,
    input wire [15:0] activation_15,
    input wire [15:0] activation_16,
    input wire [15:0] activation_17,

    input wire [15:0] activation_20,
    input wire [15:0] activation_21,
    input wire [15:0] activation_22,
    input wire [15:0] activation_23,
    input wire [15:0] activation_24,
    input wire [15:0] activation_25,
    input wire [15:0] activation_26,
    input wire [15:0] activation_27,

    input wire [15:0] activation_30,
    input wire [15:0] activation_31,
    input wire [15:0] activation_32,
    input wire [15:0] activation_33,
    input wire [15:0] activation_34,
    input wire [15:0] activation_35,
    input wire [15:0] activation_36,
    input wire [15:0] activation_37,

    input wire [15:0] activation_40,
    input wire [15:0] activation_41,
    input wire [15:0] activation_42,
    input wire [15:0] activation_43,
    input wire [15:0] activation_44,
    input wire [15:0] activation_45,
    input wire [15:0] activation_46,
    input wire [15:0] activation_47,

    input wire [15:0] activation_50,
    input wire [15:0] activation_51,
    input wire [15:0] activation_52,
    input wire [15:0] activation_53,
    input wire [15:0] activation_54,
    input wire [15:0] activation_55,
    input wire [15:0] activation_56,
    input wire [15:0] activation_57,

    input wire [15:0] activation_60,
    input wire [15:0] activation_61,
    input wire [15:0] activation_62,
    input wire [15:0] activation_63,
    input wire [15:0] activation_64,
    input wire [15:0] activation_65,
    input wire [15:0] activation_66,
    input wire [15:0] activation_67,

    input wire [15:0] activation_70,
    input wire [15:0] activation_71,
    input wire [15:0] activation_72,
    input wire [15:0] activation_73,
    input wire [15:0] activation_74,
    input wire [15:0] activation_75,
    input wire [15:0] activation_76,
    input wire [15:0] activation_77,

    output reg [15:0] out_ub_00,
    output reg [15:0] out_ub_01,
    output reg [15:0] out_ub_02,
    output reg [15:0] out_ub_03,
    output reg [15:0] out_ub_04,
    output reg [15:0] out_ub_05,
    output reg [15:0] out_ub_06,
    output reg [15:0] out_ub_07,

    output reg [15:0] out_ub_10,
    output reg [15:0] out_ub_11,
    output reg [15:0] out_ub_12,
    output reg [15:0] out_ub_13,
    output reg [15:0] out_ub_14,
    output reg [15:0] out_ub_15,
    output reg [15:0] out_ub_16,
    output reg [15:0] out_ub_17,

    output reg [15:0] out_ub_20,
    output reg [15:0] out_ub_21,
    output reg [15:0] out_ub_22,
    output reg [15:0] out_ub_23,
    output reg [15:0] out_ub_24,
    output reg [15:0] out_ub_25,
    output reg [15:0] out_ub_26,
    output reg [15:0] out_ub_27,

    output reg [15:0] out_ub_30,
    output reg [15:0] out_ub_31,
    output reg [15:0] out_ub_32,
    output reg [15:0] out_ub_33,
    output reg [15:0] out_ub_34,
    output reg [15:0] out_ub_35,
    output reg [15:0] out_ub_36,
    output reg [15:0] out_ub_37,

    output reg [15:0] out_ub_40,
    output reg [15:0] out_ub_41,
    output reg [15:0] out_ub_42,
    output reg [15:0] out_ub_43,
    output reg [15:0] out_ub_44,
    output reg [15:0] out_ub_45,
    output reg [15:0] out_ub_46,
    output reg [15:0] out_ub_47,

    output reg [15:0] out_ub_50,
    output reg [15:0] out_ub_51,
    output reg [15:0] out_ub_52,
    output reg [15:0] out_ub_53,
    output reg [15:0] out_ub_54,
    output reg [15:0] out_ub_55,
    output reg [15:0] out_ub_56,
    output reg [15:0] out_ub_57,

    output reg [15:0] out_ub_60,
    output reg [15:0] out_ub_61,
    output reg [15:0] out_ub_62,
    output reg [15:0] out_ub_63,
    output reg [15:0] out_ub_64,
    output reg [15:0] out_ub_65,
    output reg [15:0] out_ub_66,
    output reg [15:0] out_ub_67,

    output reg [15:0] out_ub_70,
    output reg [15:0] out_ub_71,
    output reg [15:0] out_ub_72,
    output reg [15:0] out_ub_73,
    output reg [15:0] out_ub_74,
    output reg [15:0] out_ub_75,
    output reg [15:0] out_ub_76,
    output reg [15:0] out_ub_77,

    output reg [15:0] final_out
);

    // Internal unified buffer memory: 256 locations of 16 bits
    reg [15:0] unified_mem [0:63];
    //reg [15:0] unified_mem  [0:63];
    // Read/Write pointer for 'ext' operation
    reg [7:0] ext_read_ptr;

    // First Function: Load inputs from DRAM into unified buffer
    always @(posedge clk) begin
        if (reset) begin
            // Optionally initialize unified_mem
            for (integer i = 0; i < 63; i = i + 1)
                unified_mem[i] <= 16'd0;
        end else if (fetch_inp) begin
            // Load data from DRAM into unified buffer
            unified_mem[dma_address] <= ui_in;
        end
    end

    // Second Function: Store data from accumulators into unified buffer
    always @(posedge clk) begin
        if (reset) begin
            // Optionally reset unified_mem
        end else if (store) begin
            // When 'store' is high, store activations into unified buffer
            if (full_acc0) begin
                unified_mem[0] <= activation_00;
                unified_mem[1] <= activation_01;
                unified_mem[2] <= activation_02;
                unified_mem[3] <= activation_03;
                unified_mem[4] <= activation_04;
                unified_mem[5] <= activation_05;
                unified_mem[6] <= activation_06;
                unified_mem[7] <= activation_07;
            end
            if (full_acc1) begin
                unified_mem[8]  <= activation_10;
                unified_mem[9]  <= activation_11;
                unified_mem[10] <= activation_12;
                unified_mem[11] <= activation_13;
                unified_mem[12] <= activation_14;
                unified_mem[13] <= activation_15;
                unified_mem[14] <= activation_16;
                unified_mem[15] <= activation_17;
            end
            if (full_acc2) begin
                unified_mem[16] <= activation_20;
                unified_mem[17] <= activation_21;
                unified_mem[18] <= activation_22;
                unified_mem[19] <= activation_23;
                unified_mem[20] <= activation_24;
                unified_mem[21] <= activation_25;
                unified_mem[22] <= activation_26;
                unified_mem[23] <= activation_27;
            end
            if (full_acc3) begin
                unified_mem[24] <= activation_30;
                unified_mem[25] <= activation_31;
                unified_mem[26] <= activation_32;
                unified_mem[27] <= activation_33;
                unified_mem[28] <= activation_34;
                unified_mem[29] <= activation_35;
                unified_mem[30] <= activation_36;
                unified_mem[31] <= activation_37;
            end
            if (full_acc4) begin
                unified_mem[32] <= activation_40;
                unified_mem[33] <= activation_41;
                unified_mem[34] <= activation_42;
                unified_mem[35] <= activation_43;
                unified_mem[36] <= activation_44;
                unified_mem[37] <= activation_45;
                unified_mem[38] <= activation_46;
                unified_mem[39] <= activation_47;
            end
            if (full_acc5) begin
                unified_mem[40] <= activation_50;
                unified_mem[41] <= activation_51;
                unified_mem[42] <= activation_52;
                unified_mem[43] <= activation_53;
                unified_mem[44] <= activation_54;
                unified_mem[45] <= activation_55;
                unified_mem[46] <= activation_56;
                unified_mem[47] <= activation_57;
            end
            if (full_acc6) begin
                unified_mem[48] <= activation_60;
                unified_mem[49] <= activation_61;
                unified_mem[50] <= activation_62;
                unified_mem[51] <= activation_63;
                unified_mem[52] <= activation_64;
                unified_mem[53] <= activation_65;
                unified_mem[54] <= activation_66;
                unified_mem[55] <= activation_67;
            end
            if (full_acc7) begin
                unified_mem[56] <= activation_70;
                unified_mem[57] <= activation_71;
                unified_mem[58] <= activation_72;
                unified_mem[59] <= activation_73;
                unified_mem[60] <= activation_74;
                unified_mem[61] <= activation_75;
                unified_mem[62] <= activation_76;
                unified_mem[63] <= activation_77;
            end
        end
    end
    reg full_acc0_dly1;
    reg full_acc0_dly2;
    // Third Function: Output data to 'final_out' when 'ext' is high
    always @(posedge clk) begin
            full_acc0_dly1<=full_acc0;
            full_acc0_dly2<=full_acc0_dly1;
    end
    always @(posedge clk) begin
        if (reset) begin
            full_acc0_dly1<=0;
            full_acc0_dly2<=0;
            ext_read_ptr <= 8'd0;
            final_out <= 16'd0;
        //这里将full——acc0延时两个时钟周期，使得unified buffer的值完全更新
        end else if (ext & full_acc0_dly2 ) begin
            // Sequentially output data from unified buffer to 'final_out'
            final_out <= unified_mem[ext_read_ptr];
            ext_read_ptr <= ext_read_ptr + 1;
            if (ext_read_ptr == 8'd63)
                ext_read_ptr <= 8'd0; // Reset pointer after reaching the end
        end else begin
            ext_read_ptr <= 8'd0; // Reset pointer when 'ext' is not high
            final_out <= 16'd0;
        end
    end

    // Output data to 'out_ub_**' when 'load_input' is high
    always @(*) begin
        if (load_input) begin
            out_ub_00 = unified_mem[addr + 0];
            out_ub_01 = unified_mem[addr + 1];
            out_ub_02 = unified_mem[addr + 2];
            out_ub_03 = unified_mem[addr + 3];
            out_ub_04 = unified_mem[addr + 4];
            out_ub_05 = unified_mem[addr + 5];
            out_ub_06 = unified_mem[addr + 6];
            out_ub_07 = unified_mem[addr + 7];

            out_ub_10 = unified_mem[addr + 8];
            out_ub_11 = unified_mem[addr + 9];
            out_ub_12 = unified_mem[addr + 10];
            out_ub_13 = unified_mem[addr + 11];
            out_ub_14 = unified_mem[addr + 12];
            out_ub_15 = unified_mem[addr + 13];
            out_ub_16 = unified_mem[addr + 14];
            out_ub_17 = unified_mem[addr + 15];

            out_ub_20 = unified_mem[addr + 16];
            out_ub_21 = unified_mem[addr + 17];
            out_ub_22 = unified_mem[addr + 18];
            out_ub_23 = unified_mem[addr + 19];
            out_ub_24 = unified_mem[addr + 20];
            out_ub_25 = unified_mem[addr + 21];
            out_ub_26 = unified_mem[addr + 22];
            out_ub_27 = unified_mem[addr + 23];

            out_ub_30 = unified_mem[addr + 24];
            out_ub_31 = unified_mem[addr + 25];
            out_ub_32 = unified_mem[addr + 26];
            out_ub_33 = unified_mem[addr + 27];
            out_ub_34 = unified_mem[addr + 28];
            out_ub_35 = unified_mem[addr + 29];
            out_ub_36 = unified_mem[addr + 30];
            out_ub_37 = unified_mem[addr + 31];

            out_ub_40 = unified_mem[addr + 32];
            out_ub_41 = unified_mem[addr + 33];
            out_ub_42 = unified_mem[addr + 34];
            out_ub_43 = unified_mem[addr + 35];
            out_ub_44 = unified_mem[addr + 36];
            out_ub_45 = unified_mem[addr + 37];
            out_ub_46 = unified_mem[addr + 38];
            out_ub_47 = unified_mem[addr + 39];

            out_ub_50 = unified_mem[addr + 40];
            out_ub_51 = unified_mem[addr + 41];
            out_ub_52 = unified_mem[addr + 42];
            out_ub_53 = unified_mem[addr + 43];
            out_ub_54 = unified_mem[addr + 44];
            out_ub_55 = unified_mem[addr + 45];
            out_ub_56 = unified_mem[addr + 46];
            out_ub_57 = unified_mem[addr + 47];

            out_ub_60 = unified_mem[addr + 48];
            out_ub_61 = unified_mem[addr + 49];
            out_ub_62 = unified_mem[addr + 50];
            out_ub_63 = unified_mem[addr + 51];
            out_ub_64 = unified_mem[addr + 52];
            out_ub_65 = unified_mem[addr + 53];
            out_ub_66 = unified_mem[addr + 54];
            out_ub_67 = unified_mem[addr + 55];

            out_ub_70 = unified_mem[addr + 56];
            out_ub_71 = unified_mem[addr + 57];
            out_ub_72 = unified_mem[addr + 58];
            out_ub_73 = unified_mem[addr + 59];
            out_ub_74 = unified_mem[addr + 60];
            out_ub_75 = unified_mem[addr + 61];
            out_ub_76 = unified_mem[addr + 62];
            out_ub_77 = unified_mem[addr + 63];
        end else begin
            // When 'load_input' is low, outputs can be zero or hold previous value
            out_ub_00 = 16'd0;
            out_ub_01 = 16'd0;
            out_ub_02 = 16'd0;
            out_ub_03 = 16'd0;
            out_ub_04 = 16'd0;
            out_ub_05 = 16'd0;
            out_ub_06 = 16'd0;
            out_ub_07 = 16'd0;

            out_ub_10 = 16'd0;
            out_ub_11 = 16'd0;
            out_ub_12 = 16'd0;
            out_ub_13 = 16'd0;
            out_ub_14 = 16'd0;
            out_ub_15 = 16'd0;
            out_ub_16 = 16'd0;
            out_ub_17 = 16'd0;

            out_ub_20 = 16'd0;
            out_ub_21 = 16'd0;
            out_ub_22 = 16'd0;
            out_ub_23 = 16'd0;
            out_ub_24 = 16'd0;
            out_ub_25 = 16'd0;
            out_ub_26 = 16'd0;
            out_ub_27 = 16'd0;

            out_ub_30 = 16'd0;
            out_ub_31 = 16'd0;
            out_ub_32 = 16'd0;
            out_ub_33 = 16'd0;
            out_ub_34 = 16'd0;
            out_ub_35 = 16'd0;
            out_ub_36 = 16'd0;
            out_ub_37 = 16'd0;

            out_ub_40 = 16'd0;
            out_ub_41 = 16'd0;
            out_ub_42 = 16'd0;
            out_ub_43 = 16'd0;
            out_ub_44 = 16'd0;
            out_ub_45 = 16'd0;
            out_ub_46 = 16'd0;
            out_ub_47 = 16'd0;

            out_ub_50 = 16'd0;
            out_ub_51 = 16'd0;
            out_ub_52 = 16'd0;
            out_ub_53 = 16'd0;
            out_ub_54 = 16'd0;
            out_ub_55 = 16'd0;
            out_ub_56 = 16'd0;
            out_ub_57 = 16'd0;

            out_ub_60 = 16'd0;
            out_ub_61 = 16'd0;
            out_ub_62 = 16'd0;
            out_ub_63 = 16'd0;
            out_ub_64 = 16'd0;
            out_ub_65 = 16'd0;
            out_ub_66 = 16'd0;
            out_ub_67 = 16'd0;

            out_ub_70 = 16'd0;
            out_ub_71 = 16'd0;
            out_ub_72 = 16'd0;
            out_ub_73 = 16'd0;
            out_ub_74 = 16'd0;
            out_ub_75 = 16'd0;
            out_ub_76 = 16'd0;
            out_ub_77 = 16'd0;
        end
    end

endmodule
