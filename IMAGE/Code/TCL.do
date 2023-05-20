vlog PD_TestBench.v
vsim tb
add wave -position insertpoint sim:/dut/*
run -all
