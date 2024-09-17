import cocotb
from cocotb.triggers import Timer
import random

# 定义测试数据并创建 cocotb 测试函数
@cocotb.test()
async def test_subtractor_6bit_basic(dut):
    """测试基本的6-bit减法功能"""
    # 定义一些测试向量 (input1 - input2 = result)
    test_vectors = [
        (0b000001, 0b000001, 0b000000),  # 1 - 1 = 0
        (0b000110, 0b000011, 0b000011),  # 6 - 3 = 3
        (0b010000, 0b001000, 0b001000),  # 16 - 8 = 8
        (0b111111, 0b000001, 0b111110),  # -1 - 1 = -2 (in 6-bit representation)
        (0b101010, 0b001011, 0b011111),  # -22 - 11 = -33 (overflow)
        (0b111111, 0b111111, 0b000000)   # -1 - -1 = 0
    ]

    for input1, input2, expected_result in test_vectors:
        # 赋值给DUT的输入信号
        dut.input1.value = input1
        dut.input2.value = input2

        # 等待模拟器运行一段时间（例如2纳秒）
        await Timer(2, units="ns")

        # 获取输出结果并检查是否正确
        result = dut.result.value
        assert result == expected_result, f"Test failed for input1={bin(input1)} and input2={bin(input2)}. Got {bin(result)}, expected {bin(expected_result)}"