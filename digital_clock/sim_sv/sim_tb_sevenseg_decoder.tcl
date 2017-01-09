# Init sim environment
vlib work
vmap work work
# Compile sources
vlog ../src_sv/sevenseg_decoder.sv
# Compile TB
vlog	tb_sevenseg_decoder.sv
# Init Simulation
vsim tb_sevenseg_decoder
log -r *

# Run simulation
run -all

# Display wave
view wave
do wave_tb_sevenseg_decoder.tcl
wave zoomfull