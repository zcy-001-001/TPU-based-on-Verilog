import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def test_relu(dut):

    dut.enable.value = 1
    dut.i.value = 0x3880
    await Timer(10, units="ns")

    z = int(dut.z.value)     # 0.5625
    assert z == 0x3880, f"Test case failed: z = {hex(z)}, expected 0x3880. "
    

    dut.i.value = 0xB880
    await Timer(10, units="ns")

    z = int(dut.z.value)     # -0.5625
    assert z == 0x0000, f"Test case failed: z = {hex(z)}, expected 0x0000. " 


    dut.i.value = 0x0000
    await Timer(10, units="ns")

    z = int(dut.z.value)     # 0
    assert z == 0x0000, f"Test case failed: z = {hex(z)}, expected 0x0000. " 
