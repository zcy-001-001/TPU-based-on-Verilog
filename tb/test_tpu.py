import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles
# weight_matrix = [[1, -1, 1, -1, 1, -1, 1, -1],
#                  [1, 1, 1, 1, 1, 1, 1, 1],
#                  [1, -1, 1, -1, 1, -1, 1, -1],
#                  [-1, -1, -1, -1, -1, -1, -1, -1],
#                  [1, -1, 1, -1, 1, -1, 1, -1],
#                  [1, 1, 1, 1, 1, 1, 1, 1],
#                  [1, -1, 1, -1, 1, -1, 1, -1],
#                  [-1, -1, -1, -1, -1, -1, -1, -1]]

async def inititialize_weight_memory(dut):
    dut.uio_in.value = 0b0001_000000_000000 # address of weight memory
    dut.ui_in.value = 0b0011110000000000  # load weight_00 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000001
    dut.ui_in.value = 0b1011110000000000  # load weight_01 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000010
    dut.ui_in.value = 0b0011110000000000  # load weight_02 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000011
    dut.ui_in.value = 0b1011110000000000  # load weight_03 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000100
    dut.ui_in.value = 0b0011110000000000  # load weight_04 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000101
    dut.ui_in.value = 0b1011110000000000  # load weight_05 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000110
    dut.ui_in.value = 0b0011110000000000  # load weight_06 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_000111
    dut.ui_in.value = 0b1011110000000000  # load weight_07 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_001000
    dut.ui_in.value = 0b0011110000000000  # load weight_10 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001001
    dut.ui_in.value = 0b0011110000000000  # load weight_11 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001010
    dut.ui_in.value = 0b0011110000000000  # load weight_12 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001011
    dut.ui_in.value = 0b0011110000000000  # load weight_13 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001100
    dut.ui_in.value = 0b0011110000000000  # load weight_14 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001101
    dut.ui_in.value = 0b0011110000000000  # load weight_15 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001110
    dut.ui_in.value = 0b0011110000000000  # load weight_16 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_001111
    dut.ui_in.value = 0b0011110000000000  # load weight_17 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_010000
    dut.ui_in.value = 0b0011110000000000  # load weight_20 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010001
    dut.ui_in.value = 0b1011110000000000  # load weight_21 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010010
    dut.ui_in.value = 0b0011110000000000  # load weight_23 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010011
    dut.ui_in.value = 0b1011110000000000  # load weight_24 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010100
    dut.ui_in.value = 0b0011110000000000  # load weight_25 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010101
    dut.ui_in.value = 0b1011110000000000  # load weight_26 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010110
    dut.ui_in.value = 0b0011110000000000  # load weight_27 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_010111
    dut.ui_in.value = 0b1011110000000000  # load weight_28 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_011000
    dut.ui_in.value = 0b1011110000000000  # load weight_30 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011001
    dut.ui_in.value = 0b1011110000000000  # load weight_31 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011010
    dut.ui_in.value = 0b1011110000000000  # load weight_32 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011011
    dut.ui_in.value = 0b1011110000000000  # load weight_33 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011100
    dut.ui_in.value = 0b1011110000000000  # load weight_34 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011101
    dut.ui_in.value = 0b1011110000000000  # load weight_35 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011110
    dut.ui_in.value = 0b1011110000000000  # load weight_36 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_011111
    dut.ui_in.value = 0b1011110000000000  # load weight_37 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_100000
    dut.ui_in.value = 0b0011110000000000  # load weight_40 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100001
    dut.ui_in.value = 0b1011110000000000  # load weight_41 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100010
    dut.ui_in.value = 0b0011110000000000  # load weight_42 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100011
    dut.ui_in.value = 0b1011110000000000  # load weight_43 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100100
    dut.ui_in.value = 0b0011110000000000  # load weight_44 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100101
    dut.ui_in.value = 0b1011110000000000  # load weight_45 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100110
    dut.ui_in.value = 0b0011110000000000  # load weight_46 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_100111
    dut.ui_in.value = 0b1011110000000000  # load weight_47 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_101000
    dut.ui_in.value = 0b0011110000000000  # load weight_50 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101001
    dut.ui_in.value = 0b0011110000000000  # load weight_51 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101010
    dut.ui_in.value = 0b0011110000000000  # load weight_52 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101011
    dut.ui_in.value = 0b0011110000000000  # load weight_53 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101100
    dut.ui_in.value = 0b0011110000000000  # load weight_54 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101101
    dut.ui_in.value = 0b0011110000000000  # load weight_55 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101110
    dut.ui_in.value = 0b0011110000000000  # load weight_56 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_101111
    dut.ui_in.value = 0b0011110000000000  # load weight_57 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0001_000000_110000
    dut.ui_in.value = 0b0011110000000000  # load weight_60 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110001
    dut.ui_in.value = 0b1011110000000000  # load weight_61 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110010
    dut.ui_in.value = 0b0011110000000000  # load weight_62 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110011
    dut.ui_in.value = 0b1011110000000000  # load weight_63 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110100
    dut.ui_in.value = 0b0011110000000000  # load weight_64 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110101
    dut.ui_in.value = 0b1011110000000000  # load weight_65 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110110
    dut.ui_in.value = 0b0011110000000000  # load weight_66 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_110111
    dut.ui_in.value = 0b1011110000000000  # load weight_67 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)

    dut.uio_in.value = 0b0001_000000_111000
    dut.ui_in.value = 0b1011110000000000  # load weight_70 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111001
    dut.ui_in.value = 0b1011110000000000  # load weight_71 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111010
    dut.ui_in.value = 0b1011110000000000  # load weight_72 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111011
    dut.ui_in.value = 0b1011110000000000  # load weight_73 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111100
    dut.ui_in.value = 0b1011110000000000  # load weight_74 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111101
    dut.ui_in.value = 0b1011110000000000  # load weight_75 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111110
    dut.ui_in.value = 0b1011110000000000  # load weight_76 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0001_000000_111111
    dut.ui_in.value = 0b1011110000000000  # load weight_77 -> -1.0 (Decimal: -1.0)
    await RisingEdge(dut.clk)

    dut.uio_in.value = 0b0000_0000_0000_0000  # Stop fetching weights
    dut.ui_in.value =  0b0000_0000_0000_0000   # no more input
    await ClockCycles(dut.clk, 1)


