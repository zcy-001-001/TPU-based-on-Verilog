import cocotb
from cocotb.triggers import Timer
from random import randint

# 测试4位加法器的Cocotb测试模块
@cocotb.test()
async def test_adder_3bit(dut):
    """测试 4 位加法器"""
    
    # 生成一组随机的输入值并应用到 DUT
    for _ in range(10):  # 测试10组随机输入
        # 生成两个随机的 4 位输入数
        input1 = randint(0, 15)  # 4-bit number (0 to 15)
        input2 = randint(0, 15)  # 4-bit number (0 to 15)

        # 将随机输入赋给 Verilog 模块的输入端口
        dut.input1.value = input1
        dut.input2.value = input2

        # 等待一段时间让仿真稳定
        await Timer(2, units='us')

        # 计算预期的输出值
        expected_sum = (input1 + input2) & 0xF  # 只保留4位的加法结果

        # 获取 DUT 的输出值
        actual_sum = dut.answer.value.integer

        # 检查 DUT 的输出是否与预期相符
        assert actual_sum == expected_sum, f"Test failed: {input1} + {input2} = {actual_sum}, expected {expected_sum}"

    print("所有测试用例通过!")
