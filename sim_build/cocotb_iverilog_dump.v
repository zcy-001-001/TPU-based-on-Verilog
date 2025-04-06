module cocotb_iverilog_dump();
initial begin
    $dumpfile("sim_build/tpu.fst");
    $dumpvars(0, tpu);
end
endmodule