# input_matrix =  [[1, 1, 1, 1, 1, 1, 1, 1],
#                  [1, 2, 1, 2, 1, 2, 1, 2],
#                  [1, 1, 1, 1, 1, 1, 1, 1],
#                  [2, 1, 2, 1, 2, 1, 2, 1],
#                  [2, 2, 2, 2, 2, 2, 2, 2],
#                  [1, 2, 1, 2, 1, 2, 1, 2],
#                  [1, 1, 1, 1, 1, 1, 1, 1],
#                  [2, 1, 2, 1, 2, 1, 2, 1]]

async def initialize_unified_buffer(dut):
    dut.uio_in.value = 0b0010_000000_000000 # address of input memory
    dut.ui_in.value = 0b0011110000000000  # load input_00 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000001
    dut.ui_in.value = 0b0011110000000000  # load input_01 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000010
    dut.ui_in.value = 0b0011110000000000  # load input_02 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000011
    dut.ui_in.value = 0b0011110000000000  # load input_03 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000100
    dut.ui_in.value = 0b0011110000000000  # load input_04 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000101
    dut.ui_in.value = 0b0011110000000000  # load input_05 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000110
    dut.ui_in.value = 0b0011110000000000  # load input_06 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_000111
    dut.ui_in.value = 0b0011110000000000  # load input_07 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_001000
    dut.ui_in.value = 0b0011110000000000  # load input_10 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001001
    dut.ui_in.value = 0b0100000000000000  # load input_11 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001010
    dut.ui_in.value = 0b0011110000000000  # load input_12 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001011
    dut.ui_in.value = 0b0100000000000000  # load input_13 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001100
    dut.ui_in.value = 0b0011110000000000  # load input_14 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001101
    dut.ui_in.value = 0b0100000000000000  # load input_15 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001110
    dut.ui_in.value = 0b0011110000000000  # load input_16 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_001111
    dut.ui_in.value = 0b0100000000000000  # load input_17 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_010000
    dut.ui_in.value = 0b0011110000000000  # load input_20 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010001
    dut.ui_in.value = 0b0011110000000000  # load input_21 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010010
    dut.ui_in.value = 0b0011110000000000  # load input_22 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010011
    dut.ui_in.value = 0b0011110000000000  # load input_23 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010100
    dut.ui_in.value = 0b0011110000000000  # load input_24 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010101
    dut.ui_in.value = 0b0011110000000000  # load input_25 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010110
    dut.ui_in.value = 0b0011110000000000  # load input_26 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_010111
    dut.ui_in.value = 0b0011110000000000  # load input_27 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_011000
    dut.ui_in.value = 0b0100000000000000  # load input_30 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011001
    dut.ui_in.value = 0b0011110000000000  # load input_31 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011010
    dut.ui_in.value = 0b0100000000000000  # load input_32 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011011
    dut.ui_in.value = 0b0011110000000000  # load input_33 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011100
    dut.ui_in.value = 0b0100000000000000  # load input_34 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011101
    dut.ui_in.value = 0b0011110000000000  # load input_35 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011110
    dut.ui_in.value = 0b0100000000000000  # load input_36 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_011111
    dut.ui_in.value = 0b0011110000000000  # load input_37 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_100000
    dut.ui_in.value = 0b0100000000000000  # load input_40 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100001
    dut.ui_in.value = 0b0100000000000000  # load input_41 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100010
    dut.ui_in.value = 0b0100000000000000  # load input_42 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100011
    dut.ui_in.value = 0b0100000000000000  # load input_43 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100100
    dut.ui_in.value = 0b0100000000000000  # load input_44 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100101
    dut.ui_in.value = 0b0100000000000000  # load input_45 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100110
    dut.ui_in.value = 0b0100000000000000  # load input_46 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_100111
    dut.ui_in.value = 0b0100000000000000  # load input_47 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_101000
    dut.ui_in.value = 0b0011110000000000  # load input_50 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101001
    dut.ui_in.value = 0b0100000000000000  # load input_51 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101010
    dut.ui_in.value = 0b0011110000000000  # load input_52 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101011
    dut.ui_in.value = 0b0100000000000000  # load input_53 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101100
    dut.ui_in.value = 0b0011110000000000  # load input_54 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101101
    dut.ui_in.value = 0b0100000000000000  # load input_55 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101110
    dut.ui_in.value = 0b0011110000000000  # load input_56 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_101111
    dut.ui_in.value = 0b0100000000000000  # load input_57 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    
    dut.uio_in.value = 0b0010_000000_110000
    dut.ui_in.value = 0b0011110000000000  # load input_60 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110001
    dut.ui_in.value = 0b0011110000000000  # load input_61 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110010
    dut.ui_in.value = 0b0011110000000000  # load input_62 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110011
    dut.ui_in.value = 0b0011110000000000  # load input_63 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110100
    dut.ui_in.value = 0b0011110000000000  # load input_64 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110101
    dut.ui_in.value = 0b0011110000000000  # load input_65 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110110
    dut.ui_in.value = 0b0011110000000000  # load input_66 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_110111
    dut.ui_in.value = 0b0011110000000000  # load input_67 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)

    dut.uio_in.value = 0b0010_000000_111000
    dut.ui_in.value = 0b0100000000000000  # load input_70 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111001
    dut.ui_in.value = 0b0011110000000000  # load input_71 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111010
    dut.ui_in.value = 0b0100000000000000  # load input_72 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111011
    dut.ui_in.value = 0b0011110000000000  # load input_73 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111100
    dut.ui_in.value = 0b0100000000000000  # load input_74 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111101
    dut.ui_in.value = 0b0011110000000000  # load input_75 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111110
    dut.ui_in.value = 0b0100000000000000  # load input_76 -> 2.0 (Decimal: 2.0)
    await RisingEdge(dut.clk)
    dut.uio_in.value = 0b0010_000000_111111
    dut.ui_in.value = 0b0011110000000000  # load input_77 -> 1.0 (Decimal: 1.0)
    await RisingEdge(dut.clk)

    dut.uio_in.value = 0b0000_000000_000000  # Stop fetching inputs
    dut.ui_in.value = 0b0000_0000_0000_0000   # no more input
    await ClockCycles(dut.clk, 1)


