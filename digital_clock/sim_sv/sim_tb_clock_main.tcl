# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/*.sv

# Compile TB
vlog tb_clock_main.sv

# Init simulation
vsim tb_clock_main
do wave_tb_clock_main.tcl
log -r *

# Run simulation
run -all

# Display wave
view wave

wave zoomfull
