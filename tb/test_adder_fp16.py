import cocotb
from cocotb.triggers import Timer
import struct

# Helper function to convert float to FP16 (16-bit representation)
def float_to_fp16(f):
    return struct.unpack('>H', struct.pack('>e', f))[0]

# Helper function to convert FP16 (16-bit representation) to float
def fp16_to_float(fp16):
    return struct.unpack('>e', struct.pack('>H', fp16))[0]

@cocotb.test()
async def test_fp16_adder(dut):
    test_cases = [
        
        (0xC000, 0x4000, 0x0000),  # -2.0 + 2.0 = 0.0
        (0x3C00, 0x4000, 0x4200),  # 1.0 + 2.0 = 3.0
        (0x3C00, 0x3C00, 0x4000),  # 1.0 + 1.0 = 2.0
        (0xC000, 0xC000, 0xC400),  # -2.0 + -2.0 = -4.0
        (0xC100, 0x3D9A, 0xBC66),  # -2.5 + 1.4 = -1.1
        (0x4100, 0xBC00, 0x3E00),  # 2.5 + -1.0 = 1.5
        
    ]

    for i, (a, b, expected_z) in enumerate(test_cases):
        dut.a.value = a
        dut.b.value = b

        await Timer(2, units="ns")

        z = int(dut.z.value)
        assert z == expected_z, f"Test case {i+1} failed: {hex(a)} + {hex(b)} = {hex(z)}, expected {hex(expected_z)}"
        cocotb.log.info(f"Test case {i+1} passed: {hex(a)} + {hex(b)} = {hex(z)}")