async def initialize_instruction_mem(dut):
    dut.uio_in.value = 0b0011_000000_000000 # input instruction at inst. mem address 0
    dut.ui_in.value = 0b001_000000_0000000  # LOAD_ADDR (inputs load from address 000000)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000001 # input instruction at address 1
    dut.ui_in.value = 0b011_000000_0000000  # LOAD_INPUT (take input from unified buffer and transfer to input setup)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000010 # input instruction at address 2
    dut.ui_in.value = 0b001_000000_0000000  # LOAD_ADDR (weights load from address 000000)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000011 # input instruction at address 3
    dut.ui_in.value = 0b010_000000_0000000  # LOAD_WEIGHT (Weights are transferred from weight memory into systolic array)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000100 # input instruction at address 4
    dut.ui_in.value = 0b100_000000_0000000  # COMPUTE (Weights are transferred from weight memory into systolic array)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000101 # input instruction at address 5
    dut.ui_in.value = 0b001_000000_0000000  # LOAD_ADDR (results store from address 000000)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000110 # input instruction at address 6
    dut.ui_in.value = 0b101_000000_0000000  # STORE (result is stored in address above within unified buffer)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_000111 # input instruction at address 7
    dut.ui_in.value = 0b001_000000_00000001 # LOAD_ADDR (load output)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_001000 # input instruction at address 8
    dut.ui_in.value = 0b111_000000_0000000 # EXT (output data off-chip, starting from the address specified above)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0011_000000_001001 # input instruction at address 9
    dut.ui_in.value = 0b0000_0000_0000_0000 # NOP (output data off-chip, starting from the address specified above)
    await ClockCycles(dut.clk, 1)

    dut.uio_in.value = 0b0000_0000_0000_0000 # stop recieving instructions
    dut.ui_in.value = 0b0000_0000_0000_0000
    await ClockCycles(dut.clk, 1)


