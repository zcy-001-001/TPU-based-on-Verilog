TOPLEVEL_LANG ?= verilog
SIM ?= icarus
WAVES=1


VERILOG_SOURCES += rtl/systolic_array.sv
VERILOG_SOURCES += rtl/accumulator.sv
VERILOG_SOURCES += rtl/relu.sv

VERILOG_SOURCES += rtl/dma.sv
VERILOG_SOURCES += rtl/input_setup.sv
VERILOG_SOURCES += rtl/weight_memory.sv
VERILOG_SOURCES += rtl/unified_buffer.sv
VERILOG_SOURCES += rtl/control_unit.sv
VERILOG_SOURCES += rtl/tpu.sv


TOPLEVEL = tpu
MODULE = tb.test_tpu


include $(shell cocotb-config --makefiles)/Makefile.sim