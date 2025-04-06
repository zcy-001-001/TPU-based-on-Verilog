import cocotb
from cocotb.triggers import Timer
from cocotb.clock import Clock


@cocotb.test()
async def test_accumulator(dut):

    clock = Clock(dut.clk, 10, units="ns")  # Create a 10us period clock on port clk
    # Start the clock. Start it low to avoid issues on the first RisingEdge
    cocotb.start_soon(clock.start(start_high=True))

    # Reset the DUT
    dut.reset.value = 1
    dut.rd_en.value = 0
    dut.rd_addr.value = 0
    dut.wr_en.value = 0
    dut.wr_addr.value = 0
    dut.wr_data.value = 0
    await Timer(10, units="ns")
    dut.reset.value = 0

    # read address = 3
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 0
    assert rd_data == 0x0, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0. "
    # write 1 at address = 3
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x3
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 3
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1
    assert rd_data == 0x3C00, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x3C00. "
    # write 1 at address = 3
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x3
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 3
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+1=2
    assert rd_data == 0x4000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4000. "
    # write 1 at address = 3
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x3
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 3
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+1+1=3
    assert rd_data == 0x4200, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4200. "

    # read address = 4
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x4
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 0
    assert rd_data == 0x0, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0. "
    # write 2 at address = 4
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x4
    dut.wr_data.value = 0x4000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 4
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x4
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 2
    assert rd_data == 0x4000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4000. "
    # write -2 at address = 4
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x4
    dut.wr_data.value = 0xC000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 4
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x4
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 2-2=0
    assert rd_data == 0x0000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0000. "

    # read address = 0x67
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x67
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 0
    assert rd_data == 0x0, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0. "
    # write -2 at address = 0x67
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x67
    dut.wr_data.value = 0xC000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0x67
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x67
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # -2
    assert rd_data == 0xC000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0xC000. "
    # write -2 at address = 0x67
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x67
    dut.wr_data.value = 0xC000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0x67
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x67
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # -2-2=-4
    assert rd_data == 0xC400, f"Test case failed: rd_data = {hex(rd_data)}, expected 0xC400. "

    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 0
    assert rd_data == 0x0, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0. "
    # write 1 at address = 0xFC
    dut.wr_en.value = 1
    dut.wr_addr.value = 0xFC
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1
    assert rd_data == 0x3C00, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x3C00. "
    # write 0 at address = 0xFC
    dut.wr_en.value = 1
    dut.wr_addr.value = 0xFC
    dut.wr_data.value = 0x0000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+0=1
    assert rd_data == 0x3C00, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x3C00. "
    # write 1 at address = 0xFC
    dut.wr_en.value = 1
    dut.wr_addr.value = 0xFC
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+0+1=2
    assert rd_data == 0x4000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4000. "
    # write 1 at address = 0xFC
    dut.wr_en.value = 1
    dut.wr_addr.value = 0xFC
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+0+1+1=3
    assert rd_data == 0x4200, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4200. "
    # write 1 at address = 0xFC
    dut.wr_en.value = 1
    dut.wr_addr.value = 0xFC
    dut.wr_data.value = 0x3C00
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0xFC
    dut.rd_en.value = 1
    dut.rd_addr.value = 0xFC
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 1+0+1+1+1=4
    assert rd_data == 0x4400, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4400. "

    # read address = 0x3FF
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3FF
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 0
    assert rd_data == 0x0, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0. "
    # write 2 at address = 0x3FF
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x3FF
    dut.wr_data.value = 0x4000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0x3FF
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3FF
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 2
    assert rd_data == 0x4000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x4000. "
    # write -2 at address = 0x3FF
    dut.wr_en.value = 1
    dut.wr_addr.value = 0x3FF
    dut.wr_data.value = 0xC000
    await Timer(10, units="ns")
    dut.wr_en.value = 0
    # read address = 0x3FF
    dut.rd_en.value = 1
    dut.rd_addr.value = 0x3FF
    await Timer(10, units="ns")
    dut.rd_en.value = 0
    rd_data = int(dut.rd_data.value)    # 2-2=0
    assert rd_data == 0x0000, f"Test case failed: rd_data = {hex(rd_data)}, expected 0x0000. "
