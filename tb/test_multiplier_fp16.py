import cocotb
from cocotb.triggers import Timer

# Test cases in hex format representing FP16 values
test_cases = [
    (0x3C00, 0x4000, 0x4000),  # 1.0 * 2.0 = 2.0
    (0xC000, 0x4000, 0xC400),  # -2.0 * 2.0 = -4.0
    (0xBC00, 0x4000, 0xC000),  # -1.0 * 2.0 = -2.0
    (0x3800, 0x3800, 0x3400),  # 0.5 * 0.5 = 0.25
    (0x0000, 0x3C00, 0x0000),  # 0 * 1.0 = 0
    (0x3880, 0x3A00, 0x36C0),  # 0.5625 * 0.75 = 0.421875
    (0x3880, 0xBA00, 0xB6C0),  # 0.5625 * -0.75 = -0.421875
    (0xB880, 0xBA00, 0x36C0),  # -0.5625 * -0.75 = 0.421875   
]

# Cocotb testbench
@cocotb.test()
async def multiplier_fp16_test(dut):
    """Test FP16 multiplier with predefined binary values."""

    for a_bits, b_bits, expected_z_bits in test_cases:
        # Apply the input values to the DUT (Device Under Test)
        dut.a.value = a_bits
        dut.b.value = b_bits

        # Wait for the operation to complete
        await Timer(10, units="ns")

        # Read the actual result from DUT
        actual_z_bits = int(dut.z.value)

        # Log the inputs and results for easier debugging
        cocotb.log.info(f"Test case: a = {hex(a_bits)}, b = {hex(b_bits)}, Expected z = {hex(expected_z_bits)}, Actual z = {hex(actual_z_bits)}")

        # Assert that the actual result matches the expected result
        assert actual_z_bits == expected_z_bits, f"Test failed: a = {hex(a_bits)}, b = {hex(b_bits)}, expected = {hex(expected_z_bits)}, got = {hex(actual_z_bits)}"
