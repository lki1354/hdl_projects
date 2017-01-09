# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/mux_clock.sv

# Compile TB
vlog tb_mux_clock.sv

# Init simulation
vsim tb
#do wave_tb_mux_clock.tcl
log -r *

# Run simulation
run -all

# Display wave
#view wave

#wave zoomfull
