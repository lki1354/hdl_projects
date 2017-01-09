# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/debounce.sv

# Compile TB
vlog tb_debounce.sv

# Init simulation
vsim tb_debounce
do wave_tb_debounce.tcl
log -r *

# Run simulation
run -all

# Display wave
view wave

wave zoomfull
