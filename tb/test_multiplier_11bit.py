import cocotb
from cocotb.triggers import Timer
import random

# 乘法的期望结果函数
def reference_multiplier(input1, input2):
    return input1 * input2

# 测试模块
@cocotb.test()
async def test_multiplier_11bit(dut):
    """ Test the 11-bit multiplier """

    # 测试用例列表 (input1, input2, expected_output)
    test_cases = [
        (5, 3),
        (15, 10),
        (1023, 1023),  # 最大11位数相乘
        (0, 25),       # 乘以0
        (512, 512),    # 中间大小的数
        (random.randint(0, 1023), random.randint(0, 1023))  # 随机输入
    ]

    # 遍历测试用例
    for input1, input2 in test_cases:
        # 设置输入信号
        dut.input1.value = input1
        dut.input2.value = input2

        # 等待 2ns
        await Timer(2, units='ns')

        # 读取输出信号
        actual_output = dut.answer.value

        # 计算期望输出
        expected_output = reference_multiplier(input1, input2)

        # 检查结果
        assert actual_output == expected_output, f"Test failed for input1={input1}, input2={input2}: expected {expected_output}, got {actual_output}"

        # 打印每个测试的结果
        cocotb.log.info(f"Test passed for input1={input1}, input2={input2}: result {actual_output}")
