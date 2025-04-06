import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, ClockCycles


@cocotb.test()
async def test_systolic_array(dut):
    
    cocotb.start_soon(Clock(dut.clk, 10, units="us").start())
    
    # reset
    dut.reset.value = 1
    await ClockCycles(dut.clk, 1)
    dut.reset.value = 0
    await ClockCycles(dut.clk, 1)

    # load weight
    dut.load_weight.value = 1
    
    dut.weight_00.value = 0x3C00    # 1
    dut.weight_01.value = 0x3C00    # 1
    dut.weight_02.value = 0x4000    # 2
    dut.weight_03.value = 0x4200    # 3
    dut.weight_04.value = 0xBC00    # -1
    dut.weight_05.value = 0xC000    # -2
    dut.weight_06.value = 0x3E00    # 1.5
    dut.weight_07.value = 0xC100    # -2.5

    dut.weight_10.value = 0x3C00    # 1
    dut.weight_11.value = 0x3C00    # 1
    dut.weight_12.value = 0x4000    # 2
    dut.weight_13.value = 0x4200    # 3
    dut.weight_14.value = 0xBC00    # -1
    dut.weight_15.value = 0xC000    # -2
    dut.weight_16.value = 0x3E00    # 1.5
    dut.weight_17.value = 0xC100    # -2.5

    dut.weight_20.value = 0x3C00    # 1
    dut.weight_21.value = 0x3C00    # 1
    dut.weight_22.value = 0x4000    # 2
    dut.weight_23.value = 0x4200    # 3
    dut.weight_24.value = 0xBC00    # -1
    dut.weight_25.value = 0xC000    # -2
    dut.weight_26.value = 0x3E00    # 1.5
    dut.weight_27.value = 0xC100    # -2.5

    dut.weight_30.value = 0x3C00    # 1
    dut.weight_31.value = 0x3C00    # 1
    dut.weight_32.value = 0x4000    # 2
    dut.weight_33.value = 0x4200    # 3
    dut.weight_34.value = 0xBC00    # -1
    dut.weight_35.value = 0xC000    # -2
    dut.weight_36.value = 0x3E00    # 1.5
    dut.weight_37.value = 0xC100    # -2.5

    dut.weight_40.value = 0x3C00    # 1
    dut.weight_41.value = 0x3C00    # 1
    dut.weight_42.value = 0x4000    # 2
    dut.weight_43.value = 0x4200    # 3
    dut.weight_44.value = 0xBC00    # -1
    dut.weight_45.value = 0xC000    # -2
    dut.weight_46.value = 0x3E00    # 1.5
    dut.weight_47.value = 0xC100    # -2.5

    dut.weight_50.value = 0x3C00    # 1
    dut.weight_51.value = 0x3C00    # 1
    dut.weight_52.value = 0x4000    # 2
    dut.weight_53.value = 0x4200    # 3
    dut.weight_54.value = 0xBC00    # -1
    dut.weight_55.value = 0xC000    # -2
    dut.weight_56.value = 0x3E00    # 1.5
    dut.weight_57.value = 0xC100    # -2.5

    dut.weight_60.value = 0x3C00    # 1
    dut.weight_61.value = 0x3C00    # 1
    dut.weight_62.value = 0x4000    # 2
    dut.weight_63.value = 0x4200    # 3
    dut.weight_64.value = 0xBC00    # -1
    dut.weight_65.value = 0xC000    # -2
    dut.weight_66.value = 0x3E00    # 1.5
    dut.weight_67.value = 0xC100    # -2.5

    dut.weight_70.value = 0x3C00    # 1
    dut.weight_71.value = 0x3C00    # 1
    dut.weight_72.value = 0x4000    # 2
    dut.weight_73.value = 0x4200    # 3
    dut.weight_74.value = 0xBC00    # -1
    dut.weight_75.value = 0xC000    # -2
    dut.weight_76.value = 0x3E00    # 1.5
    dut.weight_77.value = 0xC100    # -2.5

    await ClockCycles(dut.clk, 1)
    
    # valid
    dut.valid.value = 1
    await ClockCycles(dut.clk, 1)

    # T = 0
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x0000    # 0
    dut.a_in_2.value = 0x0000    # 0
    dut.a_in_3.value = 0x0000    # 0
    dut.a_in_4.value = 0x0000    # 0
    dut.a_in_5.value = 0x0000    # 0
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 1
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x0000    # 0
    dut.a_in_3.value = 0x0000    # 0
    dut.a_in_4.value = 0x0000    # 0
    dut.a_in_5.value = 0x0000    # 0
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 2
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x0000    # 0
    dut.a_in_4.value = 0x0000    # 0
    dut.a_in_5.value = 0x0000    # 0
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 3
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x3E00    # 1.5
    dut.a_in_4.value = 0x0000    # 0
    dut.a_in_5.value = 0x0000    # 0
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 4
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x3E00    # 1.5
    dut.a_in_4.value = 0x3E00    # 1.5
    dut.a_in_5.value = 0x0000    # 0
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 5
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x3E00    # 1.5
    dut.a_in_4.value = 0x3E00    # 1.5
    dut.a_in_5.value = 0x3E00    # 1.5
    dut.a_in_6.value = 0x0000    # 0
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 6
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x3E00    # 1.5
    dut.a_in_4.value = 0x3E00    # 1.5
    dut.a_in_5.value = 0x3E00    # 1.5
    dut.a_in_6.value = 0x3E00    # 1.5
    dut.a_in_7.value = 0x0000    # 0
    await ClockCycles(dut.clk, 1)

    # T = 7
    dut.a_in_0.value = 0x3E00    # 1.5
    dut.a_in_1.value = 0x3E00    # 1.5
    dut.a_in_2.value = 0x3E00    # 1.5
    dut.a_in_3.value = 0x3E00    # 1.5
    dut.a_in_4.value = 0x3E00    # 1.5
    dut.a_in_5.value = 0x3E00    # 1.5
    dut.a_in_6.value = 0x3E00    # 1.5
    dut.a_in_7.value = 0x3E00    # 1.5
    await ClockCycles(dut.clk, 1)

    # T = 8
    await ClockCycles(dut.clk, 1)

    # T = 9
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    # cocotb.log.info(f"Test case passed: out_0 = {out_0}")
    # dut._log.info(f"acc_out = {int(dut.acc_out_0.value)}")
    await ClockCycles(dut.clk, 1)
    

    # T = 10    
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    await ClockCycles(dut.clk, 1)
    
    # T = 11  
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    await ClockCycles(dut.clk, 1)    
    
    # T = 12  
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    await ClockCycles(dut.clk, 1)    
    
    # T = 13  
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA80. "
    await ClockCycles(dut.clk, 1)    
    
    # T = 14  
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    await ClockCycles(dut.clk, 1)

    # T = 15
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "   
    await ClockCycles(dut.clk, 1)

    # T = 16
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "  
    out_7 = int(dut.acc_out_7.value)  # -30
    assert out_7 == 0xCF80, f"Test case failed: out_7 = {hex(out_7)}, expected 0xCF80. "  
    await ClockCycles(dut.clk, 1)

    # T = 17
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "  
    out_7 = int(dut.acc_out_7.value)  # -30
    assert out_7 == 0xCF80, f"Test case failed: out_7 = {hex(out_7)}, expected 0xCF80. "  
    await ClockCycles(dut.clk, 1)

    # T = 18
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "  
    out_7 = int(dut.acc_out_7.value)  # -30
    assert out_7 == 0xCF80, f"Test case failed: out_7 = {hex(out_7)}, expected 0xCF80. "  
    await ClockCycles(dut.clk, 1)

    # T = 19
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "  
    out_7 = int(dut.acc_out_7.value)  # -30
    assert out_7 == 0xCF80, f"Test case failed: out_7 = {hex(out_7)}, expected 0xCF80. "  
    await ClockCycles(dut.clk, 1)

    # T = 20
    out_0 = int(dut.acc_out_0.value)  # 12
    assert out_0 == 0x4A00, f"Test case failed: out_0 = {hex(out_0)}, expected 0x4A00. "
    out_1 = int(dut.acc_out_1.value)  # 12
    assert out_1 == 0x4A00, f"Test case failed: out_1 = {hex(out_1)}, expected 0x4A00. "
    out_2 = int(dut.acc_out_2.value)  # 24
    assert out_2 == 0x4E00, f"Test case failed: out_2 = {hex(out_2)}, expected 0x4E00. "
    out_3 = int(dut.acc_out_3.value)  # 36
    assert out_3 == 0x5080, f"Test case failed: out_3 = {hex(out_3)}, expected 0x5080. "
    out_4 = int(dut.acc_out_4.value)  # -12
    assert out_4 == 0xCA00, f"Test case failed: out_4 = {hex(out_4)}, expected 0xCA00. "
    out_5 = int(dut.acc_out_5.value)  # -24
    assert out_5 == 0xCE00, f"Test case failed: out_5 = {hex(out_5)}, expected 0xCE00. "    
    out_6 = int(dut.acc_out_6.value)  # 18
    assert out_6 == 0x4C80, f"Test case failed: out_6 = {hex(out_6)}, expected 0x4C80. "  
    out_7 = int(dut.acc_out_7.value)  # -30
    assert out_7 == 0xCF80, f"Test case failed: out_7 = {hex(out_7)}, expected 0xCF80. "  
    await ClockCycles(dut.clk, 1)