@cocotb.test()
async def test_tpu(dut):
    cocotb.start_soon(Clock(dut.clk, 10, units="us").start()) # Start the clock

    dut.reset.value = 1  # Reset the DUT
    dut.uio_in.value  = 0b0000_0000_0000_0000 # no input during reset
    dut.ui_in.value  = 0b0000_0000_0000_0000  # no input during reset
    await ClockCycles(dut.clk, 1)

    dut.reset.value = 0
    dut.uio_in.value  = 0b0000_0000_0000_0000 # no input during reset
    dut.ui_in.value  = 0b0000_0000_0000_0000  # no input during reset
    await ClockCycles(dut.clk, 1)

    # DATA INITIALIZATION
    await initialize_unified_buffer(dut) # Initialize input data
    await inititialize_weight_memory(dut) # Initialize weight data
    await initialize_instruction_mem(dut)  # Initialize instructions


    dut.uio_in.value  = 0b0100_0000_0000_0000 # START (starts program)
    dut.ui_in.value  = 0b0000_0000_0000_0000
    await ClockCycles(dut.clk, 1) 

    dut.uio_in.value  = 0b0000_0000_0000_0000 # deassert start signal
    dut.ui_in.value  = 0b0000_0000_0000_0000 # no input

    # you need to wirte you result back to the unified buffer within 200 cycles!
    await ClockCycles(dut.clk, 200)

    # expected_output_matrix  =  [[4, -4, 4, -4, 4, -4, 4, -4],
    #                             [4, -4, 4, -4, 4, -4, 4, -4],
    #                             [4, -4, 4, -4, 4, -4, 4, -4],
    #                             [8, -8, 8, -8, 8, -8, 8, -8],
    #                             [8, -8, 8, -8, 8, -8, 8, -8],
    #                             [4, -4, 4, -4, 4, -4, 4, -4],
    #                             [4, -4, 4, -4, 4, -4, 4, -4],
    #                             [8, -8, 8, -8, 8, -8, 8, -8]]                    


    expected_unified_mem = [0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 
                            0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 
                            0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 
                            0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000, 
                            0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000, 
                            0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 
                            0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 0x4400, 0x0000, 
                            0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000, 0x4800, 0x0000]

    # Print all 64 values of the unified memory from unified_buffer after the loop
