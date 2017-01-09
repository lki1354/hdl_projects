# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/debounce.sv
vlog ../src_sv/key_long_short.sv


# Compile TB
vlog tb_key_long_short.sv

# Init simulation
vsim tb
do wave_tb_key_long_short.tcl
log -r *

# Run simulation
run -all

# Display wave
view wave

wave zoomfull
