import random
import numpy as np
import cocotb
from cocotb.triggers import Timer

def float16_to_bits(f: np.float16) -> int:
    return int(np.frombuffer(f.tobytes(), dtype=np.uint16)[0])

def bits_to_float16(b: int) -> np.float16:
    return np.frombuffer(np.array([b], dtype=np.uint16).tobytes(), dtype=np.float16)[0]

def multiplier_model(a: np.float16, b: np.float16) -> np.float16:
    return np.float16(a * b)

@cocotb.test()
async def multiplier_basic_test(dut):
    a, b = np.float16(-51.0), np.float16(1230.0)
    dut.a.value, dut.b.value = float16_to_bits(a), float16_to_bits(b)
    await Timer(2, units="ns")
    assert bits_to_float16(dut.z.value.integer) == multiplier_model(a, b)

@cocotb.test()
async def multiplier_randomised_test(dut):
    tolerance = 2e-1
    for _ in range(10):
        a, b = np.float16(random.uniform(-20, 20)), np.float16(random.uniform(-30, 30))
        dut.a.value, dut.b.value = float16_to_bits(a), float16_to_bits(b)
        await Timer(5, units="ns")
        actual_result = bits_to_float16(dut.z.value.integer)
        expected_result = multiplier_model(a, b)
        assert np.isclose(actual_result, expected_result, atol=tolerance)
        # assert actual_result == expected_result, f"Basic test failed: z = {actual_result}, expected = {expected_result}"
