# This TCL script shall prepare Modelsim to simulate the sevenseg_decoder.vhd

# (1) Prepare the simulation environment
vlib work
vmap work work

# (2) Compile the sources
vlog	../src_sv/washing_machine.sv

# (3) Compile the test bench
vlog	tb_washing_machine.sv

# (4) Initialize simulation
vsim	tb
# log all signal recursively
log -r *

# (5) Run simulation
run -all
#run 1us

# (6) Display results
view wave
do wave_tb_washing_machine.tcl
wave zoomfull