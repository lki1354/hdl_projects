# INIT sim environment
vlib work
vmap work work

# Compile sources
vlog ../src_sv/pulse_generator.sv


# Compile TB
vlog tb_pulse_generator.sv

# Init simulation
vsim tb
log -r *

# Run simulation
run -all

wave zoomfull