# 打印所有 out_ub_XX 信号值
# 打印所有 out_ub_XX 信号值
# 手动打印所有 out_ub_XX 信号值
    # 手动打印所有 out_ub_XX 信号值

    # #test accumulator
    # print(f"out_ub_00 value in hex: {hex(dut.acc0.acc_mem_0.value)}")
    # print(f"out_ub_01 value in hex: {hex(dut.acc0.acc_mem_1.value)}")
    # print(f"out_ub_02 value in hex: {hex(dut.acc0.acc_mem_2.value)}")
    # print(f"out_ub_03 value in hex: {hex(dut.acc0.acc_mem_3.value)}")
    # print(f"out_ub_04 value in hex: {hex(dut.acc0.acc_mem_4.value)}")
    # print(f"out_ub_05 value in hex: {hex(dut.acc0.acc_mem_5.value)}")
    # print(f"out_ub_06 value in hex: {hex(dut.acc0.acc_mem_6.value)}")
    # print(f"out_ub_07 value in hex: {hex(dut.acc0.acc_mem_7.value)}")
    # print(f"index value in hex: {hex(dut.acc0.index.value)}")
    # print(f"acc_in value in hex: {hex(dut.acc0.acc_in.value)}")
    # print(f"valid value in hex: {hex(dut.acc0.valid.value)}")
    # print(f"full in hex: {hex(dut.acc0.full.value)}")

    #test rule 
    # print(f"out_ub_00 value in hex: {hex(dut.relu0.z.value)}")
    # print(f"out_ub_01 value in hex: {hex(dut.relu1.z.value)}")
    # print(f"out_ub_02 value in hex: {hex(dut.relu2.z.value)}")
    # print(f"out_ub_03 value in hex: {hex(dut.relu3.z.value)}")
    # print(f"out_ub_04 value in hex: {hex(dut.relu4.z.value)}")
    # print(f"out_ub_05 value in hex: {hex(dut.relu5.z.value)}")
    # print(f"out_ub_06 value in hex: {hex(dut.relu6.z.value)}")
    # print(f"out_ub_07 value in hex: {hex(dut.relu7.z.value)}")

    # #test systolic array
    # print(f"out_ub_00 value in hex: {hex(dut.tolic.acc_out_0.value)}")
    # print(f"out_ub_01 value in hex: {hex(dut.tolic.acc_out_1.value)}")
    # print(f"out_ub_02 value in hex: {hex(dut.tolic.acc_out_2.value)}")
    # print(f"out_ub_03 value in hex: {hex(dut.tolic.acc_out_3.value)}")
    # print(f"out_ub_04 value in hex: {hex(dut.tolic.acc_out_4.value)}")
    # print(f"out_ub_05 value in hex: {hex(dut.tolic.acc_out_5.value)}")
    # print(f"out_ub_06 value in hex: {hex(dut.tolic.acc_out_6.value)}")
    # print(f"out_ub_07 value in hex: {hex(dut.tolic.acc_out_7.value)}")
    

    # #test input set
    # print(f"out_ub_00 value in hex: {hex(dut.ii.a_in_0.value)}")
    # print(f"out_ub_01 value in hex: {hex(dut.ii.a_in_1.value)}")
    # print(f"out_ub_02 value in hex: {hex(dut.ii.a_in_2.value)}")
    # print(f"out_ub_03 value in hex: {hex(dut.ii.a_in_3.value)}")
    # print(f"out_ub_04 value in hex: {hex(dut.ii.a_in_4.value)}")
    # print(f"out_ub_05 value in hex: {hex(dut.ii.a_in_5.value)}")
    # print(f"out_ub_06 value in hex: {hex(dut.ii.a_in_6.value)}")
    # print(f"out_ub_07 value in hex: {hex(dut.ii.a_in_7.value)}")
    
    # #test weight 
    # print(f"out_ub_10 value in hex: {hex(dut.we.weight_00.value)}")
    # print(f"out_ub_11 value in hex: {hex(dut.we.weight_01.value)}")
    # print(f"out_ub_12 value in hex: {hex(dut.we.weight_02.value)}")
    # print(f"out_ub_13 value in hex: {hex(dut.we.weight_03.value)}")
    # print(f"out_ub_14 value in hex: {hex(dut.we.weight_04.value)}")
    # print(f"out_ub_15 value in hex: {hex(dut.we.weight_05.value)}")
    # print(f"out_ub_16 value in hex: {hex(dut.we.weight_06.value)}")
    # print(f"out_ub_17 value in hex: {hex(dut.we.weight_07.value)}")

    #test input 
    # print(f"out_ub_10 value in hex: {hex(dut.ub.out_ub_00.value)}")
    # print(f"out_ub_11 value in hex: {hex(dut.ub.out_ub_01.value)}")
    # print(f"out_ub_12 value in hex: {hex(dut.ub.out_ub_02.value)}")
    # print(f"out_ub_13 value in hex: {hex(dut.ub.out_ub_03.value)}")
    # print(f"out_ub_14 value in hex: {hex(dut.ub.out_ub_04.value)}")
    # print(f"out_ub_15 value in hex: {hex(dut.ub.out_ub_05.value)}")
    # print(f"out_ub_16 value in hex: {hex(dut.ub.out_ub_06.value)}")
    # print(f"out_ub_17 value in hex: {hex(dut.ub.out_ub_07.value)}")

    # print(f"out_ub_10 value in hex: {hex(dut.ub.out_ub_10.value)}")
    # print(f"out_ub_11 value in hex: {hex(dut.ub.out_ub_11.value)}")
    # print(f"out_ub_12 value in hex: {hex(dut.ub.out_ub_12.value)}")
    # print(f"out_ub_13 value in hex: {hex(dut.ub.out_ub_13.value)}")
    # print(f"out_ub_14 value in hex: {hex(dut.ub.out_ub_14.value)}")
    # print(f"out_ub_15 value in hex: {hex(dut.ub.out_ub_15.value)}")
    # print(f"out_ub_16 value in hex: {hex(dut.ub.out_ub_16.value)}")
    # print(f"out_ub_17 value in hex: {hex(dut.ub.out_ub_17.value)}")

    for i in range(64): 
        unified_mem_val = hex(dut.ub.unified_mem[i].value)
        dut._log.info(f"unified_mem[{i}] = {unified_mem_val}")

    for i in range(64): 
        unified_mem_val = (dut.ub.unified_mem[i].value)
        assert unified_mem_val == expected_unified_mem[i], f"Test case failed: unified_mem[{i}] = {hex(unified_mem_val)}. "

