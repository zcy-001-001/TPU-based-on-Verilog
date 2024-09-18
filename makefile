TOPLEVEL_LANG ?= verilog
SIM ?= icarus

# TEST ?= test_mulfp16

# test_add3:
# 	VERILOG_SOURCES += rtl/adder_3bit.sv
# 	VERILOG_SOURCES += rtl/half_adder.sv
# 	VERILOG_SOURCES += rtl/full_adder.sv

# 	TOPLEVEL = adder_3bit
# 	MODULE = tb.test_adder_3bit

# test_mul11:
# 	VERILOG_SOURCES += rtl/multiplier_11bit.sv
# 	VERILOG_SOURCES += rtl/adder_22bit.sv
# 	VERILOG_SOURCES += rtl/half_adder.sv
# 	VERILOG_SOURCES += rtl/full_adder.sv

# 	TOPLEVEL = multiplier_11bit
# 	MODULE = tb.test_multiplier_11bit

# test_mulfp16:
VERILOG_SOURCES += rtl/multiplier_fp16.sv
VERILOG_SOURCES += rtl/adder_6bit.sv
VERILOG_SOURCES += rtl/multiplier_11bit.sv
VERILOG_SOURCES += rtl/adder_22bit.sv
VERILOG_SOURCES += rtl/half_adder.sv
VERILOG_SOURCES += rtl/full_adder.sv

TOPLEVEL = multiplier_fp16
MODULE = tb.test_multiplier_fp16

# test_sub6:
# 	VERILOG_SOURCES += rtl/subtractor_6bit.sv
# 	VERILOG_SOURCES += rtl/adder_6bit.sv
# 	VERILOG_SOURCES += rtl/half_adder.sv
# 	VERILOG_SOURCES += rtl/full_adder.sv
# 	TOPLEVEL = subtractor_6bit
# 	MODULE = tb.test_subtractor_6bit

# # test_adderfp16:
# VERILOG_SOURCES += rtl/adder_fp16.sv
# VERILOG_SOURCES += rtl/subtractor_6bit.sv
# VERILOG_SOURCES += rtl/adder_6bit.sv
# VERILOG_SOURCES += rtl/adder_12bit.sv
# VERILOG_SOURCES += rtl/subtractor_12bit.sv
# VERILOG_SOURCES += rtl/half_adder.sv
# VERILOG_SOURCES += rtl/full_adder.sv

# TOPLEVEL = adder_fp16
# MODULE = tb.test_adder_fp16


include $(shell cocotb-config --makefiles)/Makefile.sim

# $(TEST):
# 	make $(TEST)
